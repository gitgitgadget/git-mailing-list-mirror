Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00CC22034E
	for <e@80x24.org>; Wed, 20 Jul 2016 22:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbcGTWEv (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 18:04:51 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34109 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcGTWEt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 18:04:49 -0400
Received: by mail-io0-f169.google.com with SMTP id q83so60204786iod.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 15:04:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GeOa2/9fWIWhOntWTYwjKEb+tXE2SecQEPAgnvJcqao=;
        b=Jgc1/4Mv+t0rj58Yi6GcVpMSEDORFXhTIiDxdCxdH9ppvMLV/Sj+WStEVVaZI0ZmRp
         YkxMrDCwsxhsDf2OiojV3oe0aYL4vx7O3Jm913+xkfnbI69202GDP2a7o/zQQWlGsNLh
         9eAFZeXIK70+eDJlk9RP1yUVLuUFG80c4JYboBc0CZJgJFpNdNqL7J07PW2Om6uAJpHR
         xkyf1JqrncTgdYBNeZS6SOmSS6EIBhftCMyT99od3ywaoXlPPVs+kfwLYEVOdlVJQwmS
         W0q6WcJTonRGZZmbJ6CIJUWMevcM1Fxz3bj3VJ/DXJHyUd1s7HMN8vHvPB1oGD+vzjVZ
         L1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GeOa2/9fWIWhOntWTYwjKEb+tXE2SecQEPAgnvJcqao=;
        b=VXG2Ygj6od1KsBDj22ebvg101m/kOkRALOjUwfyQezD8SOKPJPABCgA1CuGl1Cxxwl
         3BdZCHFh6dPJdgf0ioLyU6eKPhfflpw7MxZxQcBwggBpi2vb7b2SucQf2Fu2IZvrK3Tq
         QI26d4+foPV15YKLqNdpU78beE7zba4q9nvJ7IaUThEDoTnpbSLjKa+zkIU/z1mpstyT
         sCSY1roa0StQ2O8cL9DXp6SlJjyFaudYAxN/DZ70FlIdQquPaicbquXXomwK1JelM3a5
         OAfLgdcJZfcoX+Vhzly8S90Vd4ZViS7TN2bNAOMOG6T0lS2h61C+dMYS07dlbw7zcz5F
         qW6g==
X-Gm-Message-State: ALyK8tI9TcJ1cKogZNADBFfkpr4/X9d6gG7bOMg6rxQsMVTIvwB15T9P9GEKfUV+GCoKdfcUuVhrq3j/p8jWplSo
X-Received: by 10.107.144.10 with SMTP id s10mr45110426iod.165.1469052288873;
 Wed, 20 Jul 2016 15:04:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 20 Jul 2016 15:04:48 -0700 (PDT)
In-Reply-To: <20160720172419.25473-3-pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-3-pclouds@gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 20 Jul 2016 15:04:48 -0700
Message-ID: <CAGZ79kZg-E8p1WW8j5ghOC=EJU++Dy++esv=vVRt8iuOYsrNpQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] submodule: update core.worktree using git-config
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 10:24 AM, Nguyễn Thái Ngọc Duy
<pclouds@gmail.com> wrote:
> To access a separate repository, the first step should be read its
> config file to determine if this repository layout is supported or
> not, or if we understand all repo extensions, of it is a linked
> worktree. Only then should know where to update the config file.
>
> Unfortunately, our C code base is not ready for doing all that in the
> same process. The repo detection is not meant to be used for peeking
> in other repository, and config code would read config.worktree that
> is in _current_ $GIT_DIR.
>
> For now, let's spawn a new process and let all that done separately.
>
> PS. submodule-helper also updates core.worktree. But in there, we
> create a new clone, we know what is the initial repository layout, so
> we know we can simply update "config" file without risks.

Right, the submodule--helper update_clone should not be required to convert.

>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  submodule.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index abc2ac2..b912871 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1128,7 +1128,9 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>  {
>         struct strbuf file_name = STRBUF_INIT;
>         struct strbuf rel_path = STRBUF_INIT;
> +       struct strbuf path = STRBUF_INIT;
>         const char *real_work_tree = xstrdup(real_path(work_tree));
> +       struct child_process cp = CHILD_PROCESS_INIT;
>
>         /* Update gitfile */
>         strbuf_addf(&file_name, "%s/.git", work_tree);
> @@ -1136,13 +1138,17 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>                    relative_path(git_dir, real_work_tree, &rel_path));
>
>         /* Update core.worktree setting */
> -       strbuf_reset(&file_name);
> -       strbuf_addf(&file_name, "%s/config", git_dir);
> -       git_config_set_in_file(file_name.buf, "core.worktree",
> -                              relative_path(real_work_tree, git_dir,
> -                                            &rel_path));
> +       strbuf_addstr(&path, relative_path(real_work_tree, git_dir,
> +                                          &rel_path));
> +       cp.git_cmd = 1;
> +       argv_array_pushl(&cp.args, "-C", work_tree, NULL);
> +       argv_array_pushl(&cp.args, "--work-tree", ".", NULL);
> +       argv_array_pushl(&cp.args, "config", "core.worktree", path.buf, NULL);
> +       if (run_command(&cp) < 0)
> +               die(_("failed to update core.worktree for %s"), git_dir);

Do we need to make this conditional on the extensions.worktreeConfig
variable, though? When I just run

    git config --worktree . foo bar
fatal: Per-worktree configuration requires extensions.worktreeConfig
Please read section CONFIGURATION in `git help worktree` before
enabling it.

which would trigger the failure here?

>
>         strbuf_release(&file_name);
> +       strbuf_release(&path);
>         strbuf_release(&rel_path);
>         free((void *)real_work_tree);
>  }
> --
> 2.9.1.566.gbd532d4
>
