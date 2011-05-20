From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Fri, 20 May 2011 12:48:28 +0200
Message-ID: <BANLkTikRCXLJfOJFZ7j0TV_rxsySgQwSsw@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
 <7v62p68ut0.fsf@alter.siamese.dyndns.org> <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
 <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de> <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com>
 <74D1D7FC-A747-4F85-8B1E-7ABFC9DA70A3@gieschke.de> <BANLkTimG8E_Riz3rYC9PMw_2-D=Za0Ar6w@mail.gmail.com>
 <BANLkTingSqEM5=4=rLq7Yu1x9YXstiSsNw@mail.gmail.com> <A4C82C4A-4A6A-412C-89D5-803F6DC85FD3@gieschke.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Fri May 20 12:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNNGO-0000x4-A4
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 12:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934080Ab1ETKst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 06:48:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54256 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933732Ab1ETKss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 06:48:48 -0400
Received: by pvg12 with SMTP id 12so1610389pvg.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fMQdJFXrGcBEkV6d38Dt12pk4H9JcaB81/GzwR3ruJM=;
        b=th+Pxhjgk2m3m7V1nH3TfdR1TAc6YzpZ4B2pHSgq9bMLPXw+455xVgDkaO7FCatzUx
         iB5nMulKu+TxjqWyGl4djJZI7uVrChALKWxiRlP+/btjAy9cRHkbUhBggjnXQPDtAxeA
         pTOGzDjU2c+ZP5usYO4RboLtydvysmv9P2zK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=rHTnLGzUXHjzygRPrVkFugWoCsgdBrj+HMDqcamP1IhU8OSo0DpPTNtLE7Rcqe1r+W
         WSMalETLJFzUtFqo1Ut6kWv5uHJB3W3xsSFjiVn0uBlttMd/Sb50m40AhBbky8Ic2uAD
         q+JZgh7Jtf09ze1zQnZbget4iZaxPN6cKL5N4=
Received: by 10.68.28.132 with SMTP id b4mr1030059pbh.433.1305888528166; Fri,
 20 May 2011 03:48:48 -0700 (PDT)
Received: by 10.68.47.131 with HTTP; Fri, 20 May 2011 03:48:28 -0700 (PDT)
In-Reply-To: <A4C82C4A-4A6A-412C-89D5-803F6DC85FD3@gieschke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174054>

On Fri, May 20, 2011 at 12:06 PM, Rafael Gieschke <rafael@gieschke.de> wrote:
>
> Am 19.05.2011 um 23:16 schrieb Erik Faye-Lund:
>>>
>>> Well, those platforms would currently fail, since that's the limit on
>>> the string returned from getpass. Since that hasn't happened yet, I
>>> suspect that this is a very theoretical problem.
>>>
>>> If we created our own define we could fix such problems by setting
>>> NO_GETPASS and having a reasonable lengthy GIT_MAX_PASS. But let's
>>> leave that theoretical fix for when/if it turns out to be real, huh?
>>>
>>
>> Whoa: http://www.opengroup.org/csq/view.mhtml?norationale=1&noreferences=1&RID=sun%2FSE2%2F10
>>
>> It seems that Solaris has a MAX_PASS of 8... That should mean that
>> prompted passwords can't be above 8 characters there (without using
>> GIT_ASKPASS). Can this really be the case?
>
> Good find. At least under "SunOS opensolaris 5.11 snv_111b i86pc i386 i86pc" with packages from http://sunfreeware.com/indexintel10.html, I can confirm exactly this behavior. If you try to connect to an account with password > 8 chars, git-imap-send prints "IMAP command 'LOGIN <user> <pass>' returned response (NO) - incorrect password or account name", using <= 8 chars it works fine (couldn't check git clone on https because I only have an internal IP without NAT/proxy).
>
> So maybe it would make sense to define NO_GETPASS and use compat/getpass.c on Solaris in the Makefile?
>

Actually, I'm thinking that we should avoid ever using getpass: it
(and MAX_PASS) seems to have been deprecated from POSIX long ago, and
is even removed from the latest version of the specification. Instead,
we should make our own function (based on your most recent patch?)
that fills a caller-specified strbuf instead (git_getpass already have
a static strbuf that we can fill).

By the way, I gave merging the POSIX and Win32 code-paths a stab, by
implementing minimal tc[gs]etattr :
http://repo.or.cz/w/git/kusma.git/shortlog/refs/heads/work/win32-termios

It's close to working, but the fact that we set stdin to binary mode
by default makes it misbehave and append '\r' to the end of the input.
I have some patches to try to avoid the nasty _setmode(...,
_O_BINARY)-hack in our mingw main-wrapper; perhaps this is the right
timing to finish those?

Another thing I tried, was to make the call to fopen use the path
"con" (which is the path to the terminal on Windows) instead of
"/dev/tty"; this made SetConsoleMode fail, claiming that the handle
was invalid. This failure baffles me, because the handle was valid a
few lines earlier, when I called GetConsoleMode... The idea was that
the handle would be explicitly opened in text-mode (since there's no
'b'-character in the mode-string), but I forgot that we also set
_fmode to _O_BINARY. Ugghhh, Git's handling of new-lines on Windows is
hacky... :P

So, it seems to me that the _setmode-hack should be killed to get this
code POSIX/Windows-unified (or the _fmode-hack and the
SetConsoleMode-failure should be combated).
