From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/2] bash completion: Support "divergence from upstream" warnings in __git_ps1
Date: Sat, 12 Jun 2010 12:03:38 +0200
Message-ID: <cover.1276336602.git.trast@student.ethz.ch>
References: <20100612000002.GA30196@neumann>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Jun 12 12:03:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONNZ6-000052-Ga
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 12:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab0FLKDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 06:03:43 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:30924 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615Ab0FLKDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 06:03:42 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 12:03:43 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 12:03:38 +0200
X-Mailer: git-send-email 1.7.1.561.g94582
In-Reply-To: <20100612000002.GA30196@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149001>

[Argh.  Or maybe it's an encoding problem?]

SZEDER Gabor wrote:
> Furthermore, I think it would be good to provide means to disable this
> feature for some repositories while keeping it enabled for others.  In
> the current version I could either disable or enable it globally.
> Perhaps we could disable it when bash.showUpstream is set to an empty
> value.

Well, I wanted to leave this to Andrew but since I'm already messing
around with it, here's my take on it.  I might be getting a bit
feature creepy, but it should be prepared for all possible uses now.

The semantics now are that (as with e.g. GIT_PS1_SHOWDIRTYSTATE) you
have to set the environment variable to get anything, but after that,
the config *always* overrides (so you can disable again).

Furthermore, the SVN code tries remotes/git-svn first (for
single-branch clones), and there are new features to set a certain ref
or provide a small snippet of hook code.


Andrew Sayers (1):
  bash completion: Support "divergence from upstream" warnings in
    __git_ps1

Thomas Rast (1):
  rev-list: introduce --count option

 Documentation/rev-list-options.txt     |    9 +++
 builtin/rev-list.c                     |   16 ++++++
 contrib/completion/git-completion.bash |   89 +++++++++++++++++++++++++++++++-
 revision.c                             |    2 +
 revision.h                             |    5 ++
 t/t6007-rev-list-cherry-pick-file.sh   |   29 ++++++++++
 6 files changed, 149 insertions(+), 1 deletions(-)
