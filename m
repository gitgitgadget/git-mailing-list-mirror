From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/WIP v3 1/4] for-each-ref: re-structure code for moving to
 'ref-filter'
Date: Thu, 28 May 2015 23:08:02 +0530
Message-ID: <5567527A.6090607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 28 19:38:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1l1-0000rc-2i
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbbE1RiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:38:10 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33450 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbbE1RiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:38:09 -0400
Received: by pdbqa5 with SMTP id qa5so46601205pdb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=Re83SjqVvac2mGA1T4gR643sbx/wKgMP0iVg3qYNwD4=;
        b=IXckpI/AI6r3K4kEwu2NCLoobjhs9d0KqFR/Kmitt75wxKvlz18Ql1O4gRP4DlSZDC
         cgehhUZ+bPrN6JHBsfcR0fYGe9UEUfSb/1C4PsDVrC4HqiKuR5QTnWObOzTjEi8duTXo
         p3GRpoYhHb9NOqmQrLTWE14b3Gn+yQwgcMCpiZdbZnxxc0H1SO8eUm2Ep404Om9QRnx3
         97JaYGlXIkMUfKYtF52XtUah+zXIzwlIIMzpwzqV+tDIeFmxxPlK2iFkXee/M32i3tWt
         dLGsCFt20kYVF5wH+1ccmXxcFZkBGM/c5yuzGgZvsu4z5WDqC3EVbU3mDG9A+/CV01ZA
         IJbQ==
X-Received: by 10.68.232.194 with SMTP id tq2mr7673545pbc.90.1432834689067;
        Thu, 28 May 2015 10:38:09 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id eu5sm3007421pbb.44.2015.05.28.10.38.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 10:38:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270164>

Hello,

After the second version of the WIP/PATCH ($gmane/269836), This is a 
follow up.

Changes:
*	Broke down the first commit into 3 separate commits, cause they were 
logically different and needed to built up incrementally.
*	renamed some functions which were made public so that they don't seem 
vague.
*	other small changes.
-- 
Regards,
Karthik
