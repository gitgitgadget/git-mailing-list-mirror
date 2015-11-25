From: Lars Schneider <larsxschneider@gmail.com>
Subject: Git super slow on Windows 7
Date: Wed, 25 Nov 2015 13:35:57 +0100
Message-ID: <EEA07A84-26D8-4709-97AC-2C4F3A0CC5BD@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: GIT Mailing-list <git@vger.kernel.org>, stephan.arens@autodesk.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 13:36:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ZIq-0004EZ-4W
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 13:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbbKYMgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 07:36:01 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36601 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbbKYMgA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 07:36:00 -0500
Received: by wmww144 with SMTP id w144so178235290wmw.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 04:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=z39xB8lwKIYAU5riEliIi4GzO58XZBAk7UbhL+aadIY=;
        b=R71M18Xst852IIvr615YfHjNvaMIH/1YovNL8+LrDbwOyXEha9lkjlcZJiYuknGdq6
         xucCtueO6YDt9BS5Xz+wngMyjwLgRsfgr1qXMHqEW5Ze1xRUsqLPmj9g6cIuHX5zOwhO
         P7fj07tdK5hLDO7y7SoLGQ974AEPYwioZ5eytg28z4CPMpyLCqs8YEREFshm5oe93Bqa
         PrFqq19epL1OPFIqNOr7/tD1bavjMcItaCjV4I5HFYTspQhnuSXjUX2uLk/eIcLHT49y
         NkDL9qvg8gLvFNhdsXqE0rhulta1RDRPs5BZ8y7kEVRzpGyEmLaGefoRkdGpIuMfZKpM
         vEvg==
X-Received: by 10.28.95.10 with SMTP id t10mr3994991wmb.99.1448454959022;
        Wed, 25 Nov 2015 04:35:59 -0800 (PST)
Received: from slxbook4.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 186sm3372076wmv.9.2015.11.25.04.35.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 04:35:58 -0800 (PST)
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281706>

Hi Johannes,

I am working with Git for Windows right now and it is dramatically slower than on OS X.
I executed "time git status" on Windows and OS X with the same repository and the following results:

## Windows git version 2.6.3.windows.1 (with enabled experimental flag on install):
real    0m1.327s
user    0m0.000s
sys     0m0.015s


## OS X git version 2.4.9 (Apple Git-60):
git status  0.06s user 0.13s system 102% cpu 0.186 total


Initially it was even slower on Windows (~1.6s). According to [1] I used the following settings to make it faster:
$ git config --global core.preloadindex true
$ git config --global core.fscache true

Is this behavior normal/expected?
If it is not normal, how would you debug the issue? How can I find out why it is so slow?

My user drive is not on a net share and the machine has a SSD.

Thanks,
Lars


[1] http://stackoverflow.com/questions/4485059/git-bash-is-extremely-slow-in-windows-7-x64