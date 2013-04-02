From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] peel_onion(): teach $foo^{object} peeler
Date: Tue, 02 Apr 2013 10:20:23 +0200
Message-ID: <515A94C7.3000406@alum.mit.edu>
References: <51543FDB.9010109@alum.mit.edu> <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com> <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net> <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu> <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu> <7vboa1qtnb.fsf@alter.siamese.dyndns.org> <7vhajtpdtc.fsf@alter.siamese.dyndns.org> <7vy5d3nqik.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 10:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMwSj-0007VR-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 10:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761090Ab3DBIU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 04:20:29 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:64771 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760295Ab3DBIU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 04:20:27 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-ef-515a94c9c9c7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B4.79.02380.9C49A515; Tue,  2 Apr 2013 04:20:26 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r328KNew032608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Apr 2013 04:20:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vy5d3nqik.fsf_-_@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqHtqSlSgQf9nRouuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bm9+w4wFjyTrrhzTr+B8bNo
	FyMnh4SAicScectYIGwxiQv31rOB2EIClxklPm3w7WLkArKPMUmcOv2JFSTBK6At0bT8OJDN
	wcEioCpxZLIESJhNQFdiUU8zE4gtKhAmsffCNDaIckGJkzOfgM0XEVCTmNh2iAWklVnAVeLz
	jCSQsLCAo8Trd/uZIFZdZpZ4cuoD2HhOAUuJt72WIDXMAjoS7/oeMEPY8hLb385hnsAoMAvJ
	hllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyRo+XYwtq+X
	OcQowMGoxMPrMCcyUIg1say4MvcQoyQHk5Io74FJUYFCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHi36gLleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvFbA6BQSLEpN
	T61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VofDEwSkFSPEB7b4LcxFtckJgLFIVoPcWo
	y9G16PMrRiGWvPy8VClx3vuTgYoEQIoySvPgVsBS1CtGcaCPhXm5QC7hAaY3uEmvgJYwAS1Z
	discZElJIkJKqoFxxrnHizgmh9SwcV1K7e15HskeoH/jxIf6FD7Dj4v+VIZ5ZHwREq6OvJEl
	VeJiZmjf6vXpd9/mDpZy1rLshU19Nu/V31k+eqzH7rk/YE6tzwnhQ1zPJ/dtCElv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219754>

While I was in the middle of suggesting documentation for this new
syntax, I discovered that you already added documentation to your repo
but didn't mention the new version on the mailing list (or maybe I
overlooked it).  It would be helpful if you would submit your own
changes to the mailing list to make it harder for the rest of us to
overlook them--and easier to look over them :-)

The documentation looks fine to me.

Off topic: Your patch reminds me of something else that surprised me:
there is no "$userstring^{tag}".  I suppose it would be a bit ambiguous,
given that tags can point at tags, and it would also be less useful than
the other suffixes.  But its absence irked the completionist in me :-)

Michael

On 04/01/2013 12:38 AM, Junio C Hamano wrote:
> A string that names an object can be suffixed with ^{type} peeler to
> say "I have this object name; peel it until you get this type. If
> you cannot do so, it is an error".  v1.8.2^{commit} asks for a commit
> that is pointed at an annotated tag v1.8.2; v1.8.2^{tree} unwraps it
> further to the top-level tree object.  A special suffix ^{} (i.e. no
> type specified) means "I do not care what it unwraps to; just peel
> annotated tag until you get something that is not a tag".
> 
> When you have a random user-supplied string, you can turn it to a
> bare 40-hex object name, and cause it to error out if such an object
> does not exist, with:
> 
> 	git rev-parse --verify "$userstring^{}"
> 
> for most objects, but this does not yield the tag object name when
> $userstring refers to an annotated tag.
> 
> Introduce a new suffix, ^{object}, that only makes sure the given
> name refers to an existing object.  Then
> 
> 	git rev-parse --verify "$userstring^{object}"
> 
> becomes a way to make sure $userstring refers to an existing object.
> 
> This is necessary because the plumbing "rev-parse --verify" is only
> about "make sure the argument is something we can feed to get_sha1()
> and turn it into a raw 20-byte object name SHA-1" and is not about
> "make sure that 20-byte object name SHA-1 refers to an object that
> exists in our object store".  When the given $userstring is already
> a 40-hex, by definition "rev-parse --verify $userstring" can turn it
> into a raw 20-byte object name.  With "$userstring^{object}", we can
> make sure that the 40-hex string names an object that exists in our
> object store before "--verify" kicks in.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sha1_name.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sha1_name.c b/sha1_name.c
> index 45788df..85b6e75 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -594,7 +594,7 @@ struct object *peel_to_type(const char *name, int namelen,
>  	while (1) {
>  		if (!o || (!o->parsed && !parse_object(o->sha1)))
>  			return NULL;
> -		if (o->type == expected_type)
> +		if (expected_type == OBJ_ANY || o->type == expected_type)
>  			return o;
>  		if (o->type == OBJ_TAG)
>  			o = ((struct tag*) o)->tagged;
> @@ -645,6 +645,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>  		expected_type = OBJ_TREE;
>  	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
>  		expected_type = OBJ_BLOB;
> +	else if (!prefixcmp(sp, "object}"))
> +		expected_type = OBJ_ANY;
>  	else if (sp[0] == '}')
>  		expected_type = OBJ_NONE;
>  	else if (sp[0] == '/')
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
