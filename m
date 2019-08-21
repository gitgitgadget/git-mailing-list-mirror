Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9C41F461
	for <e@80x24.org>; Wed, 21 Aug 2019 22:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfHUWEB (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 18:04:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54930 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfHUWEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 18:04:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so3611007wme.4
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R14pzN0hZUPpTP1Ua/lEXloGseMYktDVIOYGboN9qXA=;
        b=Zb29kVzu8gj/fjaJiPGh7rhTogoTzu9VLaTkN0waJt1nSLcR9LfNT2awYByuq0TBek
         q8qqUq7vdwvUESUq05Pg3GyZ+hgv1l8Gc/t1H05uVPs4ZtVl1pUj4rO4B9V/fY23bqbs
         1RT1RR5gweVPlrHuAccRGyKMOJVRuLljoRvrdwZa+ajQTPLKBtwpEW5tsbxOZINd0WK4
         /smhgTfNQZoKHdoKNARjO9daeF4cUUMldt3shBjdiNYtih1puQ+sHYn+Qs8a1sbHvGKa
         OXtYYxdQRfWLuEwk/5UVS/8LK/Sh6exDqeHxpAu5SGb2H8Psy2W49DR5H0EFERFtAF5K
         cSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R14pzN0hZUPpTP1Ua/lEXloGseMYktDVIOYGboN9qXA=;
        b=IZldtAXTiyOsEqkJiz9TWv8izlS8oJilxDudaaGDZbfzf0RqO0NqHQTiyOlFGGSz7G
         IiROLR/ZeyZXNC+1Wpy5j9P4YYjK+xYrDuEC4dmMbXOtlEbcJM5imUiCNNnxMP8yk5UE
         kfm6rmIeiD3KP0Nmic1yeqRoSka+MLTcz9mAS0FFYqdHedOTnDLEJ36BErfBmpLgsG/L
         vZikK7GGSqSvP1TmwWx+q5IP5uqm9gFW3c9oVnbgTlZ0ACKwlASSO8NSQqMP9vMFuwIC
         gQEz1p4n5H2Yv/VVWut99QkEWiS+kVEvgLzDMzV9GarxwsBVk/FlSjeeMz4/3+cyeMI/
         JCZQ==
X-Gm-Message-State: APjAAAXgjlmWjdoVp1dykxXMhUsLtHUoNDOmMTeXl/VsS3SQUgE9q5AK
        A9XKi0NaPP2kJ24+y/oU6CO4a41E
X-Google-Smtp-Source: APXvYqxkZYbicuUEEJSL26Ujmac9uIvoLOPu+0KyF0uJXs03NNxQxsQWg2h3juiLhEkT9qLoJFOH4A==
X-Received: by 2002:a1c:3944:: with SMTP id g65mr2431100wma.68.1566425039058;
        Wed, 21 Aug 2019 15:03:59 -0700 (PDT)
Received: from szeder.dev (x4db50904.dyn.telefonica.de. [77.181.9.4])
        by smtp.gmail.com with ESMTPSA id f197sm3366630wme.22.2019.08.21.15.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 15:03:58 -0700 (PDT)
Date:   Thu, 22 Aug 2019 00:03:55 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        rsbecker@nexbridge.com, johannes.schindelin@gmx.de,
        larsxschneider@gmail.com
Subject: Re: [PATCH] t0021: make sure clean filter runs
Message-ID: <20190821220355.GZ20404@szeder.dev>
References: <20190820065625.128130-1-t.gummerer@gmail.com>
 <aea64308-fcba-77a1-1196-182b35ad405c@kdbg.org>
 <20190821145616.GB2679@cat>
 <a8de9661-7f6a-f953-93a0-8ef88e9a490a@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8de9661-7f6a-f953-93a0-8ef88e9a490a@kdbg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 08:23:23PM +0200, Johannes Sixt wrote:
> Am 21.08.19 um 16:56 schrieb Thomas Gummerer:
> > On 08/20, Johannes Sixt wrote:
> >> Am 20.08.19 um 08:56 schrieb Thomas Gummerer:
> >>> Fix the test by updating the mtime of test.r, ...
> >>
> >>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> >>> index e10f5f787f..66f75005d5 100755
> >>> --- a/t/t0021-conversion.sh
> >>> +++ b/t/t0021-conversion.sh
> >>> @@ -390,6 +390,7 @@ test_expect_success PERL 'required process filter should filter data' '
> >>>  		EOF
> >>>  		test_cmp_exclude_clean expected.log debug.log &&
> >>>  
> >>> +		touch test.r &&
> >>
> >> 		test-tool chmtime +10 test.r
> >>
> >> would be more reliable.
> > 
> > Hmm, is touch unreliable on some platforms?  I didn't think of
> > 'test-tool chmtime', but I'm also not sure it's better than touch in
> > this case.
> > 
> > To me te 'touch' signifies that the timestamp must be updated after
> > the previous checkout, so git thinks it could possibly have been
> > changed, which I think is clearer in this case than setting the mtime
> > to a future time.
> 
> touch does not guarantee that the current time is different from the
> timestamp that the file already carries, particularly not when the
> filesystem stores just a resolution of 1 second, and commands are
> executed quickly.

This 'touch' must ensure that the timestamp of the file is not older
than the timestamp of the index, and to achive that it doesn't
necessarily have to modify the timestamp.

The file is modified first, then the index is updated, and finally
comes this 'touch'.  Consequently, if 'touch' doesn't modify the
timestamp of the file, then it must have the same timestamp as the
index, IOW it's racily clean, and the subsequent 'git checkout' has to
look at the file content and has to run the filter, and that's what we
want to see here.

However, I'm not sure what would happens if the system clock were to
jump back in between, but since it's only a test I don't think it's
worth caring about.

> But when we use test-tool chmtime +10, then the timestamp is definitely
> different.

'test-tool chmtime +10' adjusts the timestamp of the file relative to
its current timestamp.  So yeah, the file's timestamp definitely
changes, but that's not enough, because it doesn't ensure that the new
timestamp is not older than the timestamp of the index.  Just imagine
the arguably pathological situation that right after the file was last
modified the system miraculously comes to a complete stall, and only
manages to resume after 15 seconds to continue with updating the
index.  This means that the timestamp of the file will be 15s older
than the index, and after that 'chmtime +10' it will still be 5s
older.  Consequently, 'git checkout' will think that the file is
clean, it won't run the filter that we expect, and the test will fail.
So instead of '+10' it should be '=+10' to set the new timestamp
relative to the current time, but I'm not too keen about the timestamp
in the future either (though the file is about to be deleted anyway).

I think it would be best to explicitly set the timestamp of the file
and the index sort-of relative to each other and add an in-code
comment as well, e.g.:

  # Make sure that the file appears dirty, so checkout below has to
  # run the configured filter.
  test-tool chmtime =-10 .git/index &&
  test-tool chmtime =+0 test.r &&

