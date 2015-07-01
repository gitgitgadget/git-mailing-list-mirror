From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: add --count to usage guide
Date: Wed, 01 Jul 2015 08:19:40 -0700
Message-ID: <xmqqd20bc3cj.fsf@gitster.dls.corp.google.com>
References: <1435742651-15053-1-git-send-email-lawrencesiebert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 17:19:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAJnm-0001RY-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 17:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbbGAPTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 11:19:48 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34929 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbbGAPTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 11:19:42 -0400
Received: by iecuq6 with SMTP id uq6so36987599iec.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/Hi7NLec20Ov1/1/tV22bL+KPn9WAMj/XMBNKhli0Lg=;
        b=oMMMF9AUapOhYbmKkd4fdGyCbDBQuHDn+m8kzW2U4Rw59JivmhRs6coC54wwmguNaa
         XnRq/MKwRWnbq/+suzZFjkDN4zN0rSkmL/Pz/Kz0H3YoM90Ak/5FXSC79vK9aD9DSk2R
         Un3wEl92nY8DqETl9zRoYThtCygcPcEjMeIy/3IsTdIXmShsmsDMhxlVV8lLA6NK84Yx
         DA88mZy0fhUWqlZB9o9Faq70SPXDgYYM9nvF7PWZyPLlFfzZjPh2z6NxyTdpRoUQLbFH
         IV8kDFFQ4DggNNCEjq4NzPu7tCXcSN9YPUenym5RfbuZzwUC5wRlLPsmCAsh4ZC9FWzn
         Ct4g==
X-Received: by 10.107.15.11 with SMTP id x11mr37965203ioi.0.1435763982026;
        Wed, 01 Jul 2015 08:19:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id p138sm1540499ioe.35.2015.07.01.08.19.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 08:19:41 -0700 (PDT)
In-Reply-To: <1435742651-15053-1-git-send-email-lawrencesiebert@gmail.com>
	(Lawrence Siebert's message of "Wed, 1 Jul 2015 02:24:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273156>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> --count should be mentioned in the usage guide, this updates code and
> documentation.
>
> Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
> ---

Sounds good.  While at it, perhaps add a mention (perhaps by
creating a BUGS section at the end of the file) that --count
with --use-bitmap-index ignores pathspec silently?

>  Documentation/git-rev-list.txt | 1 +
>  builtin/rev-list.c             | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index b10ea60..7b49c85 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -56,6 +56,7 @@ SYNOPSIS
>  	     [ --reverse ]
>  	     [ --walk-reflogs ]
>  	     [ --no-walk ] [ --do-walk ]
> +	     [ --count ]
>  	     [ --use-bitmap-index ]
>  	     <commit>... [ \-- <paths>... ]
>  
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ff84a82..ee9e872 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -42,6 +42,7 @@ static const char rev_list_usage[] =
>  "    --abbrev=<n> | --no-abbrev\n"
>  "    --abbrev-commit\n"
>  "    --left-right\n"
> +"    --count\n"
>  "  special purpose:\n"
>  "    --bisect\n"
>  "    --bisect-vars\n"
