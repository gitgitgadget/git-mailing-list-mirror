From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 1/9] send-email: further document missing sendmail aliases functionality
Date: Mon, 1 Jun 2015 07:43:08 -0400
Message-ID: <CAJ80sau0GeeFxFZYsEE=uupfPqJ=vRZfNRuNd0qRJPDNvnbMPw@mail.gmail.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
	<1433111371-19573-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 13:43:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzO7e-0004Z4-S7
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 13:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbbFALnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 07:43:11 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33380 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbFALnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 07:43:09 -0400
Received: by obbnx5 with SMTP id nx5so100697741obb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0Opg2IR2xsSIrOlJd7alRcZXRbwBSU7a8vh6kottssI=;
        b=pcF+lE1eam4Yy7L9yZvOg6bYaQnh67iSfaFRf069CpH3S7vQgkJ+db3lZBn2S0bho1
         wf0kzeikz5Jjp8QTgNV3XwePeQWGoMW26MJGDq+lXyEDQmmsHwk2oBmeEWZPrk62tKEs
         q9IlDO7Vl3Cp0cwIekyx95YzUyOTsZX3qC8Z77gdDQXt0StFxMugHbJCHTx/Tv01E5Mo
         2AtpYalS/ymoWgYFYYc9Ze1y7DIIBNQLUXAYJQixRFnv4h3c25gdk+J+xEqkkP82x0tO
         Jkr5oSlw6lr2smU6jmR142lAnod/QcIoBoua5722nEHOMpHcbsyyrMsQFZC0IWKDZQOn
         PLMw==
X-Received: by 10.202.196.11 with SMTP id u11mr16936443oif.8.1433158988857;
 Mon, 01 Jun 2015 04:43:08 -0700 (PDT)
Received: by 10.182.117.197 with HTTP; Mon, 1 Jun 2015 04:43:08 -0700 (PDT)
In-Reply-To: <1433111371-19573-2-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270401>

According to the documentation, the parser should print a warning for
any explicitly unsupported constructs.  These are now explicitly
unsupported, so the parser should warn on |, /, and :include: .
Perhaps the lines that match should be ignored like the others, too.

On Sun, May 31, 2015 at 6:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Sendmail aliases[1] supports expansion to a file ("/path/name") or
> pipe ("|command"), as well as file inclusion (":include: /path/name"),
> however, our implementation does not support such functionality.
>
> [1]: https://www.freebsd.org/cgi/man.cgi?query=aliases&sektion=5
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-send-email.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index b48a764..e6d466e 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -396,6 +396,9 @@ sendmail;;
>         contain a `"` symbol are ignored.
>  *      Line continuations are not supported: lines that start with
>         whitespace characters, or end with a `\` symbol are ignored.
> +*      Redirection to a file (`/path/name`) or pipe (`|command`) is not
> +       supported.
> +*      File inclusion (`:include: /path/name`) is not supported.
>  *      Warnings are printed on the standard error output for any
>         explicitly unsupported constructs, and any other lines that are not
>         recognized by the parser.
> --
> 2.4.2.538.g5f4350e
>
