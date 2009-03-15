From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] make the ST_{C,M}TIME_NSEC macros more function like
Date: Sun, 15 Mar 2009 13:01:20 -0700
Message-ID: <7v4oxu7dyn.fsf@gitster.siamese.dyndns.org>
References: <cover.1237115791.git.barvik@broadpark.no>
 <cover.1237115791.git.barvik@broadpark.no>
 <0681248ac5c9cedf5f42adeeae89966a89e6d42a.1237115791.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Mar 15 21:03:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiwXw-00033y-5R
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 21:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbZCOUB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 16:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbZCOUB1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 16:01:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbZCOUB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 16:01:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F8F46130;
	Sun, 15 Mar 2009 16:01:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DCAA0612F; Sun,
 15 Mar 2009 16:01:21 -0400 (EDT)
In-Reply-To: <0681248ac5c9cedf5f42adeeae89966a89e6d42a.1237115791.git.barvik@broadpark.no>
 (Kjetil Barvik's message of "Sun, 15 Mar 2009 12:38:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10261C52-119C-11DE-9261-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113297>

Kjetil Barvik <barvik@broadpark.no> writes:

> Make the macros take a pointer to a 'struct stat'. This is so that it
> should be easier to understand what is going on, and that the macros
> can later be implemented as a inline function if we want to.
>
> Impact: cosmetic change

Hmm,...

I have to wonder if this cosmetic change is an improvement, though.

I do not have a strong feeling either way, but I think it makes it clear
that these two macros are not lvalues if you do not pass a pointer but
instead pass a structure.  An inline function can still take a structure
passed by value as an argument anyway, no?
