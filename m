From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [TopGit PATCH] tg-patch: fix invocation in sub working tree 
 directory
Date: Mon, 16 Mar 2009 17:24:19 -0700
Message-ID: <7vwsapt2rw.fsf@gitster.siamese.dyndns.org>
References: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
 <7vbps1umg9.fsf@gitster.siamese.dyndns.org>
 <36ca99e90903161625x317556f4hc826aabd01494ca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	u.kleine-koenig@pengutronix.de
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 01:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjN82-00081f-EE
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 01:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbZCQAY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 20:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbZCQAY2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 20:24:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180AbZCQAY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 20:24:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EB9506EDC;
	Mon, 16 Mar 2009 20:24:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 115E36ED8; Mon,
 16 Mar 2009 20:24:20 -0400 (EDT)
In-Reply-To: <36ca99e90903161625x317556f4hc826aabd01494ca0@mail.gmail.com>
 (Bert Wesarg's message of "Tue, 17 Mar 2009 00:25:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F944E164-1289-11DE-A7C9-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113408>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> On Mon, Mar 16, 2009 at 23:33, Junio C Hamano <gitster@pobox.com> wrote:
>> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>>
>>> tg patch won't work in a sub directory of the working tree, because 'git diff
>>> --name-only' prints the names relative to the top working tree.
>>
>> "diff --relative --name-only"?
>
> No, unfortunately. In my bug case the changed file was in another
> subtree, and --relative restricts the output to only files under the
> current subtree.

Ah, Ok, then insertion of cdup output does make sense (after all cdup was
designed to be used that way).
