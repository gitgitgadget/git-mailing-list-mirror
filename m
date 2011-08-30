From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6030: use $SHELL_PATH to invoke user's preferred shell
 instead of bare sh
Date: Tue, 30 Aug 2011 13:15:59 -0700
Message-ID: <7vfwki1wqo.fsf@alter.siamese.dyndns.org>
References: <Sn_8tnPB8FBe4C5QxoGkIRcdzJ2sLq_-h0oZ37fkrq42HJgWSlGgty_hMznS2ckiKKOg66yY7R2mRQqhJAzedr762dMKb_s6ELjELyGXyU-tkJzir-FnxhCkAIb3q1028d5FrBBy6EW3SXEPBMTYTw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 30 22:16:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyUjA-0006nU-IU
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 22:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561Ab1H3UQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 16:16:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756554Ab1H3UQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 16:16:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DCB54034;
	Tue, 30 Aug 2011 16:16:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZyM63aS7E6O1EbxHwTLabS0boSU=; b=k7c9Nb
	0KLXZqi29Laja0dycS3JMQ2aSfoehEXVtpb8YThd+K9BoCvpemPopQCJHgPQtDMD
	DHXjYK9kxfc6pO6z5H70fZ6RlqgGYq/Wk2MIDETb4OWiCBUBiJf7zk3CMCYPnRT5
	UVuyIAxFNI5N3ZHudTdFaH/s809JhyQ5Fe/JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NFFt9iG068FhpsOZqizdgsHEvzSY+IfT
	hYVRBi5C6vJEcIIPtmxg/DjcZ+OIlzn79jmD2TmtTO1EYQtKHhJM5AN8lnXNop34
	sz9Gc+/CSgrz1VNbWdvWSEO/l1ZtXepX816g4vFWY0n/ynioxRJ5fxpuJFgVslX8
	AhlPLLMjAvI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7564E4032;
	Tue, 30 Aug 2011 16:16:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6ECE4031; Tue, 30 Aug 2011
 16:16:00 -0400 (EDT)
In-Reply-To: <Sn_8tnPB8FBe4C5QxoGkIRcdzJ2sLq_-h0oZ37fkrq42HJgWSlGgty_hMznS2ckiKKOg66yY7R2mRQqhJAzedr762dMKb_s6ELjELyGXyU-tkJzir-FnxhCkAIb3q1028d5FrBBy6EW3SXEPBMTYTw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon, 29 Aug 2011 13:09:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E119D8FA-D344-11E0-A0F6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180439>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Some platforms (IRIX, Solaris) provide an ancient /bin/sh which chokes on
> modern shell syntax like $().  SHELL_PATH is provided to allow the user to
> specify a working sh, let's use it here.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  t/t6030-bisect-porcelain.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 62125ec..c53af62 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -732,7 +732,7 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
>  	git bisect reset &&
>  	git checkout broken &&
>  	git bisect start broken master --no-checkout &&
> -	git bisect run sh -c '
> +	git bisect run \"$SHELL_PATH\" -c '
>  		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
>  		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
>  		git pack-objects --stdout >/dev/null < tmp.\$\$

Hmm, shouldn't we also be quoting '$' in front of SHELL_PATH to make the
test_expect_success interpolate the value of SHELL_PATH, instead of hoping
that SHELL_PATH does not have double-quote in it when the shell that forms
parameters given to test_expect_success interpolates it?
