Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943061F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbdARVLd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:11:33 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35538 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbdARVLa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:11:30 -0500
Received: by mail-lf0-f52.google.com with SMTP id n124so22137702lfd.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 13:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N6ZZVcmBbhstbtJBQOSIoZvnzD0hDfeECqNEEJbAkXI=;
        b=bIY0xkuBmqKCPLJ4PaItZFroMTu6tTXw+24DqxryEwzaz/xwQqtLbdVIZgout/ceRT
         /ePjCaBPkzltEvLPPIKXqBLvEYW8ZyRTKW9+WGB+30ewhIiVWL13leqciSRWCP9N1NgG
         eQsMGHr4SWA3KB67Rc/V+DQw6g1Th+s4MoTbjAanstixLYGvW7xBGjtBNfT0ZkNBH2ps
         U0o/luJUkYe7ZeNcUzuzLFIm7KQ0ajBMhnSQgKNjH5c3BMqlWJICnzPsbf2SCzS/8v/U
         1pS4XDWMMa+/GeXBDK4KS1rklWNXtY8in4NP3JOIRNloWnQbnLC4lEFBHD2xnKRk7LuU
         OzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N6ZZVcmBbhstbtJBQOSIoZvnzD0hDfeECqNEEJbAkXI=;
        b=iixDB32cfylc8A0IyvWTaeR6XlKdEZEqTOYzty8I06zj4DY9V7cNSAbuw2LfyzdJOV
         yC7KZtUj8ww81+QxF/5Qe5yvMPXgRvlYVH/RvTTfdPwFrNcqaciALDhmKLSdnZhLqDI5
         ggsroPIN9P+KTejLqbUurMShKamHwRYf7pe6Hc5lksI70uK18ohSl4+/E6HDsSt7gt36
         uDkC6mDKzUIF/0e7zAthnfR+/vryNofT/kYKNZjjPj6VF3KNVoWLTuB4rl8eln3kRmPu
         3E8YXLwtTwmbWZEPSLXPA/U5TDza95gIVvQhu67cHRjkZMNewuymR7SdGjngwZE6uOCB
         NwgQ==
X-Gm-Message-State: AIkVDXICD0XGik+wnS06FWm40mWCoDk5dm4b9kIaAFZPqYkAts6N/1Qn/8jTRGKTug0W8g1dANNv8U/y4BLAeg==
X-Received: by 10.46.69.215 with SMTP id s206mr2581617lja.26.1484773512187;
 Wed, 18 Jan 2017 13:05:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 18 Jan 2017 13:04:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701181340530.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-6-jacob.e.keller@intel.com> <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org>
 <CA+P7+xrmAmCPOzuaKcm+WxceXnowkM4gKz05tSpdC=CDwpCEug@mail.gmail.com>
 <5c8401ef-9609-f235-9228-be980a13edf1@kdbg.org> <CA+P7+xq1LMkRG_aSyamrsPUQE+rDv4A9Qd19tDMgx-_a5OHsqQ@mail.gmail.com>
 <97d4105c-0fa6-41c5-e456-30cebd93dc36@kdbg.org> <CA+P7+xqFHG52Xo8ncUwa3owDn3OOz+rr3ZaGwfcUDCiXJmh80Q@mail.gmail.com>
 <alpine.DEB.2.20.1701181340530.3469@virtualbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 18 Jan 2017 13:04:51 -0800
Message-ID: <CA+P7+xp6c_3gTWiSrZHuXrpeZxYPguYBaBOT+uwKwATx4+1npw@mail.gmail.com>
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 4:44 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Tue, 17 Jan 2017, Jacob Keller wrote:
>
>> On Fri, Jan 13, 2017 at 1:31 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > Am 13.01.2017 um 07:57 schrieb Jacob Keller:
>> >>
>> >> On Thu, Jan 12, 2017 at 10:43 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> >>>
>> >>>  When you write
>> >>>
>> >>>   git log --branches --exclude=origin/* --remotes
>> >>>
>> >>> --exclude=origin/* applies only to --remotes, but not to --branches.
>> >>
>> >>
>> >> Well for describe I don't think the order matters.
>> >
>> >
>> > That is certainly true today. But I would value consistency more. We would
>> > lose it if some time in the future 'describe' accepts --branches and
>> > --remotes in addition to --tags and --all.
>> >
>> > -- Hannes
>> >
>>
>> I am not sure that the interface for git-log and git-describe are
>> similar enough to make this distinction work. --match already seems to
>> imply that it only works on refs in refs/tags, as it says it considers
>> globs matching excluding the "refs/tags" prefix.
>>
>> In git-describe, we already have "--tags" and "--all" but they are
>> mutually exclusive. We don't support using more than one at once, and
>> I'm not really convinced that describe will ever support more than one
>> at a time. Additionally, match already doesn't respect order.
>
> I agree that it would keep the code much simpler if you kept the order
> "exclude before include".
>
> However, should you decide to look into making the logic dependent on the
> order in which the flags were specified in the command-line, we do have a
> data structure for such a beast: we use it in gitignore and in
> sparse-checkout, it is called struct exclude_list.
>
> Just some food for thought,
> Johannes

That might help make it easier to go this route. I'll take a look.

Thanks,
Jake
