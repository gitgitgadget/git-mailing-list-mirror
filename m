From: larsxschneider@gmail.com
Subject: [PATCH v3 0/2] travis-ci: build documentation
Date: Mon,  2 May 2016 22:20:03 +0200
Message-ID: <1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 22:20:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKKE-0004zM-PH
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbcEBUUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 16:20:11 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37190 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbcEBUUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 16:20:09 -0400
Received: by mail-wm0-f48.google.com with SMTP id a17so4804195wme.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8TAlpVJt1jwiARBGHBl6Bbhk3GwQI0er0NgdP7cHtc=;
        b=v+4a72dRKPRreBJWb8rGiStnOyxG8izdw44CckFQJfMW/Y3xYtUCf8yPqqVurEMVmZ
         hnxndwCowlJfGyh1yMk+BqHCin0FjT2zOu47DoUWNQteqRSKOQkdnNk3GyJmQsnCE6gi
         OnmdvNMCQV5ozwaGGNWc7dkKFX5J0LKBAW9WbUWLEMs84cIZYX7N49e1+nN8YgcsRTju
         jy9W8hDQLivnqTNlmXJVFkZc1kcyAXnIBTeja5ov+rkTGGJarv732MKBZZJ4eDynE9B7
         PB2yh8cEOkacaOTalP79iLKo5FolLE802UwaMYF7KyZFwnO/k6j5rd53vy9bSlPqklV3
         mIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8TAlpVJt1jwiARBGHBl6Bbhk3GwQI0er0NgdP7cHtc=;
        b=XLAqN4+d1iO/IjcfT8gkwstQ/oMyx7qL6H7vXGQCdtvUnbB6UgMy//1Xekzy3zSq5Y
         1dpbckc2GEIBqtUNxUjPVuPbwTOknngZwFEm+HwlZJk3ox8P2TcvVUCvlPE59LNUwBLy
         QQMEK9AVc/FJBCtBD+AS6EM6hcYs/TpMLkyoSXYFsltHhujzPVRBIeIcII2oAkaXN8Uv
         27TAJ3ET3oXiy1R/RNjH35o7h3vqMBvtshNdlovIi4QuYG6l9QHkNw1yF9pC7K/Tcsux
         BYYwnz3CyBvf2qM/kZZ+PC4HTn5Dxn28078x4QKaFim28y+/j6dAzq5JR7/CDb67YxYQ
         hIiw==
X-Gm-Message-State: AOPr4FXuH3wUkqua2JqVPXeXR+p7MBOQAwmYjWXNpELaHwP/VVOkCONb+yU+K4j78PKgTw==
X-Received: by 10.194.88.201 with SMTP id bi9mr37681115wjb.147.1462220407797;
        Mon, 02 May 2016 13:20:07 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB4E4A.dip0.t-ipconnect.de. [93.219.78.74])
        by smtp.gmail.com with ESMTPSA id v143sm20558672wmv.4.2016.05.02.13.20.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 02 May 2016 13:20:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293282>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v2:
* remove file count check for generated documentation as it is too flaky
* run `make doc` in `test-documentation.sh` to reduce the code in
  .travis.yml and ease the execution in other CI systems
* add linkgit check
* fix existing linkgit errors
* add `make check-builtins` and `make check-docs`

Thanks to Jeff, Matthieu, Stefan, and Junio for the review!

Cheers,
Lars

Lars Schneider (2):
  Documentation: fix linkgit references
  travis-ci: build documentation

 .travis.yml                         | 15 +++++++++++++++
 Documentation/config.txt            |  6 +++---
 Documentation/git-check-ignore.txt  |  2 +-
 Documentation/git-filter-branch.txt |  4 ++--
 Documentation/git-for-each-ref.txt  |  2 +-
 Documentation/git-help.txt          |  4 ++--
 Documentation/git-instaweb.txt      |  4 ++--
 Documentation/git-sh-i18n.txt       |  2 +-
 ci/test-documentation.sh            | 24 ++++++++++++++++++++++++
 9 files changed, 51 insertions(+), 12 deletions(-)
 create mode 100755 ci/test-documentation.sh

--
2.5.1
