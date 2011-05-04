From: Rowan Lewis <me@rowanlewis.com>
Subject: Filemode is a nuisance
Date: Thu, 5 May 2011 09:38:03 +1000
Message-ID: <5B76586FBEB246BDA2F097E21C78E881@rowanlewis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 01:38:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHle5-0003X3-C4
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 01:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab1EDXiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 19:38:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55745 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab1EDXiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 19:38:09 -0400
Received: by pvg12 with SMTP id 12so720268pvg.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 16:38:08 -0700 (PDT)
Received: by 10.68.0.99 with SMTP id 3mr2293922pbd.375.1304552288162;
        Wed, 04 May 2011 16:38:08 -0700 (PDT)
Received: from rowan.sites.randb.com.au ([203.144.8.51])
        by mx.google.com with ESMTPS id a20sm1028752pbu.59.2011.05.04.16.38.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 16:38:07 -0700 (PDT)
X-Mailer: sparrow 1.1.2 (build 688.7)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172781>

Hi,

I work at a web development company, a few years ago we switched from using SVN to using git. Since then a lot of little issues and improvements have been made to git, I have to thank the developers for their hard work.

However, one problem still remains. Our projects are often cloned onto a large variety of computer environments, from Linux servers to OSX and Windows desktops. Each of these environments tends to have its own requirements for file permissions, depending on how Apache and PHP have been configured.

As a result of this we're nearly constantly forced to manually set filemode to false in every repository, including submodules.

The following is the output of git status on one of our repositories with a moderate number of submodules:

# modified:  extensions/asdc (modified content)
# modified:  extensions/canofspam (modified content, untracked content)
# modified:  extensions/db_sync (modified content)
# modified:  extensions/debugdevkit (modified content)
# modified:  extensions/emailtemplatefilter (modified content)
# modified:  extensions/export_entry (modified content)
# modified:  extensions/expressionfield (modified content)
# modified:  extensions/flexdatefield (modified content)
# modified:  extensions/globalresourceloader (modified content)
# modified:  extensions/logsdevkit (modified content)
# modified:  extensions/mpm/extension.driver.php
# modified:  extensions/order_entries (modified content)
# modified:  extensions/profiledevkit (modified content)
# modified:  extensions/publishfiltering (modified content)
# modified:  extensions/reflectionfield (modified content)
# modified:  extensions/selectbox_link_field (modified content)
# modified:  extensions/subsectionfield (modified content)

>From this list it would appear that each of the 17 items in the extensions directory has been changed, but this is not truly the case. What actually happened was someone running chmod to give Apache access to the files.

It's a real problem, as I cannot tell which of the submodules actually has changes that I need to deal with. I'm also sure that there's probably some script-foo that I could to do automatically change filemode to false; but unfortunately my bash isn't so great, and I'm the most knowledgable in shell scripting at work.

I see three possible solutions to our woes:

1) It is/becomes possible to disable filemode when repositories are created; so only in the rare case that we need this feature would we have to change the git configuration.
2) Submodules defere the filemode preference to the parent repository; so that it only needs to be disabled once per project/repository.
3) I'm an idiot and all of my googling has failed to turn up an obvious/easy solution, and someone here points me to it.

Anyhow, thanks for listening, this email has been a long time coming.

Thanks,
Rowan Lewis
