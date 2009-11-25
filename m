From: Sam Vilain <sam@vilain.net>
Subject: Client-side mirroring patches (v0)
Date: Wed, 25 Nov 2009 23:06:53 +1300
Message-ID: <1259143617-26580-1-git-send-email-sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 11:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDF3L-0006bC-GN
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934064AbZKYKYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758490AbZKYKYh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:24:37 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51584 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbZKYKYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:24:37 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 2582121C3EE; Wed, 25 Nov 2009 23:07:03 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id C3DDB21C36E
	for <git@vger.kernel.org>; Wed, 25 Nov 2009 23:06:47 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NDEm3-0006vO-0b
	for git@vger.kernel.org; Wed, 25 Nov 2009 23:06:59 +1300
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133626>

Hey folks, this is the first stage of git mirroring - making the
client support it in the face of a completely ignorant server.  I
intended to make the clean-up better, but I've been sitting on these
for a couple of weeks so I thought it would be better to have them out
there for people to have a squiz at.

The next stage would be for the mirror list to be communicated to
clients over the network protocol and updated in the git config.

Also there is the matter of falling over to the next mirror should one
not be reachable, but then we're getting into C weaknesses really.
Should I plan to do exception recovery using 'longjmp' ?  Also the
process should be interruptible and provide a user menu.  Again this
seems like it would be very tedious and clumsy in C.  How do people
manage?  Anyway, enjoy... Sam
