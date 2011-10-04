From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at
 prompt
Date: Tue, 04 Oct 2011 12:28:13 -0700
Message-ID: <7vty7oblpu.fsf@alter.siamese.dyndns.org>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
 <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 21:28:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBAf6-0007zm-Pz
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 21:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160Ab1JDT2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 15:28:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752Ab1JDT2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 15:28:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11414492E;
	Tue,  4 Oct 2011 15:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M170TWR0rmQw+Tzt5k5KimaiuN8=; b=j8yOcp
	qA5lwm0BknVbExwAaqfFx3JwCugzIqhw/SncxjryyAUDYpbNo95MeclE/9J+1yN7
	veoCMhDb8Jtr5FbHJabVtJb+Nq78l3yJyrsaLXU5Ymw0916avTa/tyYQGlGYRXgs
	6HLRNfBSH26Y4g4oTRsWEFyZGjpteqY1fgwgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CcE4V/YATtGtPwg+qoC1ghJEUtLMwf9P
	UQ7fc42KUFiO6gPPT2uEcBvsuyJjHRZ4dLUEqjLDFRyue9qxzY1XqdewgLTUd2Br
	O8IfJycC5qna7CW+Zbmk67wB9Xz+8/fOxeIEkM/qcOHAkRdpS78pOO7eIWCStPr4
	vBEmtY8ue30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07CDF492D;
	Tue,  4 Oct 2011 15:28:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A4D2492B; Tue,  4 Oct 2011
 15:28:14 -0400 (EDT)
In-Reply-To: <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com> (Phil
 Hord's message of "Tue, 4 Oct 2011 14:02:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01103D8A-EEBF-11E0-AB69-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182789>

Phil Hord <phil.hord@gmail.com> writes:

> On Tue, Oct 4, 2011 at 11:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I think I've seen this done as: "do this? [Y/n]" elsewhere.
>>
>> Not telling you what to do, but trying to feel what others may think.
>
> I think so, too.  The [y]/n syntax is not clear enough for me to
> confidently know what the default value will be.

One downside of "do this [Y,n,m,o,p,q]? " is that it limits us to
lowercase responses, which means we cannot assign 'q' for quitting from
the innermost nested context and assign 'Q' for quitting from the whole
interactive loop (e.g. "git add -p").

    "do this [y,n,m,o,p,q] (default=y)? "

may have been a better choice in hindsight.

No matter what we end up doing, let's try to be consistent.

Thanks.
