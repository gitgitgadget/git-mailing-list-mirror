From: Ilya Basin <basinilya@gmail.com>
Subject: How to recursively clean only those untracked files that are not ignored?
Date: Sat, 19 Apr 2014 13:05:52 +0400
Message-ID: <925417488.20140419130552@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 11:06:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbRDn-0006uy-OS
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 11:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbaDSJF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 05:05:58 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:64545 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbaDSJF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 05:05:56 -0400
Received: by mail-lb0-f176.google.com with SMTP id 10so1933410lbg.21
        for <git@vger.kernel.org>; Sat, 19 Apr 2014 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:reply-to:message-id:to:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=Scn9KW+Tvg9euRshX14hYes83H7ooDdieHTyWUgzW1o=;
        b=hMOpfDyK0J/ZyWnqaju78aE+7t6dLvh0c+3C6eaCBv0Zg9xJGmQCjoCHmNQn4Nm0gG
         +z0WAVlYXbKbrLjAAoPVzd3zw+ksLugnMRyN8mpm28D6qgcAwG9ui2NhROKxGHfNbv6W
         k71Y/1IqAI37QKi39MYOQx8YmNAxmcgOHhH5E2QYy1mftCcd24XclUBUY1381Xzus0Cd
         pdxP73q2E4GvsCfdeGoC/nnIUQEuq7z1etaihi3ZB28pu9snsOGY5tx0QwhGqrCEri4+
         SzRhcx/c0VlvTqsZ0tPkSbAo64DvpHqtvJoz5yDA3n2LQdpetQ06iCCqzkhVgi9z58E1
         YYwg==
X-Received: by 10.152.3.72 with SMTP id a8mr1282764laa.33.1397898354976;
        Sat, 19 Apr 2014 02:05:54 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:8d48:2a39:97d2:fc33])
        by mx.google.com with ESMTPSA id zf7sm30670605lab.7.2014.04.19.02.05.53
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 02:05:54 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246510>

According to the help, without -x option git clean should let alone the ignored files, but it doesn't.

    [il@reallin test]$ cat .gitignore
    *.sar
    [il@reallin test]$ mkdir -p conf/sar && touch conf/sar/aaa.sar
    [il@reallin test]$ git status
    # On branch master
    nothing to commit, working directory clean
    [il@reallin test]$ git clean -df
    Removing conf/

conf/sar/aaa.sar is removed.

I already asked this http://stackoverflow.com/questions/23148736/git-clean-removes-ignored-files-by-default

Someone even replied that "git does exactly what documentation says".
Well, maybe, but I have doubts that the combination '-df' (without
'-x') is useful at all. If someone wanted to delete ignored files, he
would use '-x' or '-X'.
