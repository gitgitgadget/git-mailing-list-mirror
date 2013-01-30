From: Peter Wu <lekensteyn@gmail.com>
Subject: [BUG] `git branch --contains ID name` creates branch "name"
Date: Wed, 30 Jan 2013 19:57:03 +0100
Message-ID: <679787987.uZRbjA7AMj@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:57:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cqi-0001bx-Bn
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab3A3S5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:57:10 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:42748 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab3A3S5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:57:08 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so4128459wib.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=OknKsuQ2YuvD7d8dVkGOA/jacRPfnE34MOL71VjmzxQ=;
        b=bErUc9d4PBJpHCDp10YWT2204q0ccuf8I2UiEcWBy9k9iMhZl7C4c91N3x7BQTHKLl
         dNxrVfMVhCx6XY5pdUHAmvLZxn834XrGT/aMWNIHWTnddX2EeRJndi0icKMYyiSncqhx
         3YQG6jz2VV5WDxy4gdmr2JtQ28ptbFyYJ+7rX3SFhP0uAxT3aMLiN1rPBTrd7m+CiuDE
         /20yoJf7wGlNghM8o9ch81AslD4dl7cLb07tHCBrWcDy/G34sQeUEkldDwFZvjkkz8EF
         ZmY80gB1oqxSkuHMn6OmooMZ5edmo15O07B37x/ox0br1UjmrySxCygYP7OHkvHMUUGz
         VLtg==
X-Received: by 10.194.58.175 with SMTP id s15mr10976594wjq.31.1359572227192;
        Wed, 30 Jan 2013 10:57:07 -0800 (PST)
Received: from al.localnet (svr.lekensteyn.nl. [178.21.112.251])
        by mx.google.com with ESMTPS id g2sm4784188wiy.0.2013.01.30.10.57.04
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 10:57:05 -0800 (PST)
User-Agent: KMail/4.9.5 (Linux/3.8.0-2-custom; KDE/4.9.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215057>

Hi,

I was trying to check whether a certain branch contained a commit and ran:

     git branch --contains ddc150f7a33ae0c9cb16eaac3641abc00f56316f master

This resulted in:

    fatal: A branch named 'master' already exists.
When "name" does not exist, this command creates a branch. I expect this 
command to search the mentioned branch, not trying to create it. The manual 
page of git-branch(1) does not mention such special behavior either.

Git version 1.8.1.2

Regards,
Peter
