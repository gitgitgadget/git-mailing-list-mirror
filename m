From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 15/15] Replace "unset VAR" with "unset VAR;" in
 testsuite as per t/README
Date: Wed, 29 Sep 2010 12:48:11 -0700
Message-ID: <7viq1omiv8.fsf@alter.siamese.dyndns.org>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-16-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 21:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P12di-0005R5-E3
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 21:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab0I2TsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 15:48:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab0I2TsT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 15:48:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB600DAA52;
	Wed, 29 Sep 2010 15:48:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Oh7sF7ZSnlMi
	2m3RU8rNs8088Cs=; b=RXEdrKDTtha2llwdZu9fw7eXMQ7Ke/DpW7zy3ww6/JmN
	OCn2QE7Q8oeKybcnOI5KmxyfnKs7FkOJ6DvtDtNlji0KoPGzg634zL0kf8GgNJFL
	usuSuzdPz4OQHh6VCtqcsUeAZN1ODc31izweegF7J+rAqAC0gslkw9U0XYTS4Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SRnI02
	9Z0StvhhTW6s57XSP+adYEYezVpIcSXFku9FnV5TsjVW0M5n48bEoBdF0bRVkHDA
	bCWdVoTmjlv5+cBHXazM5NOEFxKol+5HGTt1UgPdnck2X+0gI6kHuKNV3iiORcK8
	e5q5x170GB3UinIxmuTu9shqeyThHom5LqLxw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4940DAA51;
	Wed, 29 Sep 2010 15:48:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFE48DAA50; Wed, 29 Sep
 2010 15:48:12 -0400 (EDT)
In-Reply-To: <1285542879-16381-16-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\, 26 Sep 2010 17\:14\:39 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 803B4950-CC02-11DF-AD31-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157594>

Elijah Newren <newren@gmail.com> writes:

> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> @@ -175,8 +175,8 @@ test_expect_success 'init with init.templatedir s=
et' '
>  		git config -f "$test_config"  init.templatedir "${HOME}/templatedi=
r-source" &&
>  		mkdir templatedir-set &&
>  		cd templatedir-set &&
> -		unset GIT_CONFIG_NOGLOBAL &&
> -		unset GIT_TEMPLATE_DIR &&
> +		unset GIT_CONFIG_NOGLOBAL;
> +		unset GIT_TEMPLATE_DIR;
>  		NO_SET_GIT_TEMPLATE_DIR=3Dt &&
>  		export NO_SET_GIT_TEMPLATE_DIR &&
>  		git init
> @@ -187,7 +187,7 @@ test_expect_success 'init with init.templatedir s=
et' '
>  test_expect_success 'init --bare/--shared overrides system/global co=
nfig' '
>  	(
>  		test_config=3D"$HOME"/.gitconfig &&
> -		unset GIT_CONFIG_NOGLOBAL &&
> +		unset GIT_CONFIG_NOGLOBAL;
>  		git config -f "$test_config" core.bare false &&
>  		git config -f "$test_config" core.sharedRepository 0640 &&
>  		mkdir init-bare-shared-override &&
> @@ -202,7 +202,7 @@ test_expect_success 'init --bare/--shared overrid=
es system/global config' '
>  test_expect_success 'init honors global core.sharedRepository' '
>  	(
>  		test_config=3D"$HOME"/.gitconfig &&
> -		unset GIT_CONFIG_NOGLOBAL &&
> +		unset GIT_CONFIG_NOGLOBAL;
>  		git config -f "$test_config" core.sharedRepository 0666 &&
>  		mkdir shared-honor-global &&
>  		cd shared-honor-global &&

These three hunks look wrong as they break the && cascades.  All others
(including the change to 7502) look Ok.

Personally I do not agree that ";" at the end is explicit enough as
t/README seems to think.  If we want to be explicit, I'd say we should =
do
so by saying something like:

	unset VAR ;# can fail
