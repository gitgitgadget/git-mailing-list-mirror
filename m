From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 10 Dec 2014 18:02:47 +0100
Message-ID: <54887CB7.4000603@alum.mit.edu>
References: <1416262453-30349-1-git-send-email-sbeller@google.com> <20141117233525.GC4336@google.com> <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com> <20141118004841.GE4336@google.com> <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com> <20141203050217.GJ6527@google.com> <20141203051344.GM6527@google.com> <xmqqzjb4h823.fsf@gitster.dls.corp.google.com> <20141203210031.GA6631@peff.net> <20141203213858.GC6527@google.com> <20141204075920.GA27142@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 18:03:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XykfE-00068P-43
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 18:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbaLJRCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 12:02:54 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:63231 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932375AbaLJRCy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 12:02:54 -0500
X-AuditID: 12074411-f79fa6d000006b8a-76-54887cba5933
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 01.41.27530.ABC78845; Wed, 10 Dec 2014 12:02:50 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0BBF.dip0.t-ipconnect.de [93.219.11.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBAH2lx8016155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Dec 2014 12:02:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141204075920.GA27142@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqLurpiPE4N9/U4uuK91MFg29V5gt
	3t5cwmjxo6WH2WLz5nYWB1aPnbPusnss2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZzydvYm9oJmv4snWX6wNjE+4uhg5OSQETCSufV3OBGGLSVy4t56ti5GLQ0jgMqPE7/mH
	WSGc80wS/99sZwSp4hXQlji67zpYB4uAqsTql+tZQGw2AV2JRT3NYHFRgSCJk3uus0PUC0qc
	nPkEqIaDQ0TAWeL2enmQMLNAhsSkdbOYQWxhAR+JX7s2sUDsessssXPZPrBeTgE9iYnnJrFD
	NKhL/Jl3iRnClpdo3jqbeQKjwCwkK2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzU
	Il1TvdzMEr3UlNJNjJAQF9zBOOOk3CFGAQ5GJR7eFVfbQ4RYE8uKK3MPMUpyMCmJ8k4r6QgR
	4kvKT6nMSCzOiC8qzUktPsQowcGsJMKbWwaU401JrKxKLcqHSUlzsCiJ8/ItUfcTEkhPLEnN
	Tk0tSC2CycpwcChJ8PpXAzUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2I1vhgY
	rSApHqC9KSDtvMUFiblAUYjWU4yKUuK82SAJAZBERmke3FhY4nrFKA70pTBvFUgVDzDpwXW/
	AhrMBDT4RWIryOCSRISUVAOj58z7hRfmLy6fZbRFoL3yUN2xJ2lc1tLch9985U6r7dp1kHvx
	U8bIvtWWD3ZMXLF0bqKMa8U89pOPHHvbGY9Zfe+pleB/GybSmPjSNyZ0icj2mkkz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261222>

On 12/04/2014 08:59 AM, Jeff King wrote:
> On Wed, Dec 03, 2014 at 01:38:58PM -0800, Jonathan Nieder wrote:
>> The allocation of a variable-sized buffer is a small overhead that I
>> don't mind incurring on error.  In the non-error case, the caller
>> doesn't actually have to free the buffer, and if they choose to, the
>> overhead incurred is that of free(NULL)'.
> 
> I don't care at all about overhead. I care about extra work on the part
> of the caller to avoid a leak. It turns:
> 
>   if (some_func(fd, &err))
> 	return error("%s", err.msg);
> 
> into:
> 
>   if (some_func(fd, &err)) {
> 	error("%s", err.buf);
> 	strbuf_release(&err);
> 	return -1;
>   }

What if we go in the direction not of less infrastructure, but a little
bit more? Like

	struct result {
		int code;
		struct strbuf msg;
	};

	int report_errors(struct result *result)
	{
		int code = result->code;
		if (code) {
			error(result->msg.buf);
		}
		result->code = 0;
		strbuf_release(result->msg);
		return code; /* or alternatively (code ? -1 : 0) */
	}

	int report_warnings(struct result *result)
	{
		...
	}

	int report_with_prefix(struct result *result, const char *fmt, ...)
	{
		...
	}

Then a caller could look pretty much like before:

	struct result result = RESULT_INIT;

	if (some_func(fd, &result))
		return report_errors(&result);

Other callers might not even bother to check the return value of the
function, relying instead on result.code via process_error():

	char *ptr = some_func(fd, &result);
	if (report_errors(&result))
		return -1;

If the result code is considered superfluous, we could use naked strbufs
and use msg.len as the indicator that there was an error.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
