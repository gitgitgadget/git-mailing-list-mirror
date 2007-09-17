From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] Updated git-gc --auto series.
Date: Mon, 17 Sep 2007 01:43:25 -0700
Message-ID: <11900186052005-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 10:45:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCEL-00089U-K3
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706AbXIQIna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 04:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756056AbXIQIn3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:43:29 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225AbXIQIn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:43:28 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E349413686D
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 04:43:48 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58395>

An updated series of "git-gc --auto", on top of 'next',
consisting of 8 patches, will follow this message.

Differences from the previous round are:

 - Earlier if you have too many unreachable loose objects,
   automated gc would have tried to "repack -d -l" which would
   not improve the situation at all every time it was run.  It
   now at least warns upon such a situation;

 - pack-objects learned --keep-unreachable option which helps
   "repack -a -d" not to lose packed but unreachable objects
   while repacking existing packs into a new pack;

 - repack learned -A option which is similar to -a but gives
   --keep-unreachable to underlying pack-objects;

 - "git-gc --auto" runs "git-repack -A -d -l" when there are too
   many packs in the repository;

 - These changes are documented ;-)
