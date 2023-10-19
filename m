Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836E14F90
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45C4E8
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 11:07:20 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 0885DCA1283;
	Thu, 19 Oct 2023 14:07:18 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:d88a:cf14:49b7:60d0] (unknown [IPv6:2600:1700:840:e768:d88a:cf14:49b7:60d0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id C0E39CC8397;
	Thu, 19 Oct 2023 14:07:16 -0400 (EDT)
Message-ID: <573f1142-d1de-b379-2f8b-07396c1249ec@jeffhostetler.com>
Date: Thu, 19 Oct 2023 14:07:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Is there any interest in localizing term delimiters in git
 messages?
To: Junio C Hamano <gitster@pobox.com>, Jiang Xin <worldhello.net@gmail.com>,
 =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
 Jeff Hostetler <jeffhostetler@github.com>
Cc: Alexander Shopov <ash@kambanaria.org>, Git List <git@vger.kernel.org>,
 jmas@softcatala.org, alexhenrie24@gmail.com, ralf.thielow@gmail.com,
 matthias.ruester@gmail.com, phillip.szelat@gmail.com, vyruss@hellug.gr,
 christopher.diaz.riv@gmail.com, jn.avila@free.fr, flashcode@flashtux.org,
 bagasdotme@gmail.com, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=
 <avarab@gmail.com>, alessandro.menti@alessandromenti.it, elongbug@gmail.com,
 cwryu@debian.org, uneedsihyeon@gmail.com, arek_koz@o2.pl,
 dacs.git@brilhante.top, "insolor@gmail.com" <insolor@gmail.com>,
 peter@softwolves.pp.se, bitigchi@me.com, ark@cho.red, kate@kgthreads.com,
 "vnwildman@gmail.com" <vnwildman@gmail.com>, pclouds@gmail.com,
 "dyroneteng@gmail.com" <dyroneteng@gmail.com>,
 "oldsharp@gmail.com" <oldsharp@gmail.com>,
 "lilydjwg@gmail.com" <lilydjwg@gmail.com>, me@angyi.io,
 "pan93412@gmail.com" <pan93412@gmail.com>,
 "franklin@goodhorse.idv.tw" <franklin@goodhorse.idv.tw>
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
 <xmqqzg0gx6k9.fsf@gitster.g>
 <CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
 <xmqqwmvkve83.fsf@gitster.g>
 <CANYiYbEqTH975j9E0GTbSbexrw3MLhKwBCw7mibfnWbxZ+-_yw@mail.gmail.com>
 <xmqqcyxaxzxw.fsf@gitster.g>
Content-Language: en-US
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqcyxaxzxw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 10/19/23 1:52 PM, Junio C Hamano wrote:
> Jiang Xin <worldhello.net@gmail.com> writes:
> 
>> I tried to find similar patterns in `po/bg.po` using:
>>
>>      $ git  grep -h -B5 '([a-zA-Z_\.]*_[a-zA-Z_\.]\+)' po/bg.po
>>
>> And find other translated variable names in Bulgarian as follows:
>> ...
>> I suppose it would be better to keep those variable names
>> unchanged.
> 
> To me, all of them refer to names given to variables, functions, and
> mechanisms used internally as implementation details, and they are
> meant to help developers diagnose when end-users hit these errors.
> 
> I agree with you that translating these would be counter-productive
> for that purpose.
> 
> Having said that, I have to wonder if in an ideal world these should
> be written in terms that are more end-user facing.
> 
>>   * cookie_result in builtin/fsmonitor--daemon.c:
>>
>>     error(_("fsmonitor: cookie_result '%d' != SEEN"),
> 
> [jch: cc'ed JeffH for area expertise]
> 
> For example, what does it mean to the end user when the
> cookie->result we retrieve is different from FCIR_SEEN?  We lost
> sync with the fsmonitor daemon backend and to avoid yielding
> incorrect data we will be giving the "trivial" response only?  It is
> not obvious from the code and b05880d3 (fsmonitor--daemon: use a
> cookie file to sync with file system, 2022-03-25) that added it why
> the end-user might even want to be shown this message [*].  I wonder
> if this should be an untranslated trace2_* message that are meant
> for debugging.
> 
> 	Side note: and isn't the significance of the event
> 	    "warning", not "error"?  As far as the end-user is
> 	    concerned, after emitting this message
> 
> Also some of them might better be a BUG(), instead of die(_()).
...


Yeah, I think it should be an untranslated trace2 message rather
than an error.  You're right, the user cannot do anything with
that information -- and by emitting a "trivial" result, we fall
back to the normal behavior and cause the client to a regular
scan. So there is no reason to scare the user.

Jeff
