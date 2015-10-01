From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule-parallel-fetch: make some file local symbols static
Date: Thu, 1 Oct 2015 10:05:11 -0700
Message-ID: <CAGZ79kZzLtK7+rHRG_misaa9=fWF+oyeryBa+kbD3F+EB=3LMQ@mail.gmail.com>
References: <560D20E2.4060601@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 19:05:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhhIF-0005Zo-2b
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 19:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbbJARFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 13:05:13 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34500 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbJARFM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 13:05:12 -0400
Received: by ykdg206 with SMTP id g206so84319846ykd.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2015 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kcvQB+x7Lix952pPh+rkRdJmHUtV8k+x6DFzx+9Rv5Q=;
        b=dX9K8lKe/NW9WX3JtOfdbfrM5LixUikIX2Yh2X4Us7AxdqDcdrCA6P+KNO7YtYJqrM
         rtGATfjZcDwVHOJW0cSenPNhCJkzYVRQOS2nvNsLaJE4Wy6wvGE7idre61uOzOUXLXR5
         OcQe5CiwKDzTZN6/0LysdAVzd6dYgesC2g0QGqMLNIZJWmglJW2XCmF2GyCGxDG5sJGf
         vH42fwa99bRyAbC8x7YLqCcX6E7Y6TIZHF6/A+6VVDAPAW48wROTEc0UDBIlN8yuhcLy
         MXrBl8EhuopTm+JX/lQuAjUwMedu3vhd/te0dnpqvGH7VbHCtdYUg+NxNWDA9QtUjA4W
         l8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kcvQB+x7Lix952pPh+rkRdJmHUtV8k+x6DFzx+9Rv5Q=;
        b=bbX2hoVyuCP8dnXwZhi9xqqZhNoHoie/ZTQeIncc+5Vkp6LXz1NJkYbMETESgbjLzE
         tEJxaDZ/E/jhxSkYRUEk94pNRK06JnzLgMT/U9TkTdwsEKG4wcpvdLgwmeDVJWqqm0VU
         T7SI3Nac59dAFr/Xsqq2hRQY3SpDz1EsHC4voXXZt+yDBFJ9BTKOvf/m3VnMeO6cqouU
         R6GwJp2ZFcsnOwjN6IVIIF0t+Yy4E5CThSAlf4NvRWmfdyAT8zznqzUT1HcT2iiAy7iJ
         N2E/FRow5neCUxLQIA+mO3VDIFooV3q3OeV4JPUnexRyTlAI6Vtw3ILjmUpbQZxoMdY/
         Urcg==
X-Gm-Message-State: ALoCoQn10Ub9q5vpgZV1FYbV1zvfKMDl4usKxvCybcL0Pwua1kFoDYEYoSIApasmoprEHSY3RiIe
X-Received: by 10.170.190.133 with SMTP id h127mr9124820yke.115.1443719111072;
 Thu, 01 Oct 2015 10:05:11 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 1 Oct 2015 10:05:11 -0700 (PDT)
In-Reply-To: <560D20E2.4060601@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278895>

On Thu, Oct 1, 2015 at 5:02 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Commits 0fc1fdb0 ("fetch_populated_submodules: use new parallel job
> processing", 28-09-2015) and 60f24f52 ("run-command: add an asynchronous
> parallel child processor", 28-09-2015) both introduce external symbols
> which only require file scope visibility. In order to reduce the
> visibility, apply the static keyword to their declarations.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Stefan,
>
> No, despite the same subject, this is not the same patch that I sent
> you last week! :-D
>
> Could you please squash parts of this into the patches corresponding
> to the above mentioned commits.

I am sorry for the need to send this second patch. :(

>
> Thanks!
>
> BTW, I would once again suggest that you could move the definition of
> get_next_submodule() to be above/before fetch_populated_submodules()
> so that you can remove the forward declaration.
>
> ATB,
> Ramsay Jones
>
>  run-command.c | 2 +-
>  submodule.c   | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 341b23b..347d22e 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -865,7 +865,7 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
>         return finish_command(cmd);
>  }
>
> -struct parallel_processes {
> +static struct parallel_processes {

will pickup in a reroll

>         void *data;
>
>         int max_processes;
> diff --git a/submodule.c b/submodule.c
> index bd6e208..638efb5 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -622,8 +622,8 @@ struct submodule_parallel_fetch {
>  };
>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
>
> -int get_next_submodule(void *data, struct child_process *cp,
> -                      struct strbuf *err);
> +static int get_next_submodule(void *data, struct child_process *cp,
> +                             struct strbuf *err);

I thought I had this in yesterdays reroll (v6). Oh you're referring to
the version
from the 28th (I forgot to label them v5 I suppose).

I will also get rid of the forward declaration.

>
>  static int fetch_start_failure(void *data, struct child_process *cp,
>                                struct strbuf *err)
> @@ -682,8 +682,8 @@ out:
>         return spf.result;
>  }
>
> -int get_next_submodule(void *data, struct child_process *cp,
> -                      struct strbuf *err)
> +static int get_next_submodule(void *data, struct child_process *cp,
> +                             struct strbuf *err)
>  {
>         int ret = 0;
>         struct submodule_parallel_fetch *spf = data;
> --
> 2.6.0
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
