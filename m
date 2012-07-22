From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week
 13
Date: Sun, 22 Jul 2012 17:22:17 +0200
Message-ID: <500C1AA9.4000306@dewire.com>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox> <7vwr23zb65.fsf@alter.siamese.dyndns.org> <20120717082452.GC1849@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, pclouds@gmail.com, trast@student.ethz.ch,
	JGit Developers list <jgit-dev@eclipse.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 17:22:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssxzb-0004ix-Pb
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 17:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab2GVPWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 11:22:21 -0400
Received: from mail.dewire.com ([83.140.172.130]:15745 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006Ab2GVPWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 11:22:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id ED8BC8FC75;
	Sun, 22 Jul 2012 17:22:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFmgfLrajHf3; Sun, 22 Jul 2012 17:22:40 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 786508FC74;
	Sun, 22 Jul 2012 17:22:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120717 Thunderbird/15.0
In-Reply-To: <20120717082452.GC1849@tgummerer.surfnet.iacbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201852>


A note on how JGit would work here. Java has none of the fields
that constitute statcrc. I guess we would write zero here when
creating new entries. Git could recognize that when checking status and 
simply assume "clean" unless mtime or st_size says otherwise.

For existing entries JGit could either keep the old value (which is
probably a lie since) or zero it.

A modification to the spec would be that 0 == not set.

-- robin
