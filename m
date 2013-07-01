From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: handle --ff/--no-ff/--ff-only as a tri-state option
Date: Mon, 01 Jul 2013 13:27:29 -0700
Message-ID: <7vppv2f2ku.fsf@alter.siamese.dyndns.org>
References: <20130701070143.GB17269@suse.cz> <51D197AD.1070502@alum.mit.edu>
	<20130701195407.GK17269@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 01 22:27:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtkhE-0003vN-IN
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 22:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab3GAU1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 16:27:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43189 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518Ab3GAU1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 16:27:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47C8E2D1D2;
	Mon,  1 Jul 2013 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WKjTRZDpIccJuidKZUVE0KxmYO8=; b=fQMuwn
	3W0b13mwvaHuZLYk1W8PDnQZpwzKhSf9HG7zs7/MAnLkiL5/uh+YBwSxug5H1cl5
	vEmoWJbBfEeknVBaBH3NDh+9E+xlWsgyOiR6qlY97n1nxgGteihBdZ5SKvcoIaYz
	6lFlgSy+78xtLej/bfn6872tVptgsIgljC+vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ubPOGws8ysw8ImiNCU1aYXGGsH1zyyAO
	WMSlRHka0FztLXD9P/w7UA4zG59J6EBiFQRasqoS5TTaQ+SJYiXEQcaD4nbr53d6
	qu0swxLXXQSaSk0rwIlvsfFp+jrp0g3Wc/PSKI5pGtiQIwVF/xAlVmIumQczKW3s
	y4K3O9LB7tQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1512D1D0;
	Mon,  1 Jul 2013 20:27:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B45C92D1CE;
	Mon,  1 Jul 2013 20:27:30 +0000 (UTC)
In-Reply-To: <20130701195407.GK17269@suse.cz> (Miklos Vajna's message of "Mon,
	1 Jul 2013 21:54:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A777D10C-E28C-11E2-8DE0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229327>

Miklos Vajna <vmiklos@suse.cz> writes:

> On Mon, Jul 01, 2013 at 04:52:29PM +0200, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> If I find the time (unlikely) I might submit a patch to implement these
>> expectations.
>
> Seeing that the --no-ff / --ff-only combo wasn't denied just sort of 
> accidently, I agree that it makes more sense to merge allow_fast_forward
> and fast_forward_only to a single enum, that automatically gives you 
> both benefits.

Yes, this goes in the right direction.  "Pick one out of these three
possibilities" is how the configuration is done, and the command
line option parsing should follow suit by consolidating these two
variables into one.

Thanks, will queue.

I didn't read the patch carefully, though, so review comments are
very much appreciated.
