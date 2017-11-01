Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1732055E
	for <e@80x24.org>; Wed,  1 Nov 2017 17:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754879AbdKARKl (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:10:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:64050 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754818AbdKARKk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:10:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFuWk-1dxLtJ1C0E-00Esc6; Wed, 01
 Nov 2017 18:10:31 +0100
Date:   Wed, 1 Nov 2017 18:10:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/3] mingw: optionally redirect stderr/stdout via the same
 handle
In-Reply-To: <cover.1509556153.git.johannes.schindelin@gmx.de>
Message-ID: <d98f6a9a6eeb01f68f4bc853952ca675e97940bd.1509556153.git.johannes.schindelin@gmx.de>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <cover.1509556153.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:I3/c1DsqXp7/6iIOOftSoBA/dut0eyoW3ja7aKfbTmUQE7GzYdI
 E3U4nFOtHAwegTWk3FoUV5zNl9TMed+aGz+r4aRLWKr+HJC4ZDFteasBw8+cLNn/+dMao4f
 W0zPPH9qiL/7IhjOKLPLtunR48kCHbPNc5P9uBXp8ad0HROL6CVCyOr3vGD34Jq6kZ3bDMf
 834KKD+vDOjb7ahP7XdfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GJuYWJDLVeI=:Fm69CQge1zLzFS/moqnD32
 Eiz0uWtqWRU41mM58rE6NOtX0k6DmUT/OnY9WQ1De9HERrMtIYK6Vq1mzCur1TQBvB9GzB8Se
 Aar7cYqFTRhaZNRCXca60UFMB2oHqYZLxRa3bdw6B0UolxYyX8foCZbeG+ciSuyT/1XWyVlwO
 cqC4QUiJtPcucfRl/hbanO/GmffWv6O8xODLr7JfTD+7hCuPkjpd3EqXd+gNwcERJ8aVf39tX
 mzzehDDuUyFiqx+Fa4RIxUbJOiDNStmn/lR+YOXJ3q6StJ5f50/tG64mgNE0w6wm1ViwAroVk
 rdO+q8evjbvfZndjBJjHDFUXA3yOGHTRIReqn8GaCIu7uHVhwAEfZJ4CvDU9G5DhJSJ75/Kf2
 H9O3N3nH6232NTHfs9+bawLxtRa3B4k+jlEFX8EFiRKcl8b1q4UPuwn+qWwzMn6tow/iZDAyk
 km2a2qMOeGxDuhJJ4hC1bU0yCkk5GfzOMM5nEVIH6p6lV3AVMB+nRvut7uAeC6pxm9ebzd6mA
 b4lJ4IDOFj9EOyrtUY7QdPd45MKLcqBg/cvCv7NucT8h+78TijzXl+J/i2ToURYUS0a09M0UP
 DwEyZqHrloXStX/xwKU7hSEQqpXvMC90Y1Et/ssmHor+fECkFZ0hoMcad4BzYAckEuAuFthO0
 GcKMAKPXvm0cdSOj9P6pX2QV76tL2e2jCNsuiePmcOq47L+4f5PuxPeTASrNTZOfEkjeMYcTY
 jijQvaYjNUewqv8b3X7Z8RYzfV0ClEVyyJpxIKdaW3DAavuIaSPnPGR4XRofs4a+YPgsVE0Ps
 9OPfNs7ttIU9zYKe5KXFC6guRbCGLUvDiKEpIoJ1a4fbNGSVhPKOxCYBB5xYU2meoyoGHmk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "2>&1" notation in Powershell and in Unix shells implies that stderr
is redirected to the same handle into which stdout is already written.

Let's use this special value to allow the same trick with
GIT_REDIRECT_STDERR and GIT_REDIRECT_STDOUT: if the former's value is
`2>&1`, then stderr will simply be written to the same handle as stdout.

The functionality was suggested by Jeff Hostetler.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c  | 15 +++++++++++++++
 t/t0001-init.sh |  8 +++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6c6c7795a70..2d44d21aca8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2160,6 +2160,21 @@ static void maybe_redirect_std_handle(const wchar_t *key, DWORD std_id, int fd,
 			CloseHandle(handle);
 		return;
 	}
+	if (std_id == STD_ERROR_HANDLE && !wcscmp(buf, L"2>&1")) {
+		handle = GetStdHandle(STD_OUTPUT_HANDLE);
+		if (handle == INVALID_HANDLE_VALUE) {
+			close(fd);
+			handle = GetStdHandle(std_id);
+			if (handle != INVALID_HANDLE_VALUE)
+				CloseHandle(handle);
+		} else {
+			int new_fd = _open_osfhandle((intptr_t)handle, O_BINARY);
+			SetStdHandle(std_id, handle);
+			dup2(new_fd, fd);
+			/* do *not* close the new_fd: that would close stdout */
+		}
+		return;
+	}
 	handle = CreateFileW(buf, desired_access, 0, NULL, create_flag,
 			     flags, NULL);
 	if (handle != INVALID_HANDLE_VALUE) {
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0fd2fc45385..c413bff9cf1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -456,7 +456,13 @@ test_expect_success 're-init from a linked worktree' '
 test_expect_success MINGW 'redirect std handles' '
 	GIT_REDIRECT_STDOUT=output.txt git rev-parse --git-dir &&
 	test .git = "$(cat output.txt)" &&
-	test -z "$(GIT_REDIRECT_STDOUT=off git rev-parse --git-dir)"
+	test -z "$(GIT_REDIRECT_STDOUT=off git rev-parse --git-dir)" &&
+	test_must_fail env \
+		GIT_REDIRECT_STDOUT=output.txt \
+		GIT_REDIRECT_STDERR="2>&1" \
+		git rev-parse --git-dir --verify refs/invalid &&
+	printf ".git\nfatal: Needed a single revision\n" >expect &&
+	test_cmp expect output.txt
 '
 
 test_done
-- 
2.15.0.windows.1


