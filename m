From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Mon, 15 Feb 2016 15:58:12 -0500
Message-ID: <CAPig+cS=TtVGTxo0oHny4GpAAaej93T2kP93upfHtPMkAd7V0g@mail.gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
	<1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:58:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQDr-000449-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbcBOU6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 15:58:15 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36698 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbcBOU6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 15:58:13 -0500
Received: by mail-vk0-f66.google.com with SMTP id k196so8638929vka.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 12:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5ps9GyTQtgquTZ0rMJDHYkZmWiAbAfN+nBD/tzOijfw=;
        b=SjrukjH6kS81eF2Bz30a9GrAAzbDuFb0dAqYMQrWotjmdOw3Zbs/phWkvTzAtPQFkx
         f+RDqU56lOBX4XAGqeQUULnq7jC/OcBugpHvz68w/RZiMrZ/B3hCRH2eDHCBpxOfOQvM
         ENc53sXZcZ2uHAN1gUwZ3OKMv3xMSGEYpjN8g03e/LOK6k1tXDC9mNQnT2+BPJZ1J6Z2
         zmxEnZpbBRYulStRFMTj7vuzP07T5HXmNevMpV6SNGOgLe6q7H1yia+PPbB1QOT4jWkD
         8rQ9MR1JpypcDBrLuJwH1wrbmHSGAdmPiUoRsvFZvtTiI0Ju7PTZHrkPb9e/QSfoadOJ
         5+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5ps9GyTQtgquTZ0rMJDHYkZmWiAbAfN+nBD/tzOijfw=;
        b=IGknhFmzv5iAP/T6uwTgKJnmfPzbYI6CpdqpleVZCYRIvv8sGC2wRyTObZhIJTJt2z
         DjDzh2rHkr56h/QMlvQzTD3SxhooXL2rQ7x0YTcQBNTLCPNbIS6JrlZBw7f4gaxeyvAF
         6vyY3swChv6W3vg2EwD8QPOAxTN0CNrlc5tDHO6QTE5jsViHo9cQPv+H8xmfR2OiXbyU
         dAlRU5yolTHoz5rF7EBJZ3gSyc0/ysI1iWkAY9KlVdE0qEJlTZbx4e3Qnn9c06X1BPWi
         OpWSnWP4Lvwwq5+dUdxnVx3VyGbS0ycQpkJyrMyk+Ew5tJltcfz6fPbXeXCl4AWChlHG
         vMig==
X-Gm-Message-State: AG10YOS1h6fV7zfFjCF+0zZO6syHIsmF/AIeIoloTYvM5S5NMSAtkq7RVFQqvkMZsyxtXZ/Ya2sHPwvIsJwESQ==
X-Received: by 10.31.141.2 with SMTP id p2mr14816113vkd.37.1455569892762; Mon,
 15 Feb 2016 12:58:12 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 12:58:12 -0800 (PST)
In-Reply-To: <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: 8Kkzu_RwomG1hAFSjsPEwiD6Maw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286239>

On Mon, Feb 15, 2016 at 5:17 AM,  <larsxschneider@gmail.com> wrote:
> If config values are queried using 'git config' (e.g. via --get,
> --get-all, --get-regexp, or --list flag) then it is sometimes hard to
> find the configuration file where the values were defined.
>
> Teach 'git config' the '--show-origin' option to print the source
> configuration file for every printed value.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> @@ -27,6 +28,7 @@ static int actions, types;
>  static const char *get_color_slot, *get_colorbool_slot;
>  static int end_null;

Not related to your changes, but I just realized that this variable
really ought to be named 'end_nul' since we're talking about the
character NUL, not a NULL pointer.

>  static int respect_includes = -1;
> +static int show_origin;
> @@ -81,6 +83,7 @@ static struct option builtin_config_options[] = {
>         OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),

Likewise, the long option name should be --nul rather than --null, or
the long name could be dropped altogether since some other commands
just recognize short option -z.

There is no need for this patch series to address this anomaly; it's
perhaps low-hanging fruit for someone wanting to join the project. The
only very minor wrinkle is that we'd still need to recognize --null as
a deprecated (and undocumented) alias for --nul.

>         OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
>         OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
> +       OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, stdin, blob, cmdline)")),
>         OPT_END(),
>  };
