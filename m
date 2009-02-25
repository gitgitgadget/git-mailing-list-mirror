From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git diff ignore-space options should ignore missing EOL
 at  EOF differences
Date: Wed, 25 Feb 2009 01:35:06 -0800
Message-ID: <7v8wnu7tbp.fsf@gitster.siamese.dyndns.org>
References: <9b18b3110902150609q13333619k98f87a4a36a09030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>, davidel@xmailserver.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGC7-0003nw-8n
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759184AbZBYJfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760774AbZBYJfQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:35:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760369AbZBYJfO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:35:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8432115F1;
	Thu, 26 Feb 2009 04:35:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B7A2E15F0; Thu,
 26 Feb 2009 04:35:06 -0500 (EST)
In-Reply-To: <9b18b3110902150609q13333619k98f87a4a36a09030@mail.gmail.com>
 (demerphq@gmail.com's message of "Sun, 15 Feb 2009 15:09:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C385E672-03E8-11DE-987C-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111422>

demerphq <demerphq@gmail.com> writes:

> Fix bug where the diff library complains about missing EOL at EOF
> mismatches even when run under the various ignore whitespace options.

Hmm.  Perhaps I am not reading the problem description correctly, but this
is not certainly you are talking about, right?

    $ printf "abcde " >one
    $ git add one
    $ printf "abcde  " >one
    $ git diff -w one
    diff --git a/one b/one
    index c1401e2..9f6f8e6 100644
    $ echo "abcde  " >one
    $ git diff -w one
    index c1401e2..21ee909 100644
    $ exit



    
