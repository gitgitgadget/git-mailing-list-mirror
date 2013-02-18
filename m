From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone tag shallow
Date: Mon, 18 Feb 2013 13:49:24 -0800
Message-ID: <7vobfh9tsr.fsf@alter.siamese.dyndns.org>
References: <CAByu6UWEF48XvTmRnVDb2Bqxy1dNdUSXpTuy804215Vgs_KJxw@mail.gmail.com>
 <CACsJy8Dso-g7foyJhpY20DNrY11PA8ZZUmP6JXxsiJ_Ggbt_KA@mail.gmail.com>
 <CAByu6UWO=kUOvJ_YcPG9bo+XVZ5hSxRQpyEaUMcVxa=sXt_EMw@mail.gmail.com>
 <7vliamascv.fsf@alter.siamese.dyndns.org>
 <CAByu6UVfArRXGLTKgM=nw0fzij1urcVdzxx6xdoHihODD-LtRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Thibault Kruse <tibokruse@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Yat-0005eR-MH
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 22:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab3BRVt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 16:49:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756402Ab3BRVt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 16:49:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 716D3B09B;
	Mon, 18 Feb 2013 16:49:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XjPxnn7I/YE4rqdHYFa7su5VODo=; b=ae3izg
	c2X39vwTva/Z5CjSgOMzUbU20ubTE5LPPPoMXjphLdZ12yX45gDZiXF7tNbseYUO
	1wEuzFGpfQNMc6vU/Vi8OU0N8ELudSyFWxm1acMS2NnI1nd/oQFWiSvkblDqWoEu
	QzlgAt44Y+dHNBXqE6WMF6RNFKYFvtVMCRyh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZcpCmV+RgLmXeMYjhkKU6Ekxp5WU0R+1
	7nC3sotppOf2lG9+WBmnDsyVU/uNmc8ryBS6rl1Z8+oeAzJy8m77H1EsQW6GCk8R
	YHIrXcqI3BgkPvkAc8P2jE3mwwn4kqDz68AP7fzlwQ4PnwxZKCljCl68lH7RUMn3
	tsnsV1lpfbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66968B099;
	Mon, 18 Feb 2013 16:49:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDA7DB097; Mon, 18 Feb 2013
 16:49:25 -0500 (EST)
In-Reply-To: <CAByu6UVfArRXGLTKgM=nw0fzij1urcVdzxx6xdoHihODD-LtRA@mail.gmail.com>
 (Thibault Kruse's message of "Mon, 18 Feb 2013 11:11:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 103221A6-7A15-11E2-B888-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216538>

Thibault Kruse <tibokruse@googlemail.com> writes:

>> I am not sure why you meant to treat (2) and (3) differently,
>> though.  Care to elaborate?
>
> As in my example, git clone --branch <branch> does not accept all of (3).

That is a prime example of outside "checkout" we give a white lie to
show the most common <branch> to help beginners, I think.

> That's fair enough, I guess, I am not sure either. If I understand you
> right, the Synopsis and
> description are supposed to explain the non-hackish usage of commands,
> whereas documentation after the OPTIONS headline is supposed to be
> more of a complete description.

It would go more like

	SYNOPSIS
        	git foo <branch>
	DESCRIPTION
        	"git foo" distims doshes in <branch>.
	ARGUMENTS
		* <branch>: the branch to distim doshes in.
		  While it is most common to name a branch, you
                  can give any <committ-ish> to it.

if and only if use is <branch> is the most common and using
arbitrary commit is a rare case.  In other cases, we would be better
to say <committish> on the SYNOPSIS part.  That commonness/rareness
is a case-by-case matter, I would think.
