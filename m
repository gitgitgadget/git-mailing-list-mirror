From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/22] add the FORMATPRINTF macro to declare the gcc function
Date: Thu, 11 Feb 2016 12:38:37 +0000
Message-ID: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqWw-0007te-I9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbcBKMjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36071 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcBKMjS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id 128so10425660wmz.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EeGfg4NxN4YTmTKBsu0FnB7nIyV4Yq7ImvH/BNwCmd0=;
        b=x2TdyD7+0BzKOfugFF5MyOYLcMGDAPXLEfHjATxZ2RkLeuy+Ta5iQP3h1zlS6CC7vu
         k/brsv5pJI5Lc/g/hfEMlIcCmyzsZDZ/nvVzyvMvh0m8c1+FiT2fkmPST6oy9MB1MPPg
         kmIw3BWo5vQD1t9GGX0g7/NoFoCv5Z+HEo1ujt0bYOut45sRVrW09OJ/I/JHgLCm68Im
         7l56Matc6lvWmufLCIe8zRH/XceCxaHKpEeSEprnOacS4TciS3oJDyxxEa4rzXUYcFU5
         y+kmyt1+ENimcU5Aqjt7IcSpNgEzw9LGkplartGJQ0ghOKXj00ykSbDGbbA85ttMgMkv
         eAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EeGfg4NxN4YTmTKBsu0FnB7nIyV4Yq7ImvH/BNwCmd0=;
        b=Ej44cvYkN9IkVZ+VkR8Kyc/9VPc7+zQggC+NxSpUvdNEWYU9JoPXozdSZITCtoL5xB
         eMVefo3K6HA46J0EER/iEzHhX3RY0FvIKvyq2ak5m4XMnYcrqywIAZ75GMIlgLS9bOZ/
         cSWOZS7R0QtFGQEYUk6oMH3gTKJ/nt+i3rCflw74FywWu26bmIKjnHGKQmRzIuRps5ll
         5DM9OmTqkowoCCXqcY0sz7HcFnj4KCLcYoN6qywL6oTDNbhRv5ontMMee0hrK3SZMgCy
         taCZp9A2Fy4QlinhaeFLP9MHm0aVDkmIIrcuK1J65unWXbPkekb4pcOlrTVfvaLg84u7
         vDUQ==
X-Gm-Message-State: AG10YOQ8UbOSfGSDqEzQLrshZaX7n0AEEAT5Fb1dOWvIyEY5zx1UZDRbX2hPduXzHz3zWw==
X-Received: by 10.28.176.133 with SMTP id z127mr18048778wme.22.1455194357851;
        Thu, 11 Feb 2016 04:39:17 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:17 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285957>

Add the FORMATPRINTF macro for declaring the gcc function attribute 'format printf'
for code style consistency with similar macro that git already use for other gcc
attributes. And use it where necessary.

Elia Pinto (22):
  git-compat-util.h: add the FORMATPRINTF macro
  advice.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  argv-array.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  builtin/index-pack.c: use the FORMATPRINTF macro to declare the gcc
    function attribute 'format printf'
  builtin/receive-pack.c: use the FORMATPRINTF macro to declare the gcc
    function attribute 'format printf'
  builtin/update-index.c: use the FORMATPRINTF macro to declare the gcc
    function attribute 'format printf'
  builtin/upload-archive.c: use the FORMATPRINTF macro to declare the
    gcc function attribute 'format printf'
  cache.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  color.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  config.c: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  daemon.c: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  fsck.c: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  http-backend.c: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  imap-send.c: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  merge-recursive.c: use the FORMATPRINTF macro to declare the gcc
    function attribute 'format printf'
  pkt-line.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  remote.c: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  strbuf.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  trace.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  transport-helper.c: use the FORMATPRINTF macro to declare the gcc
    function attribute 'format printf'
  utf8.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'
  wt-status.h: use the FORMATPRINTF macro to declare the gcc function
    attribute 'format printf'

 advice.h                 |  3 +--
 argv-array.h             |  2 +-
 builtin/index-pack.c     |  2 +-
 builtin/receive-pack.c   |  4 ++--
 builtin/update-index.c   |  2 +-
 builtin/upload-archive.c |  2 +-
 cache.h                  | 22 +++++++++++-----------
 color.h                  |  4 ++--
 config.c                 |  2 +-
 daemon.c                 |  4 ++--
 fsck.c                   |  2 +-
 git-compat-util.h        | 14 ++++++++------
 http-backend.c           |  6 +++---
 imap-send.c              | 10 +++++-----
 merge-recursive.c        |  2 +-
 pkt-line.h               |  4 ++--
 remote.c                 |  2 +-
 strbuf.h                 | 14 +++++++-------
 trace.h                  | 16 ++++++++--------
 transport-helper.c       |  2 +-
 utf8.h                   |  2 +-
 wt-status.h              |  4 ++--
 22 files changed, 63 insertions(+), 62 deletions(-)

-- 
2.5.0
