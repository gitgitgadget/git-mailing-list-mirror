From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 0/5] Handling empty notes
Date: Fri,  7 Nov 2014 10:19:16 +0100
Message-ID: <1415351961-31567-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 10:19:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmfhj-0007Bk-VC
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 10:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaKGJTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 04:19:33 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:39019 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaKGJT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 04:19:29 -0500
Received: by mail-la0-f54.google.com with SMTP id s18so4147086lam.13
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 01:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=M4NoPjrp9ITFbhUALdCDkI/NyhREryFLoHXHFAJ1tU8=;
        b=hup8v/YK4FI/6pF0+foE+80zc0c7O+nZb/xHMMnZa/hIAxdT7TqexSU4EHdkC7rWwl
         0FCYBs+q3+/NLGrMDezeMpQ2/m04ki4xH6gghyAyOajZ1SSgb3B47CuMOwckUZHP9RLa
         4Pg0ncYGR9kwjq5RERR5jfce6fsUT09L3ZapjuEcltH7OSsnLRUmn8P61XgHmvY1HeYT
         2QCwQpQKp6dqEoQ3cydJG0iBvDOAJIXsQYNDsau42Kofb2mlW+ylvOzS6IGeG8w5sRud
         Cs+snZH2UecddYowXOTSK7hZ+40XYMw4EfETTGhMPq9s6BafkC8m8i4yB2hox6YBGUb7
         lyFA==
X-Received: by 10.112.52.37 with SMTP id q5mr10052396lbo.32.1415351968262;
        Fri, 07 Nov 2014 01:19:28 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm3081897lav.15.2014.11.07.01.19.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Nov 2014 01:19:27 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes v1 -> v2:
 - Incorporate Eric's feedback
 - Factor out an initial fix, needed before adding the tests

Changes v2 -> v3:
 - Incorporate Junio's feedback
 - Move tests from t3312 to t3301
 - Refactor the display of empty notes (the part concerning
   git-log) into a separate follow-up patch (#4)
 - Add a final (optional) patch with some whitespace and other
   cleanups in t3301. Feel free to drop this if it's too much
   churn.


Have fun! :)

...Johan

Johan Herland (5):
  builtin/notes: Fix premature failure when trying to add the empty blob
  t3301: Verify that 'git notes' removes empty notes by default
  builtin/notes: Add --allow-empty, to allow storing empty notes
  notes: Empty notes should be shown by 'git log'
  t3301: Use write_script(), nitpick whitespace

 Documentation/git-notes.txt |  12 +-
 builtin/notes.c             |  25 ++--
 notes.c                     |   3 +-
 t/t3301-notes.sh            | 301 +++++++++++++++++++++++++-------------------
 4 files changed, 197 insertions(+), 144 deletions(-)

-- 
2.0.0.rc4.501.gdaf83ca
