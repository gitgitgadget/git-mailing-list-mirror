From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] octopus: make merge process simpler to follow
Date: Sat, 12 Dec 2009 00:53:03 -0800
Message-ID: <7vljh8vaj4.fsf@alter.siamese.dyndns.org>
References: <87zl5p1gsp.fsf@jondo.cante.net>
 <1260578339-30750-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 09:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJNj6-0007Ou-QY
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 09:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbZLLIxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 03:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757244AbZLLIxI
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 03:53:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104AbZLLIxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 03:53:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C4712A6891;
	Sat, 12 Dec 2009 03:53:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=22UbSegd0gfDSCA30Xfn4WI0/sY=; b=iEOxrY
	ZNSXzCIm2r/YGRsFY3XhrhlGeVG6j93XdrU69Wbuqccr31wyyLzY+e+PBaw8UfQT
	q6IO6cskYcy69bw4XYzpb2Yc60mcKOD5I38ADWq5TX1NqjGIqH7d4jHZ6phFLQbW
	MwMmT5xxnCk4UiMa+UHQ3XHDRaVwTfDGkwHa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCsLfkkfF0jjPTO8av016BoKznScrE0J
	4jiy/OKcGatgLzVAr0fuYUV1wk8jtJ4X70RHSuZChPp97o2/xpPdBgacZFpW4LNU
	DEHxjN6AkwLSa/bqIA7w6rwLv13JbblcNb2GoGQKMvjGyJwQFtCLZ0BCR0vvkPZH
	D05YqPrdvgQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96071A688D;
	Sat, 12 Dec 2009 03:53:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C011A688C; Sat, 12 Dec 2009
 03:53:05 -0500 (EST)
In-Reply-To: <1260578339-30750-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Fri\, 11 Dec 2009 16\:38\:57 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5B33AF2-E6FB-11DE-976D-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135125>

Stephen Boyd <bebarino@gmail.com> writes:

> Its not very easy to understand what heads are being merged given
> the current output of an octopus merge. Fix this by replacing the
> sha1 with the (usually) better description in GITHEAD_<SHA1>.
>
> Suggested-by: Jari Aalto <jari.aalto@cante.net>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> Maybe this will work? At least it will replace the sha1 with
> whatever is given on the command line.

This shows what was given from the command line instead of the
commit object name.  I think it makes sense to not even make this
dependent on any option.  Also I don't think anybody misses the
commit object name in the output---after all, that is all internal
to git and is different from what the user gave us anyway (unless
the user did give us the full 40-char object name, in which case
the value of GITHEAD_<SHA1> would be that name, and we will show it,
which is also fine).

No, I haven't applied nor run it yet.  The above is purely from my cursory
reading of the code.

Anyway, I'll keep this in my inbox or queue it on 'pu' if I had time.
