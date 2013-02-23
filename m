From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] update-index: allow "-h" to also display options
Date: Sat, 23 Feb 2013 19:13:15 +0100
Message-ID: <CALWbr2x4En9qof7hFL+Onh1M1080=-OaJtAsNYY01qRj5R1a1w@mail.gmail.com>
References: <1361643041-19036-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 19:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9JbW-0006bo-7z
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 19:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407Ab3BWSNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 13:13:17 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:52600 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758290Ab3BWSNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 13:13:16 -0500
Received: by mail-qa0-f43.google.com with SMTP id dx4so915297qab.16
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 10:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UqVoao0OdZs1M/D8I04Pg5k7XWV6b7SN5lpx93Qxryo=;
        b=qVr9ujCGKzQ0Vy59zPfKVuywZiuN22FM/IoP7OYWGC82vV2ppoGtTklevH0yKJCzXd
         XeWmdWy4VNTfjdtu0J80w4aJ/0ynaAmHPRVnkwWYsXqlrdVhVpuQCoJNT5RmMYuyDI5x
         UkfZWirNiuUJtDlMjadt0O7l2vLmWjJzG3am/GyJLzRKqoiAzjex+1D3fQjeE0uOLLv9
         URRH23U3K0VLvgHKw8opSmKbRrNXzMc4AT8wctg3yLkWKnoiAb4axTAt8B4g34NYQDB+
         kBY+n5pnk8xsmALpa74ugIZFGBgNIedAr4EMZ0wqbv0rqU12rq7TZQbCW1d8aMxmbJlR
         0UDg==
X-Received: by 10.224.180.15 with SMTP id bs15mr3506008qab.24.1361643195365;
 Sat, 23 Feb 2013 10:13:15 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Sat, 23 Feb 2013 10:13:15 -0800 (PST)
In-Reply-To: <1361643041-19036-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216905>

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index ada1dff..3071ee6 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -796,7 +796,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>         };
>
>         if (argc == 2 && !strcmp(argv[1], "-h"))
> -               usage(update_index_usage[0]);
> +               usage_with_options(&update_index_usage[0], options);
>
>         git_config(git_default_config, NULL);
>

Ok I just realized that

    usage_with_options(update_index_usage, options);

would be better...

Antoine,
