From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: Don't crash when switching away from an
 invalid branch.
Date: Fri, 07 Nov 2008 15:06:18 -0800
Message-ID: <7vbpwrf85x.fsf@gitster.siamese.dyndns.org>
References: <871vxnbhbh.fsf@wine.dyndns.org>
 <alpine.DEB.1.00.0811071903300.30769@pacific.mpi-cbg.de>
 <87od0r9nnj.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 00:07:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyaQb-0002N2-0E
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 00:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbYKGXGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 18:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbYKGXGc
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 18:06:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYKGXGb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 18:06:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CA469415A;
	Fri,  7 Nov 2008 18:06:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5FEEF94159; Fri, 
 7 Nov 2008 18:06:20 -0500 (EST)
In-Reply-To: <87od0r9nnj.fsf@wine.dyndns.org> (Alexandre Julliard's message
 of "Fri, 07 Nov 2008 23:28:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B609B83A-AD20-11DD-8A0D-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100359>

Alexandre Julliard <julliard@winehq.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> ...
>> Why not
>> 		old_desc ? old_desc : "(invalid)"
>> ?
>
> IMO it looks more friendly to not display a branch that doesn't exist,
> rather than printing something like (invalid) or (null).

Actually I think it is a good idea to remind that you were in a funny
state.

For that matter, dying without removing the trace of that funny state
might be even preferrable if you need to do postmortem to figure out why
you got into such a funny state to begin with, but not everybody uses git
to debug git.  I think Dscho's suggestion is a reasonable middle ground.
