From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2 0/2] Stream fd to clean filter
Date: Wed,  6 Aug 2014 07:32:12 +0200
Message-ID: <1407303134-16635-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 07:32:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEtqG-0002Ud-V5
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 07:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbaHFFch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 01:32:37 -0400
Received: from mailer.zib.de ([130.73.108.11]:40488 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbaHFFch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 01:32:37 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s765WOlM020285;
	Wed, 6 Aug 2014 07:32:24 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s765WNKs020135;
	Wed, 6 Aug 2014 07:32:23 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
X-Miltered: at mailer.zib.de with ID 53E1BDE8.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53E1BDE8.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53E1BDE8.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254845>

The main difference to the previous version is that I've split off the
refactoring into a separate commit.  The rest is polishing the style.

Steffen Prohaska (2):
  convert: Refactor would_convert_to_git() to single arg 'path'
  convert: Stream from fd to required clean filter instead of mmap

 convert.c             | 60 ++++++++++++++++++++++++++++++++++++++++-----
 convert.h             | 10 +++++---
 sha1_file.c           | 29 ++++++++++++++++++++--
 t/t0021-conversion.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 151 insertions(+), 16 deletions(-)

-- 
2.1.0.rc1.6.gb569bd8
