From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] string_list API: document what "sorted" means.
Date: Tue, 18 Sep 2012 09:58:35 +0200
Message-ID: <505829AB.8000506@alum.mit.edu>
References: <1347895267-5054-1-git-send-email-mhagger@alum.mit.edu> <7vy5k8s622.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:58:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDshk-0002Tt-5g
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 09:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab2IRH6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 03:58:40 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:63863 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645Ab2IRH6j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 03:58:39 -0400
X-AuditID: 1207440c-b7f616d00000270b-f6-505829ae5b65
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A4.1D.09995.EA928505; Tue, 18 Sep 2012 03:58:38 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8I7war0031046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 18 Sep 2012 03:58:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vy5k8s622.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqLtOMyLA4EK7kkXXlW4mi4beK8wO
	TB4XLyl7fN4kF8AUxW2TlFhSFpyZnqdvl8CdMe37WaaCJdIVJ39PYW9gnCDWxcjJISFgInH3
	5kdmCFtM4sK99WxdjFwcQgKXGSV23d/OBOEcZ5I49LCJCaSKV0Bb4tWfi+wgNouAqsSqzQsY
	QWw2AV2JRT3NYDWiAiESMy5PZoaoF5Q4OfMJC4gtIqAmMbHtEJDNwcEsIC7R/w/MFBZwljj9
	NhakQkggV6LjxDGwTk4BM4llr2eA2cwCOhLv+h5A2fIS29/OYZ7AKDALyYJZSMpmISlbwMi8
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMkSHl2MH5bJ3OIUYCDUYmHtyI9
	PECINbGsuDL3EKMkB5OSKO9a9YgAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8vtJAOd6UxMqq
	1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBO8NDaBGwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO011wTZG9xQWIuUBSi9RSjMcfsmyvuM3Lc/Qgk
	hVjy8vNSpcR5XUE2CYCUZpTmwS2CpadXjOJAfwvzOoIM5AGmNrh5r4BWMQGtqngSBrKqJBEh
	JdXAyJLtPpXXWHgzy3W1LvvCKUczL9keul55l+ue4+RLm3UYrMXet0tyfPOPOiX++Va8N6tg
	3+v9t641pU4v5pwnsXDv/neOZ3YUv3jmxtl25M2va5PEjXtePdq14pB0hM3PA1xz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205808>

On 09/17/2012 11:17 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Junio pointed out that the sort order currently used by string_list
>> could be considered to be an implementation detail internal to
>> string_list.  But the sort order is already visible to the outside
>> world (e.g., via iteration or via print_string_list()), so it
>> shouldn't be changed willy-nilly.  Therefore, document the current
>> sort order as part of the API's contract.
>>
>> (If, at some future time, somebody wants a string_list that is sorted
>> by a different criterion, then the order should be made specifiable
>> via a callback function specified by the user.)
> 
> As I said in a separate message, we do not give any documented
> guarantee on the order the strings comes out of print_string_list(),
> other than "if you are using the unsorted list function to insert or
> append strings, we won't muck with the order of the items and you
> will get your strings back in the order you gave us".  Until we add
> a callback that the user can specify at the time of string list
> initialization, I do not think it is wise to cast it in stone and
> declare it as "shouldn't be changed willy-nilly", unnecessarily
> painting us into a corner that we need to expend extra effort to get
> out of.
> 
> Besides, nobody calls print_string_list() in the first place. I have
> always considered it as a debugging aid.

As you pointed out, mh/fetch-filter-refs depends on the sort order of
the "sought" reference array matching the sort order of the linked list
of refs received from the remote.

The linked list has been sorted since 9e8e704f using mergesort based on
strcmp().

Prior to 8bee93dd2, the sought array was sorted using qsort() and an
explicit strcmp()-based comparison function.  8bee93dd2 switched to
sorting the "sought" array using sort_string_list(), which is also based
on strcmp().

If (after mh/fetch-filter-refs) somebody would decide to change the sort
order of string_list, then it would break fetch.  So I see three
possibilities:

1. Document that string_list sorts entries according to their strcmp()
order, as proposed in this patch.  Then fetch can rely on this ordering.
 If somebody wants a different ordering in the future, it is easy to
make the sort order a parameter.

2. Leave string_list's "default" sort order unspecified, but already
implement a way to let string_list users specify a particular sort
order.  Change the fetch machinery to specify a strcmp()-based ordering
explicitly.  This approach has the advantage of letting the default sort
order of string_list to be changed, though I don't really see how this
would be helpful.

3. Change fetch back to doing its own sorting again, rather than relying
on sort_string_list().  This isn't a lot of work (inline the one line of
sort_string_list(), then either make string-list.c:cmp_items() public or
duplicate that function too).

I prefer (1) because it is nearly as flexible as (2) and doesn't require
us to do work now that might not be needed (namely, parameterizing the
compare function), nor does it require the overhead of keeping a pointer
to the compare function in the string_list header that might be needed
if string_lists with non-default sort orders should be usable with the
"functions for sorted lists only".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
