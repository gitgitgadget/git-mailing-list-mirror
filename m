From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 4/4] read_loose_refs(): treat NULL_SHA1 loose references
 as broken
Date: Mon, 08 Jun 2015 11:26:33 +0200
Message-ID: <55755FC9.7040507@alum.mit.edu>
References: <cover.1433339279.git.mhagger@alum.mit.edu>	<eb79f7d96ec74445f7adf62757119273280e09c9.1433339279.git.mhagger@alum.mit.edu>	<20150603140803.GA23901@peff.net>	<xmqqr3pswrpc.fsf@gitster.dls.corp.google.com>	<20150603201511.GA31157@peff.net> <xmqqmw0gwktt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:26:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1tKL-0001Kl-UM
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbbFHJ0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:26:38 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61534 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752653AbbFHJ0h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:26:37 -0400
X-AuditID: 1207440f-f79236d000000c5e-d1-55755fcb0baa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.FA.03166.BCF55755; Mon,  8 Jun 2015 05:26:35 -0400 (EDT)
Received: from [192.168.69.130] (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t589QXmo011568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:26:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqmw0gwktt.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqHs6vjTUYMttdYszfeEWXVe6mSwa
	eq8wW/xo6WG22Ly5ncWB1WPBplKPpjNHmT2e9e5h9Lh4Sdnj8ya5ANYobpukxJKy4Mz0PH27
	BO6M/oOf2Ave8Fb8W/OevYFxOXcXIyeHhICJxLGfZxghbDGJC/fWs4HYQgKXGSW+X+HrYuQC
	ss8zSRx90MsMkuAV0JY4sfokWBGLgKrEmzvT2UFsNgFdiUU9zUxdjBwcogJBEq9f5kKUC0qc
	nPmEBcQWEXCUOPHgOiuIzSyQJtGyZztYq7BAtMSvo1/YIXatYJKYd/Ac2HxOAWuJDaevskM0
	6EnsuP4LqlleonnrbOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0
	TfRyM0v0UlNKNzFCwpt/B2PXeplDjAIcjEo8vAcWlYQKsSaWFVfmHmKU5GBSEuXdHlMaKsSX
	lJ9SmZFYnBFfVJqTWnyIUYKDWUmEl8kCKMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2a
	WpBaBJOV4eBQkuDtjQNqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFanwxMFZB
	UjxAe7eBtPMWFyTmAkUhWk8xKkqJ85aBJARAEhmleXBjYUnrFaM40JfCEO08wIQH1/0KaDAT
	0ODvX4tBBpckIqSkGhiLBcRXKMic/zGvs69XdnKUe+camdj85+UCBewG1rNt5mmZbLy6JX9u
	2VzZ01Fbe/y3LKm8f0/ks3WkTolzR7KWaoyQlcP6G6/vztzmrZe2bN9JxvtJs5uk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271010>

On 06/03/2015 11:20 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Wed, Jun 03, 2015 at 11:51:43AM -0700, Junio C Hamano wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> On Wed, Jun 03, 2015 at 03:51:59PM +0200, Michael Haggerty wrote:
>>>>
>>>>> NULL_SHA1 is used to indicate of "invalid SHA-1" throughout our code
>>>>
>>>> s/of/an/ ?
>>>
>>> Also possibly s/invalid SHA-1/invalid ref/?
>>
>> I thought it was trying to express that we use the null sha1 as a
>> sentinel value throughout the code, no matter if the value came from a
>> ref or otherwise.
> 
> Yeah, an invalid object name, not limited to refs, is correct.
> 
> Thanks.

Thanks for all the comments. Taking them into consideration, I suggest
changing the last commit message to

--8<-----------------------------------------------------------------
read_loose_refs(): treat NULL_SHA1 loose references as broken

NULL_SHA1 is used to indicate an "invalid object name" throughout our
code (and the code of other git implementations), so it is vastly more
likely that an on-disk reference was set to this value due to a
software bug than that NULL_SHA1 is the legitimate SHA-1 of an actual
object. Therefore, if a loose reference has the value NULL_SHA1,
consider it to be broken.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
--8<-----------------------------------------------------------------

Since the only comments were about this one commit message, I won't send
an updated patch series to the mailing list unless you request it. You
can also get the patches from my GitHub account [1], branch
"for-each-ref-errors".

Michael

[1] https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
