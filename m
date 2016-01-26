From: larsxschneider@gmail.com
Subject: [PATCH v2 0/2] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 26 Jan 2016 10:53:41 +0100
Message-ID: <1453802023-85055-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, mh@glandium.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 10:53:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO0Jr-0001TT-F1
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbcAZJxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:53:47 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33118 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964956AbcAZJxp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 04:53:45 -0500
Received: by mail-wm0-f65.google.com with SMTP id u188so16338878wmu.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 01:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TlfHNGQ/dNnoDn9GuH6ojZUpULXuLQxKnCn0SN0MPMg=;
        b=ZEK1UMJqTovRDybqdb+oyT4C94PsHvoKciAL3uX2DMA9q5LsoKRzvDNtGIhPpKkat+
         qzJe4PueWRL9Q141lErpE1KRWO6jyfWyKrIcnza37YqEUDrfMTZkHtoQXIYGmM/1n1cc
         Y26wYKp0f6QwUJrWURf9QKxfhAs97RxSZpuoFVKoYxoLW3xfoL7/eN3uWVY8XZVwzdIR
         VbllyuDg4WhmJLj2bJijNyrMqffeKKFiMGMkiTFssH+GfumZuoAtzIx+z78H3GC+k4VO
         fyFnvylElcmTB34YbFvTRe6GIKpyEV/1FYkVL42iMjseUxsh+Kj20ZbYPx04ogaJdubz
         23UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlfHNGQ/dNnoDn9GuH6ojZUpULXuLQxKnCn0SN0MPMg=;
        b=DyFOyCk5bHGRTsYwXVa9lk/F5QAB8BNgBawq+ZO1/YUJhrmQ4+DmGPdUsySqlbugFR
         g7t3qh4wbbVZxT9wTSuGCxH2te98BKs1WXQnTxKpil/pFNPRhpGRijEuJVwnXfM7xxSG
         YuZ39WJz+W3gXHGOtTP1ShVpsboh73iO9fFSZbXhOPE7/jRQt1FX3Bldy8DppxSb5hG3
         ty8TQC82dBNiQd6r2W7iTtDsPi7ZHITiXEM8yL8OWE9nj/8f5A5mz0pdPXSHy7qYX3Z7
         ASzvNKXuSRhH33jwHQNWTr0Sp7B2Stx9jbMs93HgWX/Nm101cHqoG5WdbUmjkssj7NXk
         /etw==
X-Gm-Message-State: AG10YOSLDUjYwy7CJ1Ihwh5WPed3rIkWJncK3n+wgzuta07xsdLg1EHacZ6OeDqDaUbxLw==
X-Received: by 10.28.105.25 with SMTP id e25mr24690620wmc.62.1453802024115;
        Tue, 26 Jan 2016 01:53:44 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA9B5.dip0.t-ipconnect.de. [80.139.169.181])
        by smtp.gmail.com with ESMTPSA id w80sm2683566wme.17.2016.01.26.01.53.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 01:53:43 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284798>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v1:
    - improve the commit message ($gmane/284465)
    - rename the Travis cache directory from $HOME/.prove-cache to
      $HOME/travis-cache for clarity
    - explicitly use container-based infrastructure ($gmane/284432)

Thanks Mike, Jeff, and Junio for the review!

Cheers,
Lars

Lars Schneider (2):
  travis-ci: run previously failed tests first, then slowest to fastest
  travis-ci: explicity use container-based infrastructure

 .travis.yml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--
2.5.1
