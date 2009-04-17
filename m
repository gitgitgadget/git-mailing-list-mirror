From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Fri, 17 Apr 2009 16:40:54 -0700
Message-ID: <7v63h24znd.fsf@gitster.siamese.dyndns.org>
References: <1239916256-10878-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tommi Virtanen <tv@eagain.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 01:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luxhj-000740-61
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 01:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757749AbZDQXlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 19:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbZDQXlH
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 19:41:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbZDQXlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 19:41:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D0A3ABD74;
	Fri, 17 Apr 2009 19:41:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E6DFBABD6F; Fri,
 17 Apr 2009 19:40:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3606799A-2BA9-11DE-A6B8-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116803>

Mike Hommey <mh@glandium.org> writes:

> When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> variable to what would otherwise be passed to $SHELL -c. When this
> variable is set, we use it instead of the contents of argv.

How does this interact with a typical gitosis installation?  I think it
extracts bits from the ORIGINAL_COMMAND and formulates a sanitized command
line and then passes it to git-shell but I do not think it removes the
variable from the environment.
