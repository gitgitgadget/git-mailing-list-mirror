From: 0xAX <kuleshovmail@gmail.com>
Subject: GIT: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 19:56:20 +0600
Message-ID: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Kuleshov <kuleshovmail@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 14:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsXf5-0001do-Jg
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 14:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbaKWN4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 08:56:42 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:44912 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaKWN4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 08:56:42 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so6437203lab.32
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 05:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EGCMOtIa/lRPnkzt3ZSs/It0wPqRKeMN4TTGNna8Kt4=;
        b=H6uH3pEve8UfWN/oRWPU0QR1wMwvh0u/4ot571AsI4IpaJcSl79pk9FECxybCGNUV5
         aRGmnXdrvH1o7zJABICdCGok9L82NS+f4XSUd8Z+2yJLu0cGTPFXxYIVEEHBq0lQy2sl
         ybTv+x/OSn2SgFSxSW4XOOsIHV/IhTxOMlGwtdN5Ldsb118QdzZZ8ELsHPj+PwvEg1Vt
         bqqmpKIuG6X2Z5Bcstrkjz8UXkMPd79ooL6MboRVnL/BMkBhEIc16t3srPzR5IuuhEgu
         JZ/twbbV+vNyenvTGGetTIBKlBTSakX6XHM4hPyS9WqofLU4ZvhZqM0LGYos6UpRUz9W
         eq1Q==
X-Received: by 10.112.52.73 with SMTP id r9mr3236382lbo.15.1416751000070;
        Sun, 23 Nov 2014 05:56:40 -0800 (PST)
Received: from localhost.localdomain ([92.46.64.151])
        by mx.google.com with ESMTPSA id xh2sm2744689lbb.7.2014.11.23.05.56.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Nov 2014 05:56:38 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3.191.gfdea3f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260084>

Hello All,
I found memory leak at exec_cmd.c in system_path function with valgrind.
After this patch valgrind doesn't show any memory leaks, but I'm not sure
that it is the best way to solve this problem. There are a couple of places
that uses system_path, if this way will be good, i'll make another patches
to fix this leak.

Waiting for feedback.

Signed-off-by: Alex Kuleshov <kuleshovmail@gmail.com>
