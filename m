From: "David Frech" <nimblemachines@gmail.com>
Subject: Re: sharing between local "work" and "nightly build" git repos
Date: Thu, 12 Jul 2007 17:27:16 -0700
Message-ID: <7154c5c60707121727k36854891u82afc4a8be822861@mail.gmail.com>
References: <7154c5c60707121636l585b42d4l931b08f1468ddfc@mail.gmail.com>
	 <7vmyy1rwza.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 02:27:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I990E-0000Nu-Of
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 02:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831AbXGMA1S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 20:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758031AbXGMA1R
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 20:27:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:39471 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757674AbXGMA1R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 20:27:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so390217wah
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 17:27:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eRvfPyZsOGQZmaILVHryBNuRKzARUvpiyyM75H+iofu64MGPBbAf05QqnJlCIIYBfGaCTg3p2JrJPIa6MnM+5+5xiexjc+fa7mEWQBVLTxN/DYigLjtnX11aB2w+B5f76yaYqeztNd9llxgL01oMKLUeeCrPf91RNPucEq/ewA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q8POerFc7BXIboHUQSk95lfSglkMP5AOuaoWK6YBlEaggsTxYK9mo976ywm942FSd9j4NzsA37u0SdKAl3MrOlHbXb59kzix5JFrgDZdJwEacphEGCOeG23UQaD2ZeofqsMbQHROC6ik+YYiOs+0SWZPvOjkCoONRC+pJxjj/o8=
Received: by 10.114.57.1 with SMTP id f1mr339523waa.1184286436323;
        Thu, 12 Jul 2007 17:27:16 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Thu, 12 Jul 2007 17:27:16 -0700 (PDT)
In-Reply-To: <7vmyy1rwza.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52349>

On 7/12/07, Junio C Hamano <gitster@pobox.com> wrote:
> "David Frech" <nimblemachines@gmail.com> writes:
> If you are willing to redo the nightly repository from scratch,
> I would probably recommend using --reference option when
> cloning, like this:
>
>  $ git clone --reference ~david/git git://git.kernel.org/... ~/nightly-git
>  $ cd ~/nightly-git
>  $ git checkout --track -b next origin/next
>
> Then a nightly update would go like this:
>
>  $ cd ~/nightly-git
>  $ git pull origin next
>  $ make clean
>  $ make test || barf

This makes sense, including the --track, which I neglected to set.

Could you, for my sake and the list's (if others are as confused) be
clearer about the distinctions among -l, -s, and --reference? Exactly
what they do, and their orthogonality (or lack of) really isn't clear
from reading the man page.

Thanks for your help! I'll set this up and hopefully start running it tonight.

If the build or test barfs, who should get the mail?

BTW, I figured out a sneaky way (using filters in Gmail) to send it
thru my Gmail account, so I won't have any issues with sending via
SMTP from a dynamic IP.

Cheers,

- David
-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
