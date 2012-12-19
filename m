From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git-subtree behavior when the -P tree is removed and
 recreated
Date: Wed, 19 Dec 2012 07:59:14 -0800
Message-ID: <7v8v8uav8t.fsf@alter.siamese.dyndns.org>
References: <CACUV5ofmuUku=byR1_+Cq+g0SdzqZbH1Z1tPfQf4eNABVyYb_Q@mail.gmail.com>
 <CACUV5odffQoCxr=hTuP+S+DU4+6qD7y=YkTCN3iRr7rjar1bLQ@mail.gmail.com>
 <CACUV5ocT56iOS3dZsJ4JLo70o1HJv2TSrvBHE646SyQVmOuYRg@mail.gmail.com>
 <877gozuooz.fsf@pctrast.inf.ethz.ch>
 <CACUV5odJx1+47ggOAppN7whJhLABrRP-3mRWo8adQqbxF4mA5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	"David A.Greene" <greened@obbligato.org>
To: Tomi Belan <tomi.belan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 16:59:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlM3U-0000S1-U4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 16:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab2LSP7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 10:59:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab2LSP7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 10:59:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12E3DBB89;
	Wed, 19 Dec 2012 10:59:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJ4bWVM0nvHdj67gKHYkzgOZQUE=; b=oPQKPD
	/e2tq+MLaJImAmcCBrkJ3BgK8gCBWu57CjZHZgTMzleBcFEX3AC0Raqg0QUH8+Gx
	e55DeLGSkQcv04IVbjh0UMWTCX3F6/rBiSmbvDAhNSiGcDU0M+izHfTTWVWq19D0
	Ru5RdkNjIvZNnGRKHgbQFpv/liL1YLn46kA/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RN3UA5dtA8tS8glBgnUlEkUIMFof0crg
	80nGxF5NKfNOAgbxKiYkSITJuck24FO3WaPgpXn0xYq733fL3xOd+9lx0bdbPYJy
	wh6x1hQXu54fXzEHoI4gFltReMzMh86gwGCKHz2QZ0m7WuzdjwfZBbVb/rEMuVeK
	Sygy+BvSYMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE441BB88;
	Wed, 19 Dec 2012 10:59:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 586B6BB86; Wed, 19 Dec 2012
 10:59:16 -0500 (EST)
In-Reply-To: <CACUV5odJx1+47ggOAppN7whJhLABrRP-3mRWo8adQqbxF4mA5A@mail.gmail.com> (Tomi
 Belan's message of "Wed, 19 Dec 2012 16:40:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A555884-49F5-11E2-A389-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211829>

Tomi Belan <tomi.belan@gmail.com> writes:

> Thanks. Here's one more bump. Avery? David?

Thanks for your persistence.

I am moderately dissapointed by the inaction on the subtree part so
far.  It was merged hoping that it will have more exposure to the
end-users if it were in my tree, and it obviously is gettng that,
but the people involved in the subtree part does not seem to be
holding their end of the bargain.

I am seriously considering to remove it from the contrib/ area of my
tree if we do not see any response.  The contrib/ area is not meant
to be a dumping ground for abandoned WIP.

Maybe it is a seasonal thing, just before the holiday season, but
this has been unresponded for a couple of months, not even with a
"That combination is not supported", or "Thanks for a bug report".

Grumpy.
