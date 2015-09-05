From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/2] git-p4: work on a detached head
Date: Sat,  5 Sep 2015 15:02:16 +0100
Message-ID: <1441461738-25066-1-git-send-email-luke@diamand.org>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 16:02:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYE39-0004Fb-4W
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 16:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbbIEOCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 10:02:32 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33095 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbbIEOCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 10:02:30 -0400
Received: by wiclk2 with SMTP id lk2so47263211wic.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8TOi3ZtfREqmupfD8WQfH4Pl9A9jEqId66OLSLMT094=;
        b=AX4+B+c8hVy3c43l0euI47Wrm+PylMLockLW67AkO+G2L+5yvsOP61gHfGFwj+j3m8
         ZuwktiqEFbbrqIEmpggEEPr2HoKa5Q5xzuBrL4bniKCIOuAE7JYrvFSH8GpXuvb5sjFo
         DJkMIOZtGbC1dMkame/BHbCWg6dzzKr3xLyIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8TOi3ZtfREqmupfD8WQfH4Pl9A9jEqId66OLSLMT094=;
        b=SxSuKtrXcs4M4gW5tUSxycTjECjPycMIa6nT/Ja6Lnm5zOEEbxb9gntRq3Vk6AAH/p
         6VKYuznLw18upRe6VcKm4wuIHoDpdoThGlLlUVwyjb7+dW436w8pOcfQHs7+oqNUj5nL
         v3PcRvF84jnWWMHV0Yuze37f1ldW3Nytwc9BNyweyroSdMSGQECnOIL0lB/fcTdOZDxT
         44qFg2RARBz9SwvqsJFQkhOkmVrogdpHbC0ryrWESAAB8iwJS3FgvvEQ6/Ff3GpT25RC
         P09OkJ+Uiq0L4NdlVJOQeu7E1UXyR1BrMo8Qvr6k6Wj3v+l2lRZMkAt1WXPNH3Uhy/9B
         3iLw==
X-Gm-Message-State: ALoCoQmWXou7vCO3hZFb3UL5SWsnjqIJmF9hhsAkfg1Q+NIW5Q7z2rLZBHShptV2oIzuAWQ3TbdH
X-Received: by 10.180.74.52 with SMTP id q20mr17754040wiv.94.1441461749466;
        Sat, 05 Sep 2015 07:02:29 -0700 (PDT)
Received: from lgd-kipper.local.diamand.org (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id fs8sm10225413wib.0.2015.09.05.07.02.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2015 07:02:28 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.133.ga438a11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277380>

git-p4 won't submit from a detached head. If you do, it gives a
cryptic error message, and instead you have to create an endless
series of throw-away branches, which can get very trying.

The first patch in this series demonstrates the problem, and the
second patch fixes it. I've been using it for the last few days.

Luke Diamand (2):
  git-p4: add failing test for submit from detached head
  git-p4: work with a detached head

 git-p4.py               | 18 ++++++++++++------
 t/t9800-git-p4-basic.sh | 16 ++++++++++++++++
 2 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.6.0.rc0.133.ga438a11.dirty
