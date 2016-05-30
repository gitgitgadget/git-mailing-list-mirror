From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: [PATCH 0/2] strbuf: improve API
Date: Mon, 30 May 2016 12:36:40 +0200
Message-ID: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
Cc: simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:37:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KZa-0000bQ-16
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbcE3Kgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 06:36:55 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:56354 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751137AbcE3Kgy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 06:36:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 63BEA20AE;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KGAJctTjhdg4; Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 504812098;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 45267207A;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JnsgJwXkzzhm; Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from Messiaen.grenet.fr (eduroam-033086.grenet.fr [130.190.33.86])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 281DD2066;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.403.ge2646ba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295875>

This patch series implements an improvment of the strbuf API, allowing
strbuf to use preallocated memory. This makes strbuf fit to be used
in performance-critical operations.

The first patch is simply a preparatory work, adding tests for
existing strbuf implementation.
Most of the work is made in the second patch: handle pre-allocated
memory, extend the API, document it and test it.

As said in the second commit, the idea comes from Michael Haggerty.

William Duclot (2):
    strbuf: add tests
    strbuf: allow to use preallocated memory

Makefile               |   1 +
strbuf.c               |  68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
strbuf.h               |  31 +++++++++++++++++++++++++++++--
t/helper/test-strbuf.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
t/t0082-strbuf.sh      |  47 +++++++++++++++++++++++++++++++++++++++++++++++
5 files changed, 251 insertions(+), 7 deletions(-)
