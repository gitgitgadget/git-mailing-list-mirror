From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/10] Documentation: Document --function-name usage
Date: Thu, 27 Mar 2014 20:30:49 -0400
Message-ID: <CAPig+cQ5pEyPUG+Rhg2=H9r9RNo2=wFXxfawKZpb+RJxhdUKFA@mail.gmail.com>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
	<1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
	<c5de064075e6a2192817aafde75d8075ae82c974.1395942768.git.davidad@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 28 01:31:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTKhc-0001bu-K1
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 01:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172AbaC1Aav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 20:30:51 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:35488 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbaC1Aau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 20:30:50 -0400
Received: by mail-yh0-f41.google.com with SMTP id v1so4461378yhn.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 17:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XGQLpe5+sl6Ij736dtAqj7acKkcoARum3puaGKrdlzM=;
        b=IoHBh/2i9+JyNEA++U02F6SCm5L+BAjlWjgsV2qakcZwfHLL1I69g56DzWFymLCjcS
         zI3eXAKEccDj3M9km4IiqFb4Q76ZkhOwBW+xtGl4kL2C9lw4qRwjJTYClgo4sao2meoP
         wHM8f0ZHUg6Q6PDu0tht63yehZ6vQpREiS0x6qDzDkc2qsPfpGA6vnC8HYW5BbxZc/Yd
         YMpIEu4hhfgeu5tyoaUeVoTC5FZK7VPRI3UaSeokjII3kgmtLQrS6hsJuh5Jdmhua/Nl
         W0yPyW0As9UGRiZQ/knReC3+9Ag1lcCfnfVWDqaZXXiJ+StIkAGT1Xin1wkcwW0nmLgw
         DEAg==
X-Received: by 10.236.206.7 with SMTP id k7mr6830052yho.84.1395966649686; Thu,
 27 Mar 2014 17:30:49 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 17:30:49 -0700 (PDT)
In-Reply-To: <c5de064075e6a2192817aafde75d8075ae82c974.1395942768.git.davidad@alum.mit.edu>
X-Google-Sender-Auth: TF69Ojmb4wll4AmfJcPzBCXIMEc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245343>

On Thu, Mar 27, 2014 at 2:50 PM, David A. Dalrymple (and Bhushan G.
Lodha) <dad-bgl@mit.edu> wrote:
> From: "Bhushan Lodha & David A. Dalrymple" <dad-bgl@mit.edu>
>
> Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
> ---
>  Documentation/diff-options.txt |  9 +++++++++
>  Documentation/gitdiffcore.txt  | 17 ++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 9b37b2a..a778dff 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -427,6 +427,15 @@ information.
>  --pickaxe-regex::
>         Treat the <string> given to `-S` as an extended POSIX regular
>         expression to match.
> +
> +--function-name<regex>::

Missing '=' before <regex>. Ditto for the several additional instances
in this patch.

> +       Look for differences whose patch text contains hunk headers that match
> +       <regex>. This can be useful to locate changes to a particular function
> +       or other semantic element in a program, since hunk headers are intended
> +       to indicate the "function context" (in the sense of
> +       `--function-context`) in which the particular change occurs. The
> +       function context is determined by the diff driver corresponding to the
> +       file in question; see linkgit:gitattributes[7] for details.
>  endif::git-format-patch[]
>
>  -O<orderfile>::
> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index c8b3e51..b8477ce 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -222,10 +222,11 @@ version prefixed with '+'.
>  diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
>  ---------------------------------------------------------------------
>
> -This transformation limits the set of filepairs to those that change
> +This transformation limits the set of filepairs to those that involve
>  specified strings between the preimage and the postimage in a certain
> -way.  -S<block of text> and -G<regular expression> options are used to
> -specify different ways these strings are sought.
> +way.  -S<block of text>, -G<regular expression>, and
> +--function-name<regular expression> options are used to specify
> +different ways these strings are sought.
>
>  "-S<block of text>" detects filepairs whose preimage and postimage
>  have different number of occurrences of the specified block of text.
> @@ -251,6 +252,16 @@ criterion in a changeset, the entire changeset is kept.  This behavior
>  is designed to make reviewing changes in the context of the whole
>  changeset easier.
>
> +"--function-name<regular expression>" detects filepairs whose textual
> +diff contains a hunk header that matches the given regular expression.
> +The hunk header is generated via the diff driver specified in
> +`.gitattributes`, and is intended to reflect the "function context"
> +(in the sense of `--function-context`) in which the change occurs,
> +with programming-language-dependent heuristics. As of now, the
> +programming language is not auto-detected in any way. Also note that
> +hunks whose headers do not match the regular expression are not
> +currently filtered out; this is only a filepair filter.
> +
>  diffcore-order: For Sorting the Output Based on Filenames
>  ---------------------------------------------------------
>
> --
> 1.7.12.4 (Apple Git-37)
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
