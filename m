Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jolFBRl3"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9D9C9
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701882450; x=1702487250; i=l.s.r@web.de;
	bh=haOGb57/f01OSdcX4t7VXQ4R5RvLWuY6fb74/fDBHUQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jolFBRl36/2GyhP5FKKi8SrvqsQMq68XUOjEy10vZmhD+pWBHE2q6zReOCX7Odlh
	 g4/xMCiBTm3tNYtDU0Z1cG5C9rZAM91NqZ+mZ+NwlKR66h1mySuk9wd2FE2iQeFLF
	 D5Noz7fij1hhn6O7wQwvlyQJnpuDgBjjp64q1orWhnR+EdrAjF0XwoxuCOGKoJMwe
	 /ka8DSiu35guPGUdgBbZuQN1AlF9rr6Dlu11BFw94EXB+mbbbPUDblQmTXtfnHhob
	 qOPZ+JZdaMlz6n6xKvqXIT+sg6BvZ2Fyv2HzgklffnMz7y0hnH8RDdQdOYI2cWq0Q
	 RyQITkF8YI+GZZaaTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMY1D-1qvK1m3fyp-00JVyv; Wed, 06
 Dec 2023 18:07:29 +0100
Message-ID: <4954cf77-63f6-4225-833f-3c28d642ed11@web.de>
Date: Wed, 6 Dec 2023 18:07:29 +0100
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
 <389cd7b3-2350-4dc6-b282-e9d6e25fa68c@web.de> <ZXCHj3hIpQb900WX@tanuki>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZXCHj3hIpQb900WX@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DEeb5IMDjMBPI6fhUm2AgXfk1iMYjF0zoL5g6V98txqnMDwNK9R
 NCCbkFpSnDSCwweaN071VrYgej2Pk7/urCmCCX07ptW7L712US8Z+aKPfITwXs8X7q7d62t
 FGtiRL53EUmRTpEDGkU56Drx1Uj8ZdCo8/NLq/ulrgRP9+Z3WP8XN/7hj+64j29ercwOIsk
 UvN1kPMNd7ZgiQeQOoOEg==
UI-OutboundReport: notjunk:1;M01:P0:Ygwcl06U8aU=;wxE/NKJ9/2UdI214G764AztZWEc
 10XUs424/IE+oOxvv+e8gHTDMu8jxXC/YvQ0bfEHmHFfFBAti74iA5L70g0KYWP0vWXu178il
 O7HV6wMuotqWyd31H16FXh2GPjPuturH+iWQ7Ncm2gTRaFq2ca2NmJz4REgd2XG3QljdUiePB
 LUUyhP/XHkg5dYnN5nGoNSXvhZU1OtDHIznAHp7dEdm4HGEEhFu0nxAfrZk84CvLmB1bVgU9A
 EEMtiHVuPR/MnHA6ViD97MBClBQGSmtEIKjkJ3xQgRFbYxP3vnJCnjQFX+Si/bOG3HFl6RMUV
 /mJ4WRyiwSZPDIvOuXtd/UYUvJCOo8RwnKa+X1+HSjRQzvrQspwFkNe8T79z+hE/xT4Vr1PyV
 KTFyRQs7R4QXHf1dLjlr5MJNDN18SBMWea7qW9ANDIUxpNt8WIp5rwLBfOySy6IMK6oOBgYuq
 K/w0xWs88islqZPC7CfS5GPn3NHzZt45g8Ngs63OcBlDa/mYJettGpQVl6pZDSv8mGwAVxwu8
 ZJsHjcwJDbaHLeuYqYqfBXH2ZFV6xroUdaCfx6zBsXSzwc6jpBx0Z6SJ5ZzAsHxbb6K2nwxVS
 SsEGoBUCGTmxkqBpEcy3gLLH7sQTVHITAM23CaxNzYjscKvPSdOsmIEeReBhlRBJFqWO5QEJ5
 lhD+P3KRMXiRBaHGHJTVsmDfEpM6+IwPYeDVJsLSRszabwwdqW1y9+VRjSkGHZfH/YCZjeC2m
 0kEjHefJlGPxF0u4hRGC/vVHoqa9F2/qcQSH5Gky6wW2YOCBfXGmp+J5BVXp+dA0iLO+9crwG
 047G/ORt3FVN16V+ICWhox+BI32d8UUueyaUd03AYSI+ulGZSKUaWekoEGHU4f8ER54Y46rzp
 GoaYmCP3lpeuPXBH4yXyCCqSw4R1QL5HXDRm+BJkyMtARvVyBFZjenIzilWmzdZYRbqJVJqB4
 SfknJUllt59Pw8Rcg9HtuGulhoo=

Am 06.12.23 um 15:39 schrieb Patrick Steinhardt:
> On Wed, Dec 06, 2023 at 03:21:15PM +0100, Ren=C3=A9 Scharfe wrote:
>> Am 06.12.23 um 14:08 schrieb Patrick Steinhardt:
>>> On Wed, Dec 06, 2023 at 12:51:58PM +0100, Ren=C3=A9 Scharfe wrote:
>>>> Use the standard parameterized message for reporting incompatible
>>>> options to report options that are not accepted in combination with
>>>> --exclude-hidden.  This reduces the number of strings to translate an=
d
>>>> makes the UI a bit more consistent.
>>>>
>>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>>> ---
>>>>  builtin/rev-parse.c                |  9 ++++++---
>>>>  revision.c                         | 18 ++++++++++++------
>>>>  t/t6018-rev-list-glob.sh           |  6 ++----
>>>>  t/t6021-rev-list-exclude-hidden.sh |  4 ++--
>>>>  4 files changed, 22 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
>>>> index fde8861ca4..917f122440 100644
>>>> --- a/builtin/rev-parse.c
>>>> +++ b/builtin/rev-parse.c
>>>> @@ -893,13 +893,15 @@ int cmd_rev_parse(int argc, const char **argv, =
const char *prefix)
>>>>  			}
>>>>  			if (opt_with_value(arg, "--branches", &arg)) {
>>>>  				if (ref_excludes.hidden_refs_configured)
>>>> -					return error(_("--exclude-hidden cannot be used together with -=
-branches"));
>>>> +					return error(_("options '%s' and '%s' cannot be used together")=
,
>>>> +						     "--exclude-hidden", "--branches");
>>>
>>> The repetitive nature of this patch and subsequent ones made me wonder
>>> whether it would be useful to have a function similar to the
>>> `die_for_incompatible_*()` helper that knows to format this error
>>> correctly.
>>
>> I wondered the same and experimented with a die_for_incompatible_opt2()=
.
>> It would allow the compiler to detect typos.
>>
>> Passing in the conditions as parameters is a bit tedious and unlike its
>> for its higher-numbered siblings there is not much to win by doing that
>> instead of using an if statement or two nested ones.  We could pass in
>> 1 if we want to integrate that function into an if cascade like above,
>> but it would look a bit silly.  And here we'd need a non-fatal version
>> anyway.
>
> Maybe the easiest solution would be to have `error_incompatible_usage()`
> that simply wraps `error()`.

Yes, but having two variants (die_ and error_) is unfortunate.

> You'd pass in the incompatible params and
> it makes sure to format them accordingly. It could either accept two
> args or even be a vararg function with sentinel `NULL`.

Tempting, but passing the conditions separately is actually useful to
improve the shown message when there are more than two options.

> It's not perfect
> of course, but would at least ensure that we can easily convert things
> over time without having to duplicate the exact message everywhere.

Maybe the simplest option would be to use a macro, e.g.

   #define INCOMPATIBLE_OPTIONS_MESSAGE \
           _("options '%s' and '%s' cannot be used together")

It could be used with both error() and die(), and the compiler would
still ensure that two strings are passed along with it, but I don't know
how to encode that requirement in the macro name somehow to make it
self-documenting.  Perhaps by getting the number two in there?

> I don't think it's a problem to not convert everything in one go. The
> current series is a good step in the right direction, and any additional
> instances that were missed can be fixed in follow-ups.

Right; whatever we do, we can (and should) do it step by step.

Ren=C3=A9
