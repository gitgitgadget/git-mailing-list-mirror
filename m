From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 13/15] gettextize: git-revert messages using the "me"
 variable
Date: Mon, 6 Sep 2010 13:50:23 -0500
Message-ID: <20100906185023.GE25426@burratino>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
 <1283775704-29440-14-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 20:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osgnr-0000Vu-Jb
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab0IFSwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 14:52:23 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44871 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab0IFSwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 14:52:21 -0400
Received: by qwh6 with SMTP id 6so4044998qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aB8pjyQVedKBE6jWn1XnO16P48bXzmq2O09PAc5uqHo=;
        b=aTq2jyCYnmrGvJ5T6A5JlTRkffFM2dB7VbmKyKYKa3TpUgUwdZi+zp2OWk59ha2FCz
         nhyFRMLOzuT5QCnLEpSSK5LiQYxfTw1/ikSc9awDouU1ACAhEEboDkQrsc29e0ZuNDI8
         KmINPIHydQSf8ejyE8ugs6jPYde5r72yg6gOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cSHqUADuAc2/nm3IwSGi6Pc5u4MY/iQUhmHgvzh6PvT6+4MV+Nk7nQGWZRZVMlm1ES
         OAYiZprfyAtKT1nP4+2Flv7u0MqwDFFgJw1THo1lp0RWGIrbDZewqXP5GZpun9XuGhTY
         mNMUhnDp58I+JWIiXNuuhviOMwNf41IDjRAMQ=
Received: by 10.224.28.71 with SMTP id l7mr15407qac.247.1283799141002;
        Mon, 06 Sep 2010 11:52:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id l13sm5935816qck.7.2010.09.06.11.52.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 11:52:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283775704-29440-14-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155600>

(+cc: Christian, de facto cherry-pick maintainer)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Mark messages that used the "me" variable for translation. The
> potential values of the variable had already been marked using N_(),
> so we can use _(me) here.

Ah, now I understand better.  Would it be possible to squash this
patch with the previous one (for clarity)?

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -286,10 +286,10 @@ static NORETURN void die_dirty_index(const char=
 *me)
>  		die_resolve_conflict(me);
>  	} else {
>  		if (advice_commit_before_merge)
> -			die("Your local changes would be overwritten by %s.\n"
> -			    "Please, commit your changes or stash them to proceed.", me);
> +			die(_("Your local changes would be overwritten by %s.\n"
> +			    "Please, commit your changes or stash them to proceed."), _(m=
e));
>  		else
> -			die("Your local changes would be overwritten by %s.\n", me);
> +			die(_("Your local changes would be overwritten by %s.\n"), _(me))=
;

Good.

> @@ -339,7 +339,7 @@ static int do_recursive_merge(struct commit *base=
, struct commit *next,
>  	if (active_cache_changed &&
>  	    (write_cache(index_fd, active_cache, active_nr) ||
>  	     commit_locked_index(&index_lock)))
> -		die("%s: Unable to write new index file", me);
> +		die(_("%s: Unable to write new index file"), _(me));

Not good, in my opinion.  The dialogue ought to look like this, I think=
:

 $ git cherry-pick astermay
 ...
 fatal: cherry-pick: Unableway otay itewray ewnay indexway ilefay

> @@ -446,8 +446,8 @@ static int do_pick_commit(void)
>  		return fast_forward_to(commit->object.sha1, head);
> =20
>  	if (parent && parse_commit(parent) < 0)
> -		die("%s: cannot parse parent commit %s",
> -		    me, sha1_to_hex(parent->object.sha1));
> +		die(_("%s: cannot parse parent commit %s"),
> +		    _(me), sha1_to_hex(parent->object.sha1));

Likewise.

> @@ -570,7 +570,7 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
>  	}
> =20
>  	if (read_cache() < 0)
> -		die("git %s: failed to read the index", me);
> +		die(_("git %s: failed to read the index"), _(me));

Likewise.

With the exceptions mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
