From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 20:30:19 -0800
Message-ID: <7vwqufpj50.fsf@alter.siamese.dyndns.org>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:30:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4l2U-0001Le-1u
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab3BKEaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:30:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3BKEaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:30:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96A54C07D;
	Sun, 10 Feb 2013 23:30:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=61PuJpt8OE3n3Bqd9/w88+f5btA=; b=Awwou3
	c+ssEpJNWs5NWZYQnbikww1LhlpurjqPuWqFchBceBe1BEKFbYJJ/+J+ISh6+8Mo
	MivgT4TCpvOxFE6p/1Ppm2qpYCDbXXbq1isWSVR7u9KI4DIhYmb5cu3pPqFDhoga
	/BVVaMSDq6sXXg/RbnrV6emKDCohkN06LX4TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pAjqgy76zrDZ2i/riPDr3gC+izdVtWVw
	Y9t868FUrWcMhATwqGmVnFqiq1Lt5wB0F1R8c4Fu6rggvFOW9htQ1ug3kngDTthB
	maNlVCNM4XOTy95C/QXUjx4SXoM+pRA0uI+nusAvH/m7RQXiwXB3cfkAEHBxJTl8
	EQiq49dnJuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 856C0C07C;
	Sun, 10 Feb 2013 23:30:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E272FC070; Sun, 10 Feb 2013
 23:30:20 -0500 (EST)
In-Reply-To: <20130211041706.GB15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 20:17:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BED675BC-7403-11E2-8490-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215987>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> How about this?
>>>
>>> A patch on top could change the default "git-shell-commands is not
>>> present" message if that seems worthwhile.
>>
>> Hmph.
>>
>> I wonder if rewording the message when git-shell-commmands directory
>> is not there may be a better first step (which actually could be the
>> last step)?
>
> Maybe, but it's not a step that I'm interested in.  I don't think it
> changes the desirability of the patch I sent.  They are independent.

What I thought I read in the log message was that you wanted to give
a better message telling the users that the site does _not_ allow an
interactive shell access.  I do not see how that is independent from
a message given from this codepath, where the side has forbidden
shell access by not having ~/git-shell-commands directory in the
first place.  Are you shooting for customizability?
