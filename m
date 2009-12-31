From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cvsserver: make the output of 'update' more
 compatible  with cvs.
Date: Thu, 31 Dec 2009 12:14:25 -0800
Message-ID: <7vd41uucim.fsf@alter.siamese.dyndns.org>
References: <87zl5z4y0w.fsf@osv.gnss.ru> <87bpibdonj.fsf@osv.gnss.ru>
 <20091230224115.6117@nanako3.lavabit.com>
 <7vfx6rzlkg.fsf@alter.siamese.dyndns.org>
 <46a038f90912310720l4b1cbdebs2b85774ae7e33c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 21:14:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQRPt-0005zk-7e
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 21:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbZLaUOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 15:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbZLaUOi
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 15:14:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZLaUOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 15:14:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40DC28C949;
	Thu, 31 Dec 2009 15:14:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tU+UKJAR+X73LqZ7Fs4VCCD74yU=; b=R2+YW/
	JRs2MXo9TSd1GO/QTC744B1xcVP7R5f845orJ8NawxiORaEWE2p5zP5JYm0mWtkW
	XR7Gj7coEMZqN+1NgKMVUSuGMjWbixqAmQ9biqv67RQwuJitf3UtCtWCqimSrcir
	5LK6KEnV1FLuFK8TpxUGNu1X9puvqvZ2YoTz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LiggYwk0Bhs29hgjalfS/+ZxBKMITsXN
	caJNr59Gah1U3rtoGGsDMt8FBtOD+QbCgBYaPxy4L/gxFnnqm3/wr2dK3g+31upq
	wdQWLAhQxJ6KIRO6rtLQORxnLUUo3+mDy+3EZDaUjNR2Q2VfsuoreqzJDqIG3XfS
	4tCUTNTccTE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB62E8C946;
	Thu, 31 Dec 2009 15:14:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1680D8C943; Thu, 31 Dec
 2009 15:14:26 -0500 (EST)
In-Reply-To: <46a038f90912310720l4b1cbdebs2b85774ae7e33c0e@mail.gmail.com>
 (Martin Langhoff's message of "Thu\, 31 Dec 2009 16\:20\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B556938-F649-11DE-A5BC-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135972>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Thu, Dec 31, 2009 at 7:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Well, since I don't use cvsserver myself, but this v2 was done with
>> improvements based on some review suggestions, I was waiting for a
>> response or two from people who know better and care more about cvs server
>> emulation than me, which unfortunately didn't happen.
>
> Looks good to me -- good to get it into pu. While I continue to use
> git extensively, I don't use cvsserver anymore, nor work with people
> that do. Might have reason to revisit cvsserver in the near future
> though, to help Moodle transition to git.
>
> That transition will bring a few top-posters and Eclipse lovers to the
> list. Looking past such details, they are fine people who may need a
> little bit of git-newbie help ;-)
>
> happy new year,

Happy new year to you, Nana and Sergei, but not yet in my timezone ;-)

Thanks; I'll forge/add your "Acked-by:" when I queue it.
