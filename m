From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] patch series to sketch a less verbose and frightening output
Date: Sat, 29 Sep 2007 12:45:54 +0200
Message-ID: <1191062758-30631-1-git-send-email-madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 12:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbZpt-0005Zy-PZ
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 12:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbXI2KqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 06:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbXI2KqB
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 06:46:01 -0400
Received: from pan.madism.org ([88.191.52.104]:51034 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755974AbXI2KqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 06:46:00 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CB89222589
	for <git@vger.kernel.org>; Sat, 29 Sep 2007 12:45:59 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D025A23ADFB; Sat, 29 Sep 2007 12:45:58 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.2.1114.ga57c3
In-Reply-To: 20070929090121.GA4216@artemis.corp
References: 20070929090121.GA4216@artemis.corp
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59457>

  Follow 4 patches that rework progress.c a bit so that one stage only
takes one line of output with a progress bar.

  Some of the patch fix (IMHO) pointless lines to print on screen (even
for debugging purposes).

  With those patches, running git gc looks like:

    $ git gc
    Counting objects    : 10095
    Deltifying objects  : [===================================================] 100%
    Writing objects     : [==========================>                        ] 50%

    [...]

    Counting objects    : 10095
    Deltifying objects  : [===================================================] 100%
    Writing objects     : [===================================================] 100%
    Pruning objects     : [===================================================] 100%

I don't believe those patches are 100% okay yet, because it doesn't
plays that nice during a clone (it's not horribly broken, merely
surprising). But it sketches what it could look like.
