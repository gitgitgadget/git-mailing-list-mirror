From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] test: use test_i18ncmp when checking --stat output
Date: Mon, 12 Mar 2012 23:00:43 -0700
Message-ID: <7vzkblkpkk.fsf@alter.siamese.dyndns.org>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino> <20120313045404.GA12550@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 07:00:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Kmx-0005Dj-H2
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 07:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759674Ab2CMGAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 02:00:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759244Ab2CMGAp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 02:00:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A6B43068;
	Tue, 13 Mar 2012 02:00:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fIwP3mhE4FdbVkShtJ5lXgawCeM=; b=k2po75
	j+O0plDgpMO75bzWanwzss5yQVTKtItQGDmwq8dIF7KsCuWnWKgoA0aA23Xjpt2j
	TjnVNml2cxqxz3D7FjEfMQDK5vmgdpohPP/NMqV/Z/8L3P3AGRzHDGb5jkbMSJTM
	yX/TDsDjfHE5GgkLo7UqzbnQVaAEgxxxnoCPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FYXTh2skxEen8kRx3nHx++GoxWg1Q4qF
	Gbvzdpdbji5a5nzmcshnrbbX6ADERs8H+3yOZv61tUR9e8evjyfWFb+nqDicnb0N
	VbuNMrbaVueL0cZwjI+LjCqRiblAh28K/wi29qS4wawHuxBkDfOAOHAxODtWKt+a
	/JJ3kdc8UBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105103067;
	Tue, 13 Mar 2012 02:00:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 888A93066; Tue, 13 Mar 2012
 02:00:44 -0400 (EDT)
In-Reply-To: <20120313045404.GA12550@burratino> (Jonathan Nieder's message of
 "Mon, 12 Mar 2012 23:54:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF2B444E-6CD1-11E1-B019-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192981>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
> index 1b3a3441..d909e6db 100755
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -55,7 +55,7 @@ test_expect_success 'cherry-pick first..fourth works' '
>  	git diff --quiet HEAD other &&
>  
>  	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
> -	test_cmp expected actual.fuzzy &&
> +	test_i18ncmp expected actual.fuzzy &&
>  	check_head_differs_from fourth
>  '
>  
> @@ -82,7 +82,7 @@ test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
>  	git diff --quiet other &&
>  	git diff --quiet HEAD other &&
>  	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
> -	test_cmp expected actual.fuzzy &&
> +	test_i18ncmp expected actual.fuzzy &&
>  	check_head_differs_from fourth
>  '

Honestly speaking, I am not sure if we should be making these
comparisons to cast the informational output from cherry-pick
that is meant for human concumption in stone to begin with.

I think "cherry-pick first..fourth works" test should be comparing
the output from something like "log --format=%s" over the range
before and after the replaying.

All the other changes in this patch I do agree with; in C locale
these are expected to exactly match what we specify in these tests
and I do not see any reason to update them, but it is OK that they
are translated and attempting to limit the matches to untranslatable
part is not worth it.  test_i18ncmp is the tool for such comparison.

But I do not think the progress output from range cherry-pick needs
to be cast in stone even in C locale, hence the comments in the
first two paragraphs from me.
