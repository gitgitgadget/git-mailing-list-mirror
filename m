From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 13:35:42 -0800
Message-ID: <7vtxqum1u9.fsf@alter.siamese.dyndns.org>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird>
 <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de>
 <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de>
 <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com>
 <20130106120917.GC22081@elie.Belkin>
 <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9E822.4020709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gersha?= =?utf-8?Q?usen?= 
	<tboegi@web.de>, Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trxsy-0007yt-QF
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 22:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab3AFVfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 16:35:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab3AFVfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 16:35:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8744AA221;
	Sun,  6 Jan 2013 16:35:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zoelYoyssJ/Spx/inheErXn9qI0=; b=q4HXE/
	4vAzy3CI7Tyc8swOco6vJ1X0ovB5DRnjodOiaox4ebkeiW/YNyd2DadIPXuJBpOH
	ShJs1zr8n/ryrV6kDyChSetZoQgzBGRf39cBCke7BqwfQkJZaIXvW3mdul1r5f6x
	dEB+C6fmo5x7tVUVfktIUfRWaLYHurnxNextE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A9LyH/CpwQiDTODxW+F16o7UImVWY19k
	OdACpgzB3FrPRq7kw1k7qHT7eOcFs8ri5v1KJnilgVY/JAVRA8MfnBY7SGKS+jsB
	DW0DBFFqKleNLOx0LbcyEHJK04R3Hf8WP1Ky69KbOu/5MEVC7KdHoKbLZSxGz0vC
	diaxyer/GPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77D97A220;
	Sun,  6 Jan 2013 16:35:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9B6CA21F; Sun,  6 Jan 2013
 16:35:43 -0500 (EST)
In-Reply-To: <50E9E822.4020709@gmail.com> (Mark Levedahl's message of "Sun,
 06 Jan 2013 16:09:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 067E4AA6-5849-11E2-8B8A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212845>

Thanks; so perhaps you can give me an OK to forge your S-o-b to the
following?

-- >8 --
From: Mark Levedahl <mlevedahl@gmail.com>
Date: Sun, 6 Jan 2013 11:56:33 -0800
Subject: [PATCH] Makefile: add comment on CYGWIN_V15_WIN32API

There is no documented, reliable, and future-proof method to
determine the installed w32api version on Cygwin. There are many
things that can be done that will work frequently, except when they
won't.

The only sane thing is to follow the guidance of the Cygwin
developers: the only supported configuration is that which the
current setup.exe produces, and in the case of problems, if the
installation is not up to date then updating is the first required
action.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 4d47af5..52e298a 100644
--- a/Makefile
+++ b/Makefile
@@ -273,6 +273,10 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 #
+# Define CYGWIN_V15_WIN32API if you are using Cygwin v1.7.x but are not
+# using the current w32api packages. The recommended approach, however,
+# is to update your installation if compilation errors occur.
+#
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
-- 
1.8.1.302.g0f4eaa7
