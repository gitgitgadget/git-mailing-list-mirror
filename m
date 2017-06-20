Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CD520282
	for <e@80x24.org>; Tue, 20 Jun 2017 17:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdFTRf5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 13:35:57 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36339 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdFTRfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 13:35:55 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so72390706pff.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5o1jM2ISt6IyhTan1UALjWoJITlobxVvZlXtICSv5eU=;
        b=MDTqh3hbe8ZuvMkiXYFv35lLcM396AGBHUDm4WS2YcwR7JvsyWrQP0fd6oZjVs8Aci
         keMGNxsSm57VekN6CCKGxB+XSoJeG68uqrjrq/MgfgM1c4KWBrubWbSr3khMrXc8GdsF
         QNenp7uxanhMUZXHhGDZXiXJHctegl+aiPCi+aVUzH5qO/0Y5e7ep+HiMN1U/ZRShC+4
         oE4sbTRJJ+Ytg0sf4ZnK7yTL6B7GM8D9Fb5wl24k8NZC2kHabz3bVvuCCQYw0yveBMsI
         e/vWQWAWuawmADM2HRq2SgJO3xRQUoGuqTG9T6N0rgEbeprdJAqGi7HVLH2YjFbzvWMp
         jdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5o1jM2ISt6IyhTan1UALjWoJITlobxVvZlXtICSv5eU=;
        b=H3UXnTRlr5iFIyKeGW6792WQxT+W+9G+1WVTE74MiBvAiYF2SXM7y0zlrkp+ohBNjQ
         IEKA8hUk17bB6brWdclufrzdFZFWJGh0woxVRy6Ggcd6LpVJvM8pWFugFAjd1somLeKn
         KnTrnDF3VYj3e7k8Eq42zmcz9oH32Yjt7ngd5WHvGUB2FrEWkuXLCcjSGa9OnDKDDeKa
         OBzszsWQybEdBGhdEBsZS+TdGfYwa537sJSfbKz9bTSQMAzFpJ+G8aV1NfGbBlNMCV1s
         6C7/m79CLFaBsI+M3/hCw1PNpkn3VrI7rdvS/WIGAnjMb+9U1NBJwqbfC8KFn/E+KT/3
         NQhA==
X-Gm-Message-State: AKS2vOwsCSd+PlMGSBjH8A4GaWRZKvmbrc+LVkHdcTXq1nfxCoqOYCfT
        gxcuuF9qX0TtDwY1oORdU11r5ZLSFvvN
X-Received: by 10.98.34.8 with SMTP id i8mr31722592pfi.194.1497980154176; Tue,
 20 Jun 2017 10:35:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 20 Jun 2017 10:35:53 -0700 (PDT)
In-Reply-To: <20170619215025.10086-5-pc44800@gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com> <20170619215025.10086-5-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 10:35:53 -0700
Message-ID: <CAGZ79kY=Ws_8BZyLySh0e2ZmUk70gP4RNu=fbzMqRh8n6sLg9Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/6] submodule: port submodule subcommand sync from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 2:50 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> The mechanism used for porting the submodule subcommand 'sync' is
> similar to that of 'foreach', where we split the function cmd_sync
> from shell into three functions in C, module_sync,
> for_each_submodule_list and sync_submodule.
>
> print_default_remote is introduced as a submodule--helper
> subcommand for getting the default remote as stdout.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---

Up to this patch, all other patches look good to me,
here I stumbled upon a small nit.


>  builtin/submodule--helper.c | 180 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  56 +-------------
>  2 files changed, 181 insertions(+), 55 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 78b21ab22..e10cac462 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -43,6 +43,20 @@ static char *get_default_remote(void)
>         return ret;
>  }
>
> +static int print_default_remote(int argc, const char **argv, const char *prefix)
> +{
> +       const char *remote;
> +
> +       if (argc != 1)
> +               die(_("submodule--helper print-default-remote takes no arguments"));
> +
> +       remote = get_default_remote();
> +       if (remote)
> +               puts(remote);
> +
> +       return 0;
> +}
> +
>  static int starts_with_dot_slash(const char *str)
>  {
>         return str[0] == '.' && is_dir_sep(str[1]);
> @@ -311,6 +325,25 @@ static int print_name_rev(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static char *get_up_path(const char *path)
> +{
> +       int i = count_slashes(path);
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       while (i--)
> +               strbuf_addstr(&sb, "../");
> +
> +       /*
> +        *Check if 'path' ends with slash or not
> +        *for having the same output for dir/sub_dir
> +        *and dir/sub_dir/
> +        */
> +       if (!is_dir_sep(path[i - 1]))
> +               strbuf_addstr(&sb, "../");
> +
> +       return strbuf_detach(&sb, NULL);
> +}
> +
>  struct module_list {
>         const struct cache_entry **entries;
>         int alloc, nr;
> @@ -736,6 +769,151 @@ static int module_name(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +struct sync_cb {
> +       const char *prefix;
> +       unsigned int quiet: 1;
> +       unsigned int recursive: 1;
> +};
> +#define SYNC_CB_INIT { NULL, 0, 0 }
> +
> +static void sync_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +       struct sync_cb *info = cb_data;
> +       const struct submodule *sub;
> +       char *sub_key, *remote_key;
> +       char *url, *sub_origin_url, *super_config_url, *displaypath;
> +       struct strbuf sb = STRBUF_INIT;
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +
> +       if (!is_submodule_initialized(list_item->name))
> +               return;
> +
> +       sub = submodule_from_path(null_sha1, list_item->name);
> +
> +       if (!sub->url)

'sub' can be NULL as well, which when used to obtain the ->url
will crash. So we'd rather want to have (!sub || !sub->url).

I looked through other use cases, others only need (!sub), so this
thought did not hint at other bugs in the code base.


> +               die(_("no url found for submodule path '%s' in .gitmodules"),
> +                     list_item->name);
> +
> +       url = xstrdup(sub->url);

Why do we need to duplicate the url here? As we are not modifying it
(read: I did not spot the url modification), we could just use sub->url
instead, saving a variable.
