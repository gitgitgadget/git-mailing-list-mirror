From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: daemon: allow more than one host addresses given via --listen
Date: Sun, 29 Aug 2010 17:07:40 +0200
Message-ID: <1283094462-5184-1-git-send-email-alexander@sulfrian.net>
References: <7v4oel14tl.fsf@alter.siamese.dyndns.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 17:08:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpjUO-0008IY-W1
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0H2PID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 11:08:03 -0400
Received: from animux.de ([78.46.93.45]:41471 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569Ab0H2PIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 11:08:01 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id 0332380D776D; Sun, 29 Aug 2010 17:08:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr2 (2008-06-10) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.5-gr2
Received: from laptop (unknown [93.214.39.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 7862380D7590;
	Sun, 29 Aug 2010 15:08:11 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Sun, 29 Aug 2010 17:07:57 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <7v4oel14tl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154686>


Hi,
here is version 2 of my patch. I hope i considered all of your hints
Junio.

The patch currently does not support the --listen=host:port format,
but I will look if it could be done. The problem that I currently see:
For IPv6 it should be handle [ipv6-address]:port correctly. But anyway
it should be a patch on top of this patch.

Thanks,
Alex


 Documentation/git-daemon.txt | Alexander Sulfrian (2):
  daemon: add helper function named_sock_setup
  daemon: allow more than one host address given via --listen

 Documentation/git-daemon.txt |    1 +
 daemon.c                     |   62 +++++++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 18 deletions(-)
