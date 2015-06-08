From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Mon, 08 Jun 2015 12:12:52 -0700
Message-ID: <xmqqzj4a9fpn.fsf@gitster.dls.corp.google.com>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
	<1433621052-5588-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22Tp-0003zH-8j
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 21:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752405AbbFHTMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 15:12:55 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34565 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbbFHTMy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 15:12:54 -0400
Received: by iebmu5 with SMTP id mu5so69629687ieb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=M227DfNqRXWP+EANNSILr7Ff93VZhXwRX8ITfNcgUyI=;
        b=aVf0dP/oaT+iHkESBUz3x0CgIxoFvXLH1MtPn0tGQ5bEizkDj8eQ4kOSOcqrVEIvmR
         M95lc7eGk5vwgnRaPUvLMqzjCMX7GQWu1V8VAHraJIYu698vDcJgEAg99tyWK1GJxmFL
         P6CgVw9uSNZRmg3uXE16/UsOyJ8OBkO39KfRSeqTnlJ/f+jVqtyNCyMmErxWK4pTstvL
         taiZ2Dy+4gvSSBxM+d5qdYwKnjAfOBtB5cMTr3WwC9c7qYR7jeW3CREyb7zQVdtrZyg5
         Cl6gNIi53Tu5piYc3yzWPEWpiLqPE9gyPqzDg3WzFJv0S+Q7/4YgBXil+cX697Z0WIt0
         QGdg==
X-Received: by 10.107.47.4 with SMTP id j4mr16233234ioo.17.1433790774150;
        Mon, 08 Jun 2015 12:12:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id qt1sm949211igb.5.2015.06.08.12.12.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 12:12:53 -0700 (PDT)
In-Reply-To: <1433621052-5588-3-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 7 Jun 2015 01:34:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271113>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add the '--points-at' option provided by 'ref-filter'. The
> option lets the user to pick only refs which point to a particular
> commit.
>
> Add Documentation for the same.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt | 3 +++
>  builtin/for-each-ref.c             | 6 +++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 7f8d9a5..e9f6a8a 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  [verse]
>  'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
>  		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
> +		   [--points-at <object>]
>  
>  DESCRIPTION
>  -----------
> @@ -62,6 +63,8 @@ OPTIONS
>  	the specified host language.  This is meant to produce
>  	a scriptlet that can directly be `eval`ed.
>  
> +--points-at <object>::
> +	Only list tags of the given object.

Is this intended?  I would have expected if I did

	git for-each-ref --points-at master

I would get refs/heads/master and any other refs that exactly points
at that commit.

>  
>  FIELD NAMES
>  -----------
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 4d2d024..b9d180a 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -7,6 +7,7 @@
>  
>  static char const * const for_each_ref_usage[] = {
>  	N_("git for-each-ref [<options>] [<pattern>]"),
> +	N_("git for-each-ref [--points-at <object>]"),
>  	NULL
>  };
>  
> @@ -17,6 +18,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
>  	int maxcount = 0, quote_style = 0;
>  	struct ref_filter_cbdata ref_cbdata;
> +	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>  
>  	struct option opts[] = {
>  		OPT_BIT('s', "shell", &quote_style,
> @@ -33,6 +35,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
>  		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
>  			    N_("field name to sort on"), &parse_opt_ref_sorting),
> +		OPT_CALLBACK(0, "points-at", &ref_cbdata.filter.points_at,
> +			     N_("object"), N_("print only tags of the object"),
> +			     parse_opt_points_at),
>  		OPT_END(),
>  	};
>  
> @@ -54,7 +59,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	/* for warn_ambiguous_refs */
>  	git_config(git_default_config, NULL);
>  
> -	memset(&ref_cbdata, 0, sizeof(ref_cbdata));

I cannot quite see how this change relates to the addition of the
new option.

>  	ref_cbdata.filter.name_patterns = argv;
>  	filter_refs(for_each_rawref, &ref_cbdata);
