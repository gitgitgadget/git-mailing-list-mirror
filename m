From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/38] refs: create a base class "ref_store" for
 files_ref_store
Date: Thu, 9 Jun 2016 16:10:34 +0200
Message-ID: <575978DA.30608@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
 <xmqqbn3drkwd.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Thu Jun 09 16:10:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB0fe-0002ll-73
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 16:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbcFIOKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 10:10:49 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53133 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810AbcFIOKs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 10:10:48 -0400
X-AuditID: 1207440f-8bbff700000008e4-89-575978dd8968
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E8.81.02276.DD879575; Thu,  9 Jun 2016 10:10:37 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59EAYkB005111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 10:10:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqbn3drkwd.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqHu3IjLcYO0lDYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrS3OvGlkdGD32DnrLrvHs949jB4XLyl77F+6jc1j8QMvjwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8Cd0bB+GlvBEsWKG3efMzUw9kt1MXJySAiYSDStmcAG
	YgsJbGWUmDCjoIuRC8g+zyTx9fIhRpCEsECYRNfUfewgtoiAmsTEtkMsEEU7GSUaVv9lBXGY
	BWYxSXRsvQjWwSagK7Gop5kJxOYV0JS4tvoRmM0ioCKxaOdUsHWiAiES59dtZYWoEZQ4OfMJ
	0FQODk4Ba4m5DRYgYWYBPYkd13+xQtjyEtvfzmGewMg/C0nHLCRls5CULWBkXsUol5hTmqub
	m5iZU5yarFucnJiXl1qka6KXm1mil5pSuokREvD8Oxi71sscYhTgYFTi4dVIiQgXYk0sK67M
	PcQoycGkJMrrXRIZLsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd0sxUI43JbGyKrUoHyYlzcGi
	JM6rvkTdT0ggPbEkNTs1tSC1CCYrw8GhJMFrC4xsIcGi1PTUirTMnBKENBMHJ8hwLimR4tS8
	lNSixNKSjHhQTMYXA6MSJMUDtPdzOcje4oLEXKAoROspRl2OI/vvrWUSYsnLz0uVEuedAFIk
	AFKUUZoHtwKW3l4xigN9LMzrDnIJDzA1wk16BbSECWjJ8iPhIEtKEhFSUg2Msy+Z/6z3ehPm
	ZvyShUlv1uNd3/NOTOh9zXiuq6C+d63GwRPnE5JvVPrcf7Gcc9nv+btvCUju//f7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296887>

On 06/07/2016 07:03 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> We want ref_stores to be polymorphic, so invent a base class of which
>> files_ref_store is a derived class. For now there is a one-to-one
>> relationship between ref_stores and submodules.
> 
> The mention of "submodules" made me go "Huh?" but thinking about it
> for a second it is clear and obvious.  We often peek into refs in a
> different repository that is a submodule, and we do not mix them with
> our own refs.  Logically that is what a "ref store" is, and one-to-one
> relationship is expected.
> 
>> @@ -1284,3 +1288,90 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>>  	errno = ELOOP;
>>  	return NULL;
>>  }
>> +
>> +static struct ref_store *main_ref_store = NULL;
>> +
>> +static struct ref_store *submodule_ref_stores = NULL;
> 
> Let's let BSS take care of these initialization.

I like the `= NULL` because it expresses "yes, I care about the initial
values of these variables", which to me is more valuable than saving a
few bytes in the size of the executable. But in fact, GCC does the
obvious optimization: it detects that these variables are being
initialized to zero, and puts them in BSS anyway. I'd be surprised if
other compilers don't do the same. So I'd prefer to leave this as-is, if
it's OK with you.

>> [...]
>>  /*
>> + * Return a pointer to the reference store for the specified
>> + * submodule. For the main repository, use submodule==NULL; such a
>> + * call cannot fail. For a submodule, the submodule must exist and be
>> + * a nonbare repository, otherwise return NULL. Verify that the
>> + * reference store is a files_ref_store, and cast it to that type
>> + * before returning it.
>>   */
>> +static struct files_ref_store *get_files_ref_store(const char *submodule,
>> +						   const char *caller)
>>  {
>> +	struct ref_store *refs = get_ref_store(submodule);
>>  
>> +	return refs ? files_downcast(refs, 1, caller) : NULL;
>>  }
> 
> This comment may be barking up a wrong tree, but the support for
> class inheritance makes me wonder if I can do something along this
> line:
> 
>  * implement a filesystem based ref_store, that is very similar to
>    what you have as files_ref_store, but 
> 
>    - when storing a ref as a loose ref, or when checking if a ref
>      exists as a loose ref, quote them somehow (e.g. a branch
>      "Branch" is not stored as a file "$GIT_DIR/refs/heads/branch"
>      but by using "^" as a single shift marker, i.e. as
>      "$GIT_DIR/refs/heads/^branch");
> 
>    - when enumerating what refs we have as loose refs, unquote what
>      readdir(3) gave us, e.g. seeing "$GIT_DIR/refs/heads/^branch",
>      I say "there is a branch whose name is 'Branch'".
> 
>  * as locking and other 'methods' are likely to be very similar to
>    your files_ref_store, make this new backend as a subclass of it,
>    i.e. create a new class but function pointers to many methods are
>    copied from files ref_store vtable.

That is definitely something we could implement in the future. If I were
going to design an extension like this, I think I'd go straight to
something more expressive; maybe something like URL-encoding. For
example, we might like a system that can record refnames with a Unicode
encoding that is determined by us rather than by the filesystem.

Depending on the details, it might be preferable to implement the new
ref-store as an encoding layer that delegates to an old-fashioned files
backend rather than using inheritance. In fact, you'd only want to do
the translation for the loose storage part, so in the end the
implemention might look something like

    overlay_ref_store(
        encoding_ref_store(loose_ref_store()),
        packed_ref_store())

> Would the strict "when downcasting to 'files', we make sure vtable
> is that of 'files' backend" interfere with such an approach?

True, the simple approach that I use above doesn't generalize to
implementation inheritance. But I'd rather cross that bridge when we
come to it. Implementing an RTTI system in C is a bit ambitious and, I
think, comes with runtime costs.

Michael
