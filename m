From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Sun, 20 Jan 2013 10:06:33 -0800
Message-ID: <7vpq0zn2za.fsf@alter.siamese.dyndns.org>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <20130119165042.GB12307@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:07:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwzIJ-0001Hc-6J
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab3ATSGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 13:06:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab3ATSGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 13:06:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E018A91B;
	Sun, 20 Jan 2013 13:06:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4CUKPmhDqUqtBI+ZJvLySZhpkFs=; b=eR2ojw
	bxPM/DRcVZ7PP8W0KwQOxU1DHWpI4AlUsOyAAGNpWbzfWQohoIiUS85aFjVfYUrw
	7TXGP4tU1CBCz4XDwfMdP3cNO2H14Z5994w87ojZGyy2t0tkyVt/vf7ASnFtql/v
	1nGtq/xJ6mCJHZrD+9hHrYy1S4jTH/vAHApfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sPp2XK7MEztwHavp+THY1HdtJ0tWmCik
	RmP/gbEKt91vnexvevIJ7hLwZ/KT6VcCVnqdYtc9uZUUhfjR69wXq13hAjvrw2N4
	Fn44szMmS2ZZEX/1nBWIZIgKt3zyeUXHLG5j36/TrkgWMmBBoyqjcDgx71bPW8BI
	xPe5TEdTS50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10D93A91A;
	Sun, 20 Jan 2013 13:06:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94E4BA909; Sun, 20 Jan 2013
 13:06:34 -0500 (EST)
In-Reply-To: <20130119165042.GB12307@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 19 Jan 2013 08:50:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 204D4A5C-632C-11E2-ABA9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214025>

Jeff King <peff@peff.net> writes:

>> 	[uploadPack]
>> 		hiderefs = refs/changes
>
> Would you want to do the same thing on receive-pack? It could benefit
> from the same reduction in network cost (although it tends to be invoked
> less frequently than upload-pack).

Do *I* want to do?  Not when there already is a patch exists; I'd
rather take existing and tested patch ;-)

As I said, I view this primarily as solving the cluttering issue.
The use of hiderefs to hide these refs that point at objects I do
not consider belong to my repository from the pushers equally makes
sense as such, I think.
