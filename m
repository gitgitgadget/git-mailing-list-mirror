From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: add the ability to show side-by-side diff on
 commitdiff.
Date: Sun, 16 Oct 2011 18:51:07 -0700
Message-ID: <7vbotgper8.fsf@alter.siamese.dyndns.org>
References: <CAFo4x0Kb651CyxoP8wxR36aDe5=Md2UV3qjh+HPo4ad6NB=Emg@mail.gmail.com>
 <7vobxgpixo.fsf@alter.siamese.dyndns.org>
 <CAFo4x0+_Uy=yjbO61qj8krS0-iovzC5WnBE8-1n5OzxgGeg6JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 03:51:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFcMP-0005tJ-DY
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 03:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab1JQBvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 21:51:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab1JQBvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 21:51:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32B676240;
	Sun, 16 Oct 2011 21:51:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H4zT/iSRX+mF2D8DyFsRUHPTB/c=; b=FakMRt
	g2rps1rvOG+W9EdSGns+vcgW8GSN66dX5vl6xqCjjlUR+NrI8myhgUBbD2k9VR8w
	p53IIkX6j6Y1i0dG/vKg1zdsnStKhNkBPJhpvG4YXNjArjLwh+fiaxTlzhYMCs1o
	0B91uiGSaOgVoeCuABByBn8n9UwK0Pa7BF0to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UDqP8Pvs3xyJlJ1uXpAKdZW6Bfxr5+3k
	UdjHYOCo64HVdJK2F3TPkztgmU3dzP82m41SFI/fzZ9dMiW0M1HA18goefMrVvN1
	7fFQLGuZUC1LnIvz9QJtm/5PE6up0dWLR70s4whAAKOAVg0a9BYXTlVc7H+3Jd2b
	18eibjI0p28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29E70623F;
	Sun, 16 Oct 2011 21:51:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EE7C623E; Sun, 16 Oct 2011
 21:51:08 -0400 (EDT)
In-Reply-To: <CAFo4x0+_Uy=yjbO61qj8krS0-iovzC5WnBE8-1n5OzxgGeg6JA@mail.gmail.com> (Kato
 Kazuyoshi's message of "Mon, 17 Oct 2011 10:15:07 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BA43F2C-F862-11E0-88A6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183749>

Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:

> Probably like:
>
> - format_diff_line returns a class with an line.
> - remove trailing space from the class.
> - add side-by-side feature and CSS.
> - add form.
>
> Thank you for your correction!

My wording came out a bit too strong; I didn't mean to "correct" anything.

I think a better organization would be

 [1/2] change code so that $diff_class does not have leading SP
       optionally catch a case where $diff_class stays empty as an error?

 [2/2] add side-by-side feature, which would involve:
  - making format_diff_line() to return $diff_class separately;
  - necessary addition of CSS;
  - addition of form to trigger the feature.

I do not think splitting the second patch into pieces smaller than that
makes sense.

Thanks.
 
 
