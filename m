From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Mon, 15 Apr 2013 21:26:44 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <1906942.3yyCMUNxTB@cs-pc>
References: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 22:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URpfn-0003aH-Ii
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab3DOUGb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 16:06:31 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:40752 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab3DOUG1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 16:06:27 -0400
X-Greylist: delayed 2368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2013 16:06:26 EDT
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id r3FJQnDQ030719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 15 Apr 2013 21:26:50 +0200
Received: from cs-pc.localnet (g224015184.adsl.alicedsl.de [92.224.15.184])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id r3FJQnur016657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 21:26:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2013-16;
	t=1366054009; bh=bJ6KR7NXTlZoOLwbOrzA4yd+xJ4bjy/h3/aYbx+AA20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iUPdcsR5DXMRflMYoJaC0MI7Avfcl0q/Mv3/qg0njYAUkeyCo38TjPKeUtI/Ob0yK
	 SGBlTarLkqIal3EaVKlgR52mu9bk298pYbnIJ7IVGaGziPDAKAo5m1cH1tPVqQ8783
	 e900heBfCFJKCVsEP9Ink2QPQS979GXtxi4ZH+Yk=
User-Agent: KMail/4.7.3 (Linux/3.0.0-32-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221308>

Thanks for the regular update! This is great work.

One issue with the plural form messages, though:

Am Montag, 15. April 2013, 18:27:40 schrieb Ralf Thielow:
>  #: bundle.c:186
> -#, fuzzy, c-format
> +#, c-format
>  msgid "The bundle contains this ref:"
>  msgid_plural "The bundle contains these %d refs:"
> -msgstr[0] "Das Paket enth=E4lt %d Referenz"
> -msgstr[1] "Das Paket enth=E4lt %d Referenzen"
> +msgstr[0] "Das Paket enth=E4lt diese Referenz:"
> +msgstr[1] "Das Paket enth=E4lt diese %d Referenzen:"

The msgstr[0] must still contain a %d conversion specifier (which will =
be=20
filled with the number 1) even though the translated sentence wouldn't =
need=20
the 1 anymore. The previous msgstr[0] was correct; the English singular=
 msgid=20
is not.

Technical background: The ngettext function chooses only the string its=
elf,=20
which will then be fed to printf() as a second step. If the printf sees=
 more=20
variadic arguments than conversion specifiers in the string, it will be=
=20
unhappy. At least that's what I remembered about the ngettext things...

http://www.gnu.org/software/libc/manual/html_node/Advanced-gettext-
functions.html

Regards,

Christian
