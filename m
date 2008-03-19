From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase [--onto O] A B: omit needless checkout
Date: Wed, 19 Mar 2008 12:19:49 -0700
Message-ID: <7vhcf24j3e.fsf@gitster.siamese.dyndns.org>
References: <20080312191041.GF3198@ins.uni-bonn.de>
 <47D8D5B8.70809@viscovery.net> <20080315103954.GD14769@ins.uni-bonn.de>
 <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org>
 <47E10D0D.2080702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:31:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc40s-0006jn-BP
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbYCSTZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbYCSTZU
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:25:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbYCSTZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:25:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DB591067;
	Wed, 19 Mar 2008 15:20:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AC2DB1046; Wed, 19 Mar 2008 15:19:57 -0400 (EDT)
In-Reply-To: <47E10D0D.2080702@viscovery.net> (Johannes Sixt's message of
 "Wed, 19 Mar 2008 13:54:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77505>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> This teaches "git rebase [--onto O] A B" to omit an unnecessary checkout
>> of branch B before it goes on.
>> ...
>
> This works for a frequent use-case of mine:

"Works" meaning "does not break", or "gives a great performance
improvement that it is worth having it early in a tagged release"?

>   $ git rebase master devel
>
> where I am already on branch master, and now want to rebase devel on top
> of it.
>
> The code seems to take care of a lot of corner cases and less frequent
> use-cases, including using --onto, which I don't feel able to judge about.
>
>> +# git reset --hard "$onto^0"
>
> Don't forget to remove this line. ;)
