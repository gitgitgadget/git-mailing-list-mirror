Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E318800D
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147724; cv=none; b=Aay/kU5K/o89kg1ByeZQjjc2WBFVsPB3S1INSwnfC4RYEcU+NZYXJZUrrmMnkZArnaa3iOvOiZjkU1nsIDtpvqX72bDlA9fGe22x/AmMv36VPlJrBQxKtuhJi1s67r/0jynpQCNKlQt8R8EicgaRI5Iaen//0DG+gAmd4Qmg+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147724; c=relaxed/simple;
	bh=U+LIhS8co2LabY+BfCTEfKcbUF+zgFbueuC/YFugIQQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ipIbOhhcOzO8aJ/vIJXgZtGwTMn3UJWZRo8AviOTiy7ZpSxEL/00TmnfUglljMdwoj+EU7Hx+zhXVCoDph3fQkdpJSQe58FJg6YoM2QljvBy9Q/JOwIICtNNjynWiUIHVTLj6QujJReUSt3CukHmySCOjHhYo6LYMOFXUMlgIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6zX8xmj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6zX8xmj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-716a5b9ee6fso313951a34.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729147722; x=1729752522; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F883adaO80qHQey3OG37vez5tI0uiFzY8QxSVaV23cY=;
        b=U6zX8xmjmW1FaFANF7CowN/g5SpSyloKcMe7D0DoqSM5Y5qaAC/URiK8CsXIzpfWhn
         GOUX/+5TkuX14YcVT3TGlZzXilsRqo2O8996lU9jZRD+yqIRxWNxQvNNIsMtSTwD0e3V
         ru3isIEODFgF6ndECmSXMqKazdGcUp9fMas1tpHkOfF05SJ+RELsF+DdQorgV0UyrMif
         KFFUGvBZFcIcT7x0Jo0SULOiBnk3l2wvqdxe+EwR77aleQxlMpMSqeZFpEq8xVS4skfE
         ZMiW+QegibtrXdTOCHtH1DHmITSaH1aR9VlyYKjZARPf+asrnuxP6Q6l3icLCHRm0vTK
         IBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147722; x=1729752522;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F883adaO80qHQey3OG37vez5tI0uiFzY8QxSVaV23cY=;
        b=abzc26fe/jpZ571CjE+om8kTaq6VOKamQpvnEbexGMs0K5i9wobWi9w84KH8IaOrLD
         H0ESOzIsO4iIf+xBgJEbPFISKZAH0FgEOnYLpcemrWP70ApRBwFaLh0Bk3lp3DUf3Rz8
         ClynnFU7zJ8/QqZg1C1Ei3ol5j1XMm98mmlvakFdUnQnWVjtpsc3tvcNhCtpDILvthOT
         g19grtizueLq7dHi4NWjAa2ptL3Bv1XdkXK3f+05U8geTLaZBwLcrGS7OH8cDdwGIfOe
         zwXI72bm2o7on8kAQ2LEzkbsaaIriGcv+fg+qOQWE5k8X7bTK1BFJjO9rSWryi9fFKqV
         dcYg==
X-Gm-Message-State: AOJu0YyRuaGqDmnWOMSwmI1bVMkY7r3y4L4vX7xXOROZsW5ADiyZMoGu
	D8k/ooPLRAiEylDToJt9OCJa2wPxHrFFtBRK4eH9dmhWSoS8+XL1oFmd7ZRA5S1XkYjYWlyL/Wd
	YTbT8bNTjCFviF9ECuxscS1CblOgo0Ov3
X-Google-Smtp-Source: AGHT+IE4lKvYzM/7yNwcAde9QZ1h8hXMuWGhkAVflW0KZXyOFB0k3rEreVOEQtoLo/setVilpqBhsnXIPNJwDAKYfJU=
X-Received: by 2002:a05:6358:618a:b0:197:df0e:f23c with SMTP id
 e5c5f4694b2df-1c3783fe0bfmr503019855d.11.1729147721762; Wed, 16 Oct 2024
 23:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dima Tisnek <dimaqq@gmail.com>
Date: Thu, 17 Oct 2024 15:48:30 +0900
Message-ID: <CAGGBzXLN6eFZmgEE=KBp9vbcgYGGEbDJDUrfyVeYjuCrRiYcXA@mail.gmail.com>
Subject: Unitialised pointer free in is_crontab_available
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Here's the code:

static int is_crontab_available(void)
{
char *cmd;
int is_available;
int ret;

if (get_schedule_cmd("crontab", &is_available, &cmd)) {
ret = is_available;
goto out;
}

#ifdef __APPLE__
/*
* macOS has cron, but it requires special permissions and will
* create a UI alert when attempting to run this command.
*/
ret = 0;
#else
ret = check_crontab_process(cmd);
#endif

out:
free(cmd);
return ret;
}


This code will try to `free(cmd)` even if get_schedule_cmd returned 0,
when it's safe to assume that &cmd was not allocated.


static int get_schedule_cmd(const char *cmd, int *is_available, char **out)
{
char *testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
struct string_list_item *item;
struct string_list list = STRING_LIST_INIT_NODUP;

if (!testing)
return 0;

[rest snipped]


If I read this right, as long as the special env var is not set, this
function returns 0 and does not populate *out.


Reproduce:
run `git maintenance start` on a mac in some git repo

Tested with:
macos Darwin 24.0.0
arm64
homebrew git 2.47.0



c/cpython (main)> lldb (which git)
(lldb) target create "/opt/homebrew/bin/git"
Current executable set to '/opt/homebrew/bin/git' (arm64).
(lldb) b malloc_error_break
Breakpoint 1: where = libsystem_malloc.dylib`malloc_error_break,
address = 0x00000001802861bc
(lldb) run maintenance start
Process 35052 launched: '/opt/homebrew/bin/git' (arm64)
git(35052,0x1ec22b240) malloc: *** error for object 0x1: pointer being
freed was not allocated
git(35052,0x1ec22b240) malloc: *** set a breakpoint in
malloc_error_break to debug
Process 35052 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x00000001879221bc libsystem_malloc.dylib`malloc_error_break
libsystem_malloc.dylib`malloc_error_break:
->  0x1879221bc <+0>:  pacibsp
    0x1879221c0 <+4>:  stp    x29, x30, [sp, #-0x10]!
    0x1879221c4 <+8>:  mov    x29, sp
    0x1879221c8 <+12>: nop
Target 0: (git) stopped.
(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x00000001879221bc libsystem_malloc.dylib`malloc_error_break
    frame #1: 0x00000001879015e8 libsystem_malloc.dylib`malloc_vreport + 748
    frame #2: 0x000000018790523c libsystem_malloc.dylib`malloc_report + 64
    frame #3: 0x000000018792326c libsystem_malloc.dylib`find_zone_and_free + 528
    frame #4: 0x000000010004fa78 git`is_crontab_available + 56
    frame #5: 0x000000010004f974 git`update_background_schedule + 168
    frame #6: 0x000000010004e1dc git`maintenance_start + 248
    frame #7: 0x000000010004d9b4 git`cmd_maintenance + 336
    frame #8: 0x0000000100005678 git`run_builtin + 396
    frame #9: 0x0000000100004b48 git`handle_builtin + 324
    frame #10: 0x00000001000043c0 git`cmd_main + 788
    frame #11: 0x00000001000c141c git`main + 236
    frame #12: 0x0000000187768274 dyld`start + 2840
(lldb) frame select 4
frame #4: 0x000000010004fa78 git`is_crontab_available + 56
git`is_crontab_available:
->  0x10004fa78 <+56>: mov    x0, x19
    0x10004fa7c <+60>: ldp    x29, x30, [sp, #0x20]
    0x10004fa80 <+64>: ldp    x20, x19, [sp, #0x10]
    0x10004fa84 <+68>: add    sp, sp, #0x30
(lldb) disassemble -n is_crontab_available
git`is_crontab_available:
    0x10004fa40 <+0>:  sub    sp, sp, #0x30
    0x10004fa44 <+4>:  stp    x20, x19, [sp, #0x10]
    0x10004fa48 <+8>:  stp    x29, x30, [sp, #0x20]
    0x10004fa4c <+12>: add    x29, sp, #0x20
    0x10004fa50 <+16>: adrp   x0, 535
    0x10004fa54 <+20>: add    x0, x0, #0x3f ; "crontab"
    0x10004fa58 <+24>: add    x1, sp, #0x4
    0x10004fa5c <+28>: add    x2, sp, #0x8
    0x10004fa60 <+32>: bl     0x100050300    ; get_schedule_cmd
    0x10004fa64 <+36>: ldr    w8, [sp, #0x4]
    0x10004fa68 <+40>: cmp    w0, #0x0
    0x10004fa6c <+44>: csel   w19, wzr, w8, eq
    0x10004fa70 <+48>: ldr    x0, [sp, #0x8]
    0x10004fa74 <+52>: bl     0x100249170    ; symbol stub for: free
->  0x10004fa78 <+56>: mov    x0, x19
    0x10004fa7c <+60>: ldp    x29, x30, [sp, #0x20]
    0x10004fa80 <+64>: ldp    x20, x19, [sp, #0x10]
    0x10004fa84 <+68>: add    sp, sp, #0x30
    0x10004fa88 <+72>: ret
