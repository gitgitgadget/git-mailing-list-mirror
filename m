Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771533FD1
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735355600; cv=none; b=oK4kfSutUYvUf/vuXC+Ry7ZoC34m38qUVvBrDlxz2fUFtVLhnE0/0wVG2J6ckcv1CDtYQAxngZYW1p01dG+RnAL7q7zMN52znNOOU8Gyj+wqEe2bY4SvuOEhTdlTCSb5C7P2yRwHpWqLp9rMv+gfQrFBcQR2pL4P8bGUXdL9PiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735355600; c=relaxed/simple;
	bh=QJa7jo2UrAzuOtDI7DU3+pfnNfESXoz+olR+UanNPdA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=C9yzb/0tuPXRe4Lep+P4+oWDCeVtnWpTPla2spWFgFPibohRns1LzXKkZq4tcLVlLrSjDEBYnvUoFpXmKL9k9qpjvYyYhXgTt4raoVfieDEZER5Y5izYReEGt8rxOacrRyv02G79zzG0X+VRufMOuTTijc8fV+Z1q2qLonDEEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=byoungchan.lee@gmx.com header.b=gk7vvtMq; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=byoungchan.lee@gmx.com header.b="gk7vvtMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1735355595; x=1735960395; i=byoungchan.lee@gmx.com;
	bh=QBbZnnUKFmesHMWAikiFUcosits0furP+Lx2qRRvJZQ=;
	h=X-UI-Sender-Class:MIME-Version:From:Date:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gk7vvtMqWq+16A+VF2u764CUuoBYXF/YbSFPAwXBUVJCkQgFO2LoThTMjz+B+qSo
	 TTeAI4YWsnfS5TF8NC9kg93ngQdVrpylyEetwPt+D8rkXpl+BgJwCWPGTANC3zKoQ
	 2FeCU6swfvT9Qnlxk/1l06zgL+Nd6JzKEKvNNhPzxTN0Qz2w/y4fALM5QEuEh6qOm
	 bPjdKWHawu3amSvcBXsMouLVE1ikEfngRpt0ryX9oFSDKKF9FMaNYIg11lku99Yk8
	 yN+jxBTpsHExDbWKF8Jl5AJpUKvZmyjeddQ5g5s6AxJ5jce+ESJdUjof50U992Inx
	 R3Io35Zj8XDDsYSCOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MJVHe-1t7Uvb1AwS-00XlYo for <git@vger.kernel.org>; Sat, 28 Dec 2024 04:13:15
 +0100
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso10307157276.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 19:13:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyEMoGqfKyBGTsaV1mIzruc2cKtUHfYX3ooEeCp2Ivpnn0QHK9G
	7Td5Vr82/nDZtVh3QviKZXa9gZR4IK0r1byV1NKy3ggfTFRVFAJ3WJf778vaqY6bnj0aJmJ+6Zd
	zS5+MHU3DzkUx7BA7mJHn081opa4=
X-Google-Smtp-Source: AGHT+IEmIxH1f4AyVFZKjBT1oG07t3/z1BWrMqvYtAnShC2b3NIoBst77+CDHmr6h1xp7eNshjHf4KJmLurjGsoFqMg=
X-Received: by 2002:a05:6902:1244:b0:e39:6e4d:32ec with SMTP id
 3f1490d57ef6-e538c41488fmr22397586276.47.1735355594020; Fri, 27 Dec 2024
 19:13:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Byoungchan Lee <byoungchan.lee@gmx.com>
Date: Sat, 28 Dec 2024 12:13:03 +0900
X-Gmail-Original-Message-ID: <CABbmNUHA5F_ZMzngYHBzuqLLJ-3+87yVU_gZxGxhCYuMP64QKg@mail.gmail.com>
Message-ID: <CABbmNUHA5F_ZMzngYHBzuqLLJ-3+87yVU_gZxGxhCYuMP64QKg@mail.gmail.com>
Subject: [PATCH] builtin/gc: Ignore random minute field when registering macOS services
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QhQr+P5HuR6cUiE/vIsjxCrpXUrC8A/UyXOi8n/5K25nA5X7YFa
 kufnMSdTtThepkJq3yya8J7JDOSas3Z2AZuxneCnYUVhXt+q/rajD1TFj5VD84qatJKw8tE
 9iJEsBRBObDTqp6niaMNuvmNRYjX8Q3q6pIGgZcheBAL/JLSlkvKp9P7+92UndOaOFknVb6
 na8Zo0BgKdVcB6ImBOjHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ARGaguJ1tqM=;uYE0NbgMvL1d5I1jN9oUtEPsYBA
 8V1nPd+AFUUYdAaHVBt+iFFNNKhNys9fdwPSlcFRhZbPm1c8c34ZIlBvIyM8YtXGwl1PkC9nd
 /NIcv7yQJ2Wa1Dj3M9QXhHvYnfA21Sm16gXJ5G62lt5g2KKrxErYgm6qDQu+U2ZZj4G74Sdju
 dMfIfunUHPV/s29ZegwMIAhgs/uIYdKEYeDbjdnTunJ8e6wuMG3ooAUOSa7P0sihnyKI96nCK
 7IBrwBiVUuTnvwy+WkCwO6bWNaWeNH3+WVDyCnhgBLWnHR2T8Vp/uXpavReE5fPkr1nR9818x
 UkGe837SZ+m7RSy38hfcVQHqJShpoFOplkILK7vqu2Sr3NO0dVxUovFEZeEl+6kzSy64HcIW7
 mkDqKQ1fUHAxKgCFZMzp87ToTcuF4B3BiPDHokrqAE5fiMSVvL/DLg22mypPp4bpYG/5Zhge2
 fYa+yDFChMgXNxbT9xz4pV4Jq2i392Icw6BDrxbiSMJK9z+oB6bjTj2z/YGwk5GFdFq/SCcEf
 +6YP9VDCQ2BHl0EhMy22NlfZK7PxfARKSnXW3mgNKb6WX0TlJl76u5cyiOWw6CnyNj1NqAeWn
 6OUfn9VhY6/Xn6s6MZCSHH88jAM2YC4P+Z8KxgaiGf6m/Xzi1oYSDnrcNhsiqyhdl+9jE7Tzn
 Mw1tOhXCuUMM/ZRgR4pwUvsUkx+Ng6AfFNZO0x79vVxnLCWunogkt4BFc9dtILtdEWIiLEx4/
 iPyMUtCt04UsVuABEJv3khrF8x/OkOT09jwhd7z0tyKqSAoG+V6rNzOT7Xh5NFnyRRM9dQ73r
 ci44HBcOz+mNVbLquZLBt8FuVnNIxfjfTaTet1fuZCpuHBGKxNdPwfuDYZ4CIg9LX43FVqQYe
 JT8AWliPYCLjT8NaF8LIbnpmyGrw15QYejRqq27gqQPK+oivCZGAZ6sUhVVgMjyGS7sn8XnPy
 LVLNHb7HHMm6JiNauHkLRsSDQ+s0M5rfCG9tu77zqHWha43TGlLqtnrvMaxYqbJVjb6bvjGfk
 Xgj80UQ+b3T/jHmL/+/8ucj84QlebsjJyccuOHOJkZDoUcYeiQX5EEEZDEcFOE89padr1XBHX
 6bzQqo0OUNMzM8Ohm1h4TQSHfZRtfu

In macOS, `git-maintenance` registers several launchctl services
to periodically run Git maintenance tasks by creating plist files
in `~/Library/LaunchAgents/`.
To avoid re-registering services unnecessarily, we check if a service
is already registered by verifying the existence and contents
of the corresponding plist file.

However, these plist files include a random value in the minute field
to distribute maintenance tasks over time. Because this value changes
with each registration attempt, a direct comparison of the entire file
(via `strbuf_cmp()`) often fails, causing services to be erroneously
re-registered. As a result, users may see multiple services registered
and receive repeated =E2=80=9CBackground Items Added=E2=80=9D notifications=
.

To resolve this, introduce `launchctl_plist_cmp_ignore_minute()`,
which compares the content of the plist file while ignoring
the random minute field. This ensures that services are not
needlessly re-registered when the only difference in the plist file
is the randomized minute value.

Signed-off-by: Byoungchan Lee <byoungchan.lee@gmx.com>
---
 builtin/gc.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a9b1c36de2..6405f4d332 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1951,6 +1951,51 @@ static char *launchctl_get_uid(void)
  return xstrfmt("gui/%d", getuid());
 }

+/*
+ * Compare two buffers that represent launchctl property lists, but ignore
+ * lines that contain <key>Minute</key><integer>...</integer> because the
+ * minute values are not significant for comparison.
+ */
+static int launchctl_plist_cmp_ignore_minute(const struct strbuf *a,
+          const struct strbuf *b)
+{
+ char *buf_a =3D xstrndup(a->buf, a->len);
+ char *buf_b =3D xstrndup(b->buf, b->len);
+ char *line_a =3D buf_a;
+ char *line_b =3D buf_b;
+ int result =3D 0;
+
+ while (line_a && line_b) {
+  char *next_line_a =3D strchr(line_a, '\n');
+  char *next_line_b =3D strchr(line_b, '\n');
+
+  if (next_line_a)
+   *next_line_a =3D '\0';
+  if (next_line_b)
+   *next_line_b =3D '\0';
+
+  if (strstr(line_a, "<key>Minute</key><integer>") &&
+      strstr(line_a, "</integer>") &&
+      strstr(line_b, "<key>Minute</key><integer>") &&
+      strstr(line_b, "</integer>")) {
+   line_a =3D next_line_a ? next_line_a + 1 : NULL;
+   line_b =3D next_line_b ? next_line_b + 1 : NULL;
+   continue;
+  }
+
+  result =3D strcmp(line_a, line_b);
+  if (result)
+   break;
+
+  line_a =3D next_line_a ? next_line_a + 1 : NULL;
+  line_b =3D next_line_b ? next_line_b + 1 : NULL;
+ }
+
+ free(buf_a);
+ free(buf_b);
+ return result;
+}
+
 static int launchctl_boot_plist(int enable, const char *filename)
 {
  char *cmd;
@@ -2022,7 +2067,6 @@ static int launchctl_schedule_plist(const char
*exec_path, enum schedule_priorit
  struct lock_file lk =3D LOCK_INIT;
  static unsigned long lock_file_timeout_ms =3D ULONG_MAX;
  struct strbuf plist =3D STRBUF_INIT, plist2 =3D STRBUF_INIT;
- struct stat st;
  char *cmd;
  int minute =3D get_random_minute();

@@ -2100,9 +2144,8 @@ static int launchctl_schedule_plist(const char
*exec_path, enum schedule_priorit
   * Does this file already exist? With the intended contents? Is it
   * registered already? Then it does not need to be re-registered.
   */
- if (!stat(filename, &st) && st.st_size =3D=3D plist.len &&
-     strbuf_read_file(&plist2, filename, plist.len) =3D=3D plist.len &&
-     !strbuf_cmp(&plist, &plist2) &&
+ if (strbuf_read_file(&plist2, filename, plist.len) >=3D 0 &&
+     !launchctl_plist_cmp_ignore_minute(&plist, &plist2) &&
      launchctl_list_contains_plist(name, cmd))
   rollback_lock_file(&lk);
  else {
--=20
2.47.1
