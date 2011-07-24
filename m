From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] fast-export: do not export negative refs
Date: Sun, 24 Jul 2011 12:07:09 -0700
Message-ID: <7v39hvts4i.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-5-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 21:07:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql41G-00085L-Sp
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 21:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab1GXTHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 15:07:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802Ab1GXTHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 15:07:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D683DB0;
	Sun, 24 Jul 2011 15:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j/0XKRtu3d01gAEGuFdwjpI904A=; b=w1WQh2
	ZEyFHJRqBbL7YiLqR0IdIwfwvV2P35mLPXEk1cBRgj06gBjSokPlVlqYu3bB07jL
	Qmx7nzK5n9kW2OJlQD6sbYZKq3ViNrjLrcVD3sZOkdnaiKOk5lzcmOeVG0Mp9lPZ
	FmE3XTgEjyOZ0CfdSi3AOCaaw0eieTwGk2cL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kloliOrCd8nVcbIa/DV/r6sKxCaDvypR
	sp4ocPRiSFDvE6+W0ixJrI7eW6bNjjmWg/XFdl9/2uL9N65EfTKrIfgUJGwza3Kt
	5deTngOlVnfm40Z97Jb/0awHVetAMZXuOSoUxoAq9JZCNCKuZiMwliLQ279I27Js
	1YVoD8zwTM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF8833DAF;
	Sun, 24 Jul 2011 15:07:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61EC33DAE; Sun, 24 Jul 2011
 15:07:11 -0400 (EDT)
In-Reply-To: <1311517282-24831-5-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Sun, 24 Jul 2011 16:21:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2274A530-B628-11E0-A0A8-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177771>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> ... In the next commit this will be changed in order
> to make sure that 'master..master' does export master.

Sorry, but you need to be much more clear why this could be a good
thing.

Everywhere in git a range A..B means "reachable from B but exclude
everything that is reachable from A", and with that knowledge it is
natural to expect that master..master should yield an empty set. If you
need to change it for some reason, we need to know why, and if you are
doing it for a narrow special case, we need to know why that case is so
special.
