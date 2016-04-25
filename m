From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] string_list: use string-list API in unsorted_string_list_lookup()
Date: Mon, 25 Apr 2016 10:47:09 -0700
Message-ID: <CAGZ79kbjtcnRmKPz-vP3C38hsjD3OauAvqctCmhhhfy7g4WDFQ@mail.gmail.com>
References: <20160422173500.32329-1-ralf.thielow@gmail.com>
	<20160425174000.24943-1-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:47:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aukbU-0001An-OL
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209AbcDYRrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:47:17 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36766 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933183AbcDYRrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:47:15 -0400
Received: by mail-io0-f178.google.com with SMTP id u185so191738336iod.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=CQfu7mHhzelrYfCFP720IZmnsOzcvIS1Cli4M4Uurj8=;
        b=IVRLkK6nvARY3CTw/rSgszJ+KvTNBznnLlmSBFUYN22H4j3AKDVvVYdef1tE06p2q3
         il4UnIX9W05bF/XY0fHvyycNztrSIi1LMIKseFtPaimNFeg8ERZ2ubhMxZ9FpenRpf23
         PSrEw5lf7NDiZ13Bqo845uysI+4rA4ZIWDSDCeA4jJppaHxKKTqG34uQ+kF4NS3lsJpe
         fxEfoUpCKYM4rlwjhbKTjcypWkXfGgQYxFrG8giJREWocISF3EJ8DDaDHLD5Z7cLrkn/
         nchXMK8AJBTtBZdGMIBYeBdSNIwfYpAk5jrxKWIPWia9QEVZvwZvxDQdz8rRvVkR9vJ4
         DVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CQfu7mHhzelrYfCFP720IZmnsOzcvIS1Cli4M4Uurj8=;
        b=IVCnsUi01vmhU/9G478OPkBzr5lKSBzOsyyEZ1nuhLSGejmt9lfjvqztE2rLu97r/B
         G58fSCmZuG1BhZ5rvVbRO+NCyMy2VKMKRkGt56Bja7VfXPYq+g6s6k0FrjhDAN/hmD0h
         7FKSFJxwDzbBGjLD16o7dWzfEJsUeo7s7OmGQnpoASh7EpS/1cWaVv3RNWxz8IAwdUIs
         TLeGW31V5e2pDyRaunSPHKRykqpdWlK+Uw2wCgqilSHP+zSG334Wlb0rWmneqhU/QlCW
         cFMgzKJXk/xi8L0acU4rxKEONbOkOvk7s/s2SbCWArC+5HsWQ+R67zO2jWth4ZyjFbKo
         /CKA==
X-Gm-Message-State: AOPr4FUewIkYIZPVjLujSqc0F6hwqnfqH94lGvPziOMqo3/YdHPZgdp3JA+OCLWRbrIAD3r3Xm3OjDhQtXONgITe
X-Received: by 10.107.161.68 with SMTP id k65mr45354980ioe.110.1461606429721;
 Mon, 25 Apr 2016 10:47:09 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 10:47:09 -0700 (PDT)
In-Reply-To: <20160425174000.24943-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292534>

On Mon, Apr 25, 2016 at 10:40 AM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> Using the string-list API in function unsorted_string_list_lookup()
> makes the code more readable.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Changes since v1:
> - remove extra curly braces

Reviewed-by: Stefan Beller <sbeller@google.com>

>
>  string-list.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/string-list.c b/string-list.c
> index 2a32a3f..62d2084 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -231,12 +231,12 @@ void string_list_sort(struct string_list *list)
>  struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
>                                                      const char *string)
>  {
> -       int i;
> +       struct string_list_item *item;
>         compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
>
> -       for (i = 0; i < list->nr; i++)
> -               if (!cmp(string, list->items[i].string))
> -                       return list->items + i;
> +       for_each_string_list_item(item, list)
> +               if (!cmp(string, item->string))
> +                       return item;
>         return NULL;
>  }
>
> --
> 2.8.1.430.g7c694c5
>
