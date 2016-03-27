From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 0/2] gitk: changes for the "Tags and heads" view
Date: Sun, 27 Mar 2016 11:06:06 -0400
Message-ID: <1459091168-46908-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Mar 27 17:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akCGs-0005sV-6Q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 17:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbcC0PGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 11:06:22 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:34058 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcC0PGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 11:06:21 -0400
Received: by mail-qg0-f67.google.com with SMTP id j35so7057228qge.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TsjuO5M9E6Eqt44C997/B0kJQw9wacVCMHeJ+d/JW24=;
        b=O9PpaaLHSVcp8S7TTQqwstQWsEZ1KqCtesyQkgfmhxXuO3wL27inij/rWHIultekT1
         H+SPG3VQc/wa6Me4rGLYc+RMWqU6RX4VFRcmk3GVT54KexLOPgRvLYBMuHIv9tAVXa2b
         ZlafH22ct4agmbC1zlNZpKFHId2CBdfzMwzbZu7MXg2OEv/6Tu8GYbbg4jczkj1QUUqD
         p8jm4lODwA3j8psfLIRFwNladTrC3caE2GkdUSdCixkXHm/GiG6GT+RY1HRXNxlKmyjV
         bU/nG7HVMe9WNV2LP1LR0TxcrnDfWMeyIlz8WZKy8qhT09wkkWY5VGKm8uEQiP/IBSJW
         eiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TsjuO5M9E6Eqt44C997/B0kJQw9wacVCMHeJ+d/JW24=;
        b=QeCj4ea5ZD7cXJ80Zb6hEbBSRSOo5QI+eSPVpqjuEyYfAxmH/+/XMWxpTWQAoKdM2y
         UmIqqV5zAeISwkGq/MRVF8vgCmaAMByHZrD/ekj12LkXSSDdeJkk1P+YZo85BUaprXtW
         7pPjM/KcMKVL+kKovwtQzWnHjgqfLcdzjv/fgx1auS7B+MlxBbK0GyR1Vgfw6obWbkTk
         Ly4TF3ogQEW3uT3LxSPqf55S+F+HNAEHv4duBghpcSI4YPZPPW4QH+6Moo7vjyWqv3vN
         A70TjBgz5XtK0aUlOK72tZZtJQ6QsHnpj2cnIa9FsW6ORvPsaBIk9sMFxRgX803bonPX
         D9uQ==
X-Gm-Message-State: AD7BkJLBV45QpUqJ3EhrunMxzngVyiBVSKNw55zxl4OSKQ8vokmfUo5jEnYZ4pD6ASJkVw==
X-Received: by 10.140.25.206 with SMTP id 72mr29817237qgt.49.1459091180321;
        Sun, 27 Mar 2016 08:06:20 -0700 (PDT)
Received: from MRappazzo-8.nycap.info (cpe-74-70-59-36.nycap.res.rr.com. [74.70.59.36])
        by smtp.gmail.com with ESMTPSA id 78sm2312230qhr.4.2016.03.27.08.06.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 27 Mar 2016 08:06:19 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290012>

Changes since v2[1]:
 - Instead of getting the remote info for each local branch individually,
   grab it all at once and store the result
 - Instead of a command line option to enable the new sorting option,
   enable it with a preference which is stored in the config.

v1 can be found here[2].

[1] http://thread.gmane.org/gmane.comp.version-control.git/289244
[2] http://thread.gmane.org/gmane.comp.version-control.git/288544

Michael Rappazzo (2):
  gitk: alter the ordering for the "Tags and heads" view
  gitk: add an option to enable sorting the "Tags and heads" view by ref
    type

 gitk | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 13 deletions(-)

-- 
2.7.4
