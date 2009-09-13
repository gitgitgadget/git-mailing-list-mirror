From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-archive: add '-o' as a alias for '--output'
Date: Sun, 13 Sep 2009 11:34:43 -0700
Message-ID: <7v4or6sngc.fsf@alter.siamese.dyndns.org>
References: <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
 <1252863407-2598-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 20:35:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmtue-0000b4-Mn
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbZIMSew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbZIMSev
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:34:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbZIMSeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:34:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DABB4FF3F;
	Sun, 13 Sep 2009 14:34:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zwUcsatIfCFiCorwcIO6dwLkJ6o=; b=pKV1X4
	m4ZyiSNEeCg/7QvYisOkrghOXaPB1ig7hEAyaq/C9gL5kv0ryPu3Z4CiEbfz1sQT
	iDX/L7ijH9357u11qZyD5JVUGK2BDHma0HTbs3biJEwpA9DKF42n+9kr+Cfd3rzL
	DaZz2B7Z0Y/a1mxYuNpzkBd07pXXUFd98AlWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jI/lbQNU1RKYhFVQwmnJQ2EnHKW8T0JQ
	TxBF+4fmlaYAENtRCJf/gBppGiUO/jgK24UWvzPQOer2O21SBD7Y4Sce3DscR07l
	Nlqb5RNuss7CZS3morrB9GhHzCpP+4sWGqkkB+4gdmaMTEDCvETED6byR5SVuxVG
	zFVj6ZK2vuQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 712654FF3E;
	Sun, 13 Sep 2009 14:34:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 06C604FF3C; Sun, 13 Sep 2009
 14:34:44 -0400 (EDT)
In-Reply-To: <1252863407-2598-1-git-send-email-dpotapov@gmail.com> (Dmitry
 Potapov's message of "Sun\, 13 Sep 2009 21\:36\:46 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1E706010-A094-11DE-8D1C-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128381>

Dmitry Potapov <dpotapov@gmail.com> writes:

> The '-o' option is commonly used in many tools to specify the output file.
> Typing '--output' every time is a bit too long to be a practical alternative
> to redirecting output. But specifying the output name has the advantage of
> making possible to guess the desired output format by filename extension.
>
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
> ...
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index 92444dd..f7a3b95 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -48,6 +48,7 @@ OPTIONS
>  --prefix=<prefix>/::
>  	Prepend <prefix>/ to each filename in the archive.
>  
> +-o::
>  --output=<file>::
>  	Write the archive to <file> instead of stdout.

I think this patch is very reasonable, except for this hunk, which would
want to say "-o <file>::" instead.  I'll see if there are comments from
others and if there is none, apply this patch with that minor tweak.

Thanks.
