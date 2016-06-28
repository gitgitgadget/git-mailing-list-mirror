Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D972018A
	for <e@80x24.org>; Tue, 28 Jun 2016 13:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbcF1NMP (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 09:12:15 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33024 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbcF1NMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 09:12:14 -0400
Received: by mail-io0-f196.google.com with SMTP id t74so2061632ioi.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 06:12:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UiYayleSc/7rxwkVdXIIaFIUh+B0vao/Zc6AxipUKJk=;
        b=Jpu4Nt3ILCbbIDJfwr4AKGJbBm2BGrHkMg/zlDdtVKeq5X+Nf7k+pMranIE2HbpNkU
         RK9jsPICfzgjtsn9PQOV5b5hr3MuiyXhzQZrJeLHbPZ7uMulnUG5iaATvRevnPJlEgqb
         BZt7Y1+0GaNhPZKlp6YUxxHaAZ6fiePGrcbOC362xjjudo3Vlbsp7aJZtUNvTUdPDln3
         TJH2RTUvXtFJzHwstJIYEgCJbphwjdsFQZB57uOFw5tPS2bkdlCb/W1y/BcoDWOBFdHg
         WOQDcKKeQoqRb6Q+pP3XNseuzCFS2/E3k/4zmlHowrwJ8NJFpC4TNnx7Sw0U0g5It2QJ
         PUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UiYayleSc/7rxwkVdXIIaFIUh+B0vao/Zc6AxipUKJk=;
        b=Y/v/K2p/Oh6dAqkbOwmz4WCR4xbV1dewXDvUFxtoVNeCR68WiUng0hLhLH04v1GJKD
         xWDB2Om13bRHoJC7ZOAZrPkOXeZiZX5twCgDxtmAaIYat3n0JY/HWgJpDj1Mf3q8r7FJ
         icC9c9TKgo61srK62WckfsBZeH9YwdnvRVDMc/K5cZ1ytUnLrdyHUtD6jYGQI0aE6ttu
         CgYxtjVS2/+5mzOx332JRAFpaIGtGmDseaSFHFjm0f7QRFByktrYL6SfcOP4SgKFLnVH
         gZr01InqC6r4QkR9Uw62VWREkZhNty9wWy3Wm606uKTJli11Jf20vkK/V2TTNNl/bwps
         rwaQ==
X-Gm-Message-State: ALyK8tL/MKDxHXdUuSTLKUXgQscRu99B9GvbjMtPPEZlW6rNgybIUvvZ09RYjha1qjNNBGMTeow/nbLzw/bwkw==
X-Received: by 10.107.8.220 with SMTP id h89mr3511535ioi.95.1467119533105;
 Tue, 28 Jun 2016 06:12:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 28 Jun 2016 06:11:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606281139490.12947@virtualbox>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
 <CACsJy8B7ie_oQRZ7Pw3NTo4YyXwZOer-iDUVxDPSY_uhrQi1bw@mail.gmail.com> <alpine.DEB.2.20.1606281139490.12947@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 28 Jun 2016 15:11:43 +0200
Message-ID: <CACsJy8DCovHoutyEYwaxdCTU4K-h8u_JTOwt8GUiNTkkXzGz3w@mail.gmail.com>
Subject: Re: [RFC] Native access to Git LFS cache
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 11:40 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Mon, 27 Jun 2016, Duy Nguyen wrote:
>
>> On Mon, Jun 27, 2016 at 7:38 AM,  <larsxschneider@gmail.com> wrote:
>> > ## Proposed solution
>> > Git LFS caches its objects under .git/lfs/objects. Most of the time
>> > Git LFS objects are already available in the cache (e.g. if you switch
>> > branches back and forth). I implemented these "cache hits" natively in
>> > Git.  Please note that this implementation is just a quick and dirty
>> > proof of concept. If the Git community agrees that this kind of
>> > approach would be acceptable then I will start to work on a proper
>> > patch series with cross platform support and unit tests.
>>
>> Would it be possible to move all this code to a separate daemon?
>> Instead of spawning a new process to do the filtering, you send a
>> command "convert this" over maybe unix socket and either receive the
>> whole result over the socket, or receive a path of the result.
>
> Unix sockets are not really portable...

It's the same situation as index-helper. I expect you guys will
replace the transport with named pipe or similar.
-- 
Duy
