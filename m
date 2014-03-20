From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] rev-parse --parseopt: option argument name hints
Date: Thu, 20 Mar 2014 16:18:19 -0400
Message-ID: <CAPig+cTGYufCtVJDxG8RUJgyMbb7c3ZdiYMuoAbhQQaitVWRnQ@mail.gmail.com>
References: <532AA923.6030409@gmail.com>
	<1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 21:18:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQjQ2-0000Z3-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 21:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759791AbaCTUSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 16:18:21 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:43640 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759465AbaCTUST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 16:18:19 -0400
Received: by mail-yh0-f53.google.com with SMTP id v1so1419330yhn.26
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KJ5FqWh3uOTxWDYHBDxhdFSS1Gz8Eg4xBcWNqI+Xgfw=;
        b=HMRR4KOYlv0+bmVWzAiyejn1g/RNb37DnaI+iVlBrxXr3yUOIbDRsCVI0VrhYlQ92E
         yu+cIiMtipIucTGOkTsLrLEvTQNgY/3ELiOdZXxY7wWxNuXcivjtZnkkRxM0OxgIXdIM
         GZCxRd73PE3cu2fQLNiVNEfzZWhYuw9PFFpZYoADGbQ6NNOK4lmlUonPJbIfmD+u4PDv
         7kcjbLQVwxx6B1RBOTprFQ4lJ45M3HjfDtkh6vKCqCUmQz5600ydpqV+FRooAdgCtucJ
         Xy9iO8fxwAnzJ84ll+/jp/9BtvZzwPv+K+IqVJFYRIHdnovAvFuD3Lujsg/FumZZ9D9x
         rUHw==
X-Received: by 10.236.122.99 with SMTP id s63mr37783770yhh.19.1395346699143;
 Thu, 20 Mar 2014 13:18:19 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 13:18:19 -0700 (PDT)
In-Reply-To: <1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com>
X-Google-Sender-Auth: Gcd18bsgylzt48GblhLVf7tEHHY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244580>

On Thu, Mar 20, 2014 at 4:44 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
> Built-in commands can specify names for option arguments when usage text
> is generated for a command.  sh based commands should be able to do the
> same.
>
> Option argument name hint is any text that comes after [*=?!] after the
> argument name up to the first whitespace.  Underscores are replaced with
> whitespace.  It is unlikely that an underscore would be useful in the
> hint text.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
>  Changed according to the last comments.  Added "Usage text" paragraph in the
>  documentation and updated variable names.

As this is a high-traffic list, it can be difficult for reviewers to
remember all the comments regarding the previous version. It can help
a lot if you include a reference to the previous attempt, like this
[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243216/focus=243945

One more comment below...

> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 0d2cdcd..b8aabc9 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -313,6 +313,12 @@ Each line of options has this format:
>
>         * Use `!` to not make the corresponding negated long option available.
>
> +`<arg_hint>`::
> +       `<arg_hing>`, if specified, is used as a name of the argument in the

arg_hing?

> +       help output, for options that take arguments. `<arg_hint>` is
> +       terminated by the first whitespace. When output the name is shown in
> +       angle braces.  Underscore symbols are replaced with spaces.
> +
>  The remainder of the line, after stripping the spaces, is used
>  as the help associated to the option.
