From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix 'git checkout <submodule>' to update the index
Date: Thu, 02 Apr 2009 12:54:17 -0700
Message-ID: <7vprfuesra.fsf@gitster.siamese.dyndns.org>
References: <cover.1238678601u.git.johannes.schindelin@gmx.de>
 <c267451c12c4ead4c222eebe6df460b46edd59c1.1238678601u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpT17-0003uD-Vk
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 21:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbZDBTy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 15:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765317AbZDBTy0
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 15:54:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763501AbZDBTy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 15:54:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A1B2BFD1;
	Thu,  2 Apr 2009 15:54:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C10B1BFD0; Thu, 
 2 Apr 2009 15:54:18 -0400 (EDT)
In-Reply-To: <c267451c12c4ead4c222eebe6df460b46edd59c1.1238678601u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Thu, 2 Apr 2009 15:30:25 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0FAD847C-1FC0-11DE-BC3E-781813508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115489>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> While 'git checkout <submodule>' should not update the submodule's
> working directory, it should update the index.  This is in line with
> how submodules are handled in the rest of Git.
>
> While at it, test 'git reset [<commit>] <submodule>', too.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	I have no idea who thought that it would be a good idea to leave 
> 	the submodules alone, but I think it is highly counterintuitive 
> 	that
>
> 		git checkout <submodule>
>
> 	does not touch the index.

I do not see anything that treats submodule specially in the scripted
version and this check for S_ISGITLINK() has been there since the very
beginning of C rewrite 782c2d6 (Build in checkout, 2008-02-07), so it is a
regression fix that can go to maint (all the way down to 1.5.5 if you
want).

Thanks.
