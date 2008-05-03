From: "Frodo Baggins" <frodo.drogo@gmail.com>
Subject: Trouble merging to master when topic branch has a dir added
Date: Sat, 3 May 2008 19:21:46 +0530
Message-ID: <1cdff3fa0805030651j5d1936bdh4f7999163b7444ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 15:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsIAZ-0004qT-Ea
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYECNvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYECNvs
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:51:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:58347 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbYECNvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:51:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1316959fgg.17
        for <git@vger.kernel.org>; Sat, 03 May 2008 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=hCUlK5VuUQqKXqOMS4xaRAFKeoK1U3++4zo58f5nSSo=;
        b=hsjyLY98KcErnONDC1v77IxRwHDepXxWC4vRbHChR0kXxcYcw19M+eN6bwxlFKpQ+A2IvbmRHWvrrZR2S/BbxSD+nRrHGvxDuvkHqBToMdth5Fkbk+I69rPjMbjy/GhdB5X1Spo8dY81oUG09oQiBcx/lVuUD1XWphUpj7oYuik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BQsSkP+tg7iWdkbPP73c5aDKpNogl0R6dTO4C5cHpovxyWFykUb1vLM5yezxxEu+ibp1xkO4AiI4khIG3Uoryn+9COoCdRBquIMvFJDhAkb12peFcWIE4KwVLd5XQxpvUMYSksSSHp+GfzG17qH/1o/7YUSZoARg2PnlqDShE8c=
Received: by 10.86.90.13 with SMTP id n13mr7166355fgb.3.1209822706207;
        Sat, 03 May 2008 06:51:46 -0700 (PDT)
Received: by 10.86.81.16 with HTTP; Sat, 3 May 2008 06:51:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81079>

Hi,
This is a newbie question.

I created a topic branch and made a few commits which added a few
directories. I'd like to merge these changes back to master.
I get the following error messages.

frodo@laptop-zion:~/src/c/logger$ ls
logger-inc  logger-src  Makefile  test-driver
frodo@laptop-zion:~/src/c/logger$ git branch
  debug-printf-help
  debug-static
  master
* split-into-dirs
frodo@laptop-zion:~/src/c/logger$ git checkout master
fatal: Entry 'logger-src/logger.cpp' would be overwritten by merge.
Cannot merge.

I think the above error is due to the fact that the branch master did
not have these directories.

frodo@laptop-zion:~/src/c/logger$ git-ls-tree master
100644 blob 82ccb7971fc36db2bc54bb5a590f97cd37c998fb    .gitignore
100644 blob 9971a5a432d575cc682145454e5260f83e1b9fb3    Makefile
100644 blob b8f6c213ebb831ed8704b7f0e0e665212b808649    client.cpp
100644 blob d01aaec4138862ccae4be9de2c672ddaeccfa21d    logger.cpp
100644 blob 37c15a22b325934ea685a76cfd528c2bf6464f2b    logger.h
frodo@laptop-zion:~/src/c/logger$ git-ls-tree split-into-dirs
100644 blob 82ccb7971fc36db2bc54bb5a590f97cd37c998fb    .gitignore
100644 blob 7c497aff60175ce212415c1737e224f517f785e9    Makefile
040000 tree 4f181412688afaa30929b752cc1fb3f2cda3cba9    logger-inc
       <=== new dir
040000 tree 4fb363dac2a00d93d1a958f74021fcd0e3bc861e    logger-src
      <===
040000 tree bb2b91b6ec1d11d23ab8e7a3c8935504079f6bf3    test-driver         <===


Could someone help me out with this?
frodo@laptop-zion:~/src/c/logger$ git --version
git version 1.5.2.5

Regards,
Frodo B
-- 
Never laugh at live dragons.
                              -- Bilbo Baggins
