From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Fix typo in nedmalloc warning fix
Date: Thu, 11 Jun 2009 22:52:56 +0200
Message-ID: <4A316EA8.1040203@kdbg.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de> <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de> <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de> <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de> <7vr5y3lxrj.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302> <7viqjefxcv.fsf@alter.siame se.dyndns.org> <alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302> <7vprdl9qon.fsf@alter.siames
  e.dyndns.org> <alpine.DEB.1.00.0906081645490.4461@intel-tinevez-2-302> <7vzlcizn3w.fsf@a! lter.siamese.dyndns.org> <CD46A3E1-A85C-4D03-854C-973B91ACC506@zib.de> <4A2F7C80.1090807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 22:53:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MErGj-0006D6-Rr
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 22:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151AbZFKUw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 16:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754399AbZFKUw4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 16:52:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:33357 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbZFKUw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 16:52:56 -0400
Received: from [192.168.1.201] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B8D1BCDF95;
	Thu, 11 Jun 2009 22:52:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A2F7C80.1090807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121359>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  Johannes Sixt schrieb:
  > Please don't advance this series to master just yet: I see severe breakage
  > with the nedmalloc patch on one of my systems, but I ran out of time to
  > investigate further. (And I'm afraid I can continue only next Monday.)

  So, I have the failure on my other system as well, and this is the fix ;)

  -- Hannes

  compat/nedmalloc/malloc.c.h |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index b5b1495..74c42e3 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -2543,7 +2543,7 @@ struct malloc_params {
  static struct malloc_params mparams;

  /* Ensure mparams initialized */
-#define ensure_initialization() ((void)(mparams.magic == 0 || init_mparams()))
+#define ensure_initialization() ((void)(mparams.magic != 0 || init_mparams()))

  #if !ONLY_MSPACES

-- 
1.6.3.2.1225.g177fa.dirty
