From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] receive-pack: Wrap status reports inside
 side-band-64k
Date: Fri, 05 Feb 2010 14:19:46 -0800
Message-ID: <7vhbpvxr3x.fsf@alter.siamese.dyndns.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
 <1265403462-20572-6-git-send-email-spearce@spearce.org>
 <7vd40j1j2a.fsf@alter.siamese.dyndns.org>
 <20100205215344.GC27498@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:20:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdWWv-0006OF-Jj
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 23:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933917Ab0BEWTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 17:19:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933910Ab0BEWTz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 17:19:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CCD397D0F;
	Fri,  5 Feb 2010 17:19:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TJPdX7jC+RSSh4pE62Tg1IQbXhE=; b=aqzO6v
	rLKByHliFmhE2lIl5lY8SL0R8EZpk6JNoP9mOL65eC57HtrDZG4Rd1RjxHUhNkk2
	7JQX+CtLbAtk/okCxzXrohCgP/pHA9WWa+sSaG0XUIgPn8faL+dK4ww4M1KPHTJz
	cNl1aOxBnHk5JU1GNjAy87f2e6bf18FqL/Sxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tpeDkIMwRwirFMpFFgI8NZbEjr98TZmT
	WHBBe7vxili2MOiNpn2l9nmW/72XDhENOeO0W2J0vkoUjwo1g2lQnXDVljnCT03h
	BIQlID6QH1detFRutmpdkrb9VIxUDCYnFX55PDOA/T4fKFzWb9W0cqs/ilyfsmjR
	+gq693TXJS8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08AC497D0E;
	Fri,  5 Feb 2010 17:19:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 698C597D0D; Fri,  5 Feb
 2010 17:19:48 -0500 (EST)
In-Reply-To: <20100205215344.GC27498@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 5 Feb 2010 13\:53\:44 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 93EC142E-12A4-11DF-84E6-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139100>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I was following the existing convention of use_sideband is
> maximum-packet-size in server code, and boolean in client code.

Ahh, I forgot about that -- we did it when we introduced different packet
size limit.

Now it all makes sense.  Thanks.
