From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 0/3] Updates to git-add--interactive
Date: Sat, 24 Nov 2007 13:55:19 +0100
Message-ID: <1195908922-88023-1-git-send-email-win@wincent.com>
References: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 13:56:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvuYe-0000yr-3D
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 13:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbXKXMzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 07:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbXKXMzy
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 07:55:54 -0500
Received: from wincent.com ([72.3.236.74]:34072 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbXKXMzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 07:55:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAOCtOoo008418;
	Sat, 24 Nov 2007 06:55:26 -0600
X-Mailer: git-send-email 1.5.3.6.1994.g315c0c
In-Reply-To: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65946>

Based on feedback from Junio last night here is a new series. This one
goes on top of the "next" branch.

I moved the pathspec validity checking into builtin-add, thus
simplifying things considerably. I also enforced some strict assumptions
about how the optional arguments will be passed from builtin-add to
git-add--interactive; I can do this because it is the only caller, and
it once again makes things a bit simpler.

I don't expect this to actually be applied as-is, as there are some
doubts I have which I have added to the emails for each patch. In
particular there is a performance issue with the pathspec validity
checking (no idea why it is so much slower than just invoking
git-ls-files), and the behaviour is not exactly where I'd like it to be
(things like "git-add -i ." don't work because "." is considered
invalid).

So looking for feedback on how to address this issues and will resubmit.
