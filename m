From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mv: Keep moved index entries inact
Date: Mon, 21 Jul 2008 00:38:16 -0700
Message-ID: <7vk5ffvg9j.fsf@gitster.siamese.dyndns.org>
References: <20080717130651.GU32184@machine.or.cz>
 <20080717223036.20680.9672.stgit@localhost>
 <7vej5pwhub.fsf@gitster.siamese.dyndns.org>
 <20080721002354.GK10151@machine.or.cz>
 <alpine.DEB.1.00.0807210319410.3305@eeepc-johanness>
 <20080721071818.GL10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 09:39:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKpzQ-00062R-6E
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 09:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbYGUHiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 03:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbYGUHiY
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 03:38:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbYGUHiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 03:38:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EFEBB35EFC;
	Mon, 21 Jul 2008 03:38:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2E37C35EFB; Mon, 21 Jul 2008 03:38:18 -0400 (EDT)
In-Reply-To: <20080721071818.GL10151@machine.or.cz> (Petr Baudis's message of
 "Mon, 21 Jul 2008 09:18:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE9E88C0-56F7-11DD-8825-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89315>

Petr Baudis <pasky@suse.cz> writes:

> On Mon, Jul 21, 2008 at 03:20:46AM +0200, Johannes Schindelin wrote:
>> On Mon, 21 Jul 2008, Petr Baudis wrote:
>> > I want to make sure the whole index entry is intact, not just the sha1.
>> 
>> "rev-parse :dirty" will have to read the index to get at the object name 
>> of "dirty".  So there you have your index validation for you.
>
>   it will test if the entry stays _valid_, but not whether it stays the
> _same_.

You are right.  You would want to catch breakages like a file losing its
executable bits, which you cannot detect by grabbing "rev-parse :dirty"
and comparing it with the expected value.
