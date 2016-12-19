Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B921FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 13:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbcLSNyD (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 08:54:03 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:37878 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbcLSNyC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 08:54:02 -0500
Received: by mail-it0-f41.google.com with SMTP id y23so82503093itc.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YnNWDCryZyI1je6Cerwq9QeFXihQcfYwaXjxC+LAaws=;
        b=qr3V3zVofHRksfLo/zprdsi30ZGE9bbHoCTQvDnL891nCx7Zkvbb/n/+cJQ8lXCnEI
         z7JJ3uWOuajsLk6LLleGH1UrnhZ/vBKy2+hoNEWqc/1Pi4GFFOOMqlfzoz1J0BpZKrqu
         +hQiBQiGHesix1FJhh3NEQBvivJOAW+w3NHADlGkAzV+E/idER0Hssw7kX4MoEp571NE
         JLTHz7eJpq8LbBfzJiWt04IBsjnRHlklsCVLBhV/gPwCXs5/BlUot7+lfXkCk2ta4DmX
         7CwclSAyC9M6M1MWs9yVql2BXwXOhEhTDOWB2nwbSksh6VEuovGu4KcnElY/fpd3Qq55
         tHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YnNWDCryZyI1je6Cerwq9QeFXihQcfYwaXjxC+LAaws=;
        b=MzI+hJOMALN2QTttM5oAKu8xZDNrAwu5fprBRLQhc8oQ6OJas2Rgni3ZoH5vJbNIFB
         1X3GC3N5EWm/tFqfYkqu4XoQJQbO57/eOR3tjWaTUTtFHp+4tniStXL+I/8DXzbkqfs7
         HpZniBZOiyZb8wBFTlG8zuckMR5752XBipA+2D6xAv9EwoQM89ftPBuzsXwnwyYWotHj
         gkfiE6KoJ14PmI3wHHPjGhtJ9ffJJ+Ryn/Ams7AwR8OZ7np4oYjNCH25rTUMLX7Q5OjL
         TYjw2z8SNI1QwJRjYHoRo9e24g31jb3RCFHjKMCRdkiL3rEMcYWlpV5cd7IdupuEMvM0
         VW7Q==
X-Gm-Message-State: AKaTC030Vup0NSFgrqsRDh63uOa4cFrsOrhr4AXKdcsheRhxbOJi+VVefKhI2V1Svmd37uYTT9MX5XiMMntD4A==
X-Received: by 10.36.159.3 with SMTP id c3mr16578521ite.50.1482155641160; Mon,
 19 Dec 2016 05:54:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 19 Dec 2016 05:53:30 -0800 (PST)
In-Reply-To: <20161219134148.vxa4fz3jw2i23lfm@sigill.intra.peff.net>
References: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net>
 <20161219120719.GF24125@ash> <20161219134148.vxa4fz3jw2i23lfm@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Dec 2016 20:53:30 +0700
Message-ID: <CACsJy8BgfyDTUmNh_PvoVcz2q92eNTRZy5myegTdi8mu6imVUQ@mail.gmail.com>
Subject: Re: [PATCH] parse-options: print "fatal:" before usage_msg_opt()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 8:41 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 19, 2016 at 07:07:19PM +0700, Duy Nguyen wrote:
>
>> On Wed, Dec 14, 2016 at 10:10:10AM -0500, Jeff King wrote:
>> > diff --git a/parse-options.c b/parse-options.c
>> > index 312a85dbd..4fbe924a5 100644
>> > --- a/parse-options.c
>> > +++ b/parse-options.c
>> > @@ -661,7 +661,7 @@ void NORETURN usage_msg_opt(const char *msg,
>> >                const char * const *usagestr,
>> >                const struct option *options)
>> >  {
>> > -   fprintf(stderr, "%s\n\n", msg);
>> > +   fprintf(stderr, "fatal: %s\n\n", msg);
>>
>> Your commit message does not make clear if you want this "fatal" to be
>> grep-able (by scripts) or not. If not, please _() the string.  Maybe
>> this to reduce work for translators
>>
>>       /* TRANSLATORS: this is the prefix before usage error */
>>       fprintf(stderr, "%s %s\n\n", _("fatal:"), msg);
>
> I don't think we translate any of our "fatal:", "error:", etc, do we?
> It certainly doesn't look like it in usage.c.

I know. But those existed before the l10n starts, some of those belong
to plumbing messages. This one is new.
-- 
Duy
