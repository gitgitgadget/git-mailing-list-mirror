From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] rev-parse: fix --git-common-dir when executed from
 subpath of main tree
Date: Thu, 19 May 2016 17:50:49 +0900
Message-ID: <20160519085049.GA26914@glandium.org>
References: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 10:51:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Jfd-0002VK-7X
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 10:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbcESIu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 04:50:59 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38020 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026AbcESIu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 04:50:58 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b3JfN-00071B-8I; Thu, 19 May 2016 17:50:49 +0900
Content-Disposition: inline
In-Reply-To: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295046>

On Sun, Apr 03, 2016 at 09:42:23PM -0400, Michael Rappazzo wrote:
> Executing `git-rev-parse --git-common-dir` from the root of the main
> worktree results in '.git', which is the relative path to the git dir.
> When executed from a subpath of the main tree it returned somthing like:
> 'sub/path/.git'.  Change this to return the proper relative path to the
> git directory (similar to `--show-cdup`).

Note that `git rev-parse --git-dir` returns an absolute path, not a
relative one. Shouldn't --git-common-dir "simply" return the same as
--git-dir when not in a worktree?

Mike
