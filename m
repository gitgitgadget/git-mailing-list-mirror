Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49C11F404
	for <e@80x24.org>; Sat, 24 Feb 2018 15:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeBXPSl (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 10:18:41 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38686 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBXPSk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 10:18:40 -0500
Received: by mail-pl0-f66.google.com with SMTP id d4so6678511pll.5
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 07:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V3ctu/yDTODm/2TCdmMC5Sp+yQRM1wWLSqKs1mSJzl0=;
        b=bj1KkY/laVPhHQdk/x0tCkTV5kYH2rZK9NaIlzqWBgXVZkX2Qecg/jLg2pWzwxHi5P
         rFvT1lzqDWaVARh3qMc4haa/bvKHpkwnjZIidNoFAJoaI9bnu98i483cJRTjHz0GTytF
         dBblO7Ue4YMgFVt2uNhyyOdY638kGix347oc4Oa3wcluntRJ+sHVvkVVg9ONdZKjvP30
         CGESOzuYHAIUt5SozRtscLSDDS7WV7eD7f87vP4v1rghQYn5GjwMktW8pFaZKQYUIoIz
         FffGD7bm8plljekG7YqKOP3uDAj+eOItOT4bIfqSISRpnFAhrOMPlLrL5OK0XF27e0TF
         T3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V3ctu/yDTODm/2TCdmMC5Sp+yQRM1wWLSqKs1mSJzl0=;
        b=EfWAqQTmXvtSbllkfM63WnYsiSitCUd8yJ6rdi3RX13l4GjNvivzx2AvK68zmv4Zav
         NV+pcxebW+e78GR/pAkECOcFT26oXMyQOytiC4mCMeUbh4S5fhhjfx1cnz08HhXnDoHg
         BeKT6w2lcZ95KmdCbj7TvXGPrCLBOCU96LxKsamUyKsybmdg45WNfssufbj3akFP6AZD
         C/+SkZ0SwSDCCzKzor+sCDdQEp4/V1I4/Et6AGnValG53UsdsDSVBFrqEf3PvI0Wl16w
         Spe+sm7zujkC292VxAqSxI8QAQ7BgIbC48DzV6obC0H6/QmdA4HrG0qEJZy6ckTrX+xx
         F9cw==
X-Gm-Message-State: APf1xPConqyN2kXiqZrInobR1DJUVlw99VKywks5yecEyFgtQ0JqY8i6
        pIbh+y+QgXhDxS8AHSo3wnk=
X-Google-Smtp-Source: AH8x225Ve/YdIiacNqPxSM7RHiKUGg8BnCB4PXZIq4VqSOeIMxGEUKL9cK/i9II5D5NGXApjrXhi/A==
X-Received: by 2002:a17:902:d682:: with SMTP id v2-v6mr5139691ply.348.1519485519814;
        Sat, 24 Feb 2018 07:18:39 -0800 (PST)
Received: from [10.32.248.206] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id t11sm9597121pfe.17.2018.02.24.07.18.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Feb 2018 07:18:39 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 24 Feb 2018 16:18:36 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com> <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com> <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com> <20180216165815.GA4681@tor.lan> <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com> <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com> <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Feb 2018, at 21:11, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>>> I still think it would be nice to see diffs for arbitrary encodings.
>>> Would it be an option to read the `encoding` attribute and use it in
>>> `git diff`?
>> 
>> Reusing that gitk-only thing and suddenly start doing so would break
>> gitk users, no?  The tool expects the diff to come out encoded in
>> the encoding that is specified by that attribute (which is learned
>> from get_path_encoding helper) and does its thing.
>> 
>> I guess that gitk uses diff-tree plumbing and you won't be applying
>> this change to the plumbing, perhaps?  If so, it might not be too
>> bad, but those who decided to postprocess "git diff" output (instead
>> of "git diff-tree" output) mimicking how gitk does it by thinking
>> that is the safe and sane thing to do will be broken by such a
>> change.  You could do "use the encoding only when a command line
>> option says so", but then people will add a configuration variable
>> to turn it always on and these existing scripts will be broken.
>> 
>> I do not personally have much sympathy for the last case (i.e. those
>> who scripted around 'git diff' instead of 'git diff-tree' to get
>> broken), so making the new feature only work with the Porcelain "git
>> diff" might be an option.  I'll need a bit more time to formulate
>> the rest of my thought ;-)
> 
> So we are introducing in this series a way to say in what encoding
> the things should be placed in the working tree files (i.e. the
> w-t-e attribute attached to the paths).  Currently there is no
> mechanism to say what encoding the in-repo contents are and UTF-8 is
> assumed when conversion from/to w-t-e is required, but there is no
> fundamental reason why it shouldn't be customizable (if anything, as
> a piece of fact on the in-repo data, in-repo-encoding is *more*
> appropriate to be an attribute than w-t-e that can merely be project
> preference at best, as I mentioned earlier in this thread).

Correct.


> We always use the in-repo contents when generating 'diff'.  I think
> by "attribute to be used in diff", what you are reallying after is
> to convert the in-repo contents to that encoding _BEFORE_ running
> 'diff' on it.  E.g. in-repo UTF-16 that can have NUL bytes all over
> the place will not diff well with the xdiff machinery, but if you
> first convert it to UTF-8 and have xdiff work on it, you can get
> reasonable result out of it.  It is unclear what encoding you want
> your final diff output in (it is equally valid in such a set-up to
> desire your patch output in UTF-16 or UTF-8), but assuming that you
> want UTF-8 in your patch output, perhaps we do not have to break
> gitk users by hijacking the 'encoding' attribute.  Instead what you
> want is a single bit that says between in-repo or working tree which
> representation should be given to the xdiff machinery.

I fear that we could confuse users with an additional knob/bit that
defines what we diff against. Git always diff'ed against in-repo 
content and I feel it should stay that way.

However, I agree with your earlier emails that "working-tree-encoding"
is just one half of the feature. I also think it would be nice to be
able to define the "in-repo-encoding" as well. Then we could define 
something like that:

    *.foo 		text in-repo-encoding=UTF-16LE

This tells Git that the file is stored as UTF-16LE. This would help Git
generating a diff via UTF-8 conversion. I feel that the final patch 
should be in UTF-16LE again. Maybe over time we could then deprecate the
"encoding" attribute as the "in-repo-encoding" attribute serves a similar 
purpose (maybe gitk can switch to it).

In that case we could also do things like that:

    *.bar 		text working-tree-encoding=SHIFT-JIS in-repo-encoding=UTF-16LE

SHIFT-JIS encoded files would be reencoded to UTF-16LE on checkin.
On checkout the opposite would happen. This way we would lift the
"UTF-8 is the only in-repo encoding" limitation of the current w-t-e
implementation.

Does this sound sensible to you? That being said, I think "in-repo-encoding"
would deserve an own series.

- Lars
