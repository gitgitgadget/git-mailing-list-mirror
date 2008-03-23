From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 13:48:23 -0600
Message-ID: <51419b2c0803231248h6b161fa7qa120fd18e60e274@mail.gmail.com>
References: <47E64F71.3020204@jwatt.org>
	 <alpine.LSU.1.00.0803231401340.4353@racer.site>
	 <47E658D3.1060104@jwatt.org>
	 <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>
	 <47E6612A.5020408@jwatt.org>
	 <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
	 <alpine.LSU.1.00.0803231519380.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Watt" <jwatt@jwatt.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:49:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdWBm-0007G0-Jg
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbYCWTs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbYCWTs0
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:48:26 -0400
Received: from hs-out-0708.google.com ([64.233.178.243]:36152 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbYCWTsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:48:25 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1932511hsl.5
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/DTwCZpn3URoBuSvTo4MQK4EDTy1eVTu/Cw0MEjbH3I=;
        b=aqJI2BPO7d4Xa7yoOtHu/PgWL/Oo0E4fAZB84Sr0b5tuuuJWjVMR7tBj130xwL2/oerScYkkgSBMdWzZeZaVfJ7h7O552xeTX1WekMi5Lb9igAvPkwcqqimORHQJfI08Y9F0uUCcTFF2p9PpCh0NbpU0LhxeXMT5YmOlhjBXdCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VKpyuMOtlLiNAFqpXWvBtrREWQNGwCMG+BFx7QDtCZdajWl2zkH/x7OpblUh5MafsliFm5WczpgH/rNGdZQQ2lksmz2mgdQMHw5CDFAHfoedyqnkTTrXyP9kOQslvm5T2pT+m3DPRsy8bA8e02ueE1U/OCbus5/1wpapG4dUMI4=
Received: by 10.114.110.1 with SMTP id i1mr10123331wac.112.1206301703934;
        Sun, 23 Mar 2008 12:48:23 -0700 (PDT)
Received: by 10.114.205.19 with HTTP; Sun, 23 Mar 2008 12:48:23 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803231519380.4353@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77954>

Hi,

On Sun, Mar 23, 2008 at 8:22 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  On Sun, 23 Mar 2008, Elijah Newren wrote:
>
>  > If there is no currently active branch because you checked out a tag
>  > or some arbitrary commit, then HEAD is said to be detached, and HEAD
>  > will track the particular commit you checked out.
>
>  I'd say that "track" is the wrong verb here.

Good point.

>  > The end result is that HEAD is always the most recent commit to which
>  > your working copy is relative to.  See also
>  > http://www.kernel.org/pub/software/scm/git/docs/glossary.html
>  >
>  > So, it sounds like we're both saying that in your case, you'd like the
>  > HEAD become detached and track the sha1 that it previously pointed to
>  > before your push rather than continuing to track the updated branch.
>
>  If you ever propose to detach the HEAD in a remote repository when
>  somebody pushed into the referenced branch, I am totally opposed to that.
>
>  You can play your own games with the update and post-update hooks as much
>  as you want, but please leave official Git alone.  Thankyouverymuch.

Obviously such a change in isolation would merely shift to a new kind
of gotcha for users; I was thinking that I'd be able to figure out an
accompanying change that would make things work nicely (or that
someone else on the list might think of something)...but no such luck.
 Further, I think Junio's latest post describes why I likely couldn't
come up with anything else and the idea is just plain bad.

Elijah
