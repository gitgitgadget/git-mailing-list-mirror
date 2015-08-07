From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 7 Aug 2015 16:12:02 -0700
Message-ID: <CAGZ79ka8nr54P3100roRt8aGScx2a=xQM=c2P3aKkntMc+6ihQ@mail.gmail.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	<xmqq614qyebl.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZx=ML-tT6vvjynZ91x6JYqpgKVaEp-Q43MShz0J2EanQ@mail.gmail.com>
	<xmqq1tfeyc6p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 01:12:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNqo8-00038L-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 01:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946429AbbHGXMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 19:12:05 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35679 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946324AbbHGXME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 19:12:04 -0400
Received: by ykcq64 with SMTP id q64so95490000ykc.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6WjjyhmmVqRyvgmCTTvIB26p8Hes7ZgBoNCTz0qfYZ8=;
        b=mwiaVQf4X6aLC2V+204Ud/1eQQF8OaPPs7pCtqld5EcGOreR5rgyqU5LbnyKmOotGv
         ZjcK1uoZMxkwVYsw+tZp+g1cZhWKldcZ3S7g4mg/qLFA9vjhGXcTeKgUkglt/8ufSs+K
         goQutQ0DYc5vhzP1F5pJz7UADbX++uNonh4WiKabpzAge8PSbfubZ805ZTFJkd75nJs5
         CjvSKEXuAxpI1Lpk/Gks6bfeJIXQG+e63Za/3ZBawAps4wvM5rZLAQ/QcLklLrgtLVWz
         WxPHRgoUdjsMz87qClVLCReTGZzI7VyYJqASnDaYhIabDxXh4XBjlClXGkRl6O9lYrt9
         x6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6WjjyhmmVqRyvgmCTTvIB26p8Hes7ZgBoNCTz0qfYZ8=;
        b=Ab30aYPQs7gVO/KMavULMP0hNlsFFTDIOBPGc6s33sKN4vZ9JXfbmItIe/dXFSWsos
         hSekAwKOuchZIjW1PvNWiQ5MzxUMw5IUd078i+M7t/GPl+hoBcx6nMxFm97FO2nzvrx6
         Rzgj5GwAT5Jo5z53u2rt772WY3NXv5c/90tlQrD1uheNRROpqzypiXH/FGnmuWBv0haF
         k9x7ZMUNGDNrA7PQ2hRMghDhxkN1EOrtU/fnucFX2CH5y+QZSHRASV6m4+9pb1QW87ej
         UwQ07DssvfipAWNixjDyaZAXlUEOo0PkpCUGMbBtAuu2QPPGcyAVw1zvUoN78rDLhfSK
         4V7A==
X-Gm-Message-State: ALoCoQlesEv+rb/yhRZtQsHmOuBQ/M9ny/Rsh0JhHIFronb56moM2NgA8YdT6WPV4mVAuMzx6ER3
X-Received: by 10.129.116.134 with SMTP id p128mr10306793ywc.1.1438989122914;
 Fri, 07 Aug 2015 16:12:02 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Fri, 7 Aug 2015 16:12:02 -0700 (PDT)
In-Reply-To: <xmqq1tfeyc6p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275499>

On Fri, Aug 7, 2015 at 3:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Aug 7, 2015 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>>> If we followed what you just said, that patch will try to directly
>>>>> read the data in config_name_for_path string list, which is removed
>>>>> by Heiko's series, if I am reading it right.
>>>
>>> By the way, the above is more important part of the message you are
>>> responding to.  The result does not simply link, because your
>>> unsorted_string_list_lookup() will no longer have the string list in
>>> the first place X-<.
>>
>> I looked through Heikos series and think it is an improvement. I mean I
>> can redo my patches on top of his. Specially this patch will be easy,
>> as patch 2/4 (extract functions for submodule config set and lookup)
>> implements get_name_for_path. All I would need to do then is expose it
>> to the shell via the helper.
>
> Yes, that is exactly what I said a few messages ago, wasn't it?

Yes, you did. I needed to repeat it to actually mentally process it.

>
> But that would require that you read and understand Heiko's work and
> that you understand what its future direction should be, communicate
> that vision to others to share, before building on top of it.  And
> with that effort, you would already be in a good position to polish
> Heiko's stalled work and move it forward.  After all, you cannot
> just build on a stalled work, declare "my part is done; the result
> is not mergeable because the foundation is not cooked, but that is
> not my problem" ;-).

That would be an easy world to live in, but I agree that I should get the
fundamentals right.

>
> IIRC, the issues around the topic were nothing show-stopping, but
> the primary reason it stalled was that Heiko got busy with his other
> obligations, so I'd appreciate others like you to help the topic
> move forward.

Ok, I'll dig up the old reviews and review it myself before continuing
on my patches.

>
> Thanks.
>
