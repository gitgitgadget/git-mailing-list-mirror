From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v6 0/4] status: give more information during rebase
Date: Mon,  6 Jul 2015 22:56:00 +0200
Message-ID: <1436216164-7949-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 06 22:56:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCDRA-0002qy-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 22:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbbGFU4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 16:56:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58441 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbbGFU4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 16:56:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t66Ku6Ah007135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jul 2015 22:56:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t66Ku9v9020041;
	Mon, 6 Jul 2015 22:56:09 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZCDQu-00032m-U8; Mon, 06 Jul 2015 22:56:08 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 06 Jul 2015 22:56:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t66Ku6Ah007135
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436820971.11293@SwvAxPj83WqHi322nMp1FQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273460>

This is almost identical to v5. I turned git_path(var) into
git_path("%s", var) as Junio noticed, but I still prefer my version on
the other points discussed.

Guillaume Pag=C3=A8s (4):
  status: factor two rebase-related messages together
  status: differentiate interactive from non-interactive rebases
  status: give more information during rebase -i
  status: add new tests for status during rebase -i

 t/t7512-status-help.sh | 226 +++++++++++++++++++++++++++++++++++++++++=
+++++---
 wt-status.c            | 151 +++++++++++++++++++++++++++++----
 2 files changed, 346 insertions(+), 31 deletions(-)

--=20
2.5.0.rc0.7.ge1edd74.dirty
