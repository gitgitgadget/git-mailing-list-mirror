From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sat, 23 Jan 2010 12:40:27 +0100
Message-ID: <201001231240.28138.robin.rosenberg@dewire.com>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <7vmy06et5c.fsf@alter.siamese.dyndns.org> <4B59637D.4090503@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Jan 23 12:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYeM2-000550-8g
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 12:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab0AWLkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 06:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709Ab0AWLkd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 06:40:33 -0500
Received: from mail.dewire.com ([83.140.172.130]:25455 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932068Ab0AWLkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 06:40:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C0760147E151;
	Sat, 23 Jan 2010 12:40:29 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HXf7ODaTmzku; Sat, 23 Jan 2010 12:40:29 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 228CC800353;
	Sat, 23 Jan 2010 12:40:29 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <4B59637D.4090503@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137839>

fredagen den 22 januari 2010 09.36.13 skrev  Johannes Sixt:
> Junio C Hamano schrieb:
> > Credit for test script, motivation and initial patch goes to Thomas Rast,
> > but the bugs in the implementation of this patch are mine..
> 
> And with this squashed in it has fewer of them ;-) and is more portable.
> The bug was that /foo was incorrectly stripped from /foobar.

It seems this function does something unhealthy when you pass a path of the 
form //server/share. On windows dropping the double // at the beginning makes
it a different path since // is the UNC prefix.

I'm not sure git on windows actually works with UNC-prefix anyway, so my point 
may be moot, but having even more places to fix to make it work doesn't help.

-- robin
