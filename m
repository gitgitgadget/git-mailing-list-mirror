From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC/PATCH] Fix t7601-merge-pull-config.sh on AIX
Date: Sun, 6 Jul 2008 04:15:16 -0400
Message-ID: <F378B75D-AC1B-4AA6-9DBD-616568DBADA4@silverinsanity.com>
References: <1215267838-19402-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>, git@vger.kernel.org,
	Mike Ralphson <mike@abacus.co.uk>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 10:16:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFPPu-0008KD-Oy
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 10:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYGFIPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 04:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbYGFIPU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 04:15:20 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:36959 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYGFIPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 04:15:19 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 0A33A1FFC022;
	Sun,  6 Jul 2008 08:15:03 +0000 (UTC)
In-Reply-To: <1215267838-19402-1-git-send-email-vmiklos@frugalware.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87504>


On Jul 5, 2008, at 10:23 AM, Miklos Vajna wrote:

> The test failed on AIX (and likely other OS, such as apparently OSX)
> where wc -l outputs whitespace.

ACK.  This test does break on OS X and this patch fixes it.

Took me a while to realize why it was saying "8: command not found".   
Apparently "resolve_count= 8" means something very different than  
"resolve_count=8".  Then I remembered seeing a patch recently that hit  
conflict_count and I didn't have to think about how to fix it.

Thanks,
~~ Brian
