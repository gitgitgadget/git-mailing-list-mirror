From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name
Date: Sun, 28 Oct 2007 08:40:27 -0700
Message-ID: <7vd4uzuu1g.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
	<11935038083369-git-send-email-prohaska@zib.de>
	<11935038084055-git-send-email-prohaska@zib.de>
	<7vwst7wvdr.fsf@gitster.siamese.dyndns.org>
	<722152C5-299C-435E-B720-D2D331D16249@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 16:40:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImAFr-0000OU-RV
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 16:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbXJ1Pkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 11:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbXJ1Pkf
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 11:40:35 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:44552 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbXJ1Pke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 11:40:34 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8E6982EF;
	Sun, 28 Oct 2007 11:40:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 25BF68F80E;
	Sun, 28 Oct 2007 11:40:52 -0400 (EDT)
In-Reply-To: <722152C5-299C-435E-B720-D2D331D16249@zib.de> (Steffen Prohaska's
	message of "Sun, 28 Oct 2007 16:10:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62566>

Steffen Prohaska <prohaska@zib.de> writes:

> On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>>> This teaches "push <remote> HEAD" to resolve HEAD on the local
>>> side to its real ref name, e.g. refs/heads/master, and then
>>> use the real ref name on the remote side to search a matching
>>> remote ref.
>>
>> This probably is a good idea.
>
> I'll add an even shorter shorthand: "git push HEAD" will push
> the current branch to its default remote.

Ugh, that looks way too magicky.  The first parameter to push if
one ever exists has _always_ been the remote, and the above
breaks it.

Please don't.
