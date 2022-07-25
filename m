Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D46C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiGYUQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiGYUQR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:16:17 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1720E6372
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:15:11 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mi13-20020a17090b4b4d00b001ef9759d26aso22977pjb.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=0HhcYoDgjNZ8zQfIZrdPAHy54Hkg4d16xYM57XB1M54=;
        b=GJYvexEyu8GAnxa4t49kYEcthLn3m2GcLCo6ZRmI4tcjILHZhAg70Xzkr5/d73mwx3
         RNBJpV5xcRG0pUkeOAEcvV8xscQetI+Ng/WqjGkEXhA1QEsLhsJOmGD+syj3psmYU00+
         qdwOkNXplREJAgNm1/IGx/DBoZm3KuoPBsF38mM12FlRuYPRos2kqyXjI0nckXTvJER0
         kAPO1rOI+jB7GEkLKovWvke2KmHJzKX6Mp7vQhNJV0COfuNkPgsHiVS0DX9jXm2R22/l
         hnBqS0E+1ARwHd30mQD8C13BBHBDoIyACqfxxqaNBIXrGUc+MmbY/Uxy6Zh+M/9gfO4D
         5Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=0HhcYoDgjNZ8zQfIZrdPAHy54Hkg4d16xYM57XB1M54=;
        b=F9KMuTlp9Mp1d6D4GQUy5a4K2+q9kpxSNhaWqXskwrVg0z7E65Glqi3JkA/I5l1pNz
         b4KY80N3fllefUtAU6YVT8YsTKYnP7N2vGctmJniXVMN66UyeRg9CEGQBh3pF+7j67h4
         jvb9145CtmU9QPLfb8Me/8RhSbU4SGKyT55wPcGkyv46fgWbkg0PFQaHbjC3k6KQV/EN
         Ib21WbIcu4exqNp/rw0QjszP6GCtaOdWp6/9YGXiGXFQGGnDeqcDipDqlPHUWiYjO3DA
         CIaT/42oVc7cQJEiLo0sEsCF4rxc6etRtZ9bwjDAgXTa1MfCkvSg3f+WwkQ8Wc38qHbz
         8t9Q==
X-Gm-Message-State: AJIora9NUzR35yHJJ0y4FfPm5asHzbS3T1nDw3v7CRVXr/5OwPpeh5M9
        JNpOQvDwgUJoeEJWPr5KhqHDlBneQKr/EQ==
X-Google-Smtp-Source: AGRyM1ucssHeslhmqBa6O/GPaT68lPzB4G3vwtgF15ut1t5E8zItNg0mt/9Em4C8fh4YR21gjZl8Pd4rx0hwlg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8c55:0:b0:52b:7233:f7b1 with SMTP id
 e21-20020aa78c55000000b0052b7233f7b1mr13885828pfd.33.1658780103837; Mon, 25
 Jul 2022 13:15:03 -0700 (PDT)
Date:   Mon, 25 Jul 2022 13:15:02 -0700
In-Reply-To: <220725.861qu9oxl4.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l35ept0e1.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
 <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com> <30ac73716cbc234a1f176d2d417bf0e2b0b335cf.1657834081.git.gitgitgadget@gmail.com>
 <220725.861qu9oxl4.gmgdl@evledraar.gmail.com>
Subject: Re: SANITIZE=address failure on master (was: [PATCH v8 3/5] config:
 learn `git_protected_config()`)
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jul 14 2022, Glen Choo via GitGitGadget wrote:
>
>> +/* Read values into protected_config. */
>> +static void read_protected_config(void)
>> +{
>> +	char *xdg_config =3D NULL, *user_config =3D NULL, *system_config =3D N=
ULL;
>> +
>> +	git_configset_init(&protected_config);
>> +
>> +	system_config =3D git_system_config();
>> +	git_global_config(&user_config, &xdg_config);
>> +
>> +	git_configset_add_file(&protected_config, system_config);
>> +	git_configset_add_file(&protected_config, xdg_config);
>> +	git_configset_add_file(&protected_config, user_config);
>> +	git_configset_add_parameters(&protected_config);
>> +
>> +	free(system_config);
>> +	free(xdg_config);
>> +	free(user_config);
>> +}
>
> Noticed after it landed on master: This change fails with:
>
> 	make SANITIZE=3Daddress test T=3Dt0410*.sh
>
> Running that manually shows that we fail like this:
> =09
> 	$ cat trash\ directory.t0410-partial-clone/httpd/error.log | grep -o AH0=
.*
> 	AH00163: Apache/2.4.54 (Debian) configured -- resuming normal operations
> 	AH00094: Command line: '/usr/sbin/apache2 -d /home/avar/g/git/t/trash di=
rectory.t0410-partial-clone/httpd -f /home/avar/g/git/t/lib-httpd/apache.co=
nf -c Listen 127.0.0.1:10410'
> 	AH01215: AddressSanitizer:DEADLYSIGNAL: /home/avar/g/git/git-http-backen=
d
> 	AH01215: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D: /home/avar/g/git=
/git-http-backend
> 	AH01215: =3D=3D27820=3D=3DERROR: AddressSanitizer: SEGV on unknown addre=
ss 0x000000000000 (pc 0x7f7af5dc0d66 bp 0x7fff11964450 sp 0x7fff11963be8 T0=
): /home/avar/g/git/git-http-backend
> 	AH01215: =3D=3D27820=3D=3DThe signal is caused by a READ memory access.:=
 /home/avar/g/git/git-http-backend
> 	AH01215: =3D=3D27820=3D=3DHint: address points to the zero page.: /home/=
avar/g/git/git-http-backend
> 	AH01215:     #0 0x7f7af5dc0d66 in __sanitizer::internal_strlen(char cons=
t*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_libc.cpp:167: /=
home/avar/g/git/git-http-backend
> 	AH01215:     #1 0x7f7af5d512f2 in __interceptor_fopen64 ../../../../src/=
libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:6220: /home=
/avar/g/git/git-http-backend
> 	AH01215:     #2 0x562a65e37cc8 in git_fopen compat/fopen.c:22: /home/ava=
r/g/git/git-http-backend
> 	AH01215:     #3 0x562a65df3879 in fopen_or_warn wrapper.c:431: /home/ava=
r/g/git/git-http-backend
> 	AH01215:     #4 0x562a65a12476 in git_config_from_file_with_options conf=
ig.c:1982: /home/avar/g/git/git-http-backend
> 	AH01215:     #5 0x562a65a124f4 in git_config_from_file config.c:1993: /h=
ome/avar/g/git/git-http-backend
> 	AH01215:     #6 0x562a65a15288 in git_configset_add_file config.c:2389: =
/home/avar/g/git/git-http-backend
> 	AH01215:     #7 0x562a65a16a37 in read_protected_config config.c:2649: /=
home/avar/g/git/git-http-backend
> 	AH01215:     #8 0x562a65a16b5c in git_protected_config config.c:2661: /h=
ome/avar/g/git/git-http-backend
> 	AH01215:     #9 0x562a65dd9f9a in get_upload_pack_config upload-pack.c:1=
342: /home/avar/g/git/git-http-backend
> 	AH01215:     #10 0x562a65ddc1cb in upload_pack_v2 upload-pack.c:1706: /h=
ome/avar/g/git/git-http-backend
> 	AH01215:     #11 0x562a65d2eb8a in process_request serve.c:308: /home/av=
ar/g/git/git-http-backend
> 	AH01215:     #12 0x562a65d2ec18 in protocol_v2_serve_loop serve.c:323: /=
home/avar/g/git/git-http-backend
> 	AH01215:     #13 0x562a6593c5ae in cmd_upload_pack builtin/upload-pack.c=
:55: /home/avar/g/git/git-http-backend
> 	AH01215:     #14 0x562a656cf8ff in run_builtin git.c:466: /home/avar/g/g=
it/git-http-backend
> 	AH01215:     #15 0x562a656d02ab in handle_builtin git.c:720: /home/avar/=
g/git/git-http-backend
> 	AH01215:     #16 0x562a656d09d5 in run_argv git.c:787: /home/avar/g/git/=
git-http-backend
> 	AH01215:     #17 0x562a656d174f in cmd_main git.c:920: /home/avar/g/git/=
git-http-backend
> 	AH01215:     #18 0x562a6594b0b9 in main common-main.c:56: /home/avar/g/g=
it/git-http-backend
> 	AH01215:     #19 0x7f7af5a5681c in __libc_start_main ../csu/libc-start.c=
:332: /home/avar/g/git/git-http-backend
> 	AH01215:     #20 0x562a656cb209 in _start (git+0x1d1209): /home/avar/g/g=
it/git-http-backend
> 	AH01215: : /home/avar/g/git/git-http-backend
> 	AH01215: AddressSanitizer can not provide additional info.: /home/avar/g=
/git/git-http-backend
> 	AH01215: SUMMARY: AddressSanitizer: SEGV ../../../../src/libsanitizer/sa=
nitizer_common/sanitizer_libc.cpp:167 in __sanitizer::internal_strlen(char =
const*): /home/avar/g/git/git-http-backend
> 	AH01215: =3D=3D27820=3D=3DABORTING: /home/avar/g/git/git-http-backend
> 	AH01215: error: upload-pack died of signal 6: /home/avar/g/git/git-http-=
backend
>
> (We really should have a SANITIZE=3Daddress in CI, but it takes a while..=
.)

Thanks. I narrowed the failure down to the hunk above, specifically this
line:

  git_configset_add_file(&protected_config, xdg_config);

Since xdg_config can be NULL, this results in the failing call
fopen_or_warn(NULL, "r").

This logic was lifted  from do_git_config_sequence(), which checks that
each of the paths are not NULL. So a fix might be something like:

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

  diff --git a/config.c b/config.c
  index 015bec360f..208a3dd7a7 100644
  --- a/config.c
  +++ b/config.c
  @@ -2645,9 +2645,13 @@ static void read_protected_config(void)
    system_config =3D git_system_config();
    git_global_config(&user_config, &xdg_config);

  -	git_configset_add_file(&protected_config, system_config);
  -	git_configset_add_file(&protected_config, xdg_config);
  -	git_configset_add_file(&protected_config, user_config);
  +
  +	if (system_config)
  +		git_configset_add_file(&protected_config, system_config);
  +	if (xdg_config)
  +		git_configset_add_file(&protected_config, xdg_config);
  +	if (user_config)
  +		git_configset_add_file(&protected_config, user_config);
    git_configset_add_parameters(&protected_config);

    free(system_config);

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

I'm not sure if system_config can ever be NULL, but (xdg|user)_config is
NULL when $HOME is unset, and xdg_config is also unset if
$GIT_CONFIG_GLOBAL is set.
