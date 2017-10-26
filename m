Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A66F1FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 09:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdJZJMz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 05:12:55 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:45567 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdJZJMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 05:12:54 -0400
Received: by mail-vk0-f53.google.com with SMTP id q13so1705122vkb.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F5GZPgW1WR4/Qqr4DmkAS3rs7pFS6DJbo8jJXum7MgY=;
        b=fr2ppH/YbV/EzWMD7qAJKVLpDJjN3fHcJ0JDqbxtSC5R7Isa7K13HDV1FITZz2EkS0
         BgFEf3Dwi1XEdli89RfoAxFx3yvu/Nhl37q+4MT+a653pNPVjVfEEvP3sCQznoH2X6Zn
         p0Q4l+eRvzrjRmV4IAYWbJ0rGGwjVwyJCGhJMudQz+KexUeY94ESXBHagPLrTDHbypty
         DLMz1JXihurcvnIHp0aqLFlsYgi5tYbxG0bw4eb6VAH0fMfDjQw811496EPwtLKxqx9c
         D4YFuggDRMC59F1ZkVFYAJsPrOdbFgh/LRKpRM3y48sExo4efsysWtjsCaQCX4smsFjq
         /R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F5GZPgW1WR4/Qqr4DmkAS3rs7pFS6DJbo8jJXum7MgY=;
        b=PcHRM+Z9lxIvr7HEAvBauaOde3lMbmyCD8bc3gtYboUMU/NRuP340cp5VXhlSTTCBZ
         Hbn4SvGHQoAxwHJSnPYr1LAKSZTlRvm0UieXJkTe+wPfMM22k3D2mr038Bh7Q79mcyTv
         NrxtVH1OQlEXT4/nIUseRoRND2yme6WzSaGXuGc49duF0jP1XVxeweKg394KJk4MIccw
         0sK+bVh9ZP3mFaP0mnMNfrxIAPGa/sLJPAijfQg0Jslrrct67hRt7leBGrOmVW88IEsD
         Zzo1b+SeGx0RxtAqpBoHkGjN30BpoNjqd5evaV+IE18221QvBCDVxDossAnZJ8hjiBnA
         kjKQ==
X-Gm-Message-State: AMCzsaU/zW53G5jnj33cxedcwsXXHYK00Vr5h1lyq+5bVF1cIvj4fVRk
        Aytjhk6B3iMJMQbGN10p/+j0VEw8FxeGnaqCRDgqFQ==
X-Google-Smtp-Source: ABhQp+Qs2GtcXx5VH7cXoxMppRD8qNnCPIyl1gNGqGt7rt5RmXEARxgojahIY0wZVWE9g28BBjExuW6ghRWbg9I+mH0=
X-Received: by 10.31.129.133 with SMTP id c127mr3352889vkd.22.1509009173323;
 Thu, 26 Oct 2017 02:12:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.30.139 with HTTP; Thu, 26 Oct 2017 02:12:52 -0700 (PDT)
In-Reply-To: <CA+P7+xpcC7Daw5k3=XFyZRsqiBib6yY2YzLpjYfcS7yqfUzTpg@mail.gmail.com>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
 <alpine.DEB.2.21.1.1710260008270.37495@virtualbox> <xmqq4lqmfoy7.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpcC7Daw5k3=XFyZRsqiBib6yY2YzLpjYfcS7yqfUzTpg@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 26 Oct 2017 02:12:52 -0700
Message-ID: <CAGyf7-EjKaHgwkN9trO4mFvba9odbWCzA9Jh0Pk6ZE6FOskOYg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 2:07 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Oct 25, 2017 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> Note that the correct blib path starts with `C:\BuildAgent\_work` and
>>> the line
>>>
>>>       use lib (split(/:/, $ENV{GITPERLLIB}));
>>>
>>> splits off the drive letter from the rest of the path. Obviously, this
>>> fails to Do The Right Thing, and simply points to Yet Another Portability
>>> Problem with Git's reliance on Unix scripting.
>>
>> In our C code, we have "#define PATH_SEP ';'", and encourage our
>> code to be careful and use it.  Is there something similar for Perl
>> scripts, I wonder.
>>
>> I notice that t/{t0202,t9000,t9700}/test.pl share the same
>> split(/:/, $ENV{GITPERLLIB}); forcing this specific variable to use
>> the non-platform convention to accomodate the use of split(/:/)
>> certainly is a workaround, but it does feel dirty.
>>
>> It is hard to imagine that we were the first people who wants to
>> split the value of a variable into a list, where the value is a list
>> of paths, concatenated into a single string with a delimiter that
>> may be platform specific.  I wonder if we are going against a best
>> practice established in the Perl world, simply because we don't know
>> about it (i.e. basically, it would say "don't split at a colon
>> because not all world is Unix; use $this_module instead", similar to
>> "don't split at a slash, use File::Spec instead to extract path
>> components").
>>
>
> I thought there was a way to do this in File::Spec, but that's only
> for splitting regular paths, and not for splitting a list of paths
> separated by ":" or ";"
>
> We probably should find a better solution to allow this to work with
> windows style paths...? I know that python provides os.pathsep, but I
> haven't seen an equivalent for perl yet.
>
> The Env[1] core modules suggests using $Config::Config{path_sep}[2]..
> maybe we should be using this?

I was testing this recently on the Perl included with Git for Windows
and it returns : for the path separator even though it's on Windows,
so I don't think that would work. The Perl in Git for Windows seems to
want UNIX-style inputs (something Dscho seemed to allude to in his
response earlier.). I'm not sure why it's that way, but he probably
knows.

Bryan

(Pardon my previous blank message; Gmail fail.)

>
> Thanks,
> Jake
>
> [1] https://perldoc.perl.org/Env.html
> [2] https://perldoc.perl.org/Config.html
