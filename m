From: karthik nayak <karthik.188@gmail.com>
Subject: [WIP] [PATCH 0/4] Unifying git branch -l, git tag -l, and git for-each-ref
Date: Wed, 20 May 2015 18:44:42 +0530
Message-ID: <555C88C2.8060902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 20 15:14:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv3pp-0000PC-07
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 15:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbbETNOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 09:14:51 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34070 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbbETNOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 09:14:47 -0400
Received: by pabru16 with SMTP id ru16so67016897pab.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=xK+444k2D3kBh4IRhZb6tU58wFNzi5ZAqfc14Moze0s=;
        b=mgMJDuXnl4k1BOonEUXFiB3Bq0MgdCFROZxFAhLinzj4TBvfoNSs+zHg14a10Y6avQ
         4YKBwxFbJSKrPiEG/yA7gxbAPMALVXh+pignq/4rru8kf/GVdZvAmEDu7StmoJbWEmti
         5GqlFEK4cH+ReqOUJuLpy7GZ2tdgf0x9D6RrLZu6/f72bJlYi0k0G0DlTY+g47j69cr3
         TZTq3YpB/cDu9KWO7Tq/GrqxUnwyP/aKul2EwyQVBxSqRBBYvnpZ5KAufqkzy7OVqa4j
         1/EaPBzvf6STPsIezUxlTFEeAOqlkoMBzEtIEUTgsSVw5JIUvkiRQlwztQ4JH1KTxftl
         /g2g==
X-Received: by 10.66.159.68 with SMTP id xa4mr64742081pab.105.1432127686398;
        Wed, 20 May 2015 06:14:46 -0700 (PDT)
Received: from [192.168.0.110] ([106.51.128.148])
        by mx.google.com with ESMTPSA id ss3sm16297954pab.43.2015.05.20.06.14.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 06:14:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269461>

Hello All,

Just updating on my progress for my GSoC project on "Unifying git 
branch- l, git tag -l and git for-each-ref."

I have been going through the code for the above commands, I started off 
first with 'for-each-ref' because it seemed to be the most basic command 
of the three, I have been building the common library
'ref-filter' based on the requirements for 'for-each-ref', eventually
I plan to merge 'tag -l' and 'branch -l' and extend its functionality.

The '--format' and '--sort' option provided by for-each-ref seemed to be 
the most fundamental and I plan on using this implementation and 
extending the option to 'tag -l' and 'branch -l'. So this left me with 
moving most of the code from 'for-each-ref' to 'ref-filter' and leaving 
'for-each-ref' with nothing but the command call from the main git command.

This is still a WIP and hope to get some suggestions/feedback on my 
progress.
