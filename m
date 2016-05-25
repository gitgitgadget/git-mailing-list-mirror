From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] clone: don't use an integer as a NULL pointer
Date: Wed, 25 May 2016 16:30:50 -0700
Message-ID: <CAGZ79kaEtayuY8ZdB5hD_uYK8qZKQ1kiP3tPchjUm4k_HuVyow@mail.gmail.com>
References: <5746316E.8020902@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 01:31:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5iGb-0003NX-Br
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 01:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbcEYXaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 19:30:55 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36424 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbcEYXaz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 19:30:55 -0400
Received: by mail-io0-f172.google.com with SMTP id f8so42721967ioe.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 16:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=/Wtm2ozZ11LplSKJvXN04ZYkjV3ODkBHcDbW1dnssK4=;
        b=o5Ikjf68MDWRDCGaKX3lnHEMrr6ZO/wJDrXYKpaAqlM50BrIWaw5KcOExZ/ziju0L0
         reh6ap7bSUdxIGrxkcf5IjVsCeXXfrEhdnj3xfX8uk0ZMMTSDFQBAa+QNrUq3Rk986HR
         C1U82FYen8cKDHDY2RuIG+KlMJXvzY62H0fcgxUAkedwfsqaKZIoUtfRxpL6zY68HNXh
         PjNGOv6EZ1ASqBHHzqSXTJihXKwcwbLFyXGUrJ6mMLpS36t/6H/VLPlqR2Y/vRrOXFMu
         4N0JXNoXlmGEegkbtx8ATEwK0OPXAtEP9xNM/thYGHSCMRxTBSventcPMO3ckTB/qKyO
         k9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=/Wtm2ozZ11LplSKJvXN04ZYkjV3ODkBHcDbW1dnssK4=;
        b=NnScWoGZdYXlRQ/DSwXyiSlEyaDvqJ4AIeeDuVQQmWJiNxRqsTIZNlVD9tW2/s5N8d
         fOVBifFUlODi6TuuO9TGTzp1FzpgQ8brApQuYmwpHX2j/Y7qnGy6+frNyesRsq0ItHUI
         vlJDNEGRUdwOG5Zskak0oXMDt069O//PMBER6Bgm2/O7KydEKSXBkYAkD4mC9TsDbRZZ
         FxfFvd2Gdq8UECFH/NHK1o0AjEQboTQlv9v8YGKceYRk/tZugmJiM3Q/I8MIpghrgEZY
         27zmv4py7tU+oakRiDxTuMQM2SmD3M3mgptdZfzC2HQlOIFKNrmQyAs44WagVxV1tFea
         y5Vw==
X-Gm-Message-State: ALyK8tIEbIz3yDv53OnyHiP28E4grZmUOeKkpEVW3NeeBkLaCHULAxcNGb6IHoWY7VOlRgWLiiNbRzUfjvY+Q0kt
X-Received: by 10.107.53.162 with SMTP id k34mr5797972ioo.174.1464219050850;
 Wed, 25 May 2016 16:30:50 -0700 (PDT)
Received: by 10.107.136.19 with HTTP; Wed, 25 May 2016 16:30:50 -0700 (PDT)
In-Reply-To: <5746316E.8020902@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295618>

On Wed, May 25, 2016 at 4:12 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Stefan,
>
> If you need to re-roll your 'sb/submodule-default-paths' branch, could
> you please squash this into the relevant patch. (commit 8efbe28b,
> "clone: add --init-submodule=<pathspec> switch", 23-05-2016).
>
> Thanks!
>
> ATB,
> Ramsay Jones

Thanks for pointing out!

I am sorry for having you write me these emails;
Out of curiosity, how much of this is manual work and how
much did you automate of this?

>
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 22b6eac..a056f72 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -925,7 +925,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>                 struct strbuf sb = STRBUF_INIT;
>                 for_each_string_list_item(item, &init_submodules) {
>                         strbuf_addf(&sb, "submodule.defaultUpdatePath=%s", item->string);
> -                       string_list_append(&option_config, strbuf_detach(&sb, 0));
> +                       string_list_append(&option_config, strbuf_detach(&sb, NULL));
>                 }
>         }
>
> --
> 2.8.0
