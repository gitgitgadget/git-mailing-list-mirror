Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017881F858
	for <e@80x24.org>; Wed,  3 Aug 2016 23:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbcHCXc0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:32:26 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63810 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932168AbcHCXcU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 19:32:20 -0400
X-AuditID: 1207440c-217ff700000008d5-69-57a27eb00a5a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A1.6B.02261.0BE72A75; Wed,  3 Aug 2016 19:30:57 -0400 (EDT)
Received: from [192.168.69.130] (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73NUsTa027862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 19:30:55 -0400
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
To:	Stefan Beller <sbeller@google.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kbzB-bogaqco1+fbRuoQ-4a4GBwTKkuSNnpXUxTFaxcXw@mail.gmail.com>
 <bffbbd7b-3e1b-fa6d-ed53-b75a54fd6f69@alum.mit.edu>
 <CAGZ79kYs9dnRzyAV_MXXUDbRCLuxQeETHKRpVsczQMCMHkQUPw@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f84cc951-4eb0-153c-7984-fc0993d215a7@alum.mit.edu>
Date:	Thu, 4 Aug 2016 01:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYs9dnRzyAV_MXXUDbRCLuxQeETHKRpVsczQMCMHkQUPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1N1Ytyjc4EyXrEXXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4MpYsMys4JRUxdkFc9gbGCeLdjFyckgImEgsnbWQpYuRi0NIYCujxNMl7YwQzjkm
	iVcHFjGCVAkLBEns3rQfzBYRUJOYuWo2G0TRGSaJx3/usYM4zAJPGCXu9d9kA6liE9CVWNTT
	zARi8wrYSzxZsAzMZhFQkeg59h5skqhAiMS2mw1sEDWCEidnPmEBsTkFAiXWXX4OVs8soC7x
	Z94lZghbXmL72znMExj5ZyFpmYWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31
	cjNL9FJTSjcxQoKaZwfjt3UyhxgFOBiVeHg3SC4KF2JNLCuuzD3EKMnBpCTKm5MKFOJLyk+p
	zEgszogvKs1JLT7EKMHBrCTCW1YDlONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgt
	gsnKcHAoSfA+AGkULEpNT61Iy8wpQUgzcXCCDOcBGp5WCzK8uCAxtzgzHSJ/ilFRSpx3Ckiz
	AEgiozQPrheWdF4xigO9IsxbBdLOA0xYcN2vgAYzAQ0+YbAAZHBJIkJKqoGx4YXj1yf+/0tN
	r/jt9ueq8mI5unrNrSPCs443/W1OjP/YlX2hvcj356KMOY27Ez4FSVcFmHMfZBBjzuiynZzE
	LNGivqzPWW315dNG5YLx9hM/5f+/mbxLdMMKpcyp9852VV8o+cgizij+cYW3JsPTb2usuK3S
	Hb++VY3aUZ/dNX1FSMWyuXpKLMUZiYZazEXFiQAaEt5LFQMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 12:51 AM, Stefan Beller wrote:
> On Wed, Aug 3, 2016 at 3:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 08/04/2016 12:30 AM, Stefan Beller wrote:
>>> On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>
>>>> +        return 10 * score - bonus;
>>>
>>> Would it make sense to define-ify the 10 as well
>>> as this is the only hardcoded number in the
>>> scoring function?
>>
>> I started answering this question by explaining why it is not important
>> to *optimize* the number 10 (namely because scores are only ever
>> compared against other scores, so an overall scaling factor makes no
>> difference). The factor 10 only has to be large enough to provide enough
>> dynamic range for the other (adjustable) parameters.
> 
> But it only scales the score, not the bonus.

Yes, that's how it provides the overall scale of the score. If it
multiplied both values, then it would be completely pointless.

This is an important point for the optimization, but less so for the
implementation of the heuristic here. I was dynamically optimizing the
ten other variables, and everything that goes into the bonus includes
one of those factors. If I had also let this factor of 10 vary, then the
net behavior of the algorithm would be completely unchanged if I would,
say, double all eleven parameters. This is bad for optimization, because
(1) it increases the search space unnecessarily, and (2) it means that
whole lines in the parameter space give identical behavior, making the
algorithm waste time searching along those lines for a minimum.

> So another way to write it
> would be
> 
>     score - bonus/10;
> 
> assuming the values of score and bonus are large enough.

Score is the number of columns that some line is indented, so it can be
0 or 1 or any other positive integer. It is not "large enough", which is
why the "10" can't be "1".

If the calculations were done in floating point, then the factor could
be "1", because then the other factors could be made less than one.

> In some prior conversation you said you take the indent and add an epsilon
> for some special conditions to make one indent better than the other.
> 
> Epsilons are usually very small compared to the rest of the equation,

I should have mentioned that this heuristic is quite a bit more advanced
than my original proposal to use "indent" plus some "epsilon" factors.
The old discussion about epsilons is not relevant here except maybe as
an inspiration and starting point for this version.

> but if I look at the boni definitions ranging from -63..50 they are scaled up
> so much that the bonus may become larger than '1' unit of 'score', i.e.
> it is not an epsilon any more. Or to put it another way:
> If we were to s/10/100/ the results would be worse.

If you would change s/10/100/ and simultaneously multiply the other
constants by 10, the end results would be unchanged.

> Rather the 10 describes the ratio of "advanced magic" to pure indentation
> based scoring in my understanding.

No, it's basically just a number against which the other constants are
compared. E.g., if another bonus wants to balance out against exactly
one space of indentation, its constant needs to be 10. If it wants to
balance out against exactly 5 spaces, its constant needs to be 50. Etc.

Michael

