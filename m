From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] fetch/push: allow refs/*:refs/*
Date: Wed, 22 Aug 2012 09:39:03 +0200
Message-ID: <50348C97.4040606@alum.mit.edu>
References: <1345484397-10958-1-git-send-email-gitster@pobox.com> <1345484397-10958-2-git-send-email-gitster@pobox.com> <50332E2D.2070602@alum.mit.edu> <7vpq6kdu31.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 09:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T45dp-0002h0-DT
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 09:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab2HVHqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 03:46:11 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:63606 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756970Ab2HVHqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 03:46:09 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2012 03:46:09 EDT
X-AuditID: 1207440d-b7f236d000000943-76-50348c9ade84
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.D3.02371.A9C84305; Wed, 22 Aug 2012 03:39:06 -0400 (EDT)
Received: from [192.168.69.140] (p57A25F3D.dip.t-dialin.net [87.162.95.61])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7M7d4w1004284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Aug 2012 03:39:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vpq6kdu31.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqDurxyTA4F+DrkXXlW4mi4beK8wW
	/cu72ByYPT58jPO4eEnZ4/MmuQDmKG6bpMSSsuDM9Dx9uwTujI/HPrEWnJaseNg3g6WB8bVw
	FyMnh4SAicS+3i3sELaYxIV769m6GLk4hAQuM0o8+XacHcI5zSTx6thtFpAqXgFticWP+9hA
	bBYBVYnVJ46DxdkEdCUW9TQzgdiiAiESa75NYYSoF5Q4OfMJWI2IgJrExLZDYDazgKfEiYW3
	weYIC1hIrP/7hxVi2UFGid8dPcwgCU4BM4nmd5/ZIBp0JN71PWCGsOUltr+dwzyBUWAWkh2z
	kJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZI8PLuYPy/TuYQ
	owAHoxIP7wMPkwAh1sSy4srcQ4ySHExKorzPu4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiv
	1wLleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvO9BhgoWpaanVqRl
	5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDojW+GBivICkeoL1vQdp5iwsSc4GiEK2nGI05/p88
	eZeR4/NTICnEkpeflyolznsfpFQApDSjNA9uESxtvWIUB/pbmPcESBUPMOXBzXsFtIoJaJXa
	VWOQVSWJCCmpBsaKuJuZv9Ssr81UK917Zsok6Reljju+P3qQPUs+Szdrc+bH4iclG9vSSp9u
	LHq+POfxu3Xd324+PvT2Y+L5RTU7eqfa1c147KO21E3wVKt2O3fR5dY0VX5dkS2P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204008>

On 08/21/2012 07:37 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
>>> index 6207ecd..a3e3fa3 100644
>>> --- a/builtin/fetch-pack.c
>>> +++ b/builtin/fetch-pack.c
>>> @@ -546,7 +546,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>>>  	for (ref = *refs; ref; ref = next) {
>>>  		next = ref->next;
>>>  		if (!memcmp(ref->name, "refs/", 5) &&
>>> -		    check_refname_format(ref->name + 5, 0))
>>> +		    check_refname_format(ref->name, 0))
>>>  			; /* trash */
>>>  		else if (args.fetch_all &&
>>>  			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
>>
>> I understand that you didn't introduce this code, but it seems like a
>> suspicious combination of conditions:
>>
>>     if ((ref->name starts with "refs/")
>>         and (ref->name has invalid format))
> 
> This protects us from getting contaminated by bogus ref under refs/
> when running "fetch refs/heads/*:refs/remotes/origin/*" no?
> 
> The remote side can also throw phony "I have this object, too, but
> not at a particular ref---this entry is only to let you know I have
> it, so that we can negotiate minimal transfer better" entries that
> are labelled with strings that do not begin with "refs/" and do not
> pass check_refname_format() (and because they are not refs, they do
> not have to pass the test) at us, and we do not want to filter them
> out in this function.  But we do not want anything that is malformed
> under "refs/".

Thanks for the explanation.  I'm trying to dig some more into this so
that I can add some documentation, because this area of the code is
rather obscure.

Here is the loop being discussed, in full (from builtin/fetch-pack.c,
filter_refs()):

> 	for (ref = *refs; ref; ref = next) {
> 		next = ref->next;
> 		if (!memcmp(ref->name, "refs/", 5) &&
> 		    check_refname_format(ref->name, 0))
> 			; /* trash */
> 		else if (args.fetch_all &&
> 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
> 			*newtail = ref;
> 			ref->next = NULL;
> 			newtail = &ref->next;
> 			continue;
> 		}
> 		else {
> 			int i;
> 			for (i = 0; i < nr_match; i++) {
> 				if (!strcmp(ref->name, match[i])) {
> 					match[i][0] = '\0';
> 					return_refs[i] = ref;
> 					break;
> 				}
> 			}
> 			if (i < nr_match)
> 				continue; /* we will link it later */
> 		}
> 		free(ref);
> 	}

Empirically (determined by instrumenting the code and running the git
test suite):

* The first branch of the if statement is only executed for ref->name of
the form "refs/tags/foo^{}" for various "foo".

* The second branch of the if is *never* executed.

* The third branch is invoked for various reference names under "refs/"
(including oddballs like "refs/for/refs/heads/master", "refs/stash",
"refs/replace/<SHA1>"), and also for "HEAD".

This doesn't quite agree with your explanation, because the phony refs
(at least in this dataset) *do* start with "refs/" and they *are* trashed.

I'll continue to try to figure out this area.  I already found an
apparent memory leak...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
