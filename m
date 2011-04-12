From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/7] i18n: mark init-db messages for translation
Date: Tue, 12 Apr 2011 00:12:30 -0700
Message-ID: <7v39lorli9.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:12:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9XmO-0006Xe-Cm
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 09:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab1DLHMm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 03:12:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727Ab1DLHMl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 03:12:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8C652698;
	Tue, 12 Apr 2011 03:14:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oom43CPAl4uk
	qgVRQBhkTVVRrZY=; b=OcVYRnUHIikC/3L9TH57L+BIuNQ1//k7bWO5E9wsw7Z/
	KGIhTjfigO3IuQuoSQB6HjCFalY+dj6Cydrqc0xLIFekRFPx23sjSl8NyDSsJVax
	edgeJ2ePrdZXSZwnTb2E7cxdBs2NNWknWmZQ5e8P5ZhjHk5NN7mRIpTFWFaYVIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TwNEfL
	nOFIPqf9JHgpFiybJCzysISe623VlxkisYNv/O/VSIAip1243xcekJFRKh1NItXk
	BQtQnPKgOpvHAs98aoWOtndQcEi/LEz/VM3GJK3dSsPR0Wm634jjNFSN6fWmSfGL
	8Qsl+Homjl/hKuTwbSEzfjWQuoi88Bq+1+v6w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B505C2697;
	Tue, 12 Apr 2011 03:14:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BF9C12696; Tue, 12 Apr 2011
 03:14:29 -0400 (EDT)
In-Reply-To: <1302464048-21806-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 10 Apr
 2011 19:34:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83B484FA-64D4-11E0-9E88-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171375>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>  	fp =3D fopen(git_link, "w");
>  	if (!fp)
> -		die("Could not create git link %s", git_link);
> -	fprintf(fp, "gitdir: %s\n", git_dir);
> +		die(_("Could not create git link %s"), git_link);
> +	fprintf(fp, _("gitdir: %s\n"), git_dir);
>  	fclose(fp);
>  }
> =20
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index a5816d0..fa31cbd 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -374,22 +374,28 @@ test_expect_success 'init prefers command line =
to GIT_DIR' '
>  test_expect_success 'init with separate gitdir' '
>  	rm -rf newdir &&
>  	git init --separate-git-dir realgitdir newdir &&
> -	echo "gitdir: `pwd`/realgitdir" >expected &&
> -	test_cmp expected newdir/.git &&
>  	test -d realgitdir/refs
>  '
> =20
> +test_expect_success C_LOCALE_OUTPUT 'init with separate gitdir: outp=
ut' '
> +	echo "gitdir: `pwd`/realgitdir" >expected &&
> +	test_cmp expected newdir/.git
> +'

I don't think this is correct.  The file "git_link" refers to .git that=
 is
not a directory but is a regular file whose contents is "gitdir: $path"
and that should _never_ be localized, so the patch to die() message is =
Ok,
but the string given to fprintf(fp, ...) is _not_.

And t0001 should compare the expected output with "gitdir: $path"
regardless of the poisoning.
