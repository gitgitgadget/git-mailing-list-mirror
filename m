From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Provide API to invalidate refs cache
Date: Mon, 10 Oct 2011 07:46:12 +0200
Message-ID: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
References: <7v39f2rko5.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 07:46:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD8h4-00062a-7k
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 07:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab1JJFqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 01:46:25 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:56637 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab1JJFqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 01:46:25 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RD8bR-0003hC-7Z; Mon, 10 Oct 2011 07:40:41 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <7v39f2rko5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183223>

I am happy to provide the API; see the following patches.

But I won't have time to figure out who, outside of refs.c, has to
*call* invalidate_cached_refs().  The candidates that I know off the
top of my head are git-clone, git-submodule, and git-pack-refs.  It
would be great if experts in those areas would insert calls to
invalidate_cached_refs() where needed.

Even better would be if the meddlesome code were changed to use the
refs API.  I'd be happy to help expanding the refs API if needed to
accommodate your needs.

Michael Haggerty (2):
  invalidate_cached_refs(): take the submodule as parameter
  invalidate_cached_refs(): expose this function in refs API

 refs.c |   12 ++++--------
 refs.h |    8 ++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

-- 
1.7.7.rc2
