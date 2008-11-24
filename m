From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] Teach git fetch to verify signed tags
 automatically
Date: Sun, 23 Nov 2008 21:30:56 -0800
Message-ID: <7vmyfpn10v.fsf@gitster.siamese.dyndns.org>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
 <7v4p1xohbw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 24 06:33:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4U42-00022x-81
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 06:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbYKXFbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 00:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbYKXFbc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 00:31:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYKXFbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 00:31:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C6821713A;
	Mon, 24 Nov 2008 00:31:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 43756170C5; Mon,
 24 Nov 2008 00:30:57 -0500 (EST)
In-Reply-To: <7v4p1xohbw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 23 Nov 2008 20:53:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25A47D40-B9E9-11DD-A2A4-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101590>

Junio C Hamano <gitster@pobox.com> writes:

> Deskin Miller <deskinm@umich.edu> writes:
>
>> It struck me a while back when I fetched a new tagged release from git.git that
>> if I wanted to verify the tag's signature, I'd have to issue another command to
>> do so.  Shouldn't git be able to do that for me automatically, when it fetches
>> signed tags?  Now it does.  Also, 'git remote update' gets this for free.
>
> I think this should be done inside your own hook.  Not interested at all
> in a solution to touch builtin-fetch.c, unless if the patch is about
> adding a new hook so that people with other needs can use it as well.

... or a much stronger case can be made why this shouldn't be done in a
hook.

I realize "not interested at all" was a bit too strong, so I am trying to
rephrase it here.  The cycle that begins with an RFC that leads to
discussion and review is about clarifying the rationale and design
incrementally, so please do not get offended by my no, and sorry for using
unnecessarily strong wording.

What I meant was more like "The justification as given in the message does
not interest me in the patch at all as it stands.  I do not understand why
this has to be done as a patch to git-fetch itself, not in a hook script,
or why doing it inside git-fetch is a better approach than doing it in a
hook (if there already is a hook mechanism to do this)".
