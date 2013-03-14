From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/2] checkout-index: fix .gitattributes handling with --prefix
Date: Thu, 14 Mar 2013 20:00:49 +0000
Message-ID: <cover.1363291173.git.john@keeping.me.uk>
References: <7vehfhyjgv.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 21:01:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGELI-00037u-VS
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 21:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301Ab3CNUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 16:01:09 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:38351 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3CNUBI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 16:01:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 788C3161E47D;
	Thu, 14 Mar 2013 20:01:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B2-Fft91+-YO; Thu, 14 Mar 2013 20:01:07 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D3634161E291;
	Thu, 14 Mar 2013 20:00:57 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc2.4.g7799588
In-Reply-To: <7vehfhyjgv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218161>

This is from the recent "difftool --dir-diff" discussion.  With these
patches applied I think "difftool --dir-diff" should correctly apply
filters to the files that it checks out with no changes to the
git-difftool code.

John Keeping (2):
  t2003: modernize style
  entry: fix streaming filter path

 entry.c                         |   2 +-
 t/t2003-checkout-cache-mkdir.sh | 169 +++++++++++++++++++++++-----------------
 2 files changed, 97 insertions(+), 74 deletions(-)

-- 
1.8.2.rc2.4.g7799588
