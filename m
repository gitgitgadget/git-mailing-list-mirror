From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6 (v2)] Detecting HEAD more reliably while cloning
Date: Mon, 01 Dec 2008 17:33:29 -0800
Message-ID: <7vfxl7qs2e.fsf@gitster.siamese.dyndns.org>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <4934082B.5050802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:35:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KAb-0000gy-F6
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbYLBBd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbYLBBd6
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:33:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYLBBd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:33:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BB288393A;
	Mon,  1 Dec 2008 20:33:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 03DAE83938; Mon,
  1 Dec 2008 20:33:31 -0500 (EST)
In-Reply-To: <4934082B.5050802@viscovery.net> (Johannes Sixt's message of
 "Mon, 01 Dec 2008 16:52:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4918582C-C011-11DD-A404-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102090>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> Instead of introducing a full-fledged protocol extension, this round hides
>> the new information in the same place as the server capabilities list that
>> is used to implement protocol extension is hidden from older clients.
>
> Not that it makes a lot of difference, but why do you want to *hide* the
> information? Can't we just have a capability-with-parameter:
>
>  ... shallow no-progress include-tag head=refs/heads/foo\ bar ...
>
> (with spaces and backslashes escaped)?

The ref namespace is reasonably tight (most importantly I do not think you
can have space) so there is no need for quoting.  If we were to go that
route of making them extended "capabilities", the right syntax would be

    ... symref-HEAD=refs/heads/master symref-refs/remotes/origin/HEAD=refs/remotes/origin/master ...

or something like that.
