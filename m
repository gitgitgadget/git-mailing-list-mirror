From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] submodule-config: use hashmap_iter_first()
Date: Tue, 15 Mar 2016 12:21:36 -0700
Message-ID: <CAGZ79kZ_wbJ2MGs_E-P_0eLk3JX_0QhT1c_BxqWCS+vrg8+xwA@mail.gmail.com>
References: <1458069195-20888-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:21:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuXL-0001I7-Fk
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934902AbcCOTVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:21:38 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34359 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934859AbcCOTVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:21:38 -0400
Received: by mail-ig0-f175.google.com with SMTP id av4so95872059igc.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=d3FmZCIIEpXKkyyjRpf5ppsvKtC2al1GJG6/o9qui5s=;
        b=Kqg82mLlqvzVYeAdr+VhVOx5sI1HQbHHZKOIFuF78X34uf8pf2kQttGW9mhcLeb8U6
         M1in1TPjedhzTgxNh/W+xh9ZXWMmr9gK0Altf9uqXO0Co/r6btLWBDtLqZMPr10n5X5t
         3+/XadDkfwDMMF02WrJEBMAvtuMlutHqMtPx6MBWCVL+vY1L7FOiNLLr/aJ69n0uhTeY
         AWMAEcMub5t1xYlGIxIU7k6fApiEDoh/QYFUt6hxpau6gpgVX+NuaWQGcMIkiN/mxjVy
         2dR9DTjHoh4BWrUEzdz+ENZycORZMBB3lG9UUj1MDq0saKz3uSmLUOc5EaNiG6LyT41r
         xUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=d3FmZCIIEpXKkyyjRpf5ppsvKtC2al1GJG6/o9qui5s=;
        b=AUuj14cxJb1qQUBJU1GQ+T4H3feQxtmtjwZG/FJdtPqUKot1iK2vub9phsCOqd/PX9
         QcTq3pjyVdhemfgn/R619a3pwx39JSnQCJYbj/9rrNLAc2VPlLTzFwLzPSNpSD4QCPPX
         9tM1YVrC6AjRbOSJB0BIHPgq+yfGZ79gyzYQS0dqBh3UYgohYEjxdoZaJOr/sKfdIT48
         LChnjMNijh/ehe8bOGDceU3zFKroTtmWSn5V30BbJ2SpOFuGomFefXA/49s4obeUGSWb
         on+RywBn8OMkCIpklkxfUXhm92qx+NuCZw1P9/c8yZ0M6JXie/RZxirKMY9VAKC8ksLV
         YPqQ==
X-Gm-Message-State: AD7BkJJT4v0Vhrg1dy3pVXkd7acxveJS+i9KGtPOBYU/oF62llMuQQhYMZQn8io8y59IVgw48h+jaFWCVv4g+iCv
X-Received: by 10.50.1.48 with SMTP id 16mr2849607igj.93.1458069696864; Tue,
 15 Mar 2016 12:21:36 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 15 Mar 2016 12:21:36 -0700 (PDT)
In-Reply-To: <1458069195-20888-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288895>

On Tue, Mar 15, 2016 at 12:13 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> from the <hashmap.h> for simplification.

I think what Eric wanted to point out, was to not have a continuous sentence
from commit message header to body.

Either leave the body blank (as it is obvious) or write a whole sentence there:

  [PATCH v2] submodule-config: use hashmap_iter_first()

  The hashmap API offers the `hashmap_iter_first` function as initializing and
  getting the first entry is a common pattern. Use that instead of
doing initialization
  by hand and then get the first entry.



>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
> Changelog: added missed Signof-off-by and function name fixed
> in the commit message.
>
>  submodule-config.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index b82d1fb..8ac5031 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -405,8 +405,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>                 struct hashmap_iter iter;
>                 struct submodule_entry *entry;
>
> -               hashmap_iter_init(&cache->for_name, &iter);
> -               entry = hashmap_iter_next(&iter);
> +               entry = hashmap_iter_first(&cache->for_name, &iter);
>                 if (!entry)
>                         return NULL;
>                 return entry->config;
> --
> 2.8.0.rc2.216.g1477fb2.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
