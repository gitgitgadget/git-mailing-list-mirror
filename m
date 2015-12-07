From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Post-receive hook for "git pull"
Date: Mon, 07 Dec 2015 08:47:58 -0500
Message-ID: <jwv4mful6nu.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 14:48:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5w9P-0007GJ-76
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 14:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbbLGNsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 08:48:13 -0500
Received: from plane.gmane.org ([80.91.229.3]:56396 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755046AbbLGNsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 08:48:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1a5w96-0006qH-Q6
	for git@vger.kernel.org; Mon, 07 Dec 2015 14:48:05 +0100
Received: from 104-247-246-42.cpe.teksavvy.com ([104-247-246-42.cpe.teksavvy.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 14:48:04 +0100
Received: from monnier by 104-247-246-42.cpe.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 14:48:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 104-247-246-42.cpe.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Cancel-Lock: sha1:khVq1TD7euFO/2rqLuKsDudw8iA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282093>

I have a system here where it can be quite common to have thousands of
branches in the remote repository, and where I'd like to update some
local state according to the appearance of new branches (or updates of
pre-existing ones).

Currently, I use a "git for-each-ref" after pulling and then check (for
each one of those refs) if an update is warranted, but this can get slow
with that many branches.  Is there some way to get something like the
post-receive hook to be run for "git pull", so that the script gets told
directly which (remote tracking) branches have been modified/created?


        Stefan
