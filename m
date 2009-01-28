From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: Fix intermittent failures of t7701
Date: Wed, 28 Jan 2009 00:26:17 -0800
Message-ID: <7v3af3vnti.fsf@gitster.siamese.dyndns.org>
References: <497F076F.8060509@viscovery.net>
 <alpine.DEB.1.00.0901271740320.3586@pacific.mpi-cbg.de>
 <498008BA.2000201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 09:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5m7-0003i4-PW
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbZA1I0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbZA1I0a
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:26:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbZA1I0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 03:26:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3678094111;
	Wed, 28 Jan 2009 03:26:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0169094110; Wed,
 28 Jan 2009 03:26:23 -0500 (EST)
In-Reply-To: <498008BA.2000201@viscovery.net> (Johannes Sixt's message of
 "Wed, 28 Jan 2009 08:26:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5BDA2612-ED15-11DD-8D18-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107508>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Johannes Schindelin schrieb:
>> I use this trick in my valgrind series:
>> 
>> 	($PROGRAM; echo $? > exit.code) | $OTHER_PROGRAM &&
>> 	test 0 = "$(cat exit.code)"
>
> Ah, using a file as temporary storage? Why not simply
>
> 	$PROGRAM > data &&
> 	$OTHER_PROGRAM < data
>
> Hm? ;)

Because too much cleverness often blinds clever minds.

Care to reroll with the simpler, dumber but clearer version?
