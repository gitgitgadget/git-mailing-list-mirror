From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Storing notes refs outside of refs/
Date: Thu, 26 Aug 2010 11:54:52 -0700
Message-ID: <7vlj7tkxvn.fsf@alter.siamese.dyndns.org>
References: <4C7681F1.3070205@workspacewhiz.com>
 <7vy6btl2yo.fsf@alter.siamese.dyndns.org>
 <4C76B186.5080809@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 20:55:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OohbO-0005CK-OF
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 20:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab0HZSzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 14:55:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab0HZSzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 14:55:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0FD7D080B;
	Thu, 26 Aug 2010 14:54:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6WCWWMTAlecHLZYLADxR9+dclOw=; b=DJBNFt
	awrdG22THIrksoxYcPtC7AEFaKwxpLAJPt4gaY9ouNgscLCXux+4BKZix93yAUKO
	qEFV1bBlfwBBFG1eHs+vqypU9TE2Or+k+GjO5OU4YIMz3Trmo6lC2JtJTiIjHplu
	v1VIQDPrLUk8WakEloRkymA7wcf0KNLvUo6Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dnW+FJ0FuOcpLEe8EHP2eA2F85ea9FpR
	VkDx4uOifpsP7apWkqvNRYa00i3hzgKOYIn8Z8Ysar82R4O81V3p9Dyk0IgSVd81
	WaE+BWLCI8+l3Q1jLeuQz9TMnbA+NFFGkgvsPEJukK4Ge60CGd7GLxIWo3lMax9x
	sfx5BPWq1uQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B88A5D080A;
	Thu, 26 Aug 2010 14:54:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10D5DD0808; Thu, 26 Aug
 2010 14:54:53 -0400 (EDT)
In-Reply-To: <4C76B186.5080809@workspacewhiz.com> (Joshua Jensen's message of
 "Thu\, 26 Aug 2010 12\:25\:10 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B67A070-B143-11DF-8BF4-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154555>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> gitk --all --not --glob=refs/notes/*
>
> does not work.

I don't think --not there is a good idea because "--not" in rev-list
parameter means "not reachable from the following commits".

It may be useful if you made "--all --glob=!refs/notes/*" to work,
though.  I could picture myself buying such a change.

Or just use "--branches --tags" instead, perhaps?
