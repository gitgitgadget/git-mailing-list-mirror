Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981352042F
	for <e@80x24.org>; Wed, 16 Nov 2016 15:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934911AbcKPPcL (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 10:32:11 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36473 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934248AbcKPPcH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 10:32:07 -0500
Received: by mail-yb0-f196.google.com with SMTP id d128so5024671ybh.3
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DNCm1xbDJ0xwTErz7WOo7MJntOlgC4mQw0LvChUdwGc=;
        b=0Ioe4bmsS7nBbTxkm02TzYT/bZly11T5NH6zioA0m7gVABzEv+i0ElLqMgUkis4+Kh
         PXOfOJNqPHllR1w8O8pOOg7iZDRHJo3JCskB8hYpxOWdNy3B0aGjHCuI7gtGxoYpKCuy
         53fphxTtMI0OHEv8g0HbsJHenqjSPDPkDX6m1cTScgdfqXhzP4kxo2wNRXUU974BoU37
         Jnirl9xsIZd5gZ6Rxgz/L/c/o1noEIWk5jQ2CD7UeujOAoP/WN/Kcjw+DpuqY5oGRnpg
         iSsOhReJ2LiLkccwGOrpGZNlf7I5sPM+Kbz03Cagjhn6M8AxbJ4nWZ6A8sx9uTcQVZlF
         JSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DNCm1xbDJ0xwTErz7WOo7MJntOlgC4mQw0LvChUdwGc=;
        b=ZL0N2l7wrmzxG4pRGSdVhRDWVO2Ycy/defU+/v2LesuPwnrAOfPCRB9EnfdQPxrPSi
         yK3yVSxNH9Luiu1zbE3XbBnVQlHM+9AtbCNFna9vbFa14vgqMQ4XWJcWjnjkAOrbnR6O
         nBmnc2/5PkNWgHHs+TYKbTVTKCkqf09qx7DX4oC4oK8/pXSnphIzJUlSRVXVoc4pP5ha
         e1My4FrtjQfMEGaSwAFNf8OFrrV2iGuHd41zm1Ns2Wo1h2ltwqTb0vUlZJ7xg8kzrBQB
         aCF+y5HzlA+gi7pgn1IN6DuHD3ohUnMkFFMA4UMAZLWRTU84oeu32iKld9G2daeptelH
         IHpA==
X-Gm-Message-State: ABUngveo/xEZ+jAr/jnyVeWP5ROKWasLjrL+tM8RALXKWVOJ1R6RKuNubM7419TjWbWpuG/QIn50VyNrg/ZS2Q==
X-Received: by 10.37.172.65 with SMTP id r1mr1907671ybd.132.1479310326272;
 Wed, 16 Nov 2016 07:32:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Wed, 16 Nov 2016 07:31:35 -0800 (PST)
In-Reply-To: <xmqqbmxgtqxv.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <xmqqbmxgtqxv.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 16 Nov 2016 21:01:35 +0530
Message-ID: <CAOLa=ZQtmQWpFMPa-SD29N7hASHAPp8SGGJsLu+AW_Kv-1LqwA@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] port branch.c to use ref-filter's printing options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 2:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is part of unification of the commands 'git tag -l, git branch -l
>> and git for-each-ref'. This ports over branch.c to use ref-filter's
>> printing options.
>>
>> Karthik Nayak (17):
>>   ref-filter: implement %(if), %(then), and %(else) atoms
>>   ref-filter: include reference to 'used_atom' within 'atom_value'
>>   ref-filter: implement %(if:equals=<string>) and
>>     %(if:notequals=<string>)
>>   ref-filter: modify "%(objectname:short)" to take length
>>   ref-filter: move get_head_description() from branch.c
>>   ref-filter: introduce format_ref_array_item()
>>   ref-filter: make %(upstream:track) prints "[gone]" for invalid
>>     upstreams
>>   ref-filter: add support for %(upstream:track,nobracket)
>>   ref-filter: make "%(symref)" atom work with the ':short' modifier
>>   ref-filter: introduce refname_atom_parser_internal()
>>   ref-filter: introduce symref_atom_parser() and refname_atom_parser()
>>   ref-filter: make remote_ref_atom_parser() use
>>     refname_atom_parser_internal()
>>   ref-filter: add `:dir` and `:base` options for ref printing atoms
>>   ref-filter: allow porcelain to translate messages in the output
>>   branch, tag: use porcelain output
>>   branch: use ref-filter printing APIs
>>   branch: implement '--format' option
>
> This is not a new issue, but --format='%(HEAD)' you stole from
> for-each-ref is broken when you are on an unborn branch, and the
> second patch from the tip makes "git branch" (no other args) on
> an unborn branch to segfault, when there are real branches that
> have commits.
>
> Something like this needs to go before that step.
>
>  ref-filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 944671af5a..c71d7360d2 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1318,7 +1318,7 @@ static void populate_value(struct ref_array_item *ref)
>
>                         head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
>                                                   sha1, NULL);
> -                       if (!strcmp(ref->refname, head))
> +                       if (head && !strcmp(ref->refname, head))
>                                 v->s = "*";
>                         else
>                                 v->s = " ";
>
>

Thanks, will add it in.

-- 
Regards,
Karthik Nayak
