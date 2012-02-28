From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/3] http: authenticate on NTLM proxies and others suppported, by CuRL
Date: Tue, 28 Feb 2012 18:30:51 +0100
Message-ID: <8762eq50hg.fsf@thomas.inf.ethz.ch>
References: <4F4CCE01.8080300@seap.minhap.es>
	<8762er6nb2.fsf@thomas.inf.ethz.ch> <4F4D19CC.5030303@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <peff@peff.net>, <sam@vilain.net>,
	<sam.vilain@catalyst.net.nz>
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Feb 28 18:31:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Qt9-0003cy-PP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965683Ab2B1Raz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 12:30:55 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:55080 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965655Ab2B1Ray (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 12:30:54 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 18:30:50 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 18:30:51 +0100
In-Reply-To: <4F4D19CC.5030303@seap.minhap.es> (Nelson Benitez Leon's message
	of "Tue, 28 Feb 2012 19:15:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191749>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> On 02/28/2012 03:32 PM, Thomas Rast wrote:
>> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
>> 
>>> -	if (curl_http_proxy)
>>> +	if (curl_http_proxy) {
>>>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>>> +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>>> +	}
>> 
>> There was another attempt at doing the same very recently:
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/191140
>> 
>> I could swear there was a second one, but apparently that was you.
>> Neither you nor Marco submitter have so far answered the question I
>> raised in
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/191155
>> 
>> which can be summarized as: please make a case -- and put it in the
>> message! -- for or against making this configurable.  Is there a speed
>> tradeoff?  (However, you could steal some of Daniel Stenberg's
>> reasoning!)
>
> I don't see any reason to make this configurable, [snip]

Sorry for not making this clear, but you don't have to explain it to me
in the list archives; rather, the commit message should sufficiently
take care of it.  That is, I was objecting to your (lack of a) commit
message.

The argument you need to counter here is (Daniel explains this) curl
does an extra roundtrip to the proxy to determine which protocols work,
which is a little extra cost.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
