From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v6 2/4] githooks.txt: Amend dangerous advice about 'update' hook ACL
Date: Wed,  4 May 2016 22:58:10 +0000
Message-ID: <1462402692-24712-3-git-send-email-avarab@gmail.com>
References: <xmqqa8k5eakb.fsf@gitster.mtv.corp.google.com>
 <1462402692-24712-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 00:58:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5kb-0002U0-Jp
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbcEDW6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 18:58:33 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37993 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807AbcEDW6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:58:32 -0400
Received: by mail-wm0-f48.google.com with SMTP id g17so577289wme.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYJRQ7XJu/rHJ0+L6YIOceiGMEQpBWbsReQChklAIiM=;
        b=Fl6izfqSSwgjKFmSmAzFRujtc2ee88pWFcSiH5Wuo8BQSvwfgPIpwU+LHM9K6tL3Cg
         xwFlEFQ2zifDzYbl8A6u56YLZc3Uak1+oxY3Ud6lYqXhVqTR8HshP1kuw11tJgr5f/lz
         lUgWNBXb2Dyp8ZUceeG4E+KAKwkKvq+c/A/X6BKMs61nHJUMNOThI8sklnndWfWW0F2u
         wkgzNRmj8/8Rkgbv21vNcFDtL5uwrIhUjQSwLCxdw4BURjHSttwrYdvcytxBHYgMcaQJ
         GLRuQcSe01YzXeE0oO4pMLESqUPKTR3FmKw6VIk1qGJM1TeQx4VCYmGmh8mFKZiZh+Wt
         ml0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYJRQ7XJu/rHJ0+L6YIOceiGMEQpBWbsReQChklAIiM=;
        b=hH0K5tQQOgKOweZIwtfG9T50cOLiLBD2gu2nauclranTpDaBWYyaGCg85Hr+UX56lo
         HBBaPnO1ROgJELvcgJmWa8fvJugw88c70R49Vr7JAn7guqT+2Ztxml3VxUijciD3aduU
         SnEpBkynSuh019xu3vJALKVgQssdqshIoB0tbOL7X2avNv7i7eVgu+ZmrkBiW2R9rclK
         /OBtEL39zG7ZbBrqLYOeRdI8lrNcPK6fN/T6Q6bm4Cct+GYxU9AD98vCsCcG+bY3kd+z
         YLunxkkmO8OAneT0FwWmbKSIQCgZMcL3ipDpemku4EHqNP3Qz5DlmIAlEROe1FsdtI5i
         hREg==
X-Gm-Message-State: AOPr4FW33FUfA1Gb9VkAB2adLa2GaTSEN6gf3kVigsnRPisz/Xk89MmgPoPkqdsdpqXqzg==
X-Received: by 10.28.165.216 with SMTP id o207mr50867wme.31.1462402710719;
        Wed, 04 May 2016 15:58:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id us3sm6557967wjc.41.2016.05.04.15.58.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 15:58:30 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1462402692-24712-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293617>

Any ACL you implement via an 'update' hook isn't actual access control
if the user has login access to the machine running git, because they
can trivially just build their own git version which doesn't run the
hook.

Change the documentation to take this dangerous edge case into account,
and remove the mention of the advice originating on the mailing list,
the users reading this don't care where the idea came up.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/githooks.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 0d94337..0dd618a 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -274,9 +274,11 @@ does not know the entire set of branches, so it wo=
uld end up
 firing one e-mail per ref when used naively, though.  The
 <<post-receive,'post-receive'>> hook is more suited to that.
=20
-Another use suggested on the mailing list is to use this hook to
-implement access control which is finer grained than the one
-based on filesystem group.
+In an environment that restricts the users' access only to git
+commands over the wire, this hook can be used to implement access
+control without relying on filesystem ownership and group
+membership. See linkgit:git-shell[1] for how you might use the login
+shell to restrict the user's access to only git commands.
=20
 Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
--=20
2.1.3
