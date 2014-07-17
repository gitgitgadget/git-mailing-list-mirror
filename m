From: "Stuart P. Bentley" <stuart@testtrack4.com>
Subject: Feature request: Specify hooks on the command line
Date: Thu, 17 Jul 2014 16:54:41 -0700
Message-ID: <lq9no7$675$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 02:00:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7vaw-0006de-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 02:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584AbaGRAAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 20:00:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:53779 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758434AbaGRAAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 20:00:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1X7vam-0006ZV-Aa
	for git@vger.kernel.org; Fri, 18 Jul 2014 02:00:04 +0200
Received: from 23.252.53.30 ([23.252.53.30])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 02:00:04 +0200
Received: from stuart by 23.252.53.30 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 02:00:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 23.252.53.30
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253790>

I'm developing a project called [Plushu][], an ecosystem for creating 
plugin-based dedicated user shells, patterned after [Dokku][] (and 
similar to git-shell).

[Plushu]: https://github.com/plushu/plushu
[Dokku]: https://github.com/progrium/dokku

Plushu has its own hook system for plugins (so multiple plugins can 
listen on a single hook). Right now, to extend Git's hooks to Plushu's 
plugins, Plushu's plugin for Git links the "$GIT_DIR/hooks" directory 
for all new repositories to a directory with scripts that delegate to 
Plushu's hook system.

I'd rather not have to alter the repository directories to create this 
interface, so it would be a significant improvement if Git provided some 
mechanism to specify hooks on the command line. I was thinking something 
like a GIT_HOOKS_DIR environment variable, or perhaps a "--hooks 
update=/opt/hook"-style option.

(Perhaps, as a more general solution, there should be a way of 
specifying alternatives for individual GIT_DIR subdirectories per-command?)

I'm willing to draft the patch for this if someone could point me to the 
relevant spot(s) in the code.
