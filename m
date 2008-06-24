From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] leaky()
Date: Tue, 24 Jun 2008 22:14:32 +0200
Message-ID: <1214338474-16822-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 22:15:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEvO-0001UV-N3
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbYFXUOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbYFXUOj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:14:39 -0400
Received: from pan.madism.org ([88.191.52.104]:55490 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbYFXUOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:14:37 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5691D3830F;
	Tue, 24 Jun 2008 22:14:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 41710357716; Tue, 24 Jun 2008 22:14:34 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.119.gbb8cf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86138>

In the parse-options thread, it appears that we may somethings leak some
tiny bits of memory on purpose. So that it makes life of people
searching for real memory leaks easier.

The second patch marks the leaks I'm responsible for in git (and that
I'm aware of) as leaky().
