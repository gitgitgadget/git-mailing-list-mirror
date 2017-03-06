Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6B820133
	for <e@80x24.org>; Tue,  7 Mar 2017 01:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbdCGBOb (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 20:14:31 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33082 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbdCGBO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 20:14:26 -0500
Received: by mail-qk0-f172.google.com with SMTP id y76so53253275qkb.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 17:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OA0rhhSQPp65oVuPYQ8HLuXqywbA98m2+MCAPsKvQII=;
        b=UOloCU9O0bWR0LwHZa9CnWMeHl71n3h6V5wLjxbriqSzh9nAw7ZgSCNbyVhogfYKKi
         ILCuxH/yxifVsWVii4N3zATWwpL4ozF0pmL5KlWWFo5MOub96KYiSHCn7G2A0dY4Sj5p
         QFbRyio8rAjVtPD510sIH249kH8lTcHWKau/E4FZgX4GLwN22KWtauGism94C2OSB48H
         mWVa9Rg1smsW9ckT7nDOqvSPIsILb4lEZy6q5DFrmu3CCk2OyVFp94j6ZvvpTbbmkqfW
         JSiQOwXFxCNet+vRbxtn+UDF0LI71tE5/d3baCAlLghtANECV+8tVzEt2af1P7jtzFnV
         ePUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OA0rhhSQPp65oVuPYQ8HLuXqywbA98m2+MCAPsKvQII=;
        b=gOZSx2gdeaO4VDDm4Pnd9qG2ghWSYo3tXOG30zq97WAP6ZNOCv3MpzRFmdUoBTI9vY
         8un17pglymNkl8KS27g1h7BPlkk3Fcd2r/p1X54rREWErI1NqO5PpqySPt1j7KfD0Mvi
         DXXQlNapnhXnRfnaTKu1VucmjrjEO+22fmdN+2I9P1Ncn2n9XJ3OhqjHPYX/mXrksE7k
         P3u1gnSlPUc2U3YfLxTkV9yVOIXs0EFIrpKIZ6K6n5KhxQR/bAppFZ4xw7UrKkdHgac2
         QI23NDkgIV7BPJ0TAVCgZrfe9/x1my3Beb/uDj6ERvA3nGKaOSg+3jvMzLvSbm36J0w0
         SUEg==
X-Gm-Message-State: AMke39kbpuKsJ03cl98kC4r1gZSyfC9G4LPB6hJaZzQapt57lqsziFhPx2Ueo4uwyOCgkGB/3T6XeKmR2E/vTw==
X-Received: by 10.55.54.143 with SMTP id d137mr17722977qka.258.1488842996837;
 Mon, 06 Mar 2017 15:29:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.52.6 with HTTP; Mon, 6 Mar 2017 15:29:56 -0800 (PST)
In-Reply-To: <20170131194138.fbcbdnkfjgizxnoa@sigill.intra.peff.net>
References: <20170131022830.8538-1-eantoranz@gmail.com> <20170131194138.fbcbdnkfjgizxnoa@sigill.intra.peff.net>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 6 Mar 2017 17:29:56 -0600
Message-ID: <CAOc6etZjvpiQ65JHWzVeEqUzO0uJv8UjuWw7mbvCL5Om9weZLg@mail.gmail.com>
Subject: Re: [PATCH] blame: draft of line format
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 1:41 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 30, 2017 at 08:28:30PM -0600, Edmundo Carmona Antoranz wrote:
>
>> +static void pretty_info(char* revid, struct blame_entry *ent, struct strbuf *rev_buffer)
>> +{
>> +     struct pretty_print_context ctx = {0};
>> +     struct rev_info rev;
>> +
>> +     struct strbuf format = STRBUF_INIT;
>> +     strbuf_addstr(&format, format_line);
>> +     ctx.fmt = CMIT_FMT_USERFORMAT;
>> +     get_commit_format(format.buf, &rev);
>> +     pretty_print_commit(&ctx, ent->suspect->commit, rev_buffer);
>> +     strbuf_release(&format);
>> +}
>
> I think this may be less awkward if you use format_commit_message() as
> the entry point. Then you do not need a rev_info struct at all, it
> touches fewer global variables, etc.
>
> I don't know if that would cause the other difficulties you mentioned,
> though.
>
> -Peff

Thanks for the tip, Peff. It made the code to get rev info much
shorter. I'll work on some other improvements and then I'll send
another patch.

Best regards!
