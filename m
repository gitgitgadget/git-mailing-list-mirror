Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822C920229
	for <e@80x24.org>; Sun, 23 Oct 2016 10:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbcJWK2S (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 06:28:18 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38259 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbcJWK2R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 06:28:17 -0400
Received: by mail-it0-f46.google.com with SMTP id 66so92288809itl.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+8cZtkiKcJFcxAR4v1f2C14DIZK8szcobV8oIMetSLs=;
        b=TKJsv9B5vIpQfQTSLM7Z+dv3xwLQuR40y9NqKSsD/l/5QsxKhcMKiCk655bVOqz+ZI
         xCU875xZZ1lo0UWstZp1op8KCvunhwlqKzuixCNegV1+Co7xTot5zU9l0MLYfkQ0os0T
         sWrhA3UyzjQ7HpjER8Up0uIExVMZQfaqmVCG0OtKwyr6pv2GbKv4Y1zFGIYAZe8tM48S
         ob5ODlRuyzxMSy/zzJo+kp92+KzyzqNCzu2g3lNDOzWWOwVg+de8FWr6cg7L5yh3G+J0
         ecZ8oFv/KBoPJ4Zd5VUw+YxPjgPuvTRGnNT3DkBdkWwttjFu40fuullFScO1CiEbQcmB
         pp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+8cZtkiKcJFcxAR4v1f2C14DIZK8szcobV8oIMetSLs=;
        b=dNm9zW/OxB1RiVlUW7MC6t1NT/tguePriXeki7wDeJ2RoNgZFuq+gvTX8vtnPakBLI
         zZ8zkYNXD6LTNFHgohhSENVsUt5hjfqU+Y2xvG3RGpDtYjJH1n7D3DR0w+ggmiFlWtIT
         uTFoW8XuWEvQ/sNC9NMSnSF6S4PEhVEC5h7Po2p9p4/gCf4lgRpS/tRjCQP8sz2bD51o
         5Suh5DZbbhI95r806FJXLVhUPmeFXbp0945Mtwge+N52IytHf0eXq4w2w4oUTHllu+e5
         Ue8onsrHUer9EE5+qRGwxG3oA+7F/SFih6iL49WZPAdW0w+QEGsUITjHoILmufw38+Nf
         syEg==
X-Gm-Message-State: ABUngvfkok36Sy0ufbWRDbMUfHFS7bHVpkBErAoI+Y4T6knL756ZDzM1Z3WeqJaTWzE56g0N5+fyvLvUFmp94w==
X-Received: by 10.36.70.142 with SMTP id j136mr1335386itb.50.1477218496050;
 Sun, 23 Oct 2016 03:28:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Sun, 23 Oct 2016 03:27:45 -0700 (PDT)
In-Reply-To: <20161023013846.ct3olfabw2yhzio2@sigill.intra.peff.net>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net> <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net> <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
 <147712794056.12237.1478296296628149440@typhoon.fritz.box>
 <CACsJy8Bz-DhE+CkJH+3zsrZJUQfGYDN072MKawJ6dx5begfnMw@mail.gmail.com> <20161023013846.ct3olfabw2yhzio2@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 23 Oct 2016 17:27:45 +0700
Message-ID: <CACsJy8A2Q=cPhYtTexA+CS4mzyx-vHzNH033JFHDih=ohtucVw@mail.gmail.com>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
To:     Jeff King <peff@peff.net>
Cc:     Lukas Fleischer <lfleischer@lfos.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 8:38 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 23, 2016 at 08:23:01AM +0700, Duy Nguyen wrote:
>
>> I hit the same problem sometimes, but in my case sometimes I
>> accidentally do "git add" after "git add -p" and a configuration in
>> "git commit -a" won't help me. I'd prefer we could undo changes in
>> index instead. Something like reflog but for index.
>
> An index write always writes the whole file from scratch, so you really
> just need to save a copy of the old file. Perhaps something like:
>
>   rm -f $GIT_DIR/index.old
>   ln $GIT_DIR/index.old $GIT_DIR/index
>   ... and then open $GIT_DIR/index.tmp ...
>   ... and then rename(index.tmp, index) ...
>
> could do it cheaply. It's a little more complicated if you want to save
> a sequence of versions, and eventually would take a lot of space, but
> presumably a handful of saved indexes would be sufficient.

Yeah. I had something [1] like that but never sorted out the UI for it :(

> Another option would be an index format that journals, and you could
> potentially walk back the journal to a point. That seems like a much
> bigger change (and has weird layering, because deciding when to fold in
> the journal is usually a performance thing, but obviously this would
> have user-visible impact about how far back you could undo).

v2 [2] goes in this direction (but not a full blown COW, the journal
does not take part in any core operations of the index)

[1] https://public-inbox.org/git/%3C1375597720-13236-1-git-send-email-pclouds@gmail.com%3E/
[2] https://public-inbox.org/git/1375966270-10968-1-git-send-email-pclouds@gmail.com/
-- 
Duy
