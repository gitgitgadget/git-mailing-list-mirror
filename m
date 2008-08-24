From: David Aguilar <davvid@gmail.com>
Subject: git-submodule: add "sync" command (v2)
Date: Sun, 24 Aug 2008 10:21:37 -0700
Message-ID: <1219598500-8334-1-git-send-email-davvid@gmail.com>
Cc: mlevedahl@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 24 19:30:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXJQH-0002cK-Sx
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 19:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYHXR3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 13:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbYHXR3h
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 13:29:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:25935 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYHXR3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 13:29:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1296197rvb.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=G2g7nP27fVE3B9OsEvGO46qrAHSJgwhj4LJwbBGQ75A=;
        b=o7JzZnGN//zimP7RoWa/G7t76DGWLf8dHRsoKmXztlp3uRy9yjcM4e224A629D2kbI
         UovyuuUIF+oGBEKJ5QbEUem7K9JDR6Ju90WLLZ3B/bCPxTm23BHVEfdqBGejxch8wm3F
         KUc2YMw0ptFaDZyi6MnkF9VwoOzp0xcnmsWWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=j6WLCHARFLmAAJ+XCteOFTRQ4n5X0GaTAd9bq3WmuncYmsvSQMLAvCRwxX7ZuRISxh
         Z7dR75QfBZWKD8a/zjWp9oKoxPu2aVIXg7XAmWEwVAZAfYnrP6rPC5kMQEWlfncHL1oa
         8yu0HhHbDZavHtxxKken4PdRtUYjXPdNfFVFk=
Received: by 10.141.176.4 with SMTP id d4mr1694959rvp.14.1219598976717;
        Sun, 24 Aug 2008 10:29:36 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id c20sm6011565rvf.3.2008.08.24.10.29.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 10:29:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.90.g436ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93535>

The following patches rework the "sync" command in response to
Junio's input.

The first two patches are a simple refactor to move logic for
finding the name of the remote, which is not necessarily
"origin", into a standalone function.

The last patch is the reworked "git submodule sync" command.
