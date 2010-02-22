From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/6 v3] Allow Git repositories to be shared using POSIX ACLs
Date: Mon, 22 Feb 2010 23:32:10 +0100
Message-ID: <1266877936-13537-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: nhat minh le <nhat.minh.le@huoc.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 22 23:38:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjgvB-0002R7-US
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab0BVWi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:38:29 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55662 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483Ab0BVWi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:38:29 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1MMU4pT027762
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 23:30:04 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NjgpG-0007kY-4p; Mon, 22 Feb 2010 23:32:26 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NjgpG-0003XE-2N; Mon, 22 Feb 2010 23:32:26 +0100
X-Mailer: git-send-email 1.7.0.54.gb6a04.dirty
In-Reply-To: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Feb 2010 23:30:04 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140730>

This version should include fixes for all of Junio's comment:

[PATCH 1/6] Add a testcase for ACL with restrictive umask.
=> This should pass with any umask, and includes a fix for FreeBSD
(but I'm not sure it's sufficient)

[PATCH 3/6] git_mkstemp_mode, xmkstemp_mode: variants of gitmkstemps with mode argument.
=> better log message suggested by Junio.

[PATCH 5/6] git_mkstemps_mode: don't set errno to EINVAL on exit.
=> I actually got rid of this return EINVAL.
