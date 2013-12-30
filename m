From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: remove unused variable
Date: Mon, 30 Dec 2013 12:22:18 -0800
Message-ID: <xmqqtxdqqebp.fsf@gitster.dls.corp.google.com>
References: <1388420935-14030-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 21:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxjM1-0001VG-Bh
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 21:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187Ab3L3UWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 15:22:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117Ab3L3UWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 15:22:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 899CD5F0D8;
	Mon, 30 Dec 2013 15:22:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=di+vNTEyKXe24B5UBqE4MFAjQ1c=; b=ouxj1j
	dpKczwHEzGtiTU6EVstynwYtwhd4wU+5IBwuDdI8AwWGmHmBB4vqNPYoo3P64DVt
	U3GvidnX/b7LvoCyVOe8R47IBOWTKbQsXHrFF1uk3zvSn4aDFSuB115k57a8US4S
	wz1vr97zAR+liU7H/67lnb0O5nJTKFDCMgB5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KSh40OqRsaYrwoPT2IuXKv7Vhh5mWulg
	+j2DbRs9hD5a3PW2Okrmr7UB5TQ08Y9Ah8bKpkd7dhiMl/YO5ep+z5GsaKHzyZ0N
	oBJpghgH2Wfb0dfTUptC0yNA5m3M8OMwhp/QU4yOk71NCd6eJ6XDRaprHUuXcgCV
	lyUeqdlV3oM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A75F5F0D7;
	Mon, 30 Dec 2013 15:22:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB3F65F0D6;
	Mon, 30 Dec 2013 15:22:19 -0500 (EST)
In-Reply-To: <1388420935-14030-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 30 Dec 2013 21:58:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 155FB7C4-7190-11E3-9D42-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239822>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Interesting. As far as I can tell, no code ever used this symbol
since the command was introduced at 9f613ddd (Add git-for-each-ref:
helper for language bindings, 2006-09-15).

>  builtin/for-each-ref.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 6551e7b..51798b4 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -92,7 +92,7 @@ static struct {
>   */
>  static const char **used_atom;
>  static cmp_type *used_atom_type;
> -static int used_atom_cnt, sort_atom_limit, need_tagged, need_symref;
> +static int used_atom_cnt, need_tagged, need_symref;
>  static int need_color_reset_at_eol;
>  
>  /*
> @@ -1105,7 +1105,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  
>  	if (!sort)
>  		sort = default_sort();
> -	sort_atom_limit = used_atom_cnt;
>  
>  	/* for warn_ambiguous_refs */
>  	git_config(git_default_config, NULL);
