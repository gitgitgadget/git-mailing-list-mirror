From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 4 May 2016 17:34:54 +0530
Message-ID: <CAFZEwPMOuDB-SrNGPp3D1yBSVLaEvbJujKa7PVKOBt8PqUvk0w@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
	<CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com>
	<alpine.DEB.2.20.1605041304050.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 14:05:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvY6-0005jQ-3i
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 14:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbcEDME5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 08:04:57 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34278 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbcEDMEz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 08:04:55 -0400
Received: by mail-yw0-f180.google.com with SMTP id j74so74417656ywg.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FM+tqrtMoEqHdgTQEdTsDKFh1Wl8S/q+Nnt6o94cNl4=;
        b=rPv+Ek5jIiKJJWaNGmJfSW9O/RHqEXfgxtumWkX96miRGpZQWy9Rfuz/yz9BrC7l+n
         7HEcDnOCGGcuLsRAZGSvCtEIDbA150Q7EwsCrLF6b5XRG1YqdWt20PyqRehtSSbOBH4b
         6jL3kt63L5ymN8dJ1ItB/+NWNgiyi95WM9X3Jr1XEXfnMh3kp3gfKMYz5uQwPC5u0Zs1
         sTzYZmPO7lwK0xC36GZ0K7Z42sf/AzqOgBKWG9YF+E0nucy0USs2HRGdkklsxX49HWwd
         iw8D9w3h2+R0eu/33+XqotXQiSn7VKpN3apqMbl83qEuUsVrOgcg28UGOxIUHyC4LAmN
         +lZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FM+tqrtMoEqHdgTQEdTsDKFh1Wl8S/q+Nnt6o94cNl4=;
        b=D8NDmIDRftTHt2gKZ8Zmw9jai2QYoAd5svk+uq8f1NrCgRQi6AfI3NCJz3hBNPgJyr
         Z/5nVXMSSBBN/PZ6+aMP7uu7c4kmo0+hEIcZoE0V2suvPGXAwjlk1xIQfGW8dk2leBET
         Ekg++RMzfEA7pXzKGj3zDBhR6E0iN+oNXnLs3eqGs1qqzJXzUapsDhlA2Dv4D0db6Fv7
         JImttDmmonnqhSckut6kziG9b05JBgvVwsYGuSZSvnQ8h6uKJolGwMDzBS5kmiOVD1Ov
         ldo1bMkcmmfamRsfNzXokkIMvl4lfWzxrl7kkyxEZXYqnGitmUgBUwoAVfIvsKp1yZeI
         8KaQ==
X-Gm-Message-State: AOPr4FUKlcfuFSocXa2NmJQ/Xxc9W7OjqwTMCPIDmxDnXV1bji4WpGmM8PvmLv4zRfs489fQM7q/+B34yv7Npg==
X-Received: by 10.13.198.5 with SMTP id i5mr5288248ywd.263.1462363494808; Wed,
 04 May 2016 05:04:54 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Wed, 4 May 2016 05:04:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605041304050.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293544>

On Wed, May 4, 2016 at 4:35 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Christian,
>
> On Wed, 4 May 2016, Christian Couder wrote:
>
>> On Wed, May 4, 2016 at 8:07 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> >> bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>> >
>> > This subject is too low-level, talking about implementation details,
>> > whereas it should be giving a high-level summary of the change.
>>
>> When a patch is all about a low level detail, I think it is good to
>> talk about the detail in the subject.
>
> Well, this is not the case here. The intent of this commit is to prepare
> for other command modes.
>
> So... why not just say "bisect--helper: prepare for modes other than
> 'next-all'"?

Sounds nice!

> Ciao,
> Dscho

Thanks,
Pranit Bauva
