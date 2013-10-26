From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 11/15] fetch --prune: prune only based on explicit refspecs
Date: Sat, 26 Oct 2013 08:49:12 +0200
Message-ID: <526B65E8.1070900@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>	<1382543448-2586-12-git-send-email-mhagger@alum.mit.edu> <xmqqiowmml0y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 08:56:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZxnZ-00014g-96
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 08:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab3JZG4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 02:56:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53708 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751815Ab3JZG4T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Oct 2013 02:56:19 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Oct 2013 02:56:19 EDT
X-AuditID: 1207440e-b7fbc6d000004ad9-ee-526b65ed189b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 08.A1.19161.DE56B625; Sat, 26 Oct 2013 02:49:17 -0400 (EDT)
Received: from [192.168.69.9] (p57A2580B.dip0.t-ipconnect.de [87.162.88.11])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9Q6nB3r005123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 26 Oct 2013 02:49:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqqiowmml0y.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsUixO6iqPs2NTvI4NATEYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFo8bSz0mLeixdsFj9aepgdOD0urXvJ5HHozxR2j2cn2tk8
	Lr38zubxrHcPo8fFS8oeM1pes3h83iTnceDyY7YAzihum6TEkrLgzPQ8fbsE7oxFs66wFsxR
	q2g+8YepgfGaXBcjJ4eEgIlE+9u1jBC2mMSFe+vZuhi5OIQELjNKvN/cwAjhnGGSmDn3IwtI
	Fa+AtsSv1tusIDaLgKrE+cXv2UFsNgFdiUU9zUwgtqhAiMTCVcfZIeoFJU7OfALWKyKgJjGx
	7RALyFBmgftMEr97XoMVCQv4SzTfecoEsW01o8Szyz1gN3EKWEu0XZsANpVZQEfiXd8DZghb
	XmL72znMExgFZiFZMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr5WaW6KWm
	lG5ihMQN3w7G9vUyhxgFOBiVeHgL2rOChFgTy4orcw8xSnIwKYny9qZkBwnxJeWnVGYkFmfE
	F5XmpBYfYpTgYFYS4V39A6icNyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PB
	oSTBGwMyVLAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Ur/HFwIgFSfEA7d0A0s5b
	XJCYCxSFaD3FqMsx78uHb4xCLHn5ealS4rxTQYoEQIoySvPgVsCS5CtGcaCPhXmrQKp4gAkW
	btIroCVMQEv+XgF5rrgkESEl1cCY9/Xi3z/3v+y8Ij3NpHDn8Zsr8j7eEz33rPJx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236737>

On 10/24/2013 11:11 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> ...
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Everything in the proposed log message made sense to me.
> 
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index d4d93c9..83c1700 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2086,7 +2086,7 @@ remote.<name>.vcs::
>>  remote.<name>.prune::
>>  	When set to true, fetching from this remote by default will also
>>  	remove any remote-tracking branches which no longer exist on the
>> -	remote (as if the `--prune` option was give on the command line).
>> +	remote (as if the `--prune` option was given on the command line).
> 
> Shouldn't we stop saying "branches" here?
> 
>> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
>> index 0e6d2ac..5d12219 100644
>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -41,8 +41,14 @@ ifndef::git-pull[]
>>  
>>  -p::
>>  --prune::
>> -	After fetching, remove any remote-tracking branches which
>> -	no longer exist	on the remote.
>> +	After fetching, remove any remote-tracking branches that
> 
> Likewise.  This is a lot more important than the one in
> remote.<name>.prune documentation, as the next sentence "Tags are
> not subject to ..." implies that they fall into the same category as
> what gets pruned here, i.e. "remote-tracking branches" in the above
> sentence, but nobody calls refs/tags/v1.0.0 a "remote-tracking
> branch" even if it came from your 'origin'.

OK, I will change both of the above from "remote-tracking branches" to
"remote-tracking references".

>> +	no longer exist	on the remote.  Tags are not subject to
>> +	pruning in the usual case that they are fetched because of the
>> +	--tags option or remote.<name>.tagopt.  
> 
> We should mention the most usual case tags are fetched, before
> mentioning the case the unusual option "--tags" was used from the
> command line or .tagopt configuration was used.  Namely, when the
> tags are automatically followed.

OK, I will change this in the next draft.

>> @@ -63,7 +69,10 @@ ifndef::git-pull[]
>>  --tags::
>>  	This is a short-hand requesting that all tags be fetched from
>>  	the remote in addition to whatever else is being fetched.  It
>> -	is similar to using the refspec `refs/tags/*:refs/tags/*`.
>> +	is similar to using the refspec `refs/tags/*:refs/tags/*`,
>> +	except that it doesn't subject tags to pruning, regardless of
>> +	a --prune option or the configuration settings of fetch.prune
>> +	or remote.<name>.prune.
> 
> Using --tags is not similar to using refs/tags/*:refs/tags/* after
> the previous patch already; "git fetch origin --tags" and "git fetch
> origin refs/tags/*:refs/tags/*" are vastly different and that was
> the whole point of the previous step.  And that "calling something
> not so similar similar" needs to be fixed further here to clarify
> that they are not similar in yet another way.
> 
> We should just lose "It is similar to using" from 10/15 and start
> over, perhaps?  Add the first paragraph of the below in 10/15 and
> add the rest in 11/15, or something.
> 
> 	--tags::
> 		Request that all tags be fetched from the remote
> 		under the same name (i.e. `refs/tags/X` is created in
> 		our repository by copying their `refs/tags/X`), in
> 		addition to whatever is fetched by the same `git
> 		fetch` command without this option on the command
> 		line.
> 	+
>         When `refs/tags/*` hierarchy from the remote is copied only
>         because this option was given, they are not subject to be
> 	pruned when `--prune` option (or configuration variables
> 	like `fetch.prune` or `remote.<name>.prune`) is in effect.
> 
> That would make it clear that they are subject to pruning when --mirror
> or an explicit refspec refs/tags/*:refs/tags/* is given, as tags are
> not fetched "only because of --tags" in such cases.

I see your point.  What do you think about the following version, which
is a bit more compact and refers the reader to --prune for the full story:

-t::
--tags::
	Fetch all tags from the remote (i.e., fetch remote tags
	`refs/tags/*` into local tags with the same name), in addition
	to whatever else would otherwise be fetched.  Using this
	option does not subject tags to pruning, even if --prune is
	used (though tags may be pruned anyway if they are also the
	destination of an explicit refspec; see '--prune').

I also want to improve the description of tag auto-following in general.
 I will send a re-rolled patch series in the next couple of days.

Thanks for your prompt and helpful advice!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
