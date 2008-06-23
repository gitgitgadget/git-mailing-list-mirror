From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Bugfix for AIX tmpfile creation
Date: Mon, 23 Jun 2008 16:10:15 -0700
Message-ID: <7viqvzg33c.fsf@gitster.siamese.dyndns.org>
References: <1214256821-3169-1-git-send-email-patrick.higgins@cexp.com>
 <7vy74vg4zq.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0806231552510.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick Higgins <patrick.higgins@cexp.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:11:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAvCU-0000hw-S8
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 01:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbYFWXKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 19:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753558AbYFWXKb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 19:10:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbYFWXK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 19:10:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C52B10A3F;
	Mon, 23 Jun 2008 19:10:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4E72F10A3E; Mon, 23 Jun 2008 19:10:23 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806231552510.2926@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 23 Jun 2008 15:55:50 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 919FE46E-4179-11DD-B964-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85951>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 23 Jun 2008, Junio C Hamano wrote:
>>
>> Hmm, we have quite a few calls to mkstemp(), so adding the workaround to
>> this specific call site does not scale well as a fix, I am afraid.
>
> All other callers of mkstemp() always rewrite the _entire_ path and don't 
> care about the result after failure (since it failed)

Yeah, I realize I grepped wrong X-<.
