From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=200/2=5D=20multiline=20prefixes=20on=20messages?=
Date: Fri,  7 Sep 2012 21:05:03 +0200
Message-ID: <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 07 21:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA3rn-0005fn-H0
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 21:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab2IGTFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 15:05:15 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51926 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2IGTFN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 15:05:13 -0400
Received: by wgbdr13 with SMTP id dr13so2852461wgb.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cuRqOOUp/FRYUkXJMG2fOwQ51lcnaI78lv6uPdRg9Ik=;
        b=xpumB1nTLm7alrnDsHA8WmRCAmlxEOJ2RVIS4XOgJaVMeXNL+sIgSJ4J8KM6wchagJ
         6WP4x+Xbf/u0zelM4+EyM0M+CBHanrO6L8v5SohgW1mKObpGyDniw7o8aZu2xgZSg9T3
         COJBYXR+5sOfLaQnUw8hJ99qs5VIqYvgCQ/PWLhYaoega4gQIXYVTQ33OSPisie12s8u
         m04QrKx+0RJJPj84ivKIx6jv8RhpKZdv6wN4uct+A5tCrUPCTi7Y/qS+dBPMX5uoMQkd
         40fHAUvBwYMUV1V+rbK0ev/DzGarc3kx9C74irygeIRfo7S2kLXgUM+dKr0y7A3NM3lZ
         NA2A==
Received: by 10.180.80.134 with SMTP id r6mr308318wix.1.1347044711992;
        Fri, 07 Sep 2012 12:05:11 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id cl8sm208337wib.10.2012.09.07.12.05.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2012 12:05:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.176.g3fc0e4c.dirty
In-Reply-To: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204988>

This is a short implementation of an idea i have, based
on Junio's comment. It might not follows the coding style,
the comments can be adverse and so on...
Just want to know if it's the right direction.

This series introduces a function that allows to add
a prefix to multilined messages. The function itself
is an extraction of the code of "advice.c::advice()".
Extract this as a separate function has the advantage
that we can mark these prefixes for translation and
can produce a nicer output.

Junio said that we should probably avoid memory
allocation on "die()" codepaths, but "warning"
messages are acceptable, I think. If the series is
basically acceptable, the "usage:" messages are also a
cancidate for migration to this.

Ralf Thielow (2):
  advice: extract function to print messages with prefix
  i18n: mark prefix "warning:" for translation

 advice.c | 14 ++++++++++----
 advice.h |  1 +
 usage.c  |  2 +-
 3 Dateien ge=C3=A4ndert, 12 Zeilen hinzugef=C3=BCgt(+), 5 Zeilen entfe=
rnt(-)

--=20
1.7.12.176.g3fc0e4c.dirty
