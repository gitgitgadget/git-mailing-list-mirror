From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Mon, 21 Mar 2011 17:02:54 +0700
Message-ID: <AANLkTin3VVcVZZv9A+Wam41uxhReuCAaQL_6MOgCpN+h@mail.gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <7vmxl37bdp.fsf@alter.siamese.dyndns.org> <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
 <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com>
 <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com> <4D871E51.8090106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 11:32:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1cPw-0006WX-JT
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab1CUKcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:32:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53885 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab1CUKcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 06:32:51 -0400
Received: by wya21 with SMTP id 21so5614730wya.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 03:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=lWGRSJxpH6918V7pCF9/SHxyIGA3jWEsrQDOhXGwfAA=;
        b=Wv2FV04NTwqMh4FqQ/1uRDZbV/I/8z6JFl+39oZFuz+iCiO3xmmBKo9NBANUpPaFus
         d0k9l85uzPK7Km7mR+vUAhKdscRS/1VN0h8lXxFxMS6+VGsR8fhVRc70uiW7pGtlJg88
         oDKwgRqxKSsyAEP35i196aG0hxWT95gOYPBoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DbXK6E+1Nji305VRtXwjvfjOEsNNKynLvYklWXGl04R/KJXlTFRBzpoSAEMBlM69Bk
         v58de/2B3LpMnKx0iYyyQW2+CMs5q6NEXyrkUguTgInvzVANaYptERIor4zpj762Svkh
         yInbBe+gs/kl1m/NaqbJowxHRVvHSrcVDBILM=
Received: by 10.216.120.129 with SMTP id p1mr4096084weh.81.1300703569974; Mon,
 21 Mar 2011 03:32:49 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Mon, 21 Mar 2011 03:02:54 -0700 (PDT)
In-Reply-To: <4D871E51.8090106@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169578>

On Mon, Mar 21, 2011 at 4:45 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> One thing that makes it different from Michael's approach is, :/foo
>> will match ':/foo' literally in every directories and foo at top-tree.
>> I feel mildly uncomfortable with it, but it makes it consistent with
>> other wildcards. If no one objects, I'll try to make a patch with this
>> approach.
>
> Maybe I misunderstand which topic you are referring to. I have a patch
> for ":" (to denote repo-root in pathspecs), there's no need to make
> another one for ":/". (I would really prefer to do it myself since I
> brought it up.)

If you make it a wildcard as I mentioned above, the code would be
different. Your patch will match only files at top, while wildcards
can also match any files literally. You can do it, I don't mind at
all.

> I was just waiting for agreement to settle in about
> which prefix to use. Also, I have checked with J&J of mingw/msysgit fame
> meanwhile to make sure that the notation does not create problems on the
> windows side of git.

The nice (or not) thing about wildcard behavior is that because it
would match both cases, we would not need to worry too much. People
who don't know the magic can still match files (although more, not
less).
-- 
Duy
