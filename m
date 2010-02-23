From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/2] shell setup: clear_local_git_env() function
Date: Tue, 23 Feb 2010 08:55:45 +0100
Message-ID: <cb7bb73a1002222355s38fda032g99623f44d6200fbc@mail.gmail.com>
References: <7vsk8s274t.fsf@alter.siamese.dyndns.org> <1266881518-11213-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<4B837A73.8010406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 08:56:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njpct-0001Vl-V2
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 08:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab0BWH4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 02:56:09 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:42561 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab0BWH4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 02:56:08 -0500
Received: by ey-out-2122.google.com with SMTP id d26so783201eyd.19
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 23:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xqLtuPMQ4CV+zvmvkPbSz+gEJOXTzWI2ucWdJ0/GD8I=;
        b=L/RW5KHsknYlNAbw5LFtqTODTCNMyalZ6TeDJ2Fnyh4JG/a+LykIPPM96/AUcaJrDN
         LxGCj4/3myedeVyJUrm17Xv1R+780XbH75UveaZ4tzJEAhjKOsQNu4XP3RtFaAbGtc81
         pqpgdKDWQZYXjnFbQrNfj5Q+ayTwdZ6qGf+Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=e+ENCmG4oDUgbDeneonUY05ZgiaYStLiequ56L3uOnZtrwkQuvWW8szUpRVsxhK6/w
         +PfoPGUWxAm2mOvqgXMvqiPAeLGSnV7kvOScg47B7KPGBnakEzCVcer8ucR0Sod8XLLW
         WWEHBF1PGe2VSCoWgzsyyr93dB22z9Ceq05UM=
Received: by 10.213.1.143 with SMTP id 15mr4699669ebf.42.1266911765129; Mon, 
	22 Feb 2010 23:56:05 -0800 (PST)
In-Reply-To: <4B837A73.8010406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140773>

On Tue, Feb 23, 2010 at 7:49 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Giuseppe Bilotta schrieb:
>> +# Clear repo-local GIT_* environment variables. Useful when switchi=
ng to
>> +# another repository (e.g. when entering a submodule)
>> +clear_local_git_env() {
>> + =A0 =A0 unset =A0 GIT_DIR GIT_WORKTREE GIT_OBJECT_DIRECTORY \
>> + =A0 =A0 =A0 =A0 =A0 =A0 GIT_INDEX_FILE GIT_GRAFT_FILE GIT_CONFIG \
>> + =A0 =A0 =A0 =A0 =A0 =A0 GIT_NO_REPLACE_OBJECTS
>
> IMO, this list should be in sync with the one you find in
> connect.c:git_connect() around line 611. They have the same purpose.

Ah, interesting, I was looking for such a list but only found the more
generic one in cache.h
By comparing them it would seem they serve the same purpose, indeed. I
notice that the connect.c is missing GIT_CONFIG (which _must_ be unset
for us). I also notice that the connect.c one unsets the alternate DB;
I had doubts about it when preparing the list in this case.

I will resend a new patch to replace this one, syncing the two lists.

> (And, BTW, a vertical list would be more readable than a mixed
> horizontal+vertical list, IMVHO.)

I tend to conserve vertical space, but I have no particular objection t=
o that.

--=20
Giuseppe "Oblomov" Bilotta
