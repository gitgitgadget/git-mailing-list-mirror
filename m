From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v7] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri,  5 Feb 2016 23:29:04 +0200
Message-ID: <1454707746-18672-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:29:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnwu-0006Pu-3G
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbcBEV3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:29:47 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36595 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbcBEV3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 16:29:46 -0500
Received: by mail-wm0-f45.google.com with SMTP id p63so43927647wmp.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wukU45oOGMtB48MvmNagH564ky0xEbLE10rsxWrFIzQ=;
        b=NS3u9IbUnLeMrPVwAnIcNZyRfHU3m7Xm27NcZylynn06mARISalBT/igCn+8rr3+DB
         Tc4a7lXDWFYd8o/DqB79hb3jJ0Q41XNTqDBZza7PpwO51thWm0M8dVU9LGCFSYPoeER9
         4xlOkphzMubmhPQ568uVBZSBn/YOz6++pB1rDJmXh4P6uIJ0V6tsNBSTtcR8eV5ZpFHG
         ovL0qRWRKfeHQDpZ3lRVymadKw/qYX8uOYQw6K7KRxGShzcZV/bURlT0NHpxleNybsgr
         ZfaPrrwDQnlBhC9AMkvtMXByyI8SXHQhimicCm0jEIpXLo/StAuMgxfMPl/8uaycwZ09
         Ma5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wukU45oOGMtB48MvmNagH564ky0xEbLE10rsxWrFIzQ=;
        b=R908jPitKNUN5wWx6TBHUi2soeS8/c4Ody7zesrsUvtOZSfm0Gpt/9Dh7o10FJvdjd
         SRslJGme9sa+hjvGNRJVLtZLur7d44DhuDpUVuNplutoakSCbcazBRWYsgyv3O/LWOcn
         O/w8F7M+tXfQFt9d+YvVdrqr64KjSZvdyrsB70y2CXM4yQHLHlf+s9AOY1vkuALrxNBj
         riwVGD4VdK1y1tzMC61O6jV4a8CY+qvrAVbcCAwYgz3bBsAKSLRJZKw1SS7JfA1+1W9B
         7UJwgIA623lebowTPJGGupjaaUM7zM8Y0plWpWQFAkLkWVsF0inwTbuJx6FLvLpgAN3U
         0xgA==
X-Gm-Message-State: AG10YOSqOoLx+uaLX3dQpUBZcljAbDm7I/bxne33Mq7HwYejcQaabb42Wn1A42WUA1S2Tg==
X-Received: by 10.28.146.8 with SMTP id u8mr37125357wmd.72.1454707785611;
        Fri, 05 Feb 2016 13:29:45 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id q75sm446574wmd.6.2016.02.05.13.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 13:29:45 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285636>


Changes between v6 -> v7:

* Dropped patch: ident: cleanup wrt ident's source
* Revised the documentation of the feature according to comments.
* Revised the test according to comments.
* Styling fix.

v6: http://article.gmane.org/gmane.comp.version-control.git/285550
