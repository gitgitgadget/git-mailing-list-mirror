From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 23:35:19 -0800
Message-ID: <7va9s3gf9k.fsf@alter.siamese.dyndns.org>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com> <20130120234205.GC3474@elie.Belkin>
 <20130121010643.GA25437@thyrsus.com>
 <7vr4lfgfkm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Jan 21 08:35:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxBux-0004Iy-W6
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 08:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab3AUHfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 02:35:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247Ab3AUHfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 02:35:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E60B7960F;
	Mon, 21 Jan 2013 02:35:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ksdJiIMBnCRxDht51Bfam6qGyAw=; b=mEdYTz
	dNnoQ+iG5tNEs+s3D+ViVaOtqnge2k7V3m3wkN3jnvVpWgjTSKXeE6MXdf9FM388
	gZCE8/JoRGnIdF2b76Mifal4HlCZHD2Xy1qApceCFvGGdVlVn8PtpwWLYN2hgyFe
	rblBM+2Pt/s/aHenNQGz9E8U3dtyLD7Xie6NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N3omazkFLWSKdyTh1yWyfUO/B+Efkd88
	TLXY2PM4bnA1AliDorK80ma92GrtW9e8UH790D8Ku4jP1pMGB4ZP5H0yALOj3rV7
	MbfXrwJj9WVbCaX6FY20/ro6m+RgytUQ579HvW295gVY6fr0YCakIKK5I5yjynVv
	Rcusx3WmsRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4887960C;
	Mon, 21 Jan 2013 02:35:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68DE89607; Mon, 21 Jan 2013
 02:35:21 -0500 (EST)
In-Reply-To: <7vr4lfgfkm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jan 2013 23:28:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C8AC892-639D-11E2-9D56-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214089>

Junio C Hamano <gitster@pobox.com> writes:

> If you want to abandon cvsps2 users, that is perfectly fine by me.
> As long as cvsps3 and cvsimport-3 combo works, Git before this
> series will have a _working_ cvsimport as far as I am concerned.

The above obviously is "Git _after_ this series".

Git before this series that only has cvsps2 support may be broken
and Git after this series, when used with cvsps2, may be broken, but
is broken the same way as before, so it is not a net loss.

The users of distros that are slow to update cvsps can still use
cvsimport-3 with cvsps3 that is manually installed, and the users of
distros that ship cvsps3 will use cvsimport-3 and they can migrate
away from cvsps2's breakage.
