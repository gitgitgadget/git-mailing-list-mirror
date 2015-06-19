From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 06/19] fsck: Report the ID of the error/warning
Date: Fri, 19 Jun 2015 23:34:19 +0200
Organization: gmx
Message-ID: <118145527541c82e33599259c8e3e050@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <d0c24a7643acd3a1a17ab3abf0ba54ab352b3e41.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqvbej7b13.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:34:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63vp-0002Df-QC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbbFSVed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 17:34:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:59038 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbbFSVec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 17:34:32 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MdFwl-1ZOYNr2Q3n-00IU7L; Fri, 19 Jun 2015 23:34:20
 +0200
In-Reply-To: <xmqqvbej7b13.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:P5Pn6qtO2+yS9HtPMrGTE8Qpfbbuzv1grKB11ofl2HdYsaQAPd9
 yDMSrAPNuhQ7xZXxGJ6MMDYSjEQ6dgOU256ZzM0QSTIAK5h7v6QFUzKqD8M9TarQJQU8biy
 /qY4uju0k0rFA/OlHfv4tQK7mqsZJP/5XdmIVrNGvj8b7QAfEW/FFMV3GBiVHNBTyWrxwDF
 HLRq2CUbgkxYyn7DXXpkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nD70DsETCNE=:F8F7RQ2XvtQD2PF1YfU7v0
 FTNOzoQ4+eH2p3ndrxHTomJ3A6ymO8CWeQ9TFiJ9JaijePcoJLLTboKNMDLXlfeFxzZro7IvE
 Ib+4TDlW7AATe+j+ttzFPJwSNRNj3knRWv/vMsvUKlU1rOfM4uxp0o0BNeOv5L/2yvC58yqhX
 EI1dztwvuzcXVjxrVrVrjwmzmQfMLQUHt0+MIwO2ReilLmGSdFaNF4MZBLHw74D5PFwfLi+HK
 FxTsW5kL8+379jVAxBM1ptttSRlOUIAZZMbZdSau6/W2ITfL61ZrMggwCFf1Rwl7lzaNEWygg
 44GcJMIs4Sr7SFNMrqu40S7+RNnmcq3o+H+VoUrfSdHoHQVLNjcHW9r+95GX7mYIqDZpfGCnt
 E6tfpzmGyp1Eg5eO112W9K3h2FWTWwaMgWsoXCUxskdsUv17rqhHzZZozKl4g3VJxX5GOi4Yx
 jlw/aD7XjZqupbrP7TDHSlpiwnSlK1iroFX8J3I9KcGU9PxfpxBOqmZSGHYV7Fdv/WN3RzDdA
 VxHLy9v0N3emQFrKLQb9tCyYBA5ENWifZVP5P3yq2n4QX3junTTsTApREG9wddyAMk/BBy449
 jgmgDEnOWqY24QcQ2C4qQ+WEg3TmCZwVrBKniA7yFWtFjCWh9PpHEbzyBwTByo9St8TsCLjt4
 2GBqU/h8lTjWHo6GULqhaS1W6WiPqjSpeM9IImhB1MDSnsNacnx7MEq/6FU32/h5/r/8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272214>

Hi Junio,

On 2015-06-19 21:28, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Some legacy code has objects with non-fatal fsck issues; To enable the
>> user to ignore those issues, let's print out the ID (e.g. when
>> encountering "missingemail", the user might want to call `git config
>> --add receive.fsck.missingemail=warn`).
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  fsck.c          | 16 ++++++++++++++++
>>  t/t1450-fsck.sh |  4 ++--
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/fsck.c b/fsck.c
>> index 8e6faa8..0b3e18f 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -190,6 +190,20 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
>>  	}
>>  }
>>
>> +static void append_msg_id(struct strbuf *sb, const char *msg_id)
>> +{
>> +	for (;;) {
>> +		char c = *(msg_id)++;
>> +
>> +		if (!c)
>> +			break;
>> +		if (c != '_')
>> +			strbuf_addch(sb, tolower(c));
>> +	}
>> +
>> +	strbuf_addstr(sb, ": ");
>> +}
>> +
>>  __attribute__((format (printf, 4, 5)))
>>  static int report(struct fsck_options *options, struct object *object,
>>  	enum fsck_msg_id id, const char *fmt, ...)
>> @@ -198,6 +212,8 @@ static int report(struct fsck_options *options, struct object *object,
>>  	struct strbuf sb = STRBUF_INIT;
>>  	int msg_type = fsck_msg_type(id, options), result;
>>
>> +	append_msg_id(&sb, msg_id_info[id].id_string);
> 
> 
> Nice.  The append function can be made a bit more context sensitive
> to upcase a char immediately after _ to make it easier to cut and
> paste into "git config" and keep the result readable, I think.
> 
> 	git config --add receive.fsck.missingEmail=warn

Okay. I camelCased the IDs; it is a bit sore on my eyes in the command-line output, and the config variables are case-insensitive, anyway, but your wish is my command... I changed it locally, it will be part of v7.

Ciao,
Dscho
