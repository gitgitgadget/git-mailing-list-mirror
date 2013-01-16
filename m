From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 06/14] imap-send.c: remove some unused fields from
 struct store
Date: Wed, 16 Jan 2013 09:23:03 +0100
Message-ID: <50F66367.1010106@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu> <1358237193-8887-7-git-send-email-mhagger@alum.mit.edu> <20130115203204.GA12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 09:23:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvOHS-0002cO-AW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 09:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500Ab3APIXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 03:23:09 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:48001 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753881Ab3APIXI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 03:23:08 -0500
X-AuditID: 1207440d-b7f306d0000008b7-4b-50f6636b0ace
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 22.8E.02231.B6366F05; Wed, 16 Jan 2013 03:23:07 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0G8N42g029869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Jan 2013 03:23:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130115203204.GA12524@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqJud/C3AYP8RRYuuK91MFg29V5gt
	3t5cwmjxo6WH2YHFY+esu+wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xsMpn5kK
	3vNXHL+9kaWB8SF3FyMnh4SAicSx+21sELaYxIV764FsLg4hgcuMEocXLGSFcI4zSdz48wWs
	ildAW+L3lXVANgcHi4CqxK6H0iBhNgFdiUU9zUwgtqhAmETv63OMEOWCEidnPmEBsUUENCSe
	f/oG1sosEC/x5GgySFhYIELi/cI17BCr5jNKnDo3AayeU8BAYvG0D2AzmQV0JN71PWCGsOUl
	tr+dwzyBUWAWkhWzkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrp
	JkZIOPPuYPy/TuYQowAHoxIP7+e8rwFCrIllxZW5hxglOZiURHmN4r4FCPEl5adUZiQWZ8QX
	leakFh9ilOBgVhLhXWYPlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAo
	SfCuTQJqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFanwxMFZBUjxAe38lguwt
	LkjMBYpCtJ5iNObY/6T9OSPH9t9AUoglLz8vVUqcNxdkkwBIaUZpHtwiWCJ7xSgO9Lcwbz1I
	FQ8wCcLNewW0iglo1aa9n0FWlSQipKQaGDmuhl+cmC4ibCuQ8f6xxepUlr1LLd4sj579c2rT
	A2V5ncPTfwY41NQFXm6ObBbNvM968fCflq0qX93NH112LJo7LeR0pUVc48QPV+5v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213738>

On 01/15/2013 09:32 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> -			else if ((arg1 = next_arg(&cmd))) {
>> -				if (!strcmp("EXISTS", arg1))
>> -					ctx->gen.count = atoi(arg);
>> -				else if (!strcmp("RECENT", arg1))
>> -					ctx->gen.recent = atoi(arg);
>> +			} else if ((arg1 = next_arg(&cmd))) {
>> +				/* unused */
> 
> The above is just the right thing to do to ensure no behavior change.
> Let's take a look at the resulting code, though:
> 
> 			if (... various reasonable things ...) {
> 				...
> 			} else if ((arg1 = next_arg(&cmd))) {
> 				/* unused */
> 			} else {
> 				fprintf(stderr, "IMAP error: unable to parse untagged response\n");
> 				return RESP_BAD;
> 
> Anyone forced by some bug to examine this "/* unused */" case is going
> to have no clue what's going on.  In that respect, the old code was
> much better, since it at least made it clear that one case where this
> code gets hit is handling "<num> EXISTS" and "<num> RECENT" untagged
> responses.
> 
> I suspect that original code did not have an implicit and intended
> missing
> 
> 				else
> 					; /* negligible response; ignore it */
> 
> but the intent was rather 
> 
> 				else {
> 					fprintf(stderr, "IMAP error: I can't parse this\n");
> 					return RESP_BAD;
> 				}
> 
> Since actually fixing that is probably too aggressive for this patch,
> how about a FIXME comment like the following?
> 
> 		/*
> 		 * Unhandled response-data with at least two words.
> 		 * Ignore it.
> 		 *
> 		 * NEEDSWORK: Previously this case handled '<num> EXISTS'
> 		 * and '<num> RECENT' but as a probably-unintended side
> 		 * effect it ignores other unrecognized two-word
> 		 * responses.  imap-send doesn't ever try to read
> 		 * messages or mailboxes these days, so consider
> 		 * eliminating this case.
> 		 */

Yes, this sounds reasonable to me.  Thanks for the improvement.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
