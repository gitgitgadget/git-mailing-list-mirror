From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2][GSoC 2014] diff: used is_dot_or_dotdot() in code
Date: Tue, 18 Mar 2014 23:45:42 -0400
Message-ID: <CAPig+cSxu1WAEg7YmnNn-kHZMj4AacRaVPMthgAwFN0GmrrYCg@mail.gmail.com>
References: <CAM+=D-Ac2yL02-6qGQFuV_qz4FKt_6EGwRHk4+MLDnSb5CgucQ@mail.gmail.com>
	<1395192636735-7605956.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: babourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 04:45:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ7Rs-0005oq-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 04:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbaCSDpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 23:45:43 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:64249 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758221AbaCSDpm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 23:45:42 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so7960656yha.16
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NcOw6NhwVJny6KLJPyHEzPwav0KKqmeCKZI/DKwbzBU=;
        b=F8mtFwishcYGxDokKe6ZJemQndFHY4oYjrknuCmALvFFb7Bv29/yX9J7TqeFZlRT3y
         SCRQxEFg1PqHu95JeZPD3lJKmdloUaskcsaMpkrnKdiQrDPi0+I/yFGplEfx409SWK32
         3p056kfoQjESZIA/quQd+jh1ZiOjjvttimxU1dOf0iunKWUV0S5h4w9nLgEGV8rKoTrM
         L2PrBcdX21DyJ0Ad/DeS+9FmukYM17/NseXkcqfiwdXommuoMmzi4ygM1CZ5s8RpnE7V
         RqegW2coA8LtzZAmosiMvnCr1UwoKKS49xQoUI77uC9As2KZ3AhP5ut68xqwn0umlRPl
         OAsg==
X-Received: by 10.236.61.45 with SMTP id v33mr23132447yhc.20.1395200742238;
 Tue, 18 Mar 2014 20:45:42 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 20:45:42 -0700 (PDT)
In-Reply-To: <1395192636735-7605956.post@n2.nabble.com>
X-Google-Sender-Auth: 1fGx08Cgn__U94XwfayJ0ENQ0-4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244407>

On Tue, Mar 18, 2014 at 9:30 PM, babourn <ba.bourn@gmail.com> wrote:
> Subject: diff: used is_dot_or_dotdot() in code

Use imperative voice: "use" rather than "used"

> in accordance with the GSoC Microproject implemented

This commentary will not have much meaning to someone reading the
commit log months or years from now. Place it below the "---" line
following your sign-off.

> the call is_dot_or_dotdot() in the code in order to
> further universalize the call to the function and
> increase code continuity.

It should be sufficient to explain the patch by just saying:

    Subject: replace manual "."/".." check with is_dot_or_dotdot()

The rest of the explanatory text can be dropped since it doesn't add
anything (meaningful) beyond what the subject says.

> Signed-off-by: Brian Bourn <bab2177@columbia.edu>
> ---
>  diff-no-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index ba915af..44cce25 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -26,7 +26,7 @@ static int read_directory_contents(const char *path,
> struct string_list *list)
>   return error("Could not open directory %s", path);
>
>   while ((e = readdir(dir)))
> - if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
> + if (!is_dot_or_dotdot(e->d_name))

The patch is severely whitespace-damaged. (Did you post it through Nabble?)

>   string_list_insert(list, e->d_name);
>
>   closedir(dir);
> --
> 1.9.0
>
>
>
> --
> View this message in context: http://git.661346.n2.nabble.com/PATCH-GSoC-2014-diff-Imported-dir-h-and-renamed-read-directory-tp7605950p7605956.html
> Sent from the git mailing list archive at Nabble.com.
> --
