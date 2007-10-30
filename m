From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Missing MIME-headers in git-email-tool ..
Date: Tue, 30 Oct 2007 11:53:38 +0200
Message-ID: <20071030095338.GZ6372@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 10:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImnnI-0003dE-Ae
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 10:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbXJ3Jxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 05:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbXJ3Jxn
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 05:53:43 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:48288 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbXJ3Jxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 05:53:43 -0400
Received: (mea@mea-ext) by mail.zmailer.org id S3540329AbXJ3Jxi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 11:53:38 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The  git-send-email  does send posts without any sort of MIME labeling:

  From: / To: removed

  Subject: [PATCH 0/2] Blackfin I2C/TWI driver updates
  Date: Tue, 30 Oct 2007 17:33:15 +0800
  Message-Id: <1193736797-9005-1-git-send-email-bryan.wu@analog.com>
  X-Mailer: git-send-email 1.5.3.4
  Precedence: bulk


which per MIME rules means that the message in question is equivalent
to one with header labels:

  MIME-Version: 1.0
  Content-Type: text/plain; charset=US-ASCII
  Content-Transfer-Encoding: 7bit

What would be a problem ?   Some of us have names that are encoded
in 8-bit form,  and some receiving systems get all mighty upset when
they receive unlabelled email carry 8-bit encoded texts.
(Thanks to chinese and russian spammers..)


Now if the  git-send-email would add following three lines in all
outgoing email headers, things would be 99% correct for a long time..

  MIME-Version: 1.0
  Content-Type: text/plain; charset=ISO-8859-15
  Content-Transfer-Encoding: 8BIT

The potential incorrectness is with UTF-8 encoded names.
Even then it probably is merely nuisance and not real delivery
preventing detail.

  /Matti Aarnio -- one of <postmaster @ vger.kernel.org>
