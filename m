From: Andreas Krey <a.krey@gmx.de>
Subject: Big repo not shrinking on repack or gc?
Date: Wed, 14 Jan 2015 12:51:30 +0100
Message-ID: <20150114115130.GA5677@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 13:15:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBMqx-0002ck-4D
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbbANMPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 07:15:09 -0500
Received: from continuum.iocl.org ([217.140.74.2]:55598 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbANMPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:15:08 -0500
X-Greylist: delayed 1415 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2015 07:15:07 EST
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t0EBpU105936;
	Wed, 14 Jan 2015 12:51:30 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262378>

Hi everybody,

I have a repo here that is 130G, but when I clone --mirror it, the result
is only 25G big.  Because of the --mirror I don't think that I missed
any refs that keep objects only in the source repo.

I already tried 'git repack -fad' and 'git gc' to shrink the original repo,
but it only shaved off 3G, and there are a lot of loose objects and old
pack files that I simply don't expect to be there after a repack.

Shouldn't 'git gc' (even without --aggressive) or a 'repack -fad' remove
those redundant objects and packs?

How to clean this up? (Additional problem: I don't have enough space
to run a repack anymore.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
