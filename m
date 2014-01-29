From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive.c: reduce scope of variables
Date: Wed, 29 Jan 2014 10:28:10 -0800
Message-ID: <xmqqa9eek5hh.fsf@gitster.dls.corp.google.com>
References: <1391001515-5672-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 29 19:28:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8Zs6-0001xL-5u
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 19:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbaA2S2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 13:28:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796AbaA2S2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 13:28:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1940668533;
	Wed, 29 Jan 2014 13:28:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ncuc5OLu4dkzunqcD7Z7V8a0LW4=; b=TgCXk9
	SvceRUwamgXX/+EpwGOwPnXNSToJjkdcv5VtQCGuV6yVe2w38cJ5jVe4XTGx+VqB
	h8lUCj4IQJUXJllbv3/jwPzIXKez5hZ/HXtyCS9nuxT+rUD240be16Em9w6BTUBq
	mMG+dC6/HF/GnATNAmwQNi6Sno0IpATWyYL0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E9Q5Dkic+CkFa4wNXaua413YI8ywkcke
	u5ToiYP1UTChogr/ntf8hNcG5O8TLcmRYLCUQRyJvu8dsiqZKmZ1llvQqcGKSnPW
	DMqT6ezuY24+QOiXN47DLKYIieKOoHIC+ksOjelS5/6YsSe3XB92YFb0XzSRBkoM
	p26kTV0TIZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70E3C68530;
	Wed, 29 Jan 2014 13:28:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB1406852B;
	Wed, 29 Jan 2014 13:28:12 -0500 (EST)
In-Reply-To: <1391001515-5672-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Wed, 29 Jan 2014 05:18:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C8ED8C8-8913-11E3-BDAD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241218>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---

Either the patch is whitespace damaged during the mail transport, or
you are incorrectly indenting the lines with all spaces.

>  archive.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 346f3b2..49b79f8 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -112,7 +112,6 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>  	write_archive_entry_fn_t write_entry = c->write_entry;
>  	struct git_attr_check check[2];
>  	const char *path_without_prefix;
> -	int err;
>  
>  	args->convert = 0;
>  	strbuf_reset(&path);
> @@ -132,6 +131,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>  	}
>  
>  	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> +                int err;
>  		if (args->verbose)
>  			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>  		err = write_entry(args, sha1, path.buf, path.len, mode);
> @@ -319,7 +319,6 @@ static int parse_archive_args(int argc, const char **argv,
>  	const char *output = NULL;
>  	int compression_level = -1;
>  	int verbose = 0;
> -	int i;
>  	int list = 0;
>  	int worktree_attributes = 0;
>  	struct option opts[] = {
> @@ -366,6 +365,7 @@ static int parse_archive_args(int argc, const char **argv,
>  		base = "";
>  
>  	if (list) {
> +                int i;
>  		for (i = 0; i < nr_archivers; i++)
>  			if (!is_remote || archivers[i]->flags & ARCHIVER_REMOTE)
>  				printf("%s\n", archivers[i]->name);
