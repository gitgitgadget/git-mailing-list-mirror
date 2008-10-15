From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: --diff-filter=T does not list x changes
Date: Wed, 15 Oct 2008 20:42:35 +0200
Message-ID: <871vyhbsys.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 20:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqBLZ-0007k0-4S
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 20:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbYJOSmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYJOSmh
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 14:42:37 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:34492 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbYJOSmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 14:42:37 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 164F714068
	for <git@vger.kernel.org>; Wed, 15 Oct 2008 20:42:38 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id CE0551405A
	for <git@vger.kernel.org>; Wed, 15 Oct 2008 20:42:37 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98295>

>From documentation, I would expect --diff-filter to list changes in
the execute bit, but it does not. I hear on #git that this is
intended, though I still do not know how to filter on the execute bit.
Is it impossible?


Testcase:

  mkdir t && cd t && git init
  touch a && git add -A && git commit -m1
  chmod +x a && git add -A && git commit -m2
  git log --diff-filter=T        # <--- shows nothing
  rm -f a && ln -s b a && git add -A && git commit -m3
  git log --diff-filter=T


Anders
