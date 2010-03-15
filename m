From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Mon, 15 Mar 2010 16:12:24 -0700
Message-ID: <7vwrxdb2nb.fsf@alter.siamese.dyndns.org>
References: <m2tyswb1jp.fsf@igel.home>
 <7v3a0fr740.fsf@alter.siamese.dyndns.org> <m3r5nzw05p.fsf@hase.home>
 <ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com>
 <m23a01yzcc.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:12:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJSm-0000iI-SV
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937114Ab0COXMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 19:12:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410Ab0COXMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:12:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DA2EA217E;
	Mon, 15 Mar 2010 19:12:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TYgOTLRO3A50RHn3slEZU1oPf7Y=; b=Y7JxCP
	t1mUpf6jH2bgsbUlOX82fwXCvqioFqKjfKQPtxugQSqRX42tFpnETYoNxzLEXRvn
	gccLDO3aACsVFxhYRKUdhx61kPka8bWJIGlk81S5QInxtX+7x4RyBMzm7NIV/Buj
	JRUqP2Rz7PkvbuUpeSA2X2DvDKpkhJXIYqvl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LFjBiMh5/XaxbzZ43KIneAqeDKTMZVtZ
	EVcIjBh1uOsthgZpDOhTRnt8qodF1aqOhoKkQfr2lw5XI1xq7ewtGcHKLo4JyVeA
	+rYqGwlMsZaS73fdjadd5ffkwAuwaXg/Tm09AfQW3N2WrJDxNFdxQGLF7EZ/3NE+
	SdOHkrUDh/I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A726A217D;
	Mon, 15 Mar 2010 19:12:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65AE4A217B; Mon, 15 Mar
 2010 19:12:26 -0400 (EDT)
In-Reply-To: <m23a01yzcc.fsf@igel.home> (Andreas Schwab's message of "Mon\,
 15 Mar 2010 23\:49\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A912C0A-3088-11DF-97CE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142270>

Hmm, http://www.methods.co.nz/asciidoc/newlists.html seems to say that
[horizontal] is new at 8.3.0, and earlier I think I said we use 8.2.5 in
order to prepare http://www.methods.co.nz/asciidoc/newlists.html, so the
patch looks a bit scary to me.

Sadly even with 8.2.7, "git help ls-files" shows something like this:

       -t
           Identify the file status with the following tags (followed by a
           space) at the start of each line: [horizontal]

           H   cached
           S   skip-worktree
           M   unmerged
