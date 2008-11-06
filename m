From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: More help needed on merging unrelated repos
Date: Thu, 6 Nov 2008 13:13:42 +0100
Message-ID: <46d6db660811060413q7f4e2437maa6d87a27b8704b@mail.gmail.com>
References: <46d6db660811040514qc6c9663u17bd231e1ba662ad@mail.gmail.com>
	 <4910ACCA.7080007@op5.se>
	 <46d6db660811041308o19f1131dm4d49b6703fa6d22b@mail.gmail.com>
	 <4910C6F4.5010407@op5.se>
	 <46d6db660811041430l74d9a100kc15ac46dea8ff63f@mail.gmail.com>
	 <20081106083751.GA10359@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 13:15:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky3lS-0003vd-ES
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 13:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbYKFMNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 07:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbYKFMNo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 07:13:44 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:62730 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbYKFMNn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2008 07:13:43 -0500
Received: by wf-out-1314.google.com with SMTP id 27so633153wfd.4
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 04:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RZFcHjFPHm0GosX+e53nrm5B3lJwLV9CC/SZsZwwexY=;
        b=j7AM5p83+8VhjSafAxLj/UJNpIL1ZdxJb6mbgkTt2yl7W1O0nnswPqh8CvuS4DJvej
         lBOsH0bkL9dZtIACJC/ZHpxwKoLWWDIVdprgrr6sZvgctdX0IMI/UfKHMSYIUf8JX4fz
         30YUNsc/CiQBQuBdyf+7qUJwppDd4TY3vyiz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=P+Uz1Qot5FacFEyoO+8rEUoOAHLXuV31LbT4n97Io2vEX0Q5brwhevXBp4M3LOc6Vu
         PYSH2DDi4O0UI3NuKG6jbfuEC41ukK08uGIDCkvhEVeQ1xjHzY2ZE6+GuH7FiAVyjZYR
         YSlPSKdtnvkYJUachSTmyXQ3GvNeb25oe5I6Q=
Received: by 10.143.28.7 with SMTP id f7mr422048wfj.156.1225973622582;
        Thu, 06 Nov 2008 04:13:42 -0800 (PST)
Received: by 10.143.1.15 with HTTP; Thu, 6 Nov 2008 04:13:42 -0800 (PST)
In-Reply-To: <20081106083751.GA10359@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100230>

On Thu, Nov 6, 2008 at 9:37 AM, Karl Hasselstr=F6m <kha@treskal.com> wr=
ote:
> On 2008-11-04 23:30:56 +0100, Christian MICHON wrote:
>
>> note the merge can work, but it's still done in 2 steps. :(
>> thanks for suggesting this.
>
> If it had worked, you'd have gotten just one merge commit. What you
> want to do is entirely possible, but it seems the high-level commands
> were not designed with your use-case in mind.
>
> Another thing you could try is to merge the two branches separately,
> getting a history like this:
>
>  p1----\
>         \
>  p2---A--B
>      /
>  p3--
>
> And then use grafts to convince git that B has parents p1, p2, and p3
> (instead of its actual parents p1 and A). (Grep for "graft" in the
> Documentation directory.)
>
> And then use git-filter-branch to rewrite history so that the grafted
> history becomes the real history.
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>      www.treskal.com/kalle
>

nice suggestion Karl! it took a while to understand all the
consequences and workflow.
On top of your suggestion, I had to remove the
refs/original/refs/heads/master and the grafts file.

It worked well: quite a spell, but an efficient one. Kudo++

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
