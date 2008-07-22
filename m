From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status in clean working dir
Date: Mon, 21 Jul 2008 19:30:16 -0700
Message-ID: <7vy73ur6pz.fsf@gitster.siamese.dyndns.org>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Bremner <bremner@unb.ca>
X-From: git-owner@vger.kernel.org Tue Jul 22 04:31:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL7eu-0003Vv-Tu
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 04:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbYGVCaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 22:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbYGVCaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 22:30:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbYGVCaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 22:30:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F6C032722;
	Mon, 21 Jul 2008 22:30:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DD73A32720; Mon, 21 Jul 2008 22:30:18 -0400 (EDT)
In-Reply-To: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> (David Bremner's message
 of "Mon, 21 Jul 2008 20:13:55 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21DBF41E-5796-11DD-BE19-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89425>

David Bremner <bremner@unb.ca> writes:

> According to the manual page for git-status (version 1.5.6.3)
>
>        If there is no path that is different between the index file
>        and the current HEAD commit (i.e., there is nothing to commit
>        by running git-commit), the command exits with non-zero status.
>
> But it doesn't seem to work that way for me.
>
> git status -a 
>
> exits with 0
> ...

Try "git status -a >/dev/null" or "git --no-pager status -a".

I think this is an instance of the c8af1de (make git-status use a pager,
2008-04-23) stupidity raising its ugly head again.

Do people mind reverting that patch?
