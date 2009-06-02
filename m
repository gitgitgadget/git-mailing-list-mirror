From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 1/2] compat: add a mkstemps() compatibility function
Date: Tue, 02 Jun 2009 15:05:05 +0200
Message-ID: <4A252381.9000103@viscovery.net>
References: <1243503831-17993-1-git-send-email-davvid@gmail.com> <e6cd6cf90906020535m24d588eau40b800555c9e906f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, markus.heidelberg@web.de, jnareb@gmail.com
To: Antriksh Pany <antriksh.pany@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:05:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBTgA-0002va-6t
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 15:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbZFBNFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 09:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbZFBNFM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 09:05:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61315 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbZFBNFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 09:05:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MBTfw-0001pj-01; Tue, 02 Jun 2009 15:05:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B56C5FCD2; Tue,  2 Jun 2009 15:05:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <e6cd6cf90906020535m24d588eau40b800555c9e906f@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120508>

Antriksh Pany schrieb:
> 2. tv_usec has a decimal value range of 0-999999  (10^6 usec make 1
> sec). Which means that tv_usec fits completely in 20 bits (or less).
> (tv_usec << 16) yields a number that fits completely in 36 bits (or
> less). Max value of this number is 999999 * 2^16, or for convenience,
> about M = 10^6 * 2^16. This number (in the range of 0 to M) goes on to
> be divided by D=62^6. Also, M > D. Thus, there is about a  D / M * 100
> ~ 87 % probability of the division M / D working out to be zero. i.e,
> in 87% cases, the last division (v/= num_letters) will cause 'v' to
> become 0.

But this value (after the 6th division, mind you) is not used. v is used
the last time after the 5th division; at this time it still carries enough
randomness: 62^5 < 2^32.

-- Hannes
