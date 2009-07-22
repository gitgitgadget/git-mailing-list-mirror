From: Pierre Habouzit <madcoder@debian.org>
Subject: janitoring
Date: Wed, 22 Jul 2009 23:34:32 +0200
Message-ID: <1248298475-2990-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:42:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjZW-0001k8-Vs
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbZGVVlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbZGVVlE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:41:04 -0400
Received: from pan.madism.org ([88.191.52.104]:40950 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006AbZGVVlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:41:01 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B8F7C464F7;
	Wed, 22 Jul 2009 23:34:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0CF302AEA0; Wed, 22 Jul 2009 23:34:36 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc1.192.g631f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123782>

[PATCH 1/3] janitor: use NULL and not 0 for pointers.

  I really dislike the use of 0 when NULL is meant. This patch probably
  fixes most of them. The biggest culprit is nedmalloc, but a few
  remnants exist in plain git code.

[PATCH 2/3] refactor: use bitsizeof() instead of 8 * sizeof()

  use a macro for CHAR_BIT * sizeof(...), I tend to find it more
  readable than 8 * sizeof(...) in the code. YMMV.

[PATCH 3/3] janitor: add DIV_ROUND_UP and use it.

  Just use linux/kernel.h DIV_ROUND_UP(a, b), it's way easier to read
  than (a + b - 1) / (b).

PS: I don't mind if some patches don't meet large enthusiasm and are
    dropped.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
