From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 2/6] string_list: add two new functions for splitting
 strings
Date: Wed, 12 Sep 2012 15:12:36 +0200
Message-ID: <50508A44.1020008@alum.mit.edu>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu> <1347311926-5207-3-git-send-email-mhagger@alum.mit.edu> <7v8vchld82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 15:12:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBmkL-0000zB-3m
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 15:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933Ab2ILNMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 09:12:40 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:53374 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752398Ab2ILNMj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 09:12:39 -0400
X-AuditID: 12074411-b7fa36d0000008cc-92-50508a46c6ca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 85.CC.02252.64A80505; Wed, 12 Sep 2012 09:12:38 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8CDCadi019373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2012 09:12:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v8vchld82.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqOvWFRBg8H6ujEXXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7ow9H1ezFixjrTg9tYm1gXEa
	SxcjB4eEgInErh3qXYycQKaYxIV769m6GLk4hAQuM0psWfyUGcI5ziTxbfNWFpAqXgFtiYfX
	9jOC2CwCqhKr5z9hBrHZBHQlFvU0M4HYogIhEjMuT2aGqBeUODnzCViviICaxMS2Q2CLmQWM
	JOadrgcJCwuESbyY3sEEsWspo8SkhjdgczgFzCQ+bp3FBmIzC+hIvOt7wAxhy0tsfzuHeQKj
	wCwkK2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJDQFdzB
	OOOk3CFGAQ5GJR5ehgT/ACHWxLLiytxDjJIcTEqivDdbAwKE+JLyUyozEosz4otKc1KLDzFK
	cDArifBu0AXK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeJd3AjUK
	FqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyI1vhgYqyApHqC9K0HaeYsLEnOBohCt
	pxh1Oe5+XHGfUYglLz8vVUqctx2kSACkKKM0D24FLFG9YhQH+liYdyJIFQ8wycFNegW0hAlo
	yYS1/iBLShIRUlINjLm//P54yK9n/B7H6b1jyaG3WvGB3gH1KuJNm02dqq+t3Ps9peblnOoH
	Z497S250Ulgu8LH/eICvDO+tlftNE6bOu9bR5s56Ny2qwaH6xyTXj0z/XNfMS9lf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205285>

On 09/11/2012 12:33 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> +`string_list_split`, `string_list_split_in_place`::
>> +
>> +	Split a string into substrings on a delimiter character and
>> +	append the substrings to a `string_list`.  If `maxsplit` is
>> +	non-negative, then split at most `maxsplit` times.  Return the
>> +	number of substrings appended to the list.
> 
> 
> I recall that we favor
> 
> `A`::
> `B`::
> 
> 	Description for A and B
> 
> for some reason but do not remember exactly why.

Will change.  Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
