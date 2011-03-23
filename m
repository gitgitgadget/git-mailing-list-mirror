From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Wed, 23 Mar 2011 20:34:52 +0700
Message-ID: <AANLkTinsVPHV7H_AGHxyGAXpjvJ0n5SvNja1ZBvt4fGd@mail.gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <7vmxl37bdp.fsf@alter.siamese.dyndns.org> <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
 <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com>
 <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com>
 <4D871E51.8090106@drmicha.warpmail.net> <7v7hbqk8ox.fsf@alter.siamese.dyndns.org>
 <AANLkTimeEWOvmNXQV9fJKe23Qe3sipT7q=qHVB2fLq0n@mail.gmail.com> <4D89ECC6.7040903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 14:35:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2ODh-0007ZG-O6
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 14:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab1CWNfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 09:35:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab1CWNfX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 09:35:23 -0400
Received: by wya21 with SMTP id 21so7653507wya.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=xlcLcJGODAq17RfPYaoPe6zQol0jf7AluStgRH+PJsA=;
        b=D6EPb7h4ciw1gb5bNcqBgf0LBXgWIxxQwbnroELrWc36Rd2HLWEcl+s+4PMzgUhsfi
         //cgWa4zOCeW3u0YywyAYZHYMwwSf3yEY48gCVSSkaq80qoUvt3R+B0zcI3OPtadRUoD
         2xOuvHwQqqJNcMssJ0xOytPkOjc38mCs1FtoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=L2YTKvS048WRRW41LnJ+z0Uw2aFJ0BnHUTnPNvulykT5jO02u0MFkk4UZsRJzIXcUZ
         CgUR7tPTwVsVHqFg5vYzsqf72BkxcTQMFMevSZbdm8Stlh4IKHCNHCPgzWOKE/gjRA6e
         yhbuqD0ojj/Ip6X48dsly0sAhJdomMBGe5EYU=
Received: by 10.216.35.83 with SMTP id t61mr36499wea.1.1300887322073; Wed, 23
 Mar 2011 06:35:22 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 06:34:52 -0700 (PDT)
In-Reply-To: <4D89ECC6.7040903@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169828>

On Wed, Mar 23, 2011 at 7:51 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Note that there is also possible notational overlap with the WIP "attr:
> make attributes depend on file type" at
>
> http://permalink.gmane.org/gmane.comp.version-control.git/168116
>
> which suggested something like
>
> :symlink:* diff=symlinkdiffdriverofyourchoice
>
> as a notation for attributes which depend on the file type. Is that a
> problem, should I do something different there? (Also, I still need help
> with that...)

I would do

:{symlink}* diff=symlinkdiffdriverofyourchoice

There's also blank quote problem in gitattr. Tricks like 'hello.world'
would match path 'hello world' but I'd rather have something better.
If ':' is the special char, I could teach gitattr to recognize
<colon>+<quote> as a mark to do C quotation without regressions.
-- 
Duy
