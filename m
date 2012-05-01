From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: modernize style of t4006
Date: Tue, 01 May 2012 11:00:17 -0700
Message-ID: <7vzk9r93ym.fsf@alter.siamese.dyndns.org>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
 <1335892215-21331-2-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mj@ucw.cz
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 01 20:00:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHNC-0000cc-UV
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758434Ab2EASAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 14:00:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758422Ab2EASAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 14:00:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCF92691C;
	Tue,  1 May 2012 14:00:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0B4+ra3S8RHg
	iS+bCWCHZRzlLXs=; b=PvTGH9fqIgKEQdOXdlLl6GVLG/N4kYnnOrv9WQvaTB0q
	bq5waybtYzKEo/T6zY42S6ZdioqlaKw93iAI8sJrK/8tPyhtp2mZYxTd3UcQ/ttE
	xjDzvPoWAJkxodPbvTgNHyjEH+r4bSgZIoLTESTRbyxZHJ8iehdX+lSWzpVGLv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZlJVm1
	el82ev8LxUFj7neZFRqXVZDokQ/CfJlpG/UlNDUElL4vYsVi42GxYkU1aDodGsaS
	8Y7axatI9W3SEHzaT6r+e8Kdt1VBLebsGlkjWkV2HAPINLtr7dU3V3b83OMfUAxb
	p0ggZ4Atw7RyRyjOLR7kuvYCXBqqRIVvcLCgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C32EC691B;
	Tue,  1 May 2012 14:00:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 475096918; Tue,  1 May 2012
 14:00:19 -0400 (EDT)
In-Reply-To: <1335892215-21331-2-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Tue, 1 May 2012 19:10:12
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 838ABCA2-93B7-11E1-BBCD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196718>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
>  t/t4006-diff-mode.sh |   32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)

Style update is welcome, but shouldn't the assignment to sed_script
be done in the second test if it is the only user?  If you are going to
add more tests at the end, then it should be away from the second test =
to
make it clear that it is not part of it.

Thanks.

> diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
> index ff8c2f7..c8f5180 100755
> --- a/t/t4006-diff-mode.sh
> +++ b/t/t4006-diff-mode.sh
> @@ -8,23 +8,21 @@ test_description=3D'Test mode change diffs.
>  '
>  . ./test-lib.sh
> =20
> -test_expect_success \
> -    'setup' \
> -    'echo frotz >rezrov &&
> -     git update-index --add rezrov &&
> -     tree=3D`git write-tree` &&
> -     echo $tree'
> -
> -test_expect_success \
> -    'chmod' \
> -    'test_chmod +x rezrov &&
> -     git diff-index $tree >current'
> -
> -sed -e 's/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /' <current >c=
heck
> -echo ":100644 100755 X X M	rezrov" >expected
> +test_expect_success 'setup' '
> +	echo frotz >rezrov &&
> +	git update-index --add rezrov &&
> +	tree=3D`git write-tree` &&
> +	echo $tree
> +'
> =20
> -test_expect_success \
> -    'verify' \
> -    'test_cmp expected check'
> +# $_x40 is defined in test-lib.sh
> +sed_script=3D's/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /'
> +test_expect_success 'chmod' '
> +	test_chmod +x rezrov &&
> +	git diff-index $tree >current &&
> +	sed -e "$sed_script" <current >check &&
> +	echo ":100644 100755 X X M	rezrov" >expected &&
> +	test_cmp expected check
> +'
> =20
>  test_done
