From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] Rename cryptic 'which' variable to more consistent
 name
Date: Sun, 02 Sep 2012 12:56:29 -0700
Message-ID: <7vd324gnnu.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-4-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:45:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2a-0000NT-JA
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917Ab2IBUop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808Ab2IBUok (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 158528324;
	Sun,  2 Sep 2012 16:44:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=a7v+mAhoc+L2VkcqCWL/y6wneqg=; b=RjMPaUwW+6HJRGI/14hy
	7gc7YghZcuSYvbgON42VWbWmZIbqyrqZLBiW2YpmPmVaFjguU5xgjAM9aLEUU6Xd
	uln+WAeQSPRDhxbjwr9cTAm5SOK0owymsFHyFrVgjAgeeVPZ/Hx5l+X8ZqsuTBTi
	OZDcrSgonASLnnwnwT6kJp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=kTQ+nR9sWCJJFvQfSyfhKXc/Sk3HKGQIg8Mu1Gej9m3Ou3
	lAoYdLm8yQGmHbJeBYu8JkgVtjvFFyH5B2fAqSoORzTDmvH3vXk9d2ayUL+s+8wa
	/luwVNbErHbDsDQ3ZnkAaAMFIq7bkalA2hvdlhtfPbdKwHrL7jLIDHxaI70ZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02AF78323;
	Sun,  2 Sep 2012 16:44:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 447CB8322; Sun,  2 Sep 2012
 16:44:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03C6136A-F53F-11E1-8E9A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204675>

Adam Spiers <git@adamspiers.org> writes:

> 'el' is only *slightly* less cryptic, but is already used as the
> variable name for a struct exclude_list pointer in numerous other
> places, so this reduces the number of cryptic variable names in use by
> one :-)

The name originally meant to mean "to which element of the array
dir_struct.exclude_list[] are we adding this entry?" but I agree
"el" that stands for ExcludeList would be a better name.

Often we use "el" (or "elem") for elements of an iterable we are
iterating on in a loop, and the name of the iterable does not have
to be EsomethingLsomething, by the way.  Because no existing use of
"el" in this file is of that kind, I do not think this change
introduces new confusion to the code.

> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  dir.c | 10 +++++-----
>  dir.h |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index c9f341a..57a5d11 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -311,7 +311,7 @@ static int no_wildcard(const char *string)
>  }
>  
>  void add_exclude(const char *string, const char *base,
> -		 int baselen, struct exclude_list *which)
> +		 int baselen, struct exclude_list *el)
>  {
>  	struct exclude *x;
>  	size_t len;
> @@ -346,8 +346,8 @@ void add_exclude(const char *string, const char *base,
>  	x->nowildcardlen = simple_length(string);
>  	if (*string == '*' && no_wildcard(string+1))
>  		x->flags |= EXC_FLAG_ENDSWITH;
> -	ALLOC_GROW(which->excludes, which->nr + 1, which->alloc);
> -	which->excludes[which->nr++] = x;
> +	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
> +	el->excludes[el->nr++] = x;
>  }
>  
>  static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
> @@ -389,7 +389,7 @@ int add_excludes_from_file_to_list(const char *fname,
>  				   const char *base,
>  				   int baselen,
>  				   char **buf_p,
> -				   struct exclude_list *which,
> +				   struct exclude_list *el,
>  				   int check_index)
>  {
>  	struct stat st;
> @@ -436,7 +436,7 @@ int add_excludes_from_file_to_list(const char *fname,
>  		if (buf[i] == '\n') {
>  			if (entry != buf + i && entry[0] != '#') {
>  				buf[i - (i && buf[i-1] == '\r')] = 0;
> -				add_exclude(entry, base, baselen, which);
> +				add_exclude(entry, base, baselen, el);
>  			}
>  			entry = buf + i + 1;
>  		}
> diff --git a/dir.h b/dir.h
> index a226fbc..549a187 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -117,10 +117,10 @@ extern int path_excluded(struct path_exclude_check *, const char *, int namelen,
>  
>  
>  extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
> -					  char **buf_p, struct exclude_list *which, int check_index);
> +					  char **buf_p, struct exclude_list *el, int check_index);
>  extern void add_excludes_from_file(struct dir_struct *, const char *fname);
>  extern void add_exclude(const char *string, const char *base,
> -			int baselen, struct exclude_list *which);
> +			int baselen, struct exclude_list *el);
>  extern void free_excludes(struct exclude_list *el);
>  extern int file_exists(const char *);
