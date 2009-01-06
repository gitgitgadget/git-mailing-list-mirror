From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 06 Jan 2009 00:59:21 -0800
Message-ID: <7vy6xohkt2.fsf@gitster.siamese.dyndns.org>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Johnny Lee" <johnnylee194@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 10:00:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7nv-0002Eh-FA
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 10:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbZAFI73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbZAFI72
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:59:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZAFI72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:59:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 31F3E1BE9D;
	Tue,  6 Jan 2009 03:59:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BA2F81BE07; Tue, 
 6 Jan 2009 03:59:23 -0500 (EST)
In-Reply-To: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
 (Johnny Lee's message of "Tue, 6 Jan 2009 15:00:52 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52544114-DBD0-11DD-8721-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104668>

"Johnny Lee" <johnnylee194@gmail.com> writes:

> While I'm looking at these "unable to unlink" files, it seems they are
> read only:
> git@tomato:~/golf$ ls -l .git/objects/16/
> total 4
> -r--r--r-- 1 johnny johnny 26 2009-01-05 09:25
> b14f5da9e2fcd6f3f38cc9e584cef2f3c90ebe


Check "ls -ld .git/objects/16" and see if it is owned by you and writable
by you.

In sane POSIX filesystem semantics, it should not pose with problem with
respect to removal that a file is unwritable.

What counts is the writability of the parent directory.
