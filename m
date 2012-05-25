From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fmt-merge-message: add empty line between tag and signature
 verification
Date: Fri, 25 May 2012 10:05:20 -0700
Message-ID: <7vtxz4tcmn.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.02.1205250850001.19607@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 25 19:05:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXxxH-0006NB-Vx
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263Ab2EYRF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 13:05:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756295Ab2EYRFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 13:05:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 204BB831C;
	Fri, 25 May 2012 13:05:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y/yAYgysjDOszb4RfG5HHHT9fmY=; b=Rdw/vG
	iDDxDN2I0wjDt3pRynk3+XsGJnwAL/hVMqsTM6GjGn7EPxMi+0hHB+YhPxeYKYTN
	s/O0okJfMY8BwilXHBvPUBz1VicPTWwfns8nINrWrqpv8FZybly1F4QfDbitTxh2
	Qkrcc7NWN/5iuP9AaeYyGWuKzoSmmpE8cYp/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cgHDp+PA68beuK7e+ThpTU2g2GFEWFzF
	cau9wbOcGUwn64/+YJJLfIkyIZV90Pz521oRWdouWGCPe93Ico0ylv7H+BI/oX3D
	JX2NxoVyuPhKOPjQXgJBxt6+knhx6hF3+YlH5r/g3ukbhhfNGRfYZHxhPWHErOTH
	nHH6QrLA4A4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 181A1831B;
	Fri, 25 May 2012 13:05:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97C95831A; Fri, 25 May 2012
 13:05:21 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.02.1205250850001.19607@i5.linux-foundation.org>
 (Linus Torvalds's message of "Fri, 25 May 2012 09:02:03 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFE40248-A68B-11E1-9352-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198485>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> When adding the information from a tag, put an empty line between the 
> message of the tag and the commented-out signature verification 
> information.
>
> At least for the kernel workflow, I often end up re-formatting the message 
> that people send me in the tag data. In that situation, putting the tag 
> message and the tag signature verification back-to-back then means that 
> normal editor "reflow parapgraph" command will get confused and think that 
> the signature is a continuation of the last message paragraph.
>
> So I always end up having to first add an empty line, and then go back and 
> reflow the last paragraph. Let's just do it in git directly.
>
> The extra vertical space also makes the verification visually stand out 
> more from the user-supplied message, so it looks a bit more readable to me 
> too, but that may be just an odd personal preference.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> This is a throw-away patch - apply or not as you prefer. I thought I'd 
> send it out and see what people thought.
>
> I don't feel *that* strongly about it.

Speaking as one of "people" (as opposed to "the maintainer to decide one
way or the other in bikeshedding"), I think this makes sense.

> Btw, I'd also like to see the merge notes (notably the conflict file list) 
> before the generated shortlog, but that seems to really not work with the 
> current fmt-merge-message model.  Oh well.

Postponing to assess if such a change is feasible, I am not sure if that
ordering makes more sense than the current one.  Is the objective to more
strongly motivate people to explain what happened to the conflicts?
