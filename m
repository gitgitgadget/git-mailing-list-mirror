From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] commit.c: replace some literal strings with
 constants
Date: Wed, 16 Feb 2011 21:49:30 -0800
Message-ID: <7vlj1fdxcl.fsf@alter.siamese.dyndns.org>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-4-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 06:49:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpwkS-0003D3-2k
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 06:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab1BQFtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 00:49:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab1BQFtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 00:49:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5306D47A7;
	Thu, 17 Feb 2011 00:50:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9uTpERnxWAcNPjPLgxyE3eK44w8=; b=R5mVmF
	LNEdpvh81MwhNWsjiOw28lZlurHDkl1vKh36e4fpSRM5JuUmruuSm3Oubw19waHn
	weQxoh8zvMxOm2O3eUGUiGmUBNwF3l6p8WV322PErDqDcQzxIToPKaOrJYVKNUen
	zoioICFnZKqMMAw3aNkcFGfRyoDtp8ioVDsQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9S6FuFf6cSHe1qtu9n8pgvmt+pCu/WD
	DfWjtveK3tUniX4TL4GFdNZexska30yD2kh1msfpK6Bwglq/iHYQeeX7dX3P1vEn
	XuxxsIpGmukm5oprPSnBLTgCWCXFfai1GjjDHAdnvQxbwxR3hs+lXoqBKAZ6RqPt
	iB5lt61pYXY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 114ED47A4;
	Thu, 17 Feb 2011 00:50:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 25B2C47A2; Thu, 17 Feb 2011
 00:50:39 -0500 (EST)
In-Reply-To: <1297916325-89688-4-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed\, 16 Feb 2011 23\:18\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DDE2BFE6-3A59-11E0-8237-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167043>

Jay Soffian <jaysoffian@gmail.com> writes:

> A typo in any of these would be bad, so let's use
> constants for them
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> I converted these per
> http://article.gmane.org/gmane.comp.version-control.git/167015
>
> Maybe this should be the last patch in the series; it's questionable to
> me whether it's even worth doing.

Yeah, it's horrible ;-)

> +static const char commit_editmsg[] = "COMMIT_EDITMSG";
> +static const char cherry_pick_head[] = "CHERRY_PICK_HEAD";
> +static const char merge_head[] = "MERGE_HEAD";
> +static const char merge_msg[] = "MERGE_MSG";
> +static const char merge_mode[] = "MERGE_MODE";
> +static const char squash_msg[] = "SQUASH_MSG";

If they were like

	static const char COMMIT_EDITMSG[] = "...";

then that would give us typo-safety while keeping the similarity from
original code.  Uppercase variable names are a bit weird, though.
