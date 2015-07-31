From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 0/2] bisect per-worktree
Date: Fri, 31 Jul 2015 19:56:50 -0400
Message-ID: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	chriscool@tuxfamily.org
X-From: git-owner@vger.kernel.org Sat Aug 01 01:57:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLKAr-0008Bi-3k
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbbGaX5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:57:07 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35269 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbbGaX5G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:57:06 -0400
Received: by qkbm65 with SMTP id m65so34622881qkb.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=xDn4uAKCycPhb+7U3vYglz5k3euf2hnzLffo6p+m4lM=;
        b=B82M74iIy2H2Xy7TgzO4WDy6/IX7OF6qTwh8Ln5QcRysKD8H1TxnKyWEuftGlA9T85
         hU+5VDDAgeZxd2dH+FrGrHgTinhf0IcovJn6HPNFNO6XUT2CwFMSgb2Owi37kD2znL5D
         CE74yjAUKyChQJsExgpbuM+sN4C+LPpgIi8ZHVe2VyPKtz8RqcNwm3Kpw8o80xM9I3YA
         lun38tzTWISAkgkQErCEqCsuAtAXRVDryg67K8xXY26XN9G93e+u6FVhapizZ1V3mtAy
         o2s7mwilGGE+dtNPt9j//fDBQvPXWqmvE8ta1wZnhxObSuRLziTqdfDbYyVgn1ozNkEL
         JX2Q==
X-Gm-Message-State: ALoCoQlOjTag14Qwz4jJL80X/2itfrTt8SkcN/v1zE01lZcNN6TYI9tT+o53rfXeLkBCVb8bCBgV
X-Received: by 10.55.21.160 with SMTP id 32mr8851169qkv.92.1438387024565;
        Fri, 31 Jul 2015 16:57:04 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 25sm3038515qkp.37.2015.07.31.16.57.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Jul 2015 16:57:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275097>

This is RFC because I'm not sure why show-ref only works on refs/ (and
whether it should learn to look in worktree-refs/).  I'm also not sure
whether there are other changes I should make to refs.c to handle
per-worktree refs; I basically did the simplest thing I could think of
to start with.
