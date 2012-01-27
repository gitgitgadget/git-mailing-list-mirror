From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test t9500 fails if Time::HiRes is missing
Date: Thu, 26 Jan 2012 21:48:33 -0800
Message-ID: <7v8vkt1yry.fsf@alter.siamese.dyndns.org>
References: <hbf.20120123rqzg@bombur.uio.no>
 <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:48:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqefw-0004AH-S4
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab2A0Fsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 00:48:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab2A0Fsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 00:48:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5547146D8;
	Fri, 27 Jan 2012 00:48:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KGB/FtCCL861
	JUjLcTKrE9AmWoc=; b=Dm2d2WcWgGc6PMHFuoeW16tPT7/R3z0cYfI+HJndv8wC
	l3jeZG6Or5bfLfaGRyZElVNQalcsAQ61c6jdtWCidOPOKxkSAD/JpEmE5VKhPyg2
	KI5aVSXMR7BgF/QTyFJWkuMuvdZWN/rW93CACzw4MX96pzP4ZiLFWSKlEjpOSJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cLhrsQ
	2VvSvuQf0GYutGiFNQ8mK+TQ7UkvNAELL84i+MboQCeypXbIhS7DjgOL6hkVzmhm
	M/9GcdReFq84jwdbmIf+Ey+9BPos8np02D/vNoKn+zkxn7TPkNqzBsucBfGWUddu
	ikA8qyS2K/YlFfQXOm48kIW/UEWoskCyXgq0s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D1FE46D7;
	Fri, 27 Jan 2012 00:48:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D323D46D6; Fri, 27 Jan 2012
 00:48:34 -0500 (EST)
In-Reply-To: <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 Jan
 2012 10:42:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D388D68-48AA-11E1-AE7A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189194>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This doesn't actually fix the issue, it only sweeps it under the rug
> by making the tests pass, gitweb will still fail to compile on Red
> Hat once installed.

In the short term for 1.7.9, let's at least warn users about this issue=
=2E

-- >8 --
Subject: INSTALL: warn about recent Fedora breakage

Recent releases of Redhat/Fedora are reported to ship Perl binary packa=
ge
with some core modules stripped away (see http://lwn.net/Articles/47723=
4/)
against the upstream Perl5 people's wishes. The Time::HiRes module used=
 by
gitweb one of them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Hopefully, this may resolve itself over time.

 INSTALL |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/INSTALL b/INSTALL
index 8120641..6fa83fe 100644
--- a/INSTALL
+++ b/INSTALL
@@ -83,7 +83,11 @@ Issues of note:
 	- "Perl" version 5.8 or later is needed to use some of the
 	  features (e.g. preparing a partial commit using "git add -i/-p",
 	  interacting with svn repositories with "git svn").  If you can
-	  live without these, use NO_PERL.
+	  live without these, use NO_PERL.  Note that recent releases of
+	  Redhat/Fedora are reported to ship Perl binary package with some
+	  core modules stripped away (see http://lwn.net/Articles/477234/),
+	  so you might need to install additional packages other than Perl
+	  itself, e.g. Time::HiRes.
=20
 	- "openssl" library is used by git-imap-send to use IMAP over SSL.
 	  If you don't need it, use NO_OPENSSL.
