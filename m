From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/38] refs: create a base class "ref_store" for
 files_ref_store
Date: Fri, 10 Jun 2016 08:18:55 +0200
Message-ID: <575A5BCF.20409@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
 <xmqqbn3drkwd.fsf@gitster.mtv.corp.google.com> <575978DA.30608@alum.mit.edu>
 <xmqq60tijq4g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 08:19:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBFml-00042v-Rw
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 08:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbcFJGTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 02:19:02 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51425 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750871AbcFJGTA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 02:19:00 -0400
X-AuditID: 12074412-52fff700000009f7-10-575a5bd33fcd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A1.45.02551.3DB5A575; Fri, 10 Jun 2016 02:18:59 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A6IuU9024170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 02:18:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqq60tijq4g.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsUixO6iqHs5OircYN5TNYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrS3OvGlkdGD32DnrLrvHs949jB4XLyl77F+6jc1j8QMvjwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8CdcXfaAZaCh8wViw5PZW9gbGTuYuTkkBAwkTjbfZC9
	i5GLQ0hgK6NE16cbzBDOBSaJz33PWEGqhAXCJLqm7mMHsUUE1CQmth1igSjqYJJY/XEqmMMs
	MItJomPrRUaQKjYBXYlFPc1MIDavgKbE0qWdYN0sAqoSy7paWUBsUYEQifPrtrJC1AhKnJz5
	BCzOKWAt8X/jXTYQm1lAT2LH9V+sELa8xPa3c5gnMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urm
	JmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEBL3QDsb1J+UOMQpwMCrx8EbsigwXYk0sK67M
	PcQoycGkJMq7MzAqXIgvKT+lMiOxOCO+qDQntfgQowQHs5IIrxhIjjclsbIqtSgfJiXNwaIk
	zvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJglccGN1CgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkp
	qUWJpSUZ8aC4jC8GRiZIigdo76EokL3FBYm5QFGI1lOMxhwLftxey8RxZP+9tUxCLHn5ealS
	4rxXQUoFQEozSvPgFsHS3StGcaC/hXl3gVTxAFMl3LxXQKuYgFYtPxIOsqokESEl1cDobrbu
	5LmJL1q8NJwteG62281P+FvBdC8id2sUm4FzaZQwX9HWp2n+cTf8PdRLjfj291xa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296943>

On 06/09/2016 06:14 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>>> +static struct ref_store *main_ref_store = NULL;
>>>> +
>>>> +static struct ref_store *submodule_ref_stores = NULL;
>>>
>>> Let's let BSS take care of these initialization.
> [...]
> Lack of "= ..." is a clear-enough clue that the code wants these
> pointers initialized to NULL.
> [...]

OK. While I'm at it I'll add docstrings for these variables.

Michael
