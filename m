From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: t0008 hang on streaming test (OS X)
Date: Wed, 10 Jul 2013 12:36:40 -0400
Message-ID: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 10 18:36:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwxNp-0006nJ-IM
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 18:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab3GJQgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 12:36:45 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42406 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab3GJQgp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jul 2013 12:36:45 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A457E2736300; Wed, 10 Jul 2013 16:36:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.237] (ip-64-134-66-68.public.wayport.net [64.134.66.68])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id CEAA527361A3
	for <git@vger.kernel.org>; Wed, 10 Jul 2013 16:36:40 +0000 (UTC)
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230059>

The newest test in t0008 "streaming support for --stdin", seems to hang sporadically on my MacBook Pro (running 10.8.4).  The hang seems to be related to running it in parallel with other tests, as I can only reliably cause it by running with prove  and -j 3.  However, once that has hung I am able to semi-reliably have it occur by running the test separately (with the test hung in the background, using separate trash directories via the --root option).

Experimentation has led me to find that it is hanging when trying to read the 2nd response from check-ignore.

I am somewhat stuck on how to fix it.  Any ideas?

~~ Brian Gernhardt