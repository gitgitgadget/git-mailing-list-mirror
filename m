X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 0/5] Shallow clone fixes
Date: Fri, 24 Nov 2006 15:57:15 +0100
Message-ID: <8764d4vqno.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 15:26:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32226>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GncwZ-00065m-Qk for gcvg-git@gmane.org; Fri, 24 Nov
 2006 16:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934779AbWKXP0U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934782AbWKXP0U
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 10:26:20 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:33258 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S934779AbWKXP0T
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 10:26:19 -0500
Received: from adsl-84-226-49-216.adslplus.ch ([84.226.49.216]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GncwU-00067L-NG for
 git@vger.kernel.org; Fri, 24 Nov 2006 09:26:19 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 2130D10A151; Fri,
 24 Nov 2006 15:57:16 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This series fixes a number of small problems in the shallow clone
support in pu. After that it seems to work fairly well for me.

The one remaining problem I see is that a git-fetch to deepen the tree
doesn't take into account the commits that the client already has. For
instance, on the Wine tree, a "git-clone --depth 1" downloads 4655
objects, and a "git-clone --depth 2" downloads 4660, so I'd expect
that after the depth 1 clone a "git-fetch --depth 2" would only have
to download 5 objects, but currently it downloads 4650 again.

-- 
Alexandre Julliard
