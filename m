From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-shell: Add 'git-upload-archive' to allowed commands.
Date: Sat, 11 Apr 2009 12:22:54 -0700
Message-ID: <7v3acff10x.fsf@gitster.siamese.dyndns.org>
References: <49DE537C.8070907@ripe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Broes <erikbroes@ripe.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsipF-0004sO-AE
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758913AbZDKTXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758910AbZDKTW7
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:22:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758900AbZDKTW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:22:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 76896EE95;
	Sat, 11 Apr 2009 15:22:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E3D3CEE93; Sat,
 11 Apr 2009 15:22:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A6F8ACA-26CE-11DE-9FE2-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116328>

Erik Broes <erikbroes@ripe.net> writes:

> This allows for example gitosis to allow use of 'git archive --remote' in a
> controlled environment.
>
> Signed-off-by: Erik Broes <erikbroes@ripe.net>
> ---
>
> There were some questions on IRC raising (valid) concerns about security.
> If there is a dangling commit on the remote end and any user would know
> or guess the SHA, it could be retrieved where git-upload-pack will not
> allow so.
>
> We were unable to find out if this was the original reason git-shell was
> never extended with git-upload-archive functionality or if it was a simple
> oversight. If it was the reason I'm not sure there is an easy way out.

Can't the "security concern" be addressed by whatever creates the
controlled environment (e.g. gitosis)?  For example, git-daemon can be
configured to service upload-archive request, so I do not think it is such
a bad idea to make this available if the site owner wants to use it.
