From: Mike Hommey <mh@glandium.org>
Subject: git add -p doesn't respect diff.context
Date: Wed, 20 Jan 2016 15:35:23 +0900
Message-ID: <20160120063523.GA26490@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 07:35:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLmMg-0003Fn-4w
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 07:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758082AbcATGfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 01:35:31 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:36384 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbcATGf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 01:35:29 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aLmMV-0007HN-3k
	for git@vger.kernel.org; Wed, 20 Jan 2016 15:35:23 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284428>

Hi,

When doing git add -p, the default of 3 context lines is used, ignoring
the diff.context.

git add -p is using git-diff-files, and diff.context is being read in
git_diff_ui_config, so the comment above that function applies:
/*
 * These are to give UI layer defaults.
 * The core-level commands such as git-diff-files should
 * never be affected by the setting of diff.renames
 * the user happens to have in the configuration file.
 */

I guess the question is whether it's diff-files or add -p that should
honor diff.context. Or should it have its own separate config?

Mike
