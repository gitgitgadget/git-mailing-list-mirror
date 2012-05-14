From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Mon, 14 May 2012 12:09:22 -0700
Message-ID: <7vaa1ah95p.fsf@alter.siamese.dyndns.org>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
 <7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
 <CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com>
 <7vmx5ahbrm.fsf@alter.siamese.dyndns.org>
 <CAMP44s1h=MPT8vx6JrGjMZWJzRjndxYKoYgo+1Y_Mmv+gWXzaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 21:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU0eB-00034T-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 21:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757494Ab2ENTJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 15:09:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757127Ab2ENTJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 15:09:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FB79966F;
	Mon, 14 May 2012 15:09:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nsmSr0vtI4Si9IL2ZWoxCdpMwok=; b=x19wfF
	vN3lRePIHi24c/cvZ8QjENfD4yyG5sX5+fpuKtj/kUQJVGzOv+sJgMhY9LJ1Ajxy
	3F/LGuel6qVTCVDdz05srme5Pe2X41yda/dluDuThrkS0O8AVgyrjeRoWLL9ZPgZ
	F0KtjLT7oiRzMZbaHGdIHyBq2opygUnxQOoM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+dEvh9oiw1LwoSWQAckJfcrKDrRnelr
	LLR4RePpbHOOfa0XSUC+nXqqjXc2gQ1yez1JP4OwsHY/o59gaXYLvjCrkFGKlOxI
	mV8Mw7EV60+Q1ZbGj4XlvukYarZ1bj69rxBTNKAHzBCACqwuc00UyGcnKN2cZu0Z
	XuWhQUzB/ow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DC38966E;
	Mon, 14 May 2012 15:09:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 992EE966D; Mon, 14 May 2012
 15:09:23 -0400 (EDT)
In-Reply-To: <CAMP44s1h=MPT8vx6JrGjMZWJzRjndxYKoYgo+1Y_Mmv+gWXzaQ@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 14 May 2012 20:30:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5120F63C-9DF8-11E1-94F0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197800>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Here is my attempt to explain why none of them needs to be quoted:
>> ...
> I don't understand that.

That was my attempt to give the readers some context to understand what
comes after that.  If the original patch author does not understand it,
perhaps it is an indication that the function is somewhat underdocumented.

>>  # wrapper: the name of an internal shell function that wraps the
> ...
> So in short; because the variables are used as function/command names.

Yes, and the fact that this is internal and we won't listen to clueless
people who attempt "__git_complete 'foo bar' 'bar boz'" and complain are
what make all of them safe to be used without any quotes around it.
