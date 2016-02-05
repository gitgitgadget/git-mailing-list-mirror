From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v5] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri,  5 Feb 2016 09:01:39 +0200
Message-ID: <1454655702-28164-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 08:02:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRaPS-0007tO-Au
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 08:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbcBEHCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 02:02:17 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33516 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbcBEHCP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 02:02:15 -0500
Received: by mail-wm0-f49.google.com with SMTP id g62so35339097wme.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 23:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1rPikhShJvIq1hpRV0Kt4wY1J3B3r3oBpi3TW8Nj2I8=;
        b=vjvWeMH3unfbemorzMVNQwz3cJJC7OUySbR/ORAUfe6qt6DDuH0z3RhfCQriavb8PO
         dB/1itXuB5GeT8tRDsEcQmp8WIZpBP48DsDviBIFIc5wavYWjp9VKe1G8rJa8jDlprBD
         EHWIiKhjI3SgDI8Az2jAwg+JOJfNzTUxff7RPWHKsEK8QrG59HT1CJOr8Rt/ZEKQHnzE
         vYhfx1WDz1W7TBQPXbfJ9g9AKYzqbWwr3CU33hc7A3gCuyHYhZMlpOl2MvIS2Rt6PqcQ
         aGNFOndwfNkU20g0kgIjwFO238aFuhEL4Ka838DiQmsUpCIhalpp5njasbmmsseiO1dv
         WQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1rPikhShJvIq1hpRV0Kt4wY1J3B3r3oBpi3TW8Nj2I8=;
        b=cw14uIXGwm1Qj9E+eIApCHJPbdO31MId0tpliEHQ27wGfUX0dFrybYk0rjeG3CN58B
         eb1fvfSYnuDITcgWVFEEWa94Gqz2+KkFlAjn77dPq+7GYnSCieQocEh6l8lwgNiS++cO
         vfBE3Y0pm3erfrEdYD0QO3XTCbDlchR3JPwtFExeoMTkR+nfsIAQetLbqHyrgSdimZ+O
         oj1FD/cN4judjeR0h39AGTEbK332Y55+Wdjig5jtmabuJFoAjcYmT26nQ2Tr2l9Fa4iR
         xlZpysZelcLkySuRSadF9GxeJMLFhFTDdhe5/PlZuacCV/rYPkvhkN4gNTZdS3MWOHHW
         Lzrw==
X-Gm-Message-State: AG10YOThAghuphKOfMpvmD+I7wurcUwsmmBUYAq6v3MhtFgrWbQpfIJOlKCQbDpjyD2JdA==
X-Received: by 10.28.180.193 with SMTP id d184mr33177429wmf.64.1454655734426;
        Thu, 04 Feb 2016 23:02:14 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id i2sm14442915wjx.42.2016.02.04.23.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 23:02:14 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285544>


Changes between v4 -> v5:

 * Fixes for compiler warnings under standard compilation.
 * Revised commit messages according to remarks.
 * Cleanups and fixes of the added test script.
 * Indentation and styling fixes.

v4: http://thread.gmane.org/gmane.comp.version-control.git/285441
