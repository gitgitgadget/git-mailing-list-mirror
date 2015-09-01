From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] date: make "local" orthogonal to date format
Date: Tue, 1 Sep 2015 15:41:20 -0700
Message-ID: <CAPc5daWEH2UtFHe_2+2SChgMd-TcYPsA0oJFZJjw539WRS6oSQ@mail.gmail.com>
References: <20150901083731.GE30659@serenity.lan> <cover.1441144343.git.john@keeping.me.uk>
 <35b1313d4eb084ddc2bd70510d56e11a1d84e993.1441144343.git.john@keeping.me.uk>
 <xmqqwpw9pyy5.fsf@gitster.mtv.corp.google.com> <20150901223308.GI30659@serenity.lan>
 <20150901223959.GG7862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:41:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWuFQ-0001rb-OQ
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbbIAWlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:41:42 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32934 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbbIAWlk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:41:40 -0400
Received: by igbkq10 with SMTP id kq10so12708344igb.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5h6we/hwF1cMotXGLciSW8ZiADzhYbAJ1s9qtfdRwH0=;
        b=eTouJA9VTeLXaMmsXzbEFGPksd+SmXv2qzyAfqpG5uaXvwcv4hhzDDRc0kH1pN9GJJ
         7RBXgsA0IzrfuJJ0+vB6bVTTHnkpBYkY/46PtUDdxC9tWYuuLRRYygWTWbLe+u67vNYG
         ++warUi532Vf7rvHT+n0OEoZKt7tXlihHfVIM2oIh6JsEkJNSr7yz72MZ73S3lHzI/Ww
         82rBPaoBXe/akniscGiiefJBPKF3FMFAW9JEEpcesbOae+MV9+TxlnfqDS6cXkLSmYKV
         T138USlC38WNDzI8l4T4pebV7RmSCJBwhIsVFOjtPWrhC1Bsc4wND8coh++ZZtOXpn0l
         Eg4g==
X-Received: by 10.50.64.147 with SMTP id o19mr566814igs.37.1441147299869; Tue,
 01 Sep 2015 15:41:39 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Tue, 1 Sep 2015 15:41:20 -0700 (PDT)
In-Reply-To: <20150901223959.GG7862@sigill.intra.peff.net>
X-Google-Sender-Auth: 5fIs5Y7ZaZiK7s_yoKwn69Te-u4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277068>

OK by me. Thanks, I also forgot that need for preparatory code movement.

On Tue, Sep 1, 2015 at 3:39 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 01, 2015 at 11:33:08PM +0100, John Keeping wrote:
>
>> > Even in --date=raw, we do show the timezone offset, so I do not
>> > necessarily agree that raw-local is nonsensical.  That's the only
>> > difference between the one I queued yesterday and this one.
>>
>> I suspect it depends on the interpretation of "raw"; the code currently
>> interprets raw to mean "exactly what exists in the commit/tag", in which
>> case converting it to the local timezone is wrong.  But the
>> documentation describes "raw" as "the raw Git %s %z format", and if we
>> interpret it to mean "Git's internal date format" then "raw-local" makes
>> sense.
>>
>> The alternative would be the patch below as a preparatory step.
>
> Ah, right, I forgot that we need to refactor show_date() to actually do
> the right thing.
>
> I think I'd be in favor of just disallowing "raw-local", then.
>
> -Peff
