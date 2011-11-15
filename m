From: Tim Walberg <twalberg@comcast.net>
Subject: odd name-rev behavior?
Date: Tue, 15 Nov 2011 15:15:14 -0600
Message-ID: <20111115211514.GE27706@comcast.net>
Reply-To: Tim Walberg <twalberg@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 22:20:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQQR7-0004U1-KL
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 22:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416Ab1KOVUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 16:20:52 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:41245 "EHLO
	qmta02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932385Ab1KOVUw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 16:20:52 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Nov 2011 16:20:52 EST
Received: from omta24.emeryville.ca.mail.comcast.net ([76.96.30.92])
	by qmta02.emeryville.ca.mail.comcast.net with comcast
	id xZ2u1h0021zF43QA2ZF9Bt; Tue, 15 Nov 2011 21:15:09 +0000
Received: from beta.localdomain ([67.184.156.247])
	by omta24.emeryville.ca.mail.comcast.net with comcast
	id xZXr1h00q5LYcRf8kZXsaL; Tue, 15 Nov 2011 21:31:53 +0000
Received: from calvin.localdomain ([10.0.0.8])
	by beta.localdomain with esmtp (Exim 4.69)
	(envelope-from <twalberg@comcast.net>)
	id 1RQQLa-0003QM-E4; Tue, 15 Nov 2011 15:15:14 -0600
Received: from tew by calvin.localdomain with local (Exim 4.69)
	(envelope-from <tew@calvin.localdomain>)
	id 1RQQLa-0005Hf-9a; Tue, 15 Nov 2011 15:15:14 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185487>

Never noticed this before - is this expected? It doesn't seem to
match documentation, in any case...

Basically, 'git name-rev --all' lists a lot of lines that are
marked as "undefined", and most, if not all, of the objects
represented are trees, not commits... I wouldn't have expected
name-rev to follow the link from a commit to a tree and try to
process that result...

> git --version
git version 1.7.7.3
> git name-rev --all | tail -10
ed858730bc0e40d5317543ca4a199f1902b1c545 master~35
ea6d0d16af77b357caab59bda3eff8efe78370c1 undefined
ea01449260d4ed49cc30ffff8fa840273e182195 undefined
f0a186fa05e9d4dd2de85ab537ac019a74b84736 undefined
f223486e4178e0b2d6645fa3d0478602a6aec548 undefined
f6f969d943f981057d9243d5fc2d8a79864cb542 master~19
f73dc68c32681939d2ce92378128889c7b6a8902 master~90
f739f050f0a20692e947604d0d5a464cdd5393aa master~109
faa7bf622b69c93f1f21eec0de3bd0ab6957b888 master~94
ff41d4390d3fabf1ba886749a51a20722b159fdd undefined
> git cat-file -t ff41d4
tree
>


-- 
+----------------------+
| Tim Walberg          |
| 830 Carriage Dr.     |
| Algonquin, IL 60102  |
| twalberg@comcast.net |
+----------------------+
