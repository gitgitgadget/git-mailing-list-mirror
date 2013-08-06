From: David Kastrup <dak@gnu.org>
Subject: git rebase -i error message interprets \t in commit message
Date: Tue, 06 Aug 2013 17:44:43 +0200
Message-ID: <87k3jy6cyc.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 17:45:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6jRV-0005HV-57
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 17:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab3HFPo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 11:44:56 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:50980 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab3HFPo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 11:44:56 -0400
Received: from localhost ([127.0.0.1]:50023 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1V6jRP-0000qx-GI
	for git@vger.kernel.org; Tue, 06 Aug 2013 11:44:55 -0400
Received: by lola (Postfix, from userid 1000)
	id C0C23EAC27; Tue,  6 Aug 2013 17:44:43 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231756>


Hi,

I just got the following error message:

dak@lola:/usr/local/tmp/lilypond$ git rebase -i
Waiting for Emacs...
error: could not apply 16de9d2... Make tempo range \tempo 20~30 be input as \tempo 20-30 instead

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
Could not apply 16de9d2... Make tempo range 	empo 20~30 be input as 	empo 20-30 instead
dak@lola:/usr/local/tmp/lilypond$ git --version
git version 1.8.1.2

As you can see, the first message starting with "error: could not apply"
outputs a reasonable rendition of the commit summary line.  However, the
final "Could not apply" message (starting with a capital C) converts
instances of \t to a tab.

This is on Ubuntu 13.04 with

lrwxrwxrwx 1 root root 4 Aug 15  2012 /bin/sh -> dash

-- 
David Kastrup
