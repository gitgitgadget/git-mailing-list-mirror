From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] unblock and unignore SIGPIPE
Date: Mon, 18 Aug 2014 01:14:45 +0000
Message-ID: <20140818011445.GA22180@dcvr.yhbt.net>
References: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Reynolds <patrick.reynolds@github.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 03:15:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJBX8-0006KQ-7d
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 03:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbaHRBOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 21:14:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41857 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbaHRBOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 21:14:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F841FB5D;
	Mon, 18 Aug 2014 01:14:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255379>

Patrick Reynolds <patrick.reynolds@github.com> wrote:
> But in the real world, several real potential callers, including
> Perl, Apache, and Unicorn, sometimes spawn subprocesses with SIGPIPE
> ignored.

s/Unicorn/Ruby/

But unicorn would ignore SIGPIPE it if Ruby did not; relying on SIGPIPE
while doing any multiplexed I/O doesn't work well.
