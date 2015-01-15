From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] git-svn updates from Ramkumar
Date: Thu, 15 Jan 2015 15:24:59 -0800
Message-ID: <xmqqtwzr4ofo.fsf@gitster.dls.corp.google.com>
References: <20150115090703.GA12333@dcvr.yhbt.net>
	<xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
	<20150115224652.GA25482@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:25:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBtmo-0003mk-Df
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 00:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbbAOXZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 18:25:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752244AbbAOXZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 18:25:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DEDB30521;
	Thu, 15 Jan 2015 18:25:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x/XOYB454ykqAQ6bI3VWzVeULsA=; b=O3TrxF
	FqzGbb4mXIhGJ90hw+bSBa0bfPE1aoLKM2viUPfbD5uk+POl6gIAB5F/ngJoCIx4
	QcUIsS75JNxBVKCRBV2wYTmimgPsB1jCOvjGJGv2deXmoAxD810e5NQfNL3FABF0
	HMjp9zh0DvFmt65il4rM/INPduA8G4gcrBMIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orHT8DyRJ26pijnupg9wq6w5MQhqnpXt
	n1JEinbrkOV2ea1fim5MEXMMNIE/Fp87Lq7rzbpKtqqRwa4R/+epRWd22cgWq7JY
	GlEFFl9AMGdkogIM0wb2qRn6g5JyCOcfXBnBQZcq04c6fvq2ldmT1sGCw3rT01t8
	V72cPYkvLqA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 023373051F;
	Thu, 15 Jan 2015 18:25:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 343993051E;
	Thu, 15 Jan 2015 18:25:00 -0500 (EST)
In-Reply-To: <20150115224652.GA25482@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 15 Jan 2015 22:46:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B99E6B6A-9D0D-11E4-866E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262522>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks.  No tests necessary/feasible?  Just being curious.
>
> They seemed simple and obvious enough to me,
> (and most importantly, didn't trigger regressions).

I can see that the top-most one is about .git that is a textual
symlink ".gitdir: <elsewhere>" and the code after this part needed
to convert it to the real place in order to be able to read/write
"${GIT_DIR}/<some file>", so that is obvious to me.

But the other one just says "handle missing ref_id case correctly"
without clarifying what is incorrect in the original and how the
desired correct behaviour is different (in other words, what breaks
without this change)

To which a natural reaction was "Can the existing breakage
demonstrated by a test?".

If it is obvious for git-svn folks, then I wouldn't complain,
though.
