From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Alternates and broken repos: A pack and prune scheme to avoid them
Date: Sun, 18 Nov 2007 12:10:39 -0800
Message-ID: <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org>
References: <200711181225.52288.johannes.sixt@telecom.at>
	<7v3av3wg7h.fsf@gitster.siamese.dyndns.org>
	<200711182101.53936.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Nov 18 21:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItqTv-0005Bn-SV
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 21:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbXKRUKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 15:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbXKRUKp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 15:10:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40617 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbXKRUKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 15:10:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id ED0452F0;
	Sun, 18 Nov 2007 15:11:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BFF5963F4;
	Sun, 18 Nov 2007 15:11:03 -0500 (EST)
In-Reply-To: <200711182101.53936.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sun, 18 Nov 2007 21:01:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65388>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Sunday 18 November 2007 19:39, Junio C Hamano wrote:
> ...
>> I would imagine that would work as long as it can be controlled
>> when all the involved repositories are repacked and pruned, such
>> as on repo.or.cz case (but on the other hand it is not really
>> controlled well there and that is the reason you wrote the
>> message X-<).
>
> Well, I think in many situations pack and prune can be controlled. To be 
> precise, if alternates are used pack and prune *must* be controlled.
> Currently, the control is very simple: "don't prune" (and I don't recall ATM 
> what you must not do when you repack).
>
> Anyway, judging from the responses so far it seems that people can live 
> with "don't prune" (or not using alternates) ;-)

Because my point was not "don't prune is good enough", I think
you are judging from too small number of responses (in fact,
zero).

My point was that even the existing setup that is well known to
the public (i.e. repo.or.cz) does not seem to be controlled, and
adding a nicer mechanism (e.g. I do not think there currently is
a canned way to prepare a pack that contains only unreachable
objects --- you need to script it anew) for a better control may
not help the situation much, unless it is actually used.
