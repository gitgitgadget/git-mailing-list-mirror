Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5106C1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 03:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeC1Da7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 23:30:59 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:44490 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeC1Da6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 23:30:58 -0400
Received: by mail-yw0-f180.google.com with SMTP id z21so346035ywg.11
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 20:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tfzSjVOn1FukJEhqKvSKpagQE3NcUF9f60JUmsqby2U=;
        b=qIvXZETetjrg/Xr6QCA/p48hFKt38cyvRRg/t/QZ4wXW7CgiSBpIZDw2zYcgH+/Adz
         f03i1qflNkIJQINO30uaM6prKUCk4MRImxcJpoa4Wg/fl5pVY6pRrGOjQTnSG208lWhu
         1QNG610dbIg/DZ3lDLWZtvzP+dmuKedre9MKqcF5ircayKsAlhG3g3GsNMhEPxP7lmvy
         H3rFvFqCwv2YG96/X6VXz25az54VpAIZbSErtnRyL4NHtsudCpLq1tRSNBCS0T+qJnOO
         Y5O67sYY8QAmum6i/8MYyAoiI2HJwwzjC7uF96if25fqi1EwVe/LtufK8GcfpmrhNTSS
         DulQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tfzSjVOn1FukJEhqKvSKpagQE3NcUF9f60JUmsqby2U=;
        b=lNSeophl51k+YBlK6zheeuISQxkC7wHV5b22hZSdhuQUverf4R1WQK5sD05E/mpeeT
         zEQU+A9dbKiGV081wET5Qdt5ZzAWteu1ECBxbN47kDabuewIyOdWkJKWoGRFt9wuZQbb
         qZBGjaefj3wLxhuhrFjIqTbLluyr3rPNTu1e1+fhzcoausBg0YQhWOAX2QC/dj5Srqhz
         hPGclLDL9EhJoEHIAilOvLN1Q3/NgVENYWU+9Ni/Rf7TT/6Bll4bjvyH1n3RujnbgYOx
         wM2k6puJEv6s4QtEvewI5pSE9VhxPkwyVR5IHl8jzF5RmXYFy2M0rUUv2yv9r48Q2cNB
         smTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tfzSjVOn1FukJEhqKvSKpagQE3NcUF9f60JUmsqby2U=;
        b=Ka+9qawUxUalte6kNOjMHvlLNRxYSJ8k+H+WlOFGhxhlhQ0zv6qxdcDh3LXGK789sE
         5CZY+Xm50YRaMiN0DbonQClXI/o+2TEVjLrKAHWiLL3kmpNOm+Woqj4jj5MHaNaUeDT2
         GuOMwD4Rwm+NAjh5Zwb/ZME6nrXL/lPpcLUwPO4v8FdLLEiBoY1/4k6T0be9/C3cW9gN
         WKHUoE9W0OLNNIttNtzBb4tYcna3t22OfUhjdtekbS+AZYrudXyF9KF6GUYsLszA9Qjk
         4YGFUwXCrWG55ShdkAodgd0PH6RTOa9CE1p2U38NGc0NhUBFnsIuwjW6hMXlyVTfRJm5
         EMEQ==
X-Gm-Message-State: AElRT7H0Zm7ha0arhHFxgxSnvoERY8V0rSfXh5w3YzPbtCyK59aQ/I7P
        2OkRaCOQbsB3TVEgi9PHtCizXvLyYK0Q4H+rpLs=
X-Google-Smtp-Source: AIpwx48AeRycMz/UsmiDrmBkrInPxKyV8MccvsnhmXysNl8edijAmpa0rScW91LKJYwyDd4E25hURIW9yMN0j62x74g=
X-Received: by 10.129.181.76 with SMTP id c12mr1190516ywk.250.1522207857331;
 Tue, 27 Mar 2018 20:30:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3804:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 20:30:36
 -0700 (PDT)
In-Reply-To: <20180325164300.GA10909@hank>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-2-joel@teichroeb.net>
 <20180325164300.GA10909@hank>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Tue, 27 Mar 2018 20:30:36 -0700
X-Google-Sender-Auth: x1UDetZggGEaOUSM-vOzFI_2-s0
Message-ID: <CA+CzEk_vRc2AQ+Cxn66TmqbYjDcMsgy0-QXLsJwKRLE70nip_A@mail.gmail.com>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 9:43 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 03/24, Joel Teichroeb wrote:
>> ---
>
> Missing sign-off?  I saw it's missing in the other patches as well.
>

Thanks! I always forget to add a sign-off.

>> [...]
>> +
>> +     if (info->has_u) {
>> +             struct child_process cp = CHILD_PROCESS_INIT;
>> +             struct child_process cp2 = CHILD_PROCESS_INIT;
>> +             int res;
>> +
>> +             cp.git_cmd = 1;
>> +             argv_array_push(&cp.args, "read-tree");
>> +             argv_array_push(&cp.args, sha1_to_hex(info->u_tree.hash));
>> +             argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
>> +
>> +             cp2.git_cmd = 1;
>> +             argv_array_pushl(&cp2.args, "checkout-index", "--all", NULL);
>> +             argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
>> +
>> +             res = run_command(&cp) || run_command(&cp2);
>> +             remove_path(stash_index_path);
>> +             if (res)
>> +                     return error(_("Could not restore untracked files from stash"));
>
> A minor change in behaviour here is that we are removing the temporary
> index file unconditionally here, while we would previously only remove
> it if both 'read-tree' and 'checkout-index' would succeed.
>
> I don't think that's a bad thing, we probably don't want users to try
> and use that index file in any way, and I doubt that's part of anyones
> workflow, so I think cleaning it up makes sense.
>

I'm not sure about that. The shell script has a trap near the start in
order to clean up the temp index, unless I'm understanding the shell
script incorrectly.
