Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13F0201A4
	for <e@80x24.org>; Mon, 15 May 2017 01:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbdEOBzz (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 21:55:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36407 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753783AbdEOBzy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 21:55:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so12773403pfb.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bstD1J4NuA7nJ+k5T5rKWIRnEV1v9H6kIJrn8qGnwaM=;
        b=B/MBEUVgf+TYRCck8ivWqcA1XSAf1c3Z3T3xLQD6T/gi6VdvwMcWXroUr0kdt7pqIZ
         J3UqN/sE+r/5szYkhAwNoEYld2DbmJHiC1AuT4JLDECjN7t/A6FtceNfrERhnWxk13Mo
         Y/RcGmTz+EyfSQDjK1ruDPxjkobGwiLcZb2F3sLKnzb3522N00Ku65rp+ewAPYBgIBLk
         V/Ny5EKCbb1I1FoMLsRbUG8rfpoH26x0Y5YTEQV8h3kPrdOabAh98znrvi5/z2xzoJ4G
         He2cS0JlT7+RpSa2YQ/nZZ+BAjk9GD+4jdXSPnXe56lW61q2Z3oIaur6LD4IlvGWiWKV
         3ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bstD1J4NuA7nJ+k5T5rKWIRnEV1v9H6kIJrn8qGnwaM=;
        b=YX+wlw6gO0ZMPnRWAfgvqcXPRYPFMHCFcHjw6WSDwRO56jZqL3D5t+DamDpO1/99hV
         7J2MwTQKRJkrt2qKpCGUg3TiGGZpnF94WfnOLenIadVqM8WKuhDiDwGbJwdi4RkRU/nD
         cppYtQ4mlOqdnpXAI1cWInYNjjOUjRdGUdnAF4rargaaI+slBaVdYQsYxtyViIBdH01l
         cIktfkWzGiXNu0qrYx0QFq74YouOqNwtSsqiHfYYlOPgejscQDpyaEsn0EkkwFp1ep1T
         1Y9DxkxoiNEP+aP49xPpqNJ2kaGpeCP7FULF4YvWyeDZy46Z5Dug9TP+GNQzeP2VSTmx
         GfNQ==
X-Gm-Message-State: AODbwcBgaWc8MIh44ZjhMTIR/jeuhsjWdciXWWW2+69PXewmX93GP8Jc
        JYV2ANvTxf1dqg==
X-Received: by 10.98.214.90 with SMTP id r87mr3700160pfg.204.1494813353953;
        Sun, 14 May 2017 18:55:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id s63sm1637141pgb.40.2017.05.14.18.55.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 18:55:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2] send-email: support validate hook
References: <20170511193753.19594-1-jonathantanmy@google.com>
        <20170512223827.21372-1-jonathantanmy@google.com>
Date:   Mon, 15 May 2017 10:55:52 +0900
In-Reply-To: <20170512223827.21372-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 12 May 2017 15:38:26 -0700")
Message-ID: <xmqqk25iyjbr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 706091a56..b2514f4d4 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -447,6 +447,14 @@ rebase::
>  The commits are guaranteed to be listed in the order that they were
>  processed by rebase.
>  
> +sendemail-validate
> +~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by 'git send-email'.  It takes a single parameter,
> +the name of the file that holds the e-mail to be sent.  Exiting with a
> +non-zero status causes 'git send-email' to abort before sending any
> +e-mails.
> +

I briefly wondered if an interface that allows only the name of the
file will close the door to future enhancements, but in the end
decided it is OK.  E.g. users may want "here is the contents, is it
appropriate to be sent to this and that address?"---but this hook is
meant to enhances/extends the existing "make sure the contents do
not syntactically bust the technical limit of underlying transport",
and sits at a place best to do so in the codeflow, i.e. before we
even start to decide who the recipients of the patch are.  So those
who want "given the contents of the patch and list of the recipients,
decide if it is OK to send the patch to all of them" would be better
served by a separate hook, not this one.

> +	write_script .git/hooks/sendemail-validate <<-\EOF &&
> +		# test that we have the correct environment variable, pwd, and
> +		# argument
> +		case "$GIT_DIR" in
> +			*.git)
> +				true
> +				;;
> +			*)
> +				false
> +				;;
> +		esac &&
> +		test -e 0001-add-master.patch &&
> +		grep "add master" "$1"
> +	EOF

I'd squash in cosmetic changes to de-dent the contents of
write_script (our standard style is that the body of the script is
written as if the column at which write_script..EOF starts is the
left-edge of the page; I think this file already has a few style
violations that may want to be updated with a separate clean-up
patch when the file is quiet), and then de-dent the case arm (case
arms are indented at the same depth as case/esac).  Also I think we
care that 0001-add-master.patch not just exists but is a file, so
I'd do s/test -e/test -f/ while at it.

Thanks.
