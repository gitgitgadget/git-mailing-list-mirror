From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Thu, 17 Dec 2015 19:36:31 +0700
Message-ID: <CACsJy8B2tFqhfKPE17cPpp1uDYPa4OTB9zLHPY0j2QF9zuxAtQ@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
 <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
 <xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com> <xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com> <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
 <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com> <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 13:37:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Xny-00014Z-0m
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 13:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbbLQMhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 07:37:04 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34211 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbbLQMhD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 07:37:03 -0500
Received: by mail-lb0-f175.google.com with SMTP id cs9so44113622lbb.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lC4hma0wkYWFHQ7nGly+h2Ifcv+WNcmnLCao9cMQFpM=;
        b=OTMo7eN71vIojse2EydohTe5jXO3oaf1Ww4Y4dDnS6dymPxUD1XhvtIV1XxEP11wvK
         eG1mJ67xigCKyyJxNblQ8WTItBEeEQVnP2KRSkKWQQhv9TvZOb1AvQI36M33XmNV6NWg
         msu91HFyuACd1iovxrnWBekg64lebhuZKA+IBCXwEUSt2JbLIzcjZJQj6yuqG1klURGE
         KZvQyl4BiL3wViWHf8vPeHaIoSwyFSSHa1zqmZg//Uv7l8yu2Eog2m8SIzf4Ocy8FuqN
         sXPXFnCfwjCzVbWLHhtG9uIdgeQwbQd3bD6T4CUyYhoPq043FGIQRUlVrK3V8wWxeFIb
         EnWg==
X-Received: by 10.112.134.169 with SMTP id pl9mr21044717lbb.145.1450355820945;
 Thu, 17 Dec 2015 04:37:00 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 17 Dec 2015 04:36:31 -0800 (PST)
In-Reply-To: <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282652>

On Wed, Dec 16, 2015 at 4:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Dec 15, 2015 at 8:40 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> I still have a problem with the approach from "design cleanliness"
>> point of view[...]
>>
>> In any case I think we already have agreed to disagree on this
>> point, so there is no use discussing it any longer from my side.  I
>> am not closing the door to this series, but I am not convinced,
>> either.  At least not yet.
>
> In general the fantastic thing about the git configuration facility i=
s
> that it provides both systems administrators and normal users with
> what they want. It's possible to configure things system-wide and
> override those on a user or repository basis.
>
> Of course hindsight is 20/20, but I think that given what's been
> covered in this thread it's been established that it's categorically
> better that if we introduce features like these that they be
> configured through the normal configuration facility rather than the
> configuration being sticky to the index.

A minor note for implementers. We need to check that config is loaded
first. read-cache.c, being part of the core, does not bother itself
with config loading. And I think so far it has not used any config
vars. If a command forgets (*) to load the config, the cache may be
deleted (if we do it the safe way).

(*) is there any command deliberately avoid loading config? git-clone
and git-init are special, but for this particular case it's probably
fine.
--=20
Duy
