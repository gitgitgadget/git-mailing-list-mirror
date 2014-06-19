From: Sergei Organov <osv@javad.com>
Subject: Surprising 'git-describe --all --match' behavior.
Date: Thu, 19 Jun 2014 17:31:07 +0400
Message-ID: <87ionxxbz8.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 15:31:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxcR1-0000Z8-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 15:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbaFSNbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 09:31:16 -0400
Received: from mail.javad.com ([54.86.164.124]:39271 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbaFSNbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 09:31:10 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id DC1E760BFF
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 13:31:08 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1WxcQl-0006gh-1m
	for git@vger.kernel.org; Thu, 19 Jun 2014 17:31:07 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252114>

Hello,

Just playing with it, got some surprises:

$ git --version
git version 1.9.3

$ git describe --all
heads/v3.5
$ git describe --all --match 'v*'
tags/v3.5.6b2-4-gab4bf78
$ git describe --all --match 'heads/v*'
fatal: No names found, cannot describe anything.


... "heads/v3.5" matches neither 'v*' nor 'heads/v*'?

$ git describe --all --match 'v*'
tags/v3.5.6b2-4-gab4bf78
$ git describe --all --match 'tags/v*'
fatal: No names found, cannot describe anything.

... git matches short names when outputs full names?

Is it a defect, or what do I miss?

-- 
Sergei.
