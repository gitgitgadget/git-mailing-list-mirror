From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 05/10] Do not write to the reflog unless the refupdate logmessage is set
Date: Mon, 8 Jun 2009 00:27:16 +0200
Message-ID: <200906080027.16338.robin.rosenberg.lists@dewire.com>
References: <20090520221651.GR30527@spearce.org> <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com> <20090603154129.GG3355@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQpw-0008Vh-Mx
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbZFGW1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 18:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZFGW1V
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:27:21 -0400
Received: from mail.dewire.com ([83.140.172.130]:20147 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbZFGW1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 18:27:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2CADE146D03E;
	Mon,  8 Jun 2009 00:27:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IaLe7TQ2uAd; Mon,  8 Jun 2009 00:27:17 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 7AB86146D027;
	Mon,  8 Jun 2009 00:27:17 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090603154129.GG3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121015>

onsdag 03 juni 2009 17:41:29 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > Do not write to the reflog unless the refupdate logmessage is set
> 
> Why not?  What is the justification for this?  Isn't a reflog record
> still useful, at least to point out that something happened at this
> point in time, and here's the old/new values?

I need to do an update without logging to avoid a "dummy" entry in the
reflog since I use the RefUpdate mechanism. Since this is an API and
not and end user function, I was thinking this might be ok after all.

Some other optione are:
1) set a special flag.
2) set a default message and allow the caller to set it to null and
not write if null. Today the default message is null leading to the
message "null" in the log, which is kind of ugly so we should
probably change this in any case.

-- robin
