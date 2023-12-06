Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="sJcI3Iqj"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81591A2
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701872784; x=1702477584; i=l.s.r@web.de;
	bh=hvH8DV/HtanWUvRF3ZalrVEpqv4s5K0Hr2bW1Oy00jk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=sJcI3Iqj5asbKTMJ2UCon9rJPJ2zR59Q4DL0+JZAZeDfKmmlz+xpOSTEXsx15W+3
	 J9fyykZn4twm6Mo6yclmkwhPsATs3Gza86MT+r5s6sAYhxY8UdRAEDoByMZA4+QMr
	 k6v+PV6svZW361daPWV0XgDa8/u0vYrcDy1I8/5iojc64nXc4c/y3EhaITnURBdQM
	 fiuyK/h50c9t/xxHkSHiLvGM4fyTfuJBGMLdLsFBlIyIiOuQcnb4aRH/1+sJEPqoA
	 Jd8oN/B/QwSPngRYc9iuXC7A5iU/yiMJASnNOCLBzbzKvjUvJuyfp+PGrxVvNsSp0
	 cO92+tbQa44QDGzPnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sXj-1rCoBQ48rn-001o3V; Wed, 06
 Dec 2023 15:21:16 +0100
Message-ID: <389cd7b3-2350-4dc6-b282-e9d6e25fa68c@web.de>
Date: Wed, 6 Dec 2023 15:21:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] revision, rev-parse: factorize incompatibility
 messages about --exclude-hidden
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-5-l.s.r@web.de> <ZXByOXWo6cIy71s2@tanuki>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZXByOXWo6cIy71s2@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TKWmAXK6DkDtJDtmhiRHe6RgPZACPQTKPzFK73HQnjyznTbCxiO
 yf7MSxxWOBUdKjcqjdCKwRns6HG6CW/p/cmIZJKi8bcoAzjjtUg0XSV9XdwVbAJ17PwvO21
 NL/Nyu0F8I/iooI4aIpUQET5RRQvV6sQmWBFUYG8ikBAWFJK1rS85ZGf5TH4haQsSfsifqL
 Ru0LPeigle1HXYhcd50wA==
UI-OutboundReport: notjunk:1;M01:P0:M8COFHU1G1U=;KlIcXZHAYZN4E6i1iWz3ssWP13T
 yfVqPbJ6WuK4jy7HSMr0Q51KeS6nAfZnXz//H1t6EvQAHYaV0TxZ9MK5LdOmbX7szF6HY2cyV
 mElS7G63Tcb+K10ALAaucvSiVQGUlWRUAwcUGOq3ucnv+HgS3RspdVKgOuQHWOh9erlBETm0g
 igZe6Aeb638EFaWfSRn4oYIN3MvJ1cKEVjM4GqQKNj9+5z6u1T3MXH3EI3V8pskPaVgezqP2r
 eML2OrTAGeWHgM9yqooFM/Wz59eY2s5jhS1FNRqxIv90KXxvvnb3YBGDKTPA8qjC9bdUyOMDq
 ZIWuyp9efxgFmva0GUPWQxdgswmIf+fJtImmtR3KxMidLH20ds/ams9dGWaNgiBtEcst3oYFA
 RmDqwN5T70vhgrf84dCBNQ/9PjkL6AYSoxYD6OVASyvGJzdrFoIiOnwoVHR6OnykDWoSVrBs9
 au8eQvrajiuBeRAC6E9l2S71Sr1IiAR0X9u6dPwRm2f55rTXOE5foQc7NFmmIiVJ1REcA9Bnd
 CQrAdI4fPggZGXwH3qpSccGmrnabAkF9ciT+nn2nA7lY7anop2Yz8VeO/KkkAd0u9MclM+3hi
 okZtW9KOITH4wb6+4tf1wTblp4EP5A0i4f4Jmc+jzXjV7aNRaoIktRH0TFChJ8igZR8YKAeNS
 jtsM0aby14S0yY8i6MgzZWsvUqag2ssfQbor0ns60hdKwsABmKzyj3Pe2YFy8uVtqOtrPmJ84
 ERcSn4aDG1qhFX0jVVFEyURsW6vT87CQWMl23Sb6InsTYQQm2+U+RkXs41BO3DqCHKJ7vSIk2
 HFyJ54b3uGXzHMTdBZIUOWu9o/MUxrJv8em1X8xPPnaN4aqZab0l4PE9s34GbZ2DHQ81LQRtN
 38XGhv8/VjVeeXzq1b/DoHDWbMkpauB1DQIfKQy+1dOlRZAyb8YqENvlvnkBVc7HLHtoEvZb9
 XxnKt9H0CUBVxmel5qA9s7WLh3Y=

Am 06.12.23 um 14:08 schrieb Patrick Steinhardt:
> On Wed, Dec 06, 2023 at 12:51:58PM +0100, Ren=C3=A9 Scharfe wrote:
>> Use the standard parameterized message for reporting incompatible
>> options to report options that are not accepted in combination with
>> --exclude-hidden.  This reduces the number of strings to translate and
>> makes the UI a bit more consistent.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/rev-parse.c                |  9 ++++++---
>>  revision.c                         | 18 ++++++++++++------
>>  t/t6018-rev-list-glob.sh           |  6 ++----
>>  t/t6021-rev-list-exclude-hidden.sh |  4 ++--
>>  4 files changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
>> index fde8861ca4..917f122440 100644
>> --- a/builtin/rev-parse.c
>> +++ b/builtin/rev-parse.c
>> @@ -893,13 +893,15 @@ int cmd_rev_parse(int argc, const char **argv, co=
nst char *prefix)
>>  			}
>>  			if (opt_with_value(arg, "--branches", &arg)) {
>>  				if (ref_excludes.hidden_refs_configured)
>> -					return error(_("--exclude-hidden cannot be used together with --b=
ranches"));
>> +					return error(_("options '%s' and '%s' cannot be used together"),
>> +						     "--exclude-hidden", "--branches");
>
> The repetitive nature of this patch and subsequent ones made me wonder
> whether it would be useful to have a function similar to the
> `die_for_incompatible_*()` helper that knows to format this error
> correctly.

I wondered the same and experimented with a die_for_incompatible_opt2().
It would allow the compiler to detect typos.

Passing in the conditions as parameters is a bit tedious and unlike its
for its higher-numbered siblings there is not much to win by doing that
instead of using an if statement or two nested ones.  We could pass in
1 if we want to integrate that function into an if cascade like above,
but it would look a bit silly.  And here we'd need a non-fatal version
anyway.

Perhaps a build step that lists all new translatable strings would help?
Nah, that would require building each commit.

A LLM-based tool to find translatable strings with the same meaning?
Don't know how difficult that would be.

So I feel the same, but don't have a solution that would justify the
churn of replacing the duplicate strings with function calls. :-/

Ren=C3=A9
