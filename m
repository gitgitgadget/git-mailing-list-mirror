From: Johannes Sixt <j6t@kdbg.org>
Subject: How to cut extra liftime of expired loose objects
Date: Mon, 30 May 2016 18:43:07 +0200
Message-ID: <574C6D9B.1080200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 18:43:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7QHc-0006ch-JS
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 18:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161664AbcE3QnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 12:43:12 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:30292 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161420AbcE3QnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 12:43:12 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3rJMqx1mG6z5tlF
	for <git@vger.kernel.org>; Mon, 30 May 2016 18:43:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0E10629BD
	for <git@vger.kernel.org>; Mon, 30 May 2016 18:43:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295909>

I think there is logic somewhere in git gc or its minions that gives 
expired objects that have been packed a two weeks extra life time as 
loose objects.

That is, reachable loose objects are moved to a pack, but those objects 
that were packed, but become unreachable due to expired reflogs, are 
evicted from the pack and live for another two weeks or so as loose objects.

As a consequence of this, I always have a few thousand loose objects in 
my busy repositories, no matter how often I collect garbage. Is there a 
knob that removes the extra lease of life of objects without reducing 
the usual expiration times of reflogs etc?

-- Hannes
