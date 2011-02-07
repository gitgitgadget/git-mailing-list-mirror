From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Mon, 07 Feb 2011 14:51:52 -0800
Message-ID: <7vk4hbsbjr.fsf@alter.siamese.dyndns.org>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
 <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
 <4D4063EC.7090509@lsrfire.ath.cx> <4D432735.8000208@lsrfire.ath.cx>
 <7v1v3wd1al.fsf@alter.siamese.dyndns.org> <4D437CA0.1070006@lsrfire.ath.cx>
 <7vsjwcb6rh.fsf@alter.siamese.dyndns.org> <4D4477E4.6020006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 07 23:52:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmZwL-0003dU-7L
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 23:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab1BGWwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 17:52:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab1BGWwF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 17:52:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDDF03156;
	Mon,  7 Feb 2011 17:53:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VhTPS/aP1rJU
	Lryn/DZkozXryok=; b=lvDdVMqcyLMiYvRJlFmZvRM854GHipJODxYj5+5NjKzl
	HjOjLN0IxgWqLqRjWvjlIbNscJJa3L0awKwL14BPAm1C7KrzK/JyclqkDPEhtSVm
	yvzGEo75LBybS3s5CyrojExPxWh6Ew8nT/q8dunengh/SvRulLfgMgY5TkY43EU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sqo/7m
	OHHh3zureCLz7rKYgfKTxGA2Ony8UlG53dZA55f27g/vdi+g+hogX2/pNmv3EBMC
	HH1cYQgWLlkXwFFNX/dRhrOR+oFC/LXFPT745MaZS/hH+92vPDD1bOxg/63uCHzD
	R+lzVTuxBApHjq9JDiBHF2z4hceWusCTXZ4Bo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 997153153;
	Mon,  7 Feb 2011 17:52:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 42E063148; Mon,  7 Feb 2011
 17:52:51 -0500 (EST)
In-Reply-To: <4D4477E4.6020006@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat\, 29 Jan 2011 21\:26\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01065EC8-330D-11E0-A52B-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166308>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev=
-list-graph-simplify-history.sh
> index f7181d1..50ffcf4 100755
> --- a/t/t6016-rev-list-graph-simplify-history.sh
> +++ b/t/t6016-rev-list-graph-simplify-history.sh
> @@ -168,6 +168,7 @@ test_expect_success '--graph --full-history --sim=
plify-merges -- bar.txt' '
>  	echo "|\\  " >> expected &&
>  	echo "| * $C4" >> expected &&
>  	echo "* | $A5" >> expected &&
> +	echo "* | $A4" >> expected &&
>  	echo "* | $A3" >> expected &&
>  	echo "|/  " >> expected &&
>  	echo "* $A2" >> expected &&

Thanks for a patch with a test; I am not sure if this is quite correct,
though.

A4 has three parents, C2, A3 and B2, and does not introduce any change
with respect to bar.txt.  A6 has bar.txt identical to that of A5, but w=
e
cannot omit it because we are showing its two parents (A5 and C4), and
that is why we show it.  A4 isn't even gets shown as a merge, so I don'=
t
understand why we need to show it?

Don't we need to also adjust the simplify-merges codepath to take this
change into account, or something?
