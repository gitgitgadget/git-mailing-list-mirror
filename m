From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] sparse: Fix some "symbol not declared" warnings
Date: Sun, 11 Sep 2011 17:06:03 -0700
Message-ID: <7vr53mbp5g.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
 <7vobyqn4jh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 02:06:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2u2P-0007y3-MB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 02:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab1ILAGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 20:06:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab1ILAGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 20:06:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 190CB4251;
	Sun, 11 Sep 2011 20:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T2RSdcLfZTdzIKPfOikvb8MAInk=; b=xBove4
	Rmv0mzXhffdyYeqOdpFK3dFz5WBiMeE6A0hWWjzSWT7HP3tcnCUY9Kur4fRnLzuB
	LrovLPVol53UK7Z5XHgZPzZx7NvxbRW6gooaHBprdchgsEY/Cn5QLS5VY5isijqy
	au9xaGvArFph5H1GEeqek2zlIN0gVqDrXbdgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hxz7Mmx6NriRudK3dnDsoAfWfLtRmk+I
	tAQvLm1IGPbvBqUs/ybwZiqrIC4t5BTkBnCFhDsmmmQRpM76PLoYfT8sXSXTiAFl
	iL2qNrI2utyAm78MJuiLLvZsk1E7LuzOxWC4Oq1IeIpvI8ABhPx6XsHjnyCSAnLe
	d5I6Ifb48QQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 107BF424F;
	Sun, 11 Sep 2011 20:06:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FCB2424E; Sun, 11 Sep 2011
 20:06:04 -0400 (EDT)
In-Reply-To: <7vobyqn4jh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 Sep 2011 14:38:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01BF7352-DCD3-11E0-A7D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181202>

Junio C Hamano <gitster@pobox.com> writes:

> There are many others that can be identified by running the attached
> script after you build your git. I'll follow this message up with three
> consolidated patches, but the latter two needs to be split into smaller
> pieces to be either queued on top (for topics in next) or squashed into
> (for topics in pu), which I am not going to do myself today (hint, hint).

Well, I lied ;-)  I've separated things out, queued fix-ups at the tips of
branches, and pushed out the integration result to the public repositories
(other than k.org that seems to be still down).
