From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Mon, 26 May 2014 23:25:47 -0400
Message-ID: <CAPig+cRE0LUaNLTJARBCmoDn7cR1bbgi8At0ChgSDWBjDPaNjg@mail.gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
	<1401118436-66090-2-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 05:25:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp81Q-0008Pg-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 05:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbaE0DZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 23:25:48 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:53586 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaE0DZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 23:25:48 -0400
Received: by mail-yh0-f45.google.com with SMTP id b6so7009682yha.32
        for <git@vger.kernel.org>; Mon, 26 May 2014 20:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HwZQXEKolCibODMeHkqvPXH45B+21eOi9/zL+1OVmxs=;
        b=0iorkvSCCsB5SCrWu8lRPbr0pN+IVyAeg33CxvRBD4aBmQMr6T9hDVL0FPVzOuwT3h
         wi+wNjNdRpmQWa6goydT469G0a5f4vwTWcAL+0N7xf9EszoBqJvqLLv3ZWfvQO1bVYjs
         zdjomFJq1KRwhuVwOKADNu4t19fxAIW+zfUbVm68Yl9/gCMbm66xdJeeDM1j0spGRmFH
         g1leuQm18ICDSwZC2DhfdG9nFu+7vMiXPIxhHOZT9ObFjrpOiYRyuxhdzEbJMCEv+5vh
         nrjnAeUMoWxO1pN3hCAZ3UVhkZKRC41uT5qXN6uSu4HtSHoxKcXt4hLa66i/ipYlTMbn
         jaeA==
X-Received: by 10.236.127.109 with SMTP id c73mr42552973yhi.1.1401161147720;
 Mon, 26 May 2014 20:25:47 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Mon, 26 May 2014 20:25:47 -0700 (PDT)
In-Reply-To: <1401118436-66090-2-git-send-email-modocache@gmail.com>
X-Google-Sender-Auth: DkyIk2dDHoBel8svvEVuZohw0Wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250138>

On Mon, May 26, 2014 at 11:33 AM, Brian Gesiak <modocache@gmail.com> wrote:
> xcalloc takes two arguments: the number of elements and their size.
> run_add_interactive passes the arguments in reverse order, passing the
> size of a char*, followed by the number of char* to be allocated.
> Rearrgange them so they are in the correct order.

s/Rearrgange/Rearrange/

Same misspelling afflicts the entire patch series.

> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> ---
>  builtin/add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 672adc0..488acf4 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -248,7 +248,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>         int status, ac, i;
>         const char **args;
>
> -       args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
> +       args = xcalloc((pathspec->nr + 6), sizeof(const char *));
>         ac = 0;
>         args[ac++] = "add--interactive";
>         if (patch_mode)
> --
> 2.0.0.rc1.543.gc8042da
