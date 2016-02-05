From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v6] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri,  5 Feb 2016 09:42:25 +0200
Message-ID: <1454658148-3031-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 08:43:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRb2h-0006Qb-Bj
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 08:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbcBEHmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 02:42:55 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35637 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcBEHmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 02:42:54 -0500
Received: by mail-wm0-f45.google.com with SMTP id r129so14502221wmr.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9UWuktT5VnlKHu5A0VhrtCvxHJO7pGoOxcxuMXQT8l0=;
        b=uXhs8WkRUxmSWQLTOYOOi5zDuP+UHwxqf5S0s43VFmrc5zxcnGMZoS2l87E0xqqgop
         omnZQSN6cqqzgbUwV8/sWtWsflfmuYYQ722aGcj2ryRyciWX7QGXbvlan0T4c56lmuum
         fYwaIkij8KAkClc2Gjt43eZ+CA57oc1rO18e48fypF2FDsLMtS/cBRHW88JfFUQZ9RNA
         VYZOEz7q4DjhXutpJocKdYHjaJBjx1doJixsHc4NaFA7yc0LY9YrKCAsNrLk1HlaZwoG
         L7IUiZT49FutXzP4+DoCU+LPQNReNOLO2gTcmE1l+a6IkUAGK69s3pMU2uysCUG4AQE4
         zDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9UWuktT5VnlKHu5A0VhrtCvxHJO7pGoOxcxuMXQT8l0=;
        b=YQP+LDWekSN57noRV3PrIWMHxzFDSjQo5kCLrbcnoUvX/x3xKhPck1tsYkFRrnKY+v
         a7SbcwO0WwufeJ12AG5NITCzAaR1By0qSafASpYuyVflhm3S4gm5OJCvCG8gP9R0ei/A
         5RFIRhd/TwGA8jWTD01ftgSXX/Yjxkp9kxvVeW4DhyvSA0Oafvv8scB9Gx+3ZYppeqCI
         T2Qkh/wGhyShJ6FH8XwzIMfCJooccb4CspqO57DbUYhzstlXPQXTSdR8MflrJo/+/kyd
         NDjInHP5K2vu46lVzDdmtV1q47QOKbzI7eT8n1iLdWeQOrc1EA6YYHECnAzMzsoLYwc1
         kdYQ==
X-Gm-Message-State: AG10YOT8wTuddhDL7oA1vYIGs5a7d1JzKUeq1LogHbTYgLBGzwR0P3TjHUAodhgn7S2EMg==
X-Received: by 10.28.23.73 with SMTP id 70mr33568690wmx.37.1454658173064;
        Thu, 04 Feb 2016 23:42:53 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id w66sm16062302wmd.2.2016.02.04.23.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 23:42:52 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285550>


Change between v5 -> v6:

* Removed trailing comma in 'enum ident_person'.

v5: http://article.gmane.org/gmane.comp.version-control.git/285544
