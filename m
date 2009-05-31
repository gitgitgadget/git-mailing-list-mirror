From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: inconsistency with --abbrev=0
Date: Sun, 31 May 2009 17:48:00 +0200
Message-ID: <200905311748.00782.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 17:48:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAnGa-00032M-K3
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 17:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbZEaPsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 11:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754974AbZEaPr7
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 11:47:59 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:34605 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbZEaPr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 11:47:59 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id D49AD104302D5
	for <git@vger.kernel.org>; Sun, 31 May 2009 17:47:57 +0200 (CEST)
Received: from [89.59.69.237] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MAnGP-0000jX-00
	for git@vger.kernel.org; Sun, 31 May 2009 17:47:57 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/xvOU5iU5zUcyvDsYBxjGu94txytrEmXrRvUS7
	EtivnY3gw+oLmStvrclP4gTL0kufdZqPJoO9TEyNfQqxvB6E0t
	2rC4ozFsD8gw1LyQ3EuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120405>

The minimum (>=4) number of chars is shown by

  git log|show|whatchanged --abbrev-commit --raw --abbrev=0
  git rev-list --abbrev-commit --abbrev=0 HEAD
  git show-ref --abbrev=0
  and the various diff commands

All 40 are shown by

  git branch -v --abbrev=0
  git ls-files --stage --abbrev=0
  git ls-tree --abbrev=0 HEAD

The latter group uses parse-options and doesn't set abbrev to 4 in this
case. This is needed for git-describe to omit the output of the commit.

What should --abbrev=0 behave like?

Markus
