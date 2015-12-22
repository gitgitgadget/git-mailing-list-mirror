From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 22 Dec 2015 15:27:34 +0700
Message-ID: <CACsJy8AF-7ULixapHmTtCia9x0HTtJ1nmnAER9A3BeLVjQM_Mg@mail.gmail.com>
References: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com> <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
 <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com> <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
 <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com> <20151216024605.GA618@sigill.intra.peff.net>
 <xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com> <xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
 <20151217074443.GA4830@sigill.intra.peff.net> <CACsJy8BwARfGmGBXEdWHnDxxXcubZDzjCg7Zy6qD0qzHZWGoFw@mail.gmail.com>
 <xmqqy4cnfyds.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 09:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBIIo-0005k1-8P
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 09:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbLVI2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 03:28:07 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35134 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbLVI2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 03:28:06 -0500
Received: by mail-lb0-f179.google.com with SMTP id bc4so27244521lbc.2
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0Of7Uoj9XJ1f6BZuMXF4GQJYuucOcwRsdTeIleHxnak=;
        b=0yz0YMPVHMd5QjrACxCKADpfUtswCqfBhm1gZezu10UL0qlIcPuLI0aa66DZ5vtCOY
         NDJAaHtTkh7lh9IAcytuKfz6EtUejqJwyvSfRqEWJmn6WjGrIcNG+aiuV4eRHsmW8zmK
         754MrTlcWbx0CzoqR86osl8AKaFKdAUCwmBLE+7w+nnCKpGAC1FB7rhq/9tsZdfU3WUB
         0ybIOzUSbF0OMSBlbuE2jduz4wVb0NfsEZZ9+G6DEygTjRhyOQZhfGEpQOM7NMfb1VDN
         hgsg5tpXbw+FC2s7upv/pLFUB3Iw1SGqMUbBBjwZeNK/ZwjyFBDsA8LOY6ALTtSyuFdc
         6faQ==
X-Received: by 10.112.134.169 with SMTP id pl9mr7632354lbb.145.1450772883891;
 Tue, 22 Dec 2015 00:28:03 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 22 Dec 2015 00:27:34 -0800 (PST)
In-Reply-To: <xmqqy4cnfyds.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282835>

On Tue, Dec 22, 2015 at 1:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Dec 17, 2015 at 2:44 PM, Jeff King <peff@peff.net> wrote:
>>> I think we may actually be thinking of the same thing. Naively, I would
>>> expect:
>>>
>>> ..
>>>   - if there is cache data in the index but that config flag is not set,
>>>     presumably we would not update it (we could even explicitly drop it,
>>>     but my understanding is that is not necessary for correctness, but
>>>     only as a possible optimization).
>>
>> No, if somebody adds or removes something from the index, we either
>> update or drop it, or it's stale. There's the invalidate_untracked()
>> or something in dir.c that we can hook in, check config var and do
>> that. And because config is cached recently, it should be a cheap
>> operation.
>
> Checking the config may be cheap, but it bothers me a lot that we
> have to call that "invalidate" thing every time we go into the
> codepath to deal with the index, from code cleanliness point of
> view.

In that case we can just check config once in read_index_from and
destroy UNTR extension. Or the middle ground, we check config once in
that place, make a note in struct index_state, and make invalidate_*
check that note instead of config file. The middle ground has an
advantage over destroying UNTR: (probably) many operations will touch
index but do not add or remove entries. Though I may be wrong,
replacing an entry may be implemented as delete then add, I haven't
checked the code.
-- 
Duy
