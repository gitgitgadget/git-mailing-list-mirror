From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above
 LIB_{H,OBJS}
Date: Mon, 15 Nov 2010 08:07:08 -0800
Message-ID: <7v8w0umuz7.fsf@alter.siamese.dyndns.org>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-2-git-send-email-avarab@gmail.com>
 <20101114172331.GA26459@burratino>
 <AANLkTinaDhXQjPC6s1eFb8HwEReW7P-ObmwRn2Hpb=O4@mail.gmail.com>
 <20101114185130.GA18385@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 17:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI1aa-0001LK-8u
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 17:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757846Ab0KOQHW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 11:07:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052Ab0KOQHV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 11:07:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DD6F2F29;
	Mon, 15 Nov 2010 11:07:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NLUd6jge51NT
	yKgc+ckN9wDV2Og=; b=ouSS+slB+9bJV0bdyuPmJPoY1aYGwflf+CuPM/bCWAYF
	ZjGLWilDc+qgshkJ0Kyu5Bk05Jymq+Vpck6UFhIxNg0XDWIQ6h8Dsvh7f/+SRfxd
	gITCRRAnM5rBd0j4ntzCbu/XE9PrNErS4B1aVYn0GfOBPcbbveJAsrH1BboMmd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ONbHK8
	3p4z3H6fdoUX9X2rnuTG5N0olRYN/sUsDK8syfRjSYhsz+1lOZkDEf5zXWdFSl1i
	PYn1e3h+LZbj2Ew8kEC57HO0ecptNB0liYat0/YHx8GFXl3wSHWiAOMgV3buGdA1
	6wehZRQTK1nJe/G3NRS+FA2arU9beeGk38Ukk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 518CE2F22;
	Mon, 15 Nov 2010 11:07:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EDBC12F1F; Mon, 15 Nov 2010
 11:07:18 -0500 (EST)
In-Reply-To: <20101114185130.GA18385@burratino> (Jonathan Nieder's message of
 "Sun\, 14 Nov 2010 12\:51\:30 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F25EDA6-F0D2-11DF-BE57-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161492>

Jonathan Nieder <jrnieder@gmail.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> That listing should be in a comment at the start of the
>> Makefile. Please submit a patch for that!
>
> How about this?  An annoying piece of GNU makefile syntax makes this
> uglier than it needs to be (search for HACK for details).
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> index 1f1ce04..38edd65 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,6 +1,8 @@
>  # The default target of this Makefile is...
>  all::
> =20
> +outline:: ; @echo "Configuration."
> +
>  # Define V=3D1 to have a more verbose compile.
>  #
>  # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.

Hmm, I don't quite get what you are trying to do here.  What good does =
the
output from "make outline" do to a potential/actual developer?  You can
learn that there are sections for "Testing rules", but then what?  You
will look for that string in the editor or pager.

Or is this some sort of outline/org-mode hack?
