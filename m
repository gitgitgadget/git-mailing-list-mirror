From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 0/6] Replacement for rr/for-each-ref-decoration
Date: Mon, 18 Nov 2013 23:09:07 +0530
Message-ID: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:48:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSw9-00042p-7y
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab3KRRse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:48:34 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53890 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab3KRRsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:48:32 -0500
Received: by mail-pa0-f45.google.com with SMTP id kp14so1263554pab.32
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uccEJTlAM7RkAje+2WLBudQucRbDEAWWnbwyZNerOhU=;
        b=ogOV+v7gUV96ZKPREKp+7U7UGRyF00Oo/Wke3Qut5jE3U/EZkDX9U8ZDXP+auIFn6l
         91wCAgBlpmLFg4CUTznMNcJkm2d24ms9TlKImolhDpyGe+vLu0tSKyhV9vl4r8hAB66K
         aZaz4MBc5K6DNMqKUm2ojAYe/FEDE6cP4c3O8bVyzcr3wgfbnloo47U65gshooJgJVc/
         HTeMvQicwSl7YzjrJqvnjzAfegR7pS38U280vGD0e3WZJ0T8U0d2/GWxQZhYO9g39xTi
         X8vwb8/lMy94SeBPnar8EE1H7yiw4v9qBtsxysatQiwo0MFjoehtZ/Ccl7lRD/CTJAy2
         DdMw==
X-Received: by 10.68.20.227 with SMTP id q3mr1424508pbe.201.1384796911927;
        Mon, 18 Nov 2013 09:48:31 -0800 (PST)
Received: from localhost.localdomain ([122.164.173.226])
        by mx.google.com with ESMTPSA id hu10sm24836183pbc.11.2013.11.18.09.48.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 09:48:31 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.5.g70ebc73.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237995>

Hi,

The major change since v3 is in [6/6]: color no more auto-resets after
each token, but instead only to avoid leakage (thanks to Junio). Other
minor changes are in accordance with Eric Sunshine's review.

Thanks.

Ramkumar Ramachandra (6):
  t6300 (for-each-ref): clearly demarcate setup
  t6300 (for-each-ref): don't hardcode SHA-1 hexes
  for-each-ref: introduce %(HEAD) asterisk marker
  for-each-ref: introduce %(upstream:track[short])
  for-each-ref: introduce %(color:...) for color
  for-each-ref: avoid color leakage

 Documentation/git-for-each-ref.txt | 14 +++++-
 builtin/for-each-ref.c             | 93 +++++++++++++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh            | 69 ++++++++++++++++++++++------
 3 files changed, 151 insertions(+), 25 deletions(-)

-- 
1.8.5.rc0.5.g70ebc73.dirty
