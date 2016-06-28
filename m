Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3189C2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 15:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbcF1Pup (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 11:50:45 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33527 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbcF1Puo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 11:50:44 -0400
Received: by mail-io0-f196.google.com with SMTP id t74so2482119ioi.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 08:50:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uq3LHeowp6+76QISCAyTF8qvrlUZlB2UBV3NvG41q3c=;
        b=03pl3zmp28dmh1jHpEJn6CkyOnhKiYlVm7kBJTPiqykEy7I6FjEkmW1GwckTtzkL1r
         Lwz7SuVHyg7VW4gd0r2be+sez5IHaim4EId8q1t1K29IXaHte1Ca363wN9TWOLTC0kN4
         kQPTdOACYWatuoWFBAytPD1HBFW/zOGFlraawkC6naNJstV7L33HBwuE0BA0emmxmpZG
         Co9onWHRl6sVEqHicjK9Tzz3D85Q9UHaPkOg6BdDOF3RgDrmtV0twBDWkub3u2xWOPbT
         FXJfFhHo27fUFWSmGRAGKw3yrGLgHTGEYUjQJdcPNtT1Y5oqPFNxZvK/O7TuMwiidiw2
         IPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uq3LHeowp6+76QISCAyTF8qvrlUZlB2UBV3NvG41q3c=;
        b=U/glQqr71CZOXvIHMXUT/4vwfyQZ54Eif4g+fp6dYE/BTrZtU3AuK/Pt9FFzPbg/z1
         MSYfmD2EWz5efs4ggqBHjoPiB3hdN/QMT2ayhqavKne2YB6U8LmlFKHYpVXQpVy8SMXG
         idtIYErc2Bxn7q8hpXEauRfUiYZ8TN8HRhuL5GeNjdxYqVDlOyGm075v2ex2rHvIVqtr
         JWzpXPWSjmHABzMZYKFpvxRbTdVltzXIWSg0RHS7aveu/ss5QYfY/zydxZuL+Yu449YO
         12oS9awrCzg4pgB6d/3RobCMhYjziXPa8+FKY9AzA3OBSKTdBGLLlBE8cWyi+jLNoEWF
         fVQA==
X-Gm-Message-State: ALyK8tJF2KqgJio8u5oF01PJCcDcAoYRKlHc7y6VYxpOIta6Y82SEE3aA5Vs720gbgjyIjtLA8Arlw/XFDs0tg==
X-Received: by 10.107.159.16 with SMTP id i16mr4112132ioe.29.1467129043990;
 Tue, 28 Jun 2016 08:50:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 28 Jun 2016 08:50:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606281513380.12947@virtualbox>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
 <CACsJy8B7ie_oQRZ7Pw3NTo4YyXwZOer-iDUVxDPSY_uhrQi1bw@mail.gmail.com>
 <alpine.DEB.2.20.1606281139490.12947@virtualbox> <CACsJy8DCovHoutyEYwaxdCTU4K-h8u_JTOwt8GUiNTkkXzGz3w@mail.gmail.com>
 <alpine.DEB.2.20.1606281513380.12947@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 28 Jun 2016 17:50:14 +0200
Message-ID: <CACsJy8BLhO3R=8rAqLwAXc3LGLVVr4KGtWOm4MAh7bKDMn+uPw@mail.gmail.com>
Subject: Re: [RFC] Native access to Git LFS cache
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 3:14 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Tue, 28 Jun 2016, Duy Nguyen wrote:
>
>> On Tue, Jun 28, 2016 at 11:40 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Mon, 27 Jun 2016, Duy Nguyen wrote:
>> >
>> >> On Mon, Jun 27, 2016 at 7:38 AM,  <larsxschneider@gmail.com> wrote:
>> >> > ## Proposed solution
>> >> > Git LFS caches its objects under .git/lfs/objects. Most of the time
>> >> > Git LFS objects are already available in the cache (e.g. if you
>> >> > switch branches back and forth). I implemented these "cache hits"
>> >> > natively in Git.  Please note that this implementation is just a
>> >> > quick and dirty proof of concept. If the Git community agrees that
>> >> > this kind of approach would be acceptable then I will start to work
>> >> > on a proper patch series with cross platform support and unit
>> >> > tests.
>> >>
>> >> Would it be possible to move all this code to a separate daemon?
>> >> Instead of spawning a new process to do the filtering, you send a
>> >> command "convert this" over maybe unix socket and either receive the
>> >> whole result over the socket, or receive a path of the result.
>> >
>> > Unix sockets are not really portable...
>>
>> It's the same situation as index-helper. I expect you guys will
>> replace the transport with named pipe or similar.
>
> Yes, I will have to work on that. But I might need to ask for a change in
> the design if I hit some obstacle there: named pipes are not the same at
> all as Unix sockets.
>
> Read: it will be painful, and not a general solution. So every new Unix
> socket that you introduce will introduce new problems for me.

I thought we could have a drop-in replacement (or maybe a higher
abstraction that would be sufficient for git). Thanks for pointing it
out.
-- 
Duy
