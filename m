From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/3] Support `git pull --rebase=interactive`
Date: Tue, 12 Jan 2016 16:22:06 +0100 (CET)
Message-ID: <cover.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ0nE-000140-AC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 16:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762783AbcALPX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 10:23:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:54984 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbcALPXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 10:23:24 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MLNeQ-1aJYji15Sk-000ZM2; Tue, 12 Jan 2016 16:22:08
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:o+lJaJp/+J5b7RK/qx+256qbj+FZWnTJmWgTNE+WlfWVcQV3We7
 FTakaFqb+uOxG21nM+HMudzcJbDKaG0/ciVk98dTiTNFG01t1uVVsPrqkO/CWp999S0vo9l
 zKcqwa9isPU0PCHh+R903B7TEBdiqv3BgELYZIMJKmr0YS1Uj336Lz7MXD7K4FqxxeFTYRf
 E/KDPYNzpdTBmQlnKtR0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qu6vtRIuTcI=:0j11gkDaw/z482WEXWVvqm
 nu4LT+YZtR9CsxDbQKU0iJXR+EdEFMbNA/WkaYmqipWz7rvn7Cg1t0IoIiEyZWITfiNBA4KwH
 bTY1HBL8epeXsDMUZ5r3U94HhkLBIWMDAdGzqeNrbLap/Z0CVEoiv94MQNRYRD9K3Y0zf2CLU
 mQDSuk+hCxg39kmzoO0is9fHOOMGQcOu24dHhl05VBC9StOj9wiXuyYQZ5iQMnWLcC0QTySCV
 I9QX5R3pzZJPOS3yBCxfn2RO5jCJ6UV7SUGU5jBW+qA7gDG6mTWS4KKs0v5/ko4Ngz7WZh3Qb
 xdGyD6+Bi6IQsnFX946tNL28nW04+UfRgM4VIDei2bgS4CLx2q5yh4v7fEBP1WftPBjmKrtGK
 zywMixxphdBk4mzo/I0XfIS8g9qgQS2aXC45vHgbeRaBxS/mYC8PzEeICzAcMdfUNWLM8n8eF
 ZzAnSSGilkB+k6i59aRau9izpjdk3ZLjDQn65OCLVjEmY0Z4KN/DSKUaBvrVdE3sWR6PQmb2U
 jgZdgLV5KW5iiTRPKBKIdtogBN3pWlPTPK1xuCifsHxI2SFrqO+Xr4+KY6nhgeMku+Rskg/F/
 maWoemDRaInmKCyGOj4rOK5wYlTYU/dHNo0Yl9wm6KrIsEKSu+jF639h7Tay4wi9GC98PE71z
 F5SEhaQggvU29sbTUQwjSYsNgkW5dbRuUy8l1HDVNJ7TT6R0qeVK4uYR1BC5TPW+6AFarA/9W
 1DB8wvwiNnBrUcSpm5qR9AmAl+bzcBspEZOlq8BgaJHOS4NTraEHilZ6sjo7bXg2Btl4Up0T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283821>

A couple of years ago, I found the need to collaborate on topic branches
that were rebased all the time, and I really needed to see what I was
rebasing when pulling, so I introduced an interactively-rebasing pull.

This patch series ports that work to the builtin pull.


Johannes Schindelin (3):
  Teach 'git pull' to handle --rebase=interactive
  Teach 'git remote' that the config var branch.*.rebase can be
    'interactive'
  completion: add missing branch.*.rebase values

 Documentation/config.txt               |  1 +
 Documentation/git-pull.txt             |  4 +++-
 builtin/pull.c                         |  7 ++++++-
 builtin/remote.c                       |  8 ++++++--
 contrib/completion/git-completion.bash |  2 +-
 t/t5520-pull.sh                        | 10 ++++++++++
 6 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.6.3.windows.1.300.g1c25e49
