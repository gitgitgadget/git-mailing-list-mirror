From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 0/4] i-t-a entries again...
Date: Mon,  6 Jun 2016 18:16:39 +0700
Message-ID: <20160606111643.7122-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: thomas.braun@virtuell-zuhause.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 13:16:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9sWd-0007yX-J6
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 13:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbcFFLQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 07:16:52 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35754 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbcFFLQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 07:16:51 -0400
Received: by mail-pf0-f178.google.com with SMTP id g64so66172087pfb.2
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMrDIyy8BKw14PZMHYyKk0drermyO7nIJTY39a7Qffg=;
        b=HLLH+vIKgIx1ChK3U5Iw8ge9LWeOGfnVEn6XqSCsbnd4z8I97bp1Aw0wkPCWBUR/Pd
         6JqaA5uGa9fmUz2AyyYJFNlt8z8pJaBURUDNQiQqBcYy69vfcPsmVJdCULSrhDiqXJD3
         mY2wozmuFqp/n2eu+17eNjsAfsTfR4isuQwYPJ/GIP6pGZnLEI8DoqK0t/L9najC1cNo
         gHcLn3UoFkoT52dPa1A0broS2QmaElv9zJPx/WBVAQKUFAiW1eTwP3ek28LL+/hrC4AN
         vygadSkOhJCn/VVnnSEcAfJWQsaDKhjotN5jF7gyRaK4W2kzecfDYHX/Vh6G0yZ2HsQT
         6AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMrDIyy8BKw14PZMHYyKk0drermyO7nIJTY39a7Qffg=;
        b=fOQRIsqqR3fwtfUKJ85qY5Au/unKbHIoDFhymqwP2cUXVKMhV9u1pRVFxszJ228wv0
         kgHT5JjCoSPkv4BASS+xm3xpGuogPMTtbE1uLzilVgtgBJPDgCbSObZ9vmhZMwFUM5hn
         BCWyYRdyrP7VQuSd27/M2XnyVfmfHMMoJRm7ojERUOoEZy0kRWf3VYiiaSGUs/HVlSU5
         If96X0cHxk7ND5dF3n1TN5BlLNeHzfqd/rf7myJo3/g1zEfCkiCWUbmFR1CCRmma3ntM
         mBO5S9Irm5QSAUi25OL4Edq2RDwWM48ENG4JmjPJ+pQLokaY3foVB5rXB+5R+2iwXLho
         ztuQ==
X-Gm-Message-State: ALyK8tIimZFC1em8AD9CiPiUJBzuqtVvstv4UR1FxFiitnhg7jefZHsFdg/OjBO/kAFlTg==
X-Received: by 10.98.49.135 with SMTP id x129mr24679306pfx.35.1465211810554;
        Mon, 06 Jun 2016 04:16:50 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id hw10sm24538524pac.15.2016.06.06.04.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 04:16:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 06 Jun 2016 18:16:45 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296497>

The first two patches bring back a patch does fixes "git status" when
i-t-a entries are present (i.e. "git diff" should show new files while
"git diff --cached" should show no changes).

The third commit fixes "git commit" creating empty commits when i-t-a
entries are the only changes compared to HEAD.

The last one brings back the old behavior before 3f6d56d (commit:
ignore intent-to-add entries instead of refusing - 2012-02-07). I
still believe that current behavior has its uses. So instead of
reverting the behavior unconditonally, the user can choose to switch
back to the old behavior via config key.

The last two do not have have proper tests added because I just
created them in the last hours. This is mainly to bring back the old
discussion to see what should be the way forward.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  diff.h: extend "flags" field to 64 bits because we're out of bits
  Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
  commit: don't count i-t-a entries when checking if the new commit is =
empty
  commit: reinstate commit behavior before 3f6d56d via a config option

 Documentation/diff-options.txt |  6 ++++++
 builtin/commit.c               | 14 ++++++++++----
 cache-tree.c                   | 14 +++++++++++---
 diff-lib.c                     | 18 ++++++++++++++++--
 diff.c                         |  4 +++-
 diff.h                         |  7 ++++---
 t/t2203-add-intent.sh          | 20 ++++++++++++++++++--
 wt-status.c                    |  5 +++++
 8 files changed, 73 insertions(+), 15 deletions(-)

--=20
2.8.2.524.g6ff3d78
