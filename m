From: David Barr <david.barr@cordelta.com>
Subject: fast-import: use struct hash_table
Date: Thu, 31 Mar 2011 22:59:56 +1100
Message-ID: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5GYD-0002jn-O0
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363Ab1CaMA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 08:00:28 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:53347 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752520Ab1CaMA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 08:00:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 6E907C05A;
	Thu, 31 Mar 2011 22:57:19 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Aee5W5E69kpE; Thu, 31 Mar 2011 22:57:17 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 36DD1C057;
	Thu, 31 Mar 2011 22:57:17 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170475>

The current custom hash tables in fast-import.c do not grow.
This causes poor performance for very large imports.
Fortunately, we have struct hash_table and friends so there's
no need to write cumbersome hash table growth code.

If anyone is interested, I think the hash API documentation
could use an example or two.
