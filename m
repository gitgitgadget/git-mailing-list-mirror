From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Mon, 20 Aug 2012 20:46:16 -0700
Message-ID: <7vtxvwgb5j.fsf@alter.siamese.dyndns.org>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <CA+sFfMexCWLza65bVp2uXoqo3+yY5MPBBcGugoEA6UCEwAv6Ow@mail.gmail.com>
 <CAG+J_Dz3SHyNSUBuFcHu-x8gkE+wj5wJGLOfopNQw0dBThtSuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 05:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3fQB-0006vS-6X
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 05:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab2HUDqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 23:46:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2HUDqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 23:46:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D55C487DE;
	Mon, 20 Aug 2012 23:46:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+dapjYF31s56t2hcL7XYbUpXLX4=; b=abkG+I
	L9iZ35mF42uV8W+0chuMM9szwqevrE9AdWCg4yulFY1fgzxOeL+96TlAt/BGlejs
	6TfecGjHJzTFjCo5vWc26XILFo+Q8aMXFILgz3O51uD63ek4AG7vR8N3HV8j52YM
	xAXVGx4HSIbIX09yIE90MZbuWzVbBPkACOPDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qJOM8pnI4kp8BIC/o1m6iDjUwSRxryiU
	3AiWRO3DV1CphWjJagbOoNWvHbuV5TcamMOcXCuppfsReZpswDLAUDQiUNbYBN7t
	7holY4sxTKmwcZ673zdylhf5HiCBFflFMbVlaz/C0L0TyvDx7dHMN1QM4qkIjGev
	evUN56HDwls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2D3587DD;
	Mon, 20 Aug 2012 23:46:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 438B687DC; Mon, 20 Aug 2012
 23:46:18 -0400 (EDT)
In-Reply-To: <CAG+J_Dz3SHyNSUBuFcHu-x8gkE+wj5wJGLOfopNQw0dBThtSuA@mail.gmail.com> (Jay
 Soffian's message of "Mon, 20 Aug 2012 22:16:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3C7FCFC-EB42-11E1-86EF-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203923>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Aug 20, 2012 at 9:53 PM, Brandon Casey <drafnel@gmail.com> wrote:
>>    git config --system -e
>>
>> Hopefully your editor exposes the path that it is editing even if you
>> don't have permission to modify it.
>
>   GIT_EDITOR=echo git config --system -e
>
> works for me.

Clever ;-)
