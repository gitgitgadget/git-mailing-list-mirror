From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 14/15] Add missing &&'s throughout the testsuite
Date: Wed, 29 Sep 2010 12:37:48 -0700
Message-ID: <7vmxr0mjcj.fsf@alter.siamese.dyndns.org>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-15-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 21:38:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P12Th-0001xU-AQ
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 21:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab0I2TiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 15:38:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab0I2TiA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 15:38:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CCC5DA8A8;
	Wed, 29 Sep 2010 15:37:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GEsiTk964w/RafRpeuPLHLo04Fw=; b=StmaXt
	5ZZwqob5LOuS4sCarlJqVIRqzSmyxu0SPa/FE9/Jd3u7Bz7QcDXccQJ9v9AKxIMH
	U+l/HtLmarfnsXBCDtjGB5zrTibJfX4F+0ssVpry3ASqAr74a95oGadb9u2LT8Be
	CUKeTjlV7YvMsRGkAp0bpVxCCBNz2bFoijAaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NPI/WspG691swmKI1wG4IHcIIj+OYWyB
	VwnAdFCxYZ6RK9cRYBxVZgG3CP9bc8VD/4aE95POsZHUeiC7ZaW6HdHNI4IErzDA
	zvkbouPfRW38RRobrkQoKMZ028Ps13a/8brR31G0l6Bqq3A/9+BE6YdgXnPTGaoD
	g9H12JjJwZc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56B99DA8A4;
	Wed, 29 Sep 2010 15:37:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51A43DA89B; Wed, 29 Sep
 2010 15:37:50 -0400 (EDT)
In-Reply-To: <1285542879-16381-15-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\, 26 Sep 2010 17\:14\:38 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E5A7B22-CC01-11DF-906F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157593>

Elijah Newren <newren@gmail.com> writes:

> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index de38c7f..ddd1c23 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -19,24 +19,23 @@ attr_check () {
>  test_expect_success 'setup' '
>  
>  	mkdir -p a/b/d a/c &&
> -	(
> -		echo "[attr]notest !test"
> -		echo "f	test=f"
> -		echo "a/i test=a/i"
> -		echo "onoff test -test"
> -		echo "offon -test test"
> -		echo "no notest"
> -	) >.gitattributes &&
> -	(
> -		echo "g test=a/g" &&
> -		echo "b/g test=a/b/g"
> -	) >a/.gitattributes &&
> -	(
> -		echo "h test=a/b/h" &&
> -		echo "d/* test=a/b/d/*"
> -		echo "d/yes notest"
> -	) >a/b/.gitattributes
> -
> +	cat <<EOF >.gitattributes &&

If you are not doing any variable substitution in the here document,
please quote EOF to make it clear, i.e.

	cat >.gitattributes <<\EOF &&

> @@ -73,7 +72,7 @@ offon: test: set
>  no: test: unspecified
>  a/b/d/no: test: a/b/d/*
>  a/b/d/yes: test: unspecified
> -EOF
> +EOF &&

Huh?  Cascading && (or ||) goes on the first line of <<HERE document, as
you wrote yourself in the above ;-)

> diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
> index 3c73a78..3d0384d 100755
> --- a/t/t4119-apply-config.sh
> +++ b/t/t4119-apply-config.sh
> @@ -73,7 +73,7 @@ D=`pwd`
>  test_expect_success 'apply --whitespace=strip in subdir' '
>  
>  	cd "$D" &&
> -	git config --unset-all apply.whitespace
> +	git config --unset-all apply.whitespace &&

At this point, do we know that the previous test that added
apply.whitespace to $D's configuration has successfully run and left the
variable, or do we need to say this might-fail?

> diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
> index 230143c..ddabf4f 100755
> --- a/t/t8003-blame.sh
> +++ b/t/t8003-blame.sh
> @@ -153,15 +153,15 @@ test_expect_success 'blame path that used to be a directory' '
>  '
>  
>  test_expect_success 'blame to a commit with no author name' '
> -  TREE=`git rev-parse HEAD:`
> +  TREE=`git rev-parse HEAD:` &&
>    cat >badcommit <<EOF
>  tree $TREE
>  author <noname> 1234567890 +0000
>  committer David Reiss <dreiss@facebook.com> 1234567890 +0000
>  
>  some message
> -EOF
> -  COMMIT=`git hash-object -t commit -w badcommit`
> +EOF &&

Huh, again?
