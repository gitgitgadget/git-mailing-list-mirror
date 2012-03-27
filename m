From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Tue, 27 Mar 2012 08:14:13 -0700
Message-ID: <7v7gy6krei.fsf@alter.siamese.dyndns.org>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
 <4F715ABD.4080102@viscovery.net>
 <CAJMEqRAQZwaeMNai9wckmPE2mRVVpttzEobZrsn29fMAo+LRRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 17:14:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCY6G-0006wx-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 17:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab2C0POQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 11:14:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634Ab2C0POP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 11:14:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29585A2C;
	Tue, 27 Mar 2012 11:14:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s71ko5mdzEWI7N+07AdsTxZ6fUM=; b=to6WYd
	cDVwxShYr3bwEUq1za2et77krlBKpVYlWtSrsYNmsUjw/tuH10cY8YaUja/B8hKS
	aViC0z1Bd5kFQ0tARv0ZXrzrksZvtXVhlJK2Gu4R4JDU+yJvof9TMZtjVjkkDRxs
	7uFpXHEOUAZ12RiEYe4r8Up2VPMaKAAYSJB24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dva3f8e6iLGN0j4oZP3tadQuCljsgPtI
	MqdtW4NpCR3pnAI6pulHZLjU/iIEvq2xriYq0IBTk5E94hGD61bsEfwOXnkjC1TF
	Mmobc7jirBZFiAOb0eYRPWnMF874lwj103FojhT8JA6n8UmpGi4vi15QesTqtUeh
	D7iYRnnAhlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA3CD5A2B;
	Tue, 27 Mar 2012 11:14:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 678725A2A; Tue, 27 Mar 2012
 11:14:14 -0400 (EDT)
In-Reply-To: <CAJMEqRAQZwaeMNai9wckmPE2mRVVpttzEobZrsn29fMAo+LRRQ@mail.gmail.com> (James
 Pickens's message of "Tue, 27 Mar 2012 00:37:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 838F3696-781F-11E1-B0BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194049>

James Pickens <jepicken@gmail.com> writes:

> On Mar 26, 2012 at 11:14 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Git is not a shell. And I'm sure it is not the only program that has this
>> ... 
>> Don't check the
>> sanity of your PATH by testing how your shell looks up executables.
>
> I'm not claiming that it's sane to have a broken PATH, but as I
> mentioned in an earlier email, sometimes my PATH gets broken through
> no fault of my own, and it would be nice if Git could be more helpful
> in that case.

Hrm, so which was more helpful in diagnosing the broken PATH?  Git by
letting you be aware that there is some problem, or your shell by keeping
me oblivious of the issue?
