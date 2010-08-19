From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/regex: define out variables only used under
 RE_ENABLE_I18N
Date: Thu, 19 Aug 2010 13:02:22 -0700
Message-ID: <7vtymq74mp.fsf@alter.siamese.dyndns.org>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain>
 <1282242601-2630-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 22:02:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmBJv-0007eu-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 22:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab0HSUCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 16:02:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab0HSUCd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 16:02:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13DF7CFD4C;
	Thu, 19 Aug 2010 16:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ohjjag0bPNs+
	6SvRpmNv2KgvM3Y=; b=mB+YbmzNL9YZ7tta5zx3qhZRNGc9Lv9AF+IX0Ce+dDoO
	V/5vsgFMLAZl0a/fK1rYN10U4hQWiHnvM6p8HD+hP1seUjIVoAhER8M/wz9AJV5B
	g0DIKLGAu1JwFraJvo1GJTJjZqsm57GAkfTkZObKNhcYC5g1k6JWdVMXWSJV57Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IWJuWm
	HKYHW/0JxWBiHqdqT213LcI/DRi7OiKztZAqPQ8NzenWN+uWuvjV7kizPsVe750q
	egUZAzM7T47nwpvlHwatGqcK27ZHVPmJDHy7HFIS/jDaHHegINAn6+Fd/kSqITk6
	5S1Xy/ZIrCWUVxuBn8QUydGW8peoNEYguMiTE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E40E7CFD47;
	Thu, 19 Aug 2010 16:02:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08116CFD44; Thu, 19 Aug
 2010 16:02:24 -0400 (EDT)
In-Reply-To: <1282242601-2630-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 19 Aug
 2010 18\:30\:01 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1333E92-ABCC-11DF-A88E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153954>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Wrap variables that were only used RE_ENABLE_I18N in `#ifdef
> RE_ENABLE_I18N`. This eliminates compiler warnings when compiling wit=
h
> NO_REGEX=3DYesPlease.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

Hmm, this unfortunately is not enough for me to compile it locally.

In file included from compat/regex/regex.c:77:
compat/regex/regcomp.c: In function 're_compile_pattern':
compat/regex/regcomp.c:237: error: old-style function definition
compat/regex/regcomp.c: In function 're_set_syntax':
compat/regex/regcomp.c:276: error: old-style function definition
compat/regex/regcomp.c: In function 're_compile_fastmap':
compat/regex/regcomp.c:289: error: old-style function definition
compat/regex/regcomp.c: In function 'regcomp':
compat/regex/regcomp.c:491: error: old-style function definition
compat/regex/regcomp.c: In function 'regfree':
compat/regex/regcomp.c:655: error: old-style function definition
In file included from compat/regex/regex.c:78:
compat/regex/regexec.c: In function 'regexec':
compat/regex/regexec.c:227: error: old-style function definition
compat/regex/regexec.c: In function 're_match':
compat/regex/regexec.c:311: error: old-style function definition
compat/regex/regexec.c: In function 're_search':
compat/regex/regexec.c:324: error: old-style function definition
compat/regex/regexec.c: In function 're_match_2':
compat/regex/regexec.c:337: error: old-style function definition
compat/regex/regexec.c: In function 're_search_2':
compat/regex/regexec.c:351: error: old-style function definition
compat/regex/regexec.c: In function 're_search_2_stub':
compat/regex/regexec.c:366: error: old-style function definition
compat/regex/regexec.c: In function 're_search_stub':
compat/regex/regexec.c:410: error: old-style function definition
compat/regex/regexec.c: In function 're_copy_regs':
compat/regex/regexec.c:497: error: old-style function definition
compat/regex/regexec.c: In function 're_set_registers':
compat/regex/regexec.c:578: error: old-style function definition
compat/regex/regexec.c: In function 're_search_internal':
compat/regex/regexec.c:631: error: old-style function definition
compat/regex/regexec.c: In function 'prune_impossible_nodes':
compat/regex/regexec.c:952: error: old-style function definition
make: *** [compat/regex/regex.o] Error 1

The fix should be straightforward, and I think it should be squashed wi=
th
the header ANSIfication you sent earlier.

Thanks.
