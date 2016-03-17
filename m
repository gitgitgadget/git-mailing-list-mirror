From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 2/3] git-credential-cache: put socket to
 xdg-compatible path
Date: Thu, 17 Mar 2016 18:26:00 +0800
Message-ID: <CAKqreuyOpNOGmWCwLnKY7_ax7szfsFX8R8gpYRym9BYe+3zdDA@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-2-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>, Jeff King <peff@peff.net>,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 11:26:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agV83-00017n-RE
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 11:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935504AbcCQK0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 06:26:03 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33064 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933565AbcCQK0B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 06:26:01 -0400
Received: by mail-ob0-f177.google.com with SMTP id fz5so79276376obc.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rxY1qAhA1QtyngRzZ5lNclFW7/U5EDDaNMFDa/62aI4=;
        b=inF0k5l4ZVh0cZnkFZRL21+sSxV1Z2VbHr80Oc99Su8L82/zZoBro8bNmMpyGroNYt
         nCAo7TQx5r+/yU6ZrSPfONdh9JJR734fw0xbb2QTuS4k7bwuCjH0aLYWr/a2fopiZ1a1
         3gtfH/j492BSvJ8Rj/ghqmDHIh70ZTFSnnI8Ib6cV6PbR6MmpthF1OXGA4c4Z+aSVPv6
         wmheSZXSgLFUkG5ofDTD0TPt6m9mJgl3k2PbbkFRuTE8LGIZ7Zm7G+MdGwHkl4xhHaqc
         UOLtO7jRBKZll47BUzUguDjPEfUzqe3bukkxvYbMiR46+5SDcWIDb0nv8wAn0XjSrd4Z
         iMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rxY1qAhA1QtyngRzZ5lNclFW7/U5EDDaNMFDa/62aI4=;
        b=PLJQ7wVD9DjylWQsZkFFaCEJwghb0CbKGgpKQYuJbxk4atzcFYD7D2B40HqXvvWa0/
         KCnsjsY4XyGilKpMD+VgrrwVu3HXWkbcBRZOQUfGxkgH3PGsISpGZYObCPT2YHv5NwIs
         cm9NB95SQTFQXRn0i1TUPa/6BpSbBHBdjxev+CJG1WB9VvYEUv9/ca9dNY1nbse/uWEB
         1JC7SZ8Yet5R1IKNfViVSTxCjRd47BhFq6TGUazDwC64XFT4Stq+D9aYx+TtVScompx+
         QInxUK7crms6+geZ8ydzYm0zWAfmyX5++nNSKWCph0sXkCVOmm+XzYgcaeRgaLlWropP
         DZ0w==
X-Gm-Message-State: AD7BkJJo0YG52YPDjyOvBZ04OouJrSLttIL+O8IxGZ6zO53etNtrqfzp9js2d7tI3cS0eQMVkmHZmCEc+bnLpQ==
X-Received: by 10.60.93.162 with SMTP id cv2mr5508302oeb.28.1458210360479;
 Thu, 17 Mar 2016 03:26:00 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 03:26:00 -0700 (PDT)
In-Reply-To: <1458122865-29447-2-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289096>

2016-03-16 18:07 GMT+08:00 Hui Yiqun <huiyiqun@gmail.com>:
> move .git-credential-cache/socket to xdg_runtime_dir("credential-cache.sock")
>
> Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
> ---
>  credential-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/credential-cache.c b/credential-cache.c
> index f4afdc6..40d838b 100644
> --- a/credential-cache.c
> +++ b/credential-cache.c
> @@ -105,7 +105,7 @@ int main(int argc, const char **argv)
>         op = argv[0];
>
>         if (!socket_path)
> -               socket_path = expand_user_path("~/.git-credential-cache/socket");
> +               socket_path = xdg_runtime_dir("credential-cache.sock");
>         if (!socket_path)
>                 die("unable to find a suitable socket path; use --socket");
>
> --
> 2.7.2
>
I'm sure but if user set up git-credential-cache with following command:

    git config --global credential.helper "cache --socket
~/.git-credential-cache/socket"

will the ~ be expanded?
