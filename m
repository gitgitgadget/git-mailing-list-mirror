From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 13/13] Add basic git daemon support to publish receive-pack
Date: Sun, 4 Jan 2009 00:48:01 +0100
Message-ID: <200901040048.01520.robin.rosenberg@dewire.com>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org> <1229992043-1053-13-git-send-email-spearce@spearce.org> <1229992043-1053-14-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 00:49:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJGFE-0007iZ-W8
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 00:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbZACXsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 18:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbZACXsK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 18:48:10 -0500
Received: from mail.dewire.com ([83.140.172.130]:13316 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755841AbZACXsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 18:48:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 55CED1484F53;
	Sun,  4 Jan 2009 00:48:03 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WOnD54CZJEHE; Sun,  4 Jan 2009 00:48:02 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id AA73F8026CF;
	Sun,  4 Jan 2009 00:48:02 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1229992043-1053-14-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104487>

tisdag 23 december 2008 01:27:23 skrev Shawn O. Pearce:
> +	private static final Pattern SAFE_REPOSITORY_NAME = Pattern
> +			.compile("^[A-Za-z][A-Za-z0-9/_ -]+(\\.git)?$");

This restriction is too strict. Wouldn't any path not containing ".." be valid? In particular this did not work with my "EGIT.contrib" repo. I
have a lot of repos with names llike "name.purpose". Just adding
'.' to the character set isn't really enough.

-- robin
