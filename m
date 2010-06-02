From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Documentation on writing portable code for Git
Date: Wed, 2 Jun 2010 09:42:50 +0000
Message-ID: <AANLkTinqWn9i5CFDW_62eSu6xSH2hqef2aLJ7pYAiGVk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com, Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 02 11:43:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkTQ-0001J0-Nt
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 11:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab0FBJmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 05:42:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37914 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab0FBJmv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 05:42:51 -0400
Received: by iwn6 with SMTP id 6so1232399iwn.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=M3Sq2p8ipVfiIkQicDRDRJRmOp6TC7fnJKnivNIZA1U=;
        b=n2ZnZEMHW9XJjKcPNJWTGaammRkGBCOF6KU/JBT5qoFfNl8Uv4uu7WjESwY/QLuwOB
         sDfMsKo5AbuEfZEXu6U+PCIX7gP7xji7Urm4J6oJsmgF6mFkF8AJkZ+26PYpwYtPMmxK
         4PPCxf5uO2u6mPZ+6HfVbZxJdBiY/OCS/AZi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=IrV2Vwzec3xhslmG+E2gwPWqdqQGnwuxDKGWd7c1tN/KMsu71nbWc7FQrJUfBdAPvw
         wtpGN6R2sSFJFaimkckCedE5Gm8+VDNcTARW4lJ4VjTl1t5oy8ChK7dJA1/VuN/6xbDk
         InjQnl0EUp/D9LzidcuKHC722tzzCv3F1u5dg=
Received: by 10.231.149.143 with SMTP id t15mr9607419ibv.29.1275471770333; 
	Wed, 02 Jun 2010 02:42:50 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 2 Jun 2010 02:42:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148236>

On Wed, Jun 2, 2010 at 06:41, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 6/2/2010 2:13, schrieb Brandon Casey:
>> =C2=A0test_expect_success 'setup' '
>> - =C2=A0 =C2=A0 unset GIT_PAGER GIT_PAGER_IN_USE &&
>> + =C2=A0 =C2=A0 unset GIT_PAGER GIT_PAGER_IN_USE
>
> Maybe we should terminate the line with ';' to document that it is a
> deliberate choice that there is no '&&'?

(Split from the "ignore return status of shell's unset builtin"
thread)

It would be nice if there was documentation describing how to write
portable code for various parts of Git. Basically a bullet-point
aggregate of the subjects of various patches we keep getting from
users of IRIX, Solaris, HP-UX etc. E.g:

    * Use FOO=3Dbar and then export FOO, not export FOO=3Dbar

    * Don't check the return value of unset, Solaris ...

I could contribute some of these for Perl.
