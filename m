From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] strbuf: describe the return value of strbuf_read_file()
Date: Tue, 14 Jun 2016 11:27:54 +0530
Message-ID: <CAFZEwPPd_+9nFPCG51nr5s1XMs5SKXG3O3vbAZmxA-BHvZdFPg@mail.gmail.com>
References: <20160613202346.6473-1-pranit.bauva@gmail.com> <xmqqfusgbv0e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 07:58:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bChMO-0005T4-RH
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 07:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbcFNF54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 01:57:56 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34138 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbcFNF5z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 01:57:55 -0400
Received: by mail-yw0-f182.google.com with SMTP id c72so145705638ywb.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 22:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iwKDyBo8pChSBEqY+qtrdU34s6GqDjfHq9Vz4UtAlLc=;
        b=gIw1B1pNUrUJsACH/s13BTm3kYAzto+whKg3dhJMRQmvqN7IvPBqzRh/2d3a0/Vnf9
         s60x+VBfbsPYxrwOGxbss7QI/atjzUhgOVV8I9ohQ5n7T7BklMFUn/NNdauZyVIP+UDB
         iwuhROR0nsVPerCWfOWbMDpcaDmsws8x+GJ7EI2YDEqVedo2ofiNCrebuLuNVgj6ntpW
         XmlN9gOtOYFhttTQEl5SM/U5fF+PScSSYZeqLrgTwjfW/3aBQRgR87JxdY1Us6ptvHIT
         xAEscxnKYcmgNKiwMMmxis/5BHq+a4Q/OS/nkny1D4/UvMNAaitsxMNaMQIfHZOYVueE
         l5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iwKDyBo8pChSBEqY+qtrdU34s6GqDjfHq9Vz4UtAlLc=;
        b=buc7sjhkuHqnanT5lLiPRQeyslPsD+ZJ01wi43CRc+0Zg4XLqFbC65ZPrNdoogq0sd
         y135L1ZxFS4lfkr887Sw27uCCEmQ5I+qlf7n1boN9ZvW93uZlMGDEdTlY20PLHw92UWb
         eUDZ9UTkvPPDh8EfQB8u/VqjdXUXRKi9t0JxN/WURFWRt5Ay06A6Nw69BR7+oLgk4f3u
         9Q1UHYLfdPp1j55XUHlwT/CoYTL0l5ai7oZki01mXAufwZm+miO3qfAVKKXqfQDCFqhS
         vuWKGKoARdMT6Ugfg807/+gen2mrYlqELzxNrpyAUY0xZdKjheGWRt4E3Yz0dbQYYTzA
         zGdg==
X-Gm-Message-State: ALyK8tKk+tnYIm7/z1jndButSh8PWk3W+D9Pc3+HbHZcZ39w+O0TbFHlpfbX8UUxey0UNUxmIWtRwujvyfNTcw==
X-Received: by 10.129.50.83 with SMTP id y80mr877010ywy.305.1465883875073;
 Mon, 13 Jun 2016 22:57:55 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Mon, 13 Jun 2016 22:57:54 -0700 (PDT)
In-Reply-To: <xmqqfusgbv0e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297264>

Hey Junio,

On Tue, Jun 14, 2016 at 3:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> It is easy to be misguided on the return value of the function
>> strbuf_read_file(). It does follow the pattern of other standard functions
>> for reading files but its better to explicitly specify it.
>
> Good thing to do; I wonder if we want to explicitly say -1 or
> leave it at "negative values are errors", though (my knee-jerk
> reaction being "do not over-specify more than absolute minimum
> to write callers correctly").

Sure I will re-roll with specifying about negative values as errors.

Regards,
Pranit Bauva
