From: Josh Triplett <josh@joshtriplett.org>
Subject: Easiest way to clone over an existing directory?
Date: Wed, 15 Jun 2016 08:51:34 -0700
Message-ID: <20160615155133.GA13168@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 17:51:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDD6Y-0006T1-MY
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 17:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbcFOPvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 11:51:42 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46084 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932700AbcFOPvl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 11:51:41 -0400
Received: from mfilter38-d.gandi.net (mfilter38-d.gandi.net [217.70.178.169])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 880A3A80D3
	for <git@vger.kernel.org>; Wed, 15 Jun 2016 17:51:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter38-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter38-d.gandi.net (mfilter38-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id kzERB4tTf55d for <git@vger.kernel.org>;
	Wed, 15 Jun 2016 17:51:37 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B760DA80D1
	for <git@vger.kernel.org>; Wed, 15 Jun 2016 17:51:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297379>

Currently, every time I set up a new system, I run the following:

git clone $MY_HOMEDIR
mv home/.git .
rm -r home
git checkout -f

This seems like an odd dance to go through.  But I can't just git clone
into ~ directly, because git clone will not clone into an existing
non-empty directory.

(I could use "git clone -n" to avoid the unnecessary checkout, but the
files are small, and it wouldn't remove the need to rmdir so the number
of commands would remain the same.)

Does some better way exist to handle this?  And if not, would it make
sense for git clone to have an option to clone into an existing
directory (which should also avoid setting junk_work_tree)?
