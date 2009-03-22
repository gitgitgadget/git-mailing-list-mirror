From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC] git gui doesn't call post-checkout hook on checkout or clone
Date: Sun, 22 Mar 2009 16:49:05 +0100
Message-ID: <49C65DF1.8030608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, spearce@spearce.org, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 16:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlPwz-0001kK-Ds
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 16:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbZCVPtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 11:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754584AbZCVPtM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 11:49:12 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:46512 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbZCVPtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 11:49:12 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7D372F9735C7;
	Sun, 22 Mar 2009 16:49:09 +0100 (CET)
Received: from [80.128.47.63] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277)
	id 1LlPvB-0001ou-00; Sun, 22 Mar 2009 16:49:09 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/UiCNxn8eXtrBvZydGtFE9IXzYqn6lKCTfBOLg
	8hZHjaK4g8z1KnpoojglECXfbChZRMwTbpPSO7rKs446bzl/d+
	KcT64i2PpE/44NngPZbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114148>

When checking out or cloning via git gui, the post-checkout
hook is not called. This is a bit unexpected ...

The reason is that git gui uses git read-tree with the -u
option and not git checkout and git clone. I changed git
read-tree to call the post-checkout hook when called with
-u and it seems to solve the problem. I would make a patch
for that if you want.

But is this the right way to do this? Seems like we could
surprise some users of git read-tree with this change in
behaviour.

(I hope i cc'ed the right people this time ;-)

Jens
