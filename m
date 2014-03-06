From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] merge hook tests: fix missing '&&' in test
Date: Thu, 06 Mar 2014 13:27:03 -0800
Message-ID: <xmqqmwh3vx08.fsf@gitster.dls.corp.google.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	<1394117424-29780-6-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:27:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfow-0000D7-GA
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbaCFV1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:27:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbaCFV1H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:27:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B533370C77;
	Thu,  6 Mar 2014 16:27:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wA0/LS4xjTxWcnkV4EvF4fyDhEo=; b=U+pKlv
	hWjapZ/5TpunGlVVWQB76ilTSYVA9d97D+dTRFqN54kHK5JlnCM2ryCjKplQSTZw
	yEG+pPm8z7bBPWBecU6Uv0zf3sbXkg3Iqjhi+uo+PaQp2V0+kXvPKvSwm6+kNfu9
	lI5u8mpvSySW1i3pZJzqg2fMBYcmesSQPPcQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NA4o3AUNVv2BhGce8KnLd4ig9YP+D06k
	F0A4zrvenc7J7MfhN3l0VOsbAbtr2TeBHtVfRiXkRskPHTFcge3xZsN2k4yqKbVm
	Qx1p851a0ZmM+1kEgzVDNTH38bOLyB9VJuLjDPXj+8hnUoqBDdzIWRaBxBPvlZ58
	8O9ieHvTIho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A226970C76;
	Thu,  6 Mar 2014 16:27:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B627C70C74;
	Thu,  6 Mar 2014 16:27:05 -0500 (EST)
In-Reply-To: <1394117424-29780-6-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Thu, 6 Mar 2014 15:50:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 10C88960-A576-11E3-841F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243556>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---

Please have these preparatory fix-ups (i.e. the changes that would
be immediately useful even if it turns out that the main body of the
series were not ready for inclusion) early in the series, not late
as 5th patch of a 6 patch series.

Thanks.

>  t/t7505-prepare-commit-msg-hook.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> index ae7b2db..604c06e 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -189,7 +189,7 @@ test_expect_success 'with failing hook (merge)' '
>  	git add file &&
>  	rm -f "$HOOK" &&
>  	git commit -m other &&
> -	write_script "$HOOK" <<-EOF
> +	write_script "$HOOK" <<-EOF &&
>  	exit 1
>  	EOF
>  	git checkout - &&
