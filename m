From: rupert THURNER <rupert.thurner@gmail.com>
Subject: submodule add does not consider git svn
Date: Sat, 23 Jul 2011 05:33:05 +0200
Message-ID: <CAJs9aZ9cMZd5PfOW7Zfza3un5JqKRM5eQdDpKPCWvLn-vkzktA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 05:33:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkSy5-0003JK-7C
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 05:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184Ab1GWDd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 23:33:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37614 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab1GWDdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 23:33:25 -0400
Received: by iyb12 with SMTP id 12so2400308iyb.19
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 20:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Lr/o8K2NS/kyOO0zm4aOtxsdYZclcjxWAAXhlTEK2fE=;
        b=pwMezrVxdF+R6ryPBwIIGW+ggNBcNUejzDg9SjhGU4trofsN0Y0aiHCkYsHRUsSR1K
         VxKZNmzbC/eGGE4XoOYTE1JfoaJbdlP/EvMkuZ7eeSPqLYlmdsqysBEf9ERJz0A6e5mt
         fY23JN+6OBxJ+1sZW5bQI0FGwUTNlwyulEerU=
Received: by 10.231.114.104 with SMTP id d40mr1924994ibq.114.1311392005070;
 Fri, 22 Jul 2011 20:33:25 -0700 (PDT)
Received: by 10.42.96.193 with HTTP; Fri, 22 Jul 2011 20:33:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177680>

it seems that "git submodule add" looses information from "git svn
clone". what am i missing here which would allow to "git svn rebase"
the repository, even if it is newly added as submodule?

the following example takes a little, as the repository has 15'000
revisions, even 99% do not concern the checked out part.

rupert @ login : ~/tmp/subm-bug
 mkdir -p  ~/tmp/subm-bug
 cd ~/tmp/subm-bug
 git svn clone https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg/GeoIP/trunk
GeoIP
 git init test
 cd test
 git submodule add ~/tmp/subm-bug/GeoIP
 cd GeoIP
 git svn rebase

Migrating from a git-svn v1 layout...
Data from a previous version of git-svn exists, but
        .git/svn
        (required for this version (1.7.5.4) of git-svn) does not exist.
Done migrating from a git-svn v1 layout
Unable to determine upstream SVN information from working tree history
