From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/2] jc/merge-theirs, rebased on top of mv/merge-in-c
Date: Mon, 23 Jun 2008 14:45:26 +0200
Message-ID: <cover.1214224424.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 14:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAlRV-0001zm-89
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 14:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbYFWMpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 08:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbYFWMp3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 08:45:29 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48108 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbYFWMp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 08:45:28 -0400
Received: from vmobile.example.net (dsl5401C3C5.pool.t-online.hu [84.1.195.197])
	by yugo.frugalware.org (Postfix) with ESMTP id 7A0E21DDC5C;
	Mon, 23 Jun 2008 14:45:25 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 561F318E0E6; Mon, 23 Jun 2008 14:45:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85860>

On Mon, Jun 23, 2008 at 12:15:35AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Currently tip of 'pu' is broken and does not pass tests, as j6t/mingw
> has interaction with dr/ceiling and jc/merge-theirs has interaction
> with mv/merge-in-c.

Here is jc/merge-theirs, on top of mv/merge-in-c. Now all tests pass
here if I merge both to master.

To avoid unnecessary traffic, I do not send e0aafb4 ([PATCH 1/2]
git-merge-file --ours, --theirs"), as that is unchanged.

Junio C Hamano (2):
  git-merge-file --ours, --theirs
  git-merge-recursive-{ours,theirs}

 Documentation/git-merge-file.txt |   12 +++++++-
 Makefile                         |    3 ++
 builtin-merge-file.c             |   10 +++++-
 builtin-merge-recursive.c        |   37 ++++++++++++++++++++++---
 builtin-merge.c                  |    2 +
 git.c                            |    2 +
 ll-merge.c                       |   24 ++++++++++------
 ll-merge.h                       |    4 ++-
 t/t6034-merge-ours-theirs.sh     |   56 ++++++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                    |    8 +++++-
 xdiff/xmerge.c                   |   24 +++++++++++-----
 11 files changed, 155 insertions(+), 27 deletions(-)
 create mode 100755 t/t6034-merge-ours-theirs.sh
