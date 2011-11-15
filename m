From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odd name-rev behavior?
Date: Tue, 15 Nov 2011 15:20:52 -0800
Message-ID: <7vpqgtt1kb.fsf@alter.siamese.dyndns.org>
References: <20111115211514.GE27706@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Walberg <twalberg@comcast.net>
X-From: git-owner@vger.kernel.org Wed Nov 16 00:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQSJH-00043J-D0
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 00:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab1KOXUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 18:20:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756664Ab1KOXUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 18:20:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2269C5AB4;
	Tue, 15 Nov 2011 18:20:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZlUf1C/xR53WNtC1lDc2IlLakXs=; b=EgSsjs
	twHmVI+azNnNBalMQpRa+wOxGpCWoHNleVEJFjoUTzPmrVBrkarU5WktLsMcliKh
	9sFUwmbVFRTiK7BsARjC5CWG0hgNfgySNaSTXzx+Jf341ON7gwhEW5sz958KD3q0
	9lDK/d7gbRnYZwFTY9swEIRkpN9UiFTO/C4rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e8JnK30nJRiD2jYMEGyl8r6IbVFjrAUm
	Bzt4fbpC3dUkW1l+1pmZsOP1IkTPy6REWZ1QG70Yx1s2JzXxO5Js5oBXnTR1emY5
	4TdcFEDKbAzMmdppW9HvcpaT3ZWIg1MjvlU5oaMRIge9lm0gy2B5TNUzszWor94U
	dO749wpXUiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A7565AB3;
	Tue, 15 Nov 2011 18:20:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EA755AB2; Tue, 15 Nov 2011
 18:20:53 -0500 (EST)
In-Reply-To: <20111115211514.GE27706@comcast.net> (Tim Walberg's message of
 "Tue, 15 Nov 2011 15:15:14 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76B6B1F8-0FE0-11E1-A1BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185497>

Tim Walberg <twalberg@comcast.net> writes:

> Never noticed this before - is this expected? It doesn't seem to
> match documentation, in any case...
>
> Basically, 'git name-rev --all' lists a lot of lines that are
> marked as "undefined", and most, if not all, of the objects
> represented are trees, not commits... I wouldn't have expected
> name-rev to follow the link from a commit to a tree and try to
> process that result...

I wouldn't either, but this does not look like a recent breakage. v1.6.0
seems to show the same broken behaviour.
