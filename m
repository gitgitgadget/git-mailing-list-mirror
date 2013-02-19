From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] fixup! Documentation/git-commit.txt: rework the --cleanup
 section
Date: Tue, 19 Feb 2013 12:28:23 -0800
Message-ID: <20130219202822.GA13460@google.com>
References: <7va9r06we2.fsf@alter.siamese.dyndns.org>
 <1361298570-19738-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, ralf.thielow@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 21:28:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7to9-0005i0-5K
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 21:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934023Ab3BSU2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 15:28:33 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:42309 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279Ab3BSU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 15:28:32 -0500
Received: by mail-da0-f48.google.com with SMTP id v40so3117339dad.35
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 12:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pdLyMd2G3Jh8oPnmeQA6J7fIRnyOHEO1mP7/TWhY2mM=;
        b=ZiYUbDMT9Yj2XANHsecXBARRgc1Y9+Xuvm+sl+WNEG6xDvsQAROuAsqwMbXxWnrobf
         +s0VmSMDsC9JoLwdrOV+NK3fx67nzipfcCMqjR5dVLqUztEXY+IVsseXwDJwWod7Q4oB
         BVypzBo4t8UdsSnvpZTTQOwmVOSQdzJZz7+prWjFuGQ6W2gAJz4S+XmdZrwyF5Dj9x4j
         K0rHxwY/YJpxKwrVRN9pc5Qy5zJtrr91cKWLsk7RI+VOEp3YEXPmR0tvOrn9uaxBS/7b
         BFE3veCAWnZ8iSn0h2A37OvKJ8RYVC2gr0gH6W8WNWs6rUNnZ064iSOxAwv5or/2PFO0
         gEOg==
X-Received: by 10.68.58.3 with SMTP id m3mr43587398pbq.69.1361305711906;
        Tue, 19 Feb 2013 12:28:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id hu2sm19024712pbc.38.2013.02.19.12.28.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 12:28:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361298570-19738-1-git-send-email-bcasey@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216657>

Hi,

Brandon Casey wrote:

> Signed-off-by: Brandon Casey <drafnel@gmail.com>

This renders as

	--cleanup=<mode>
	    This option determines how the supplied commit message
	    should be cleaned up before committing. The <mode> can be
	    strip, whitespace, verbatim, or default.

	    strip
		Strip leading and trailing empty lines, trailing
		whitespace, and #commentary and collapse consecutive
		empty lines.

	    whitespace
		Same as strip except #commentary is not removed.

	    verbatim
		Do not change the message at all.

	    default

		strip if the message is to be edited. Otherwise
		whitespace.

		The default can be changed by the 'commit.cleanup' config
		variable (see linkgit:git-config[1]).

Problems:

 * There's a weird extra blank line after "default"
 * Wrong indentation for the final paragraph.
 * The linkgit isn't resolved for some reason.

The following fixes it for me.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-commit.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 992c219..24a99cc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -185,11 +185,12 @@ whitespace::
 verbatim::
 	Do not change the message at all.
 default::
-	`strip` if the message is to be edited.  Otherwise `whitespace`.
+	Same as `strip` if the message is to be edited.
+	Otherwise `whitespace`.
 --
 +
-	The default can be changed by the 'commit.cleanup' configuration
-	variable (see linkgit:git-config[1]).
+The default can be changed by the 'commit.cleanup' configuration
+variable (see linkgit:git-config[1]).
 
 -e::
 --edit::
-- 
1.8.1.3
