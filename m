From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the
 default
Date: Mon, 09 Nov 2009 22:05:01 -0800
Message-ID: <7vpr7qgbjm.fsf@alter.siamese.dyndns.org>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1257789555.4108.348.camel@laptop> <20091110040847.GC29454@elte.hu>
 <76718490911092112v4d1e7761ue98def756ed0d93b@mail.gmail.com>
 <20091110052211.GK7897@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Nov 10 07:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7jr7-00073f-PO
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 07:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbZKJGFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 01:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbZKJGFI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 01:05:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbZKJGFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 01:05:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F4027A91B;
	Tue, 10 Nov 2009 01:05:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IZzD13LZfaPqs67uBr8e2UdBPpo=; b=hSJQq8
	nZC6NLdHbdNEKoWeFtNRVIewC8xUsACNCX7DG8lRJ9YjVZ0aaApRCEMtMwO98GUf
	kLkREn0XVTJIaL5jXosKVAxB2KugdmGlrKeVRZ+Ibl6RpWzIwW83sgHR9jZwYXUQ
	8SoM6/D8W7xxDMcT6Zczd8Xmr6t0sfM/G6E3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J09k/bc6NXtFFo/iYZoawhS7xhKkpBN1
	KezFwkbPrviGQkUkAJh5LujoHC+vpg7jcP8Y0AEQuQsVVPQEDj/QIciX7yedIks7
	2giBNllvYxuoCxZuFI1ikl04Jdj5nBayQGiP1b+J4dJYpdGYUOCbfHA9gK51G17v
	Hf02EbFcHwI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D86D97A91A;
	Tue, 10 Nov 2009 01:05:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB4F97A919; Tue, 10 Nov
 2009 01:05:02 -0500 (EST)
In-Reply-To: <20091110052211.GK7897@elte.hu> (Ingo Molnar's message of "Tue\,
 10 Nov 2009 06\:22\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF4E8880-CDBE-11DE-878F-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132540>

Ingo Molnar <mingo@elte.hu> writes:

> +1 for putting it into a .1.6.x stable branch too. (Unless there's a 
> case where the recursive threading is actually useful and is being 
> relied on.)

As I wrote in the LKML message when that patch was made (please see my
other message for the URL to the archive), my assessment of this issue is
that it would have been the right thing to do if we were doing this now
without any existing users, but nobody really cares deeply enough either
way to warrant fast tracking the schedule we promised back in August.

It would take a bit stronger nudging than "unless there is a case against
changing the default because it is being relied on", as I know that people
who rely on would not speak up for a long time.  We already saw that it
took 6 month between Feb 2009 to Aug 2009 for people who wanted to change
the default to notice and complain that the change they were promised did
not happen ;-).

Some people will complain when we switch the default to no-chain-reply-to
in the 1.7.0 release.  I am willing to take flak from them and defend the
change.

But I am not convinced that this deserves to be fast-tracked to the 1.6.x
series.  We gave them until 1.7.0 and I have no good answer to "why didn't
you wait as you promised?"  I'd rather avoid telling them that "that is
how kernel people wanted it, and sorry, their wish trumps yours." if I
can.
