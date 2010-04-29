From: Bryan Richardson <btricha@gmail.com>
Subject: Re: See commits on remote repository
Date: Wed, 28 Apr 2010 20:44:10 -0600
Message-ID: <h2s3f81a4241004281944t574993dfo2af11e451baf98de@mail.gmail.com>
References: <n2v3f81a4241004281535h30d35f5cw5f33e265d19d35b6@mail.gmail.com>
	 <1272495295.3021.84.camel@kheops>
	 <20100429014943.GA4269@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 29 04:44:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7Jjq-0003Dc-WF
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 04:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab0D2CoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 22:44:12 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:44695 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab0D2CoL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 22:44:11 -0400
Received: by iwn12 with SMTP id 12so4910940iwn.15
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 19:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LHHy8VUywZhDNmptIFORP+BOtM99W5fGrw/b4u3g9wM=;
        b=vWhzZsnvSf7ZrZFsCCOvYkJZy7IOs4lPDFQdKI71wz2AxNzBs8UDsRKvaEESW9OGRv
         3abS2jVODjQaewkTCBNuCBkn5m4r1pEh4Rzc/siZv/7q7o7+MIvn/gCKK/qFbMbbAlbM
         BezJdbHulK0Wp+40mmaAuNcLoTlttWCmEvE4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Eu5VnzL1qK9Kfmx2Xz18Tfx1E2W5oScKnt+9wx0qOSi1NQnycVBEEbpDBcB6aNTLZP
         eONSr8PwssUyhkGCs6ZzVAL+4O4V/kBSQ42ZJbtRW8YyAAEiH9LlkUkAYervmfYr9d+0
         ZKdv60IRPXyNM1dRjTHcAWSBqUgb9EcxSw+bM=
Received: by 10.231.166.16 with SMTP id k16mr172913iby.14.1272509050926; Wed, 
	28 Apr 2010 19:44:10 -0700 (PDT)
Received: by 10.231.36.203 with HTTP; Wed, 28 Apr 2010 19:44:10 -0700 (PDT)
In-Reply-To: <20100429014943.GA4269@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146027>

Sweetness... this will be most useful. Thanks to both you and Sylvain
for responding!

On Wed, Apr 28, 2010 at 7:49 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 29, 2010 at 12:54:55AM +0200, Sylvain Rabot wrote:
>
>> > For example, say I have repository X, which I do a bare clone on t=
o
>> > create repository Y for someone else to work on (effectively forki=
ng
>> > repo X). Is there a way for me to see, from repository X, what com=
mits
>> > have been made to repository Y?
>> >
>> $ git remote update
>> $ git log origin/<branch>
>> $ gitk origin/<branch>
>
> That's backwards. He's in the parent repo and wants to see what the
> child did.
>
> The answer is "no, not automatically. Git is fully distributed and
> repository X knows nothing about repository Y that was cloned from it=
".
>
> But also because git is fully distributed, you can simply treat the
> cloned child like any other remote:
>
> =A0git remote add y /path/to/y
> =A0git remote update ;# or just "git fetch y"
> =A0git log y/<branch> ;# what happened in y's <branch>
> =A0gitk y/<branch>...<branch> ;# differences since y forked
>
> -Peff
>
