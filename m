From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: put THEIR commits AFTER my commits with a single rebase command
Date: Thu, 18 Apr 2013 12:33:21 +0400
Message-ID: <1949082828.20130418123321@gmail.com>
References: <1928280357.20130418091807@gmail.com> <516F9329.4060405@viscovery.net>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 10:33:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USkHe-0004R8-8e
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 10:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933Ab3DRId3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 04:33:29 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:38778 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964887Ab3DRId1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 04:33:27 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so2450770lbh.18
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=DwoggHiiyMq1msNmFqlsHNXstyIXY1ktKDg/JeIWN04=;
        b=zKrX8cFlrBgjwEMpL1jHZVklwCOpM0zqC5yDHOU6M9gkzV2nRL8mUhsartRMdqKlp+
         wie7jDuzSf0hBtSlZS1HqBoEgLh8+bOLSnMsCYNg89foA1mvKF/elN0o4ApYOdkuvgF6
         MzTtErO5Lki60nP/Uin2D1UNmnVVZQFehJxRP2KtmdtX0O/R8kAsFoR04Vj0qI3AZmjs
         0bmmTdh6ndXxFVa/k4+4UKZ5psy0g27IHF06Bwu1CWUThl7/PiuzXsyM3Z5f+QSNDpEm
         bWNSIF1L0f1ywkMczNnNAgJQa9po64zWZln1kdkj4jV29M2p9ZfPG7gpFWwjdTi05ofK
         akDQ==
X-Received: by 10.112.140.1 with SMTP id rc1mr5367287lbb.43.1366274005669;
        Thu, 18 Apr 2013 01:33:25 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:84e0:55a3:4150:1bdd])
        by mx.google.com with ESMTPS id t6sm3943606lae.3.2013.04.18.01.33.23
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 01:33:24 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <516F9329.4060405@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221626>


JS> Perhaps this one:

JS>    git merge origin/master
JS>    git rebase ORIG_HEAD

JS> -- Hannes

Wouldn't I have to resolve conflicts twice?


BTW, during the rebase, can I tell git to rewrite a different branch
upon rebase success or abort?

    git branch -f tmp origin/master
    git rebase --onto master master tmp
    if [ $? -ne 0 ]; then
       # modify some file in .git/ ?
    else
        git branch -f master
        git checkout master
    fi



-- 
