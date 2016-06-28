Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8CB2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 16:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbcF1QB0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:01:26 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36383 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbcF1QB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 12:01:26 -0400
Received: by mail-it0-f47.google.com with SMTP id a5so96014689ita.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 09:01:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2aobmSK6ULXiDj0gtwkODbZECfsFx2a1I2PpBI2DV+4=;
        b=optzP2M9tr9UIBZS1yLkKMEfwIpoUmZYblkSTCoptPbWCuzmYtNJRpx3VYiHtYf+pn
         mVSKhyU7msOVUb/fx0QC9LIbODQSrdXytRIWP61oxI1Y5Vr7ZD+Fk+TUHFjOUp66kweB
         0+TV33f74l1gbFyg1GsKK3Btk+v4bq1AHXCGovG14w26HS8C0r/Zipnxi2zUPF8Nl9sU
         YBJDvmj5QU+jqSe0tSq228NMEwybOUova5cEwlkCUzfQq++AIe3CknBr7vkVyWvuIt68
         R/J5tiBbDvmSpayUXJj+6AkyVQl/QMuUiLHtJq8fJxItDE0Xd9H2/aFo948LckfVuGqj
         2HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2aobmSK6ULXiDj0gtwkODbZECfsFx2a1I2PpBI2DV+4=;
        b=jL4hR1ZoYeIUamFgMKrd1s2OVUS4lOSk2aFJXZipiqRbiMFdJGz9rgSB1DYAZ6I3+X
         ACS3sletDiBxeFPOhXoktACbia2XfqVU3/9dJ1WcUOkWe4gu0lArZTBpYwmPptR8Kvf1
         m52wiio3tu9hQJKl022o4fUlcBlJYEqmeEJ1xQsUHmo7BHzOcUt7t8FLqie/ivpQRkZo
         /LMOKxkjbJIm2OoDSx4+snTtk1RtZs0RPljuPn32F57OQvEjuDtc+gtc7XT+/rZHSU4b
         6eDFGhPzKlxvDQwkC9ri3AkmjiSMpEtYmkdg/Vvf0dlFBCaEFlGBLmvPm14mzsSA3kGD
         xerA==
X-Gm-Message-State: ALyK8tKHrarRBpUJPt7RxGm/vWvgzfh6Hr1p4j19/IPo/HVdLQWDKLC0MQLcr1WoGUGNJnzt5HK6fGPfm2Yslg==
X-Received: by 10.36.43.5 with SMTP id h5mr16086914ita.57.1467129672671; Tue,
 28 Jun 2016 09:01:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 28 Jun 2016 09:00:41 -0700 (PDT)
In-Reply-To: <5491DA7A-4B1E-4015-879F-F01FF7481143@gmail.com>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
 <CACsJy8B7ie_oQRZ7Pw3NTo4YyXwZOer-iDUVxDPSY_uhrQi1bw@mail.gmail.com>
 <alpine.DEB.2.20.1606281139490.12947@virtualbox> <CACsJy8DCovHoutyEYwaxdCTU4K-h8u_JTOwt8GUiNTkkXzGz3w@mail.gmail.com>
 <alpine.DEB.2.20.1606281513380.12947@virtualbox> <5491DA7A-4B1E-4015-879F-F01FF7481143@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 28 Jun 2016 18:00:41 +0200
Message-ID: <CACsJy8AVSa+=PgYwPAx3HmFJ3Gb51K9TJxtGSQjZWTH=DazvLA@mail.gmail.com>
Subject: Re: [RFC] Native access to Git LFS cache
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	technoweenie@github.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 3:43 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 28 Jun 2016, at 15:14, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>
>> Hi Duy,
>>
>> On Tue, 28 Jun 2016, Duy Nguyen wrote:
>>
>>> On Tue, Jun 28, 2016 at 11:40 AM, Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>>
>>>> On Mon, 27 Jun 2016, Duy Nguyen wrote:
>>>>
>>>>> On Mon, Jun 27, 2016 at 7:38 AM,  <larsxschneider@gmail.com> wrote:
>>>>>> ## Proposed solution
>>>>>> Git LFS caches its objects under .git/lfs/objects. Most of the time
>>>>>> Git LFS objects are already available in the cache (e.g. if you
>>>>>> switch branches back and forth). I implemented these "cache hits"
>>>>>> natively in Git.  Please note that this implementation is just a
>>>>>> quick and dirty proof of concept. If the Git community agrees that
>>>>>> this kind of approach would be acceptable then I will start to work
>>>>>> on a proper patch series with cross platform support and unit
>>>>>> tests.
>>>>>
>>>>> Would it be possible to move all this code to a separate daemon?
>>>>> Instead of spawning a new process to do the filtering, you send a
>>>>> command "convert this" over maybe unix socket and either receive the
>>>>> whole result over the socket, or receive a path of the result.
>>>>
>>>> Unix sockets are not really portable...
>>>
>>> It's the same situation as index-helper. I expect you guys will
>>> replace the transport with named pipe or similar.
>>
>> Yes, I will have to work on that. But I might need to ask for a change in
>> the design if I hit some obstacle there: named pipes are not the same at
>> all as Unix sockets.
>>
>> Read: it will be painful, and not a general solution. So every new Unix
>> socket that you introduce will introduce new problems for me.
>
> Thanks Duy for your suggestion. I considered a daemon, but a daemon makes
> it always harder for the user as the user needs to ensure the daemon is
> running! Plus, Dscho's concerns regarding Windows.
>
> I think the core problem is that we invoke the filter for every file:
> https://github.com/git/git/blob/master/convert.c#L461-L475
>
> Couldn't we start the filter executable at the beginning of the Git process
> and communicate with it via stdin/stdout whenever we hit the Git filter
> code? Would that work?

Yeah if one filter process per one git process still brings
significant perf. gain for you, why not, it's simpler than daemon.
Though you may want to look at Christian's external odb first in the
other mail. Note though that external odb may still spawn process a
lot (because the design is you cache objects locally once and you
don't have to spawn again). Whether that fits in lfs scheme, I have no
idea (I have never used git-lfs myself).

> Alternatively, do you see a way to add a "plugin" system to Git? Where Git
> could be configured to dynamically load a "filter" library?

I don't think plugins as .so files are welcome because it would force
us to freeze some ABI. So far all git extension has always been via an
external process.
-- 
Duy
