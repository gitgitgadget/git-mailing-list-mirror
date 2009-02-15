From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] notes: only clean up message file when editing
Date: Sat, 14 Feb 2009 23:54:34 -0800
Message-ID: <7vr620nnid.fsf@gitster.siamese.dyndns.org>
References: <200902142056.42198.trast@student.ethz.ch>
 <4655551d70d8829a7a15219aef384deb4e63371a.1234642638.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 15 08:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYbrH-0005Ky-2H
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 08:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbZBOHyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 02:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZBOHyo
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 02:54:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZBOHyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 02:54:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 18AD99967D;
	Sun, 15 Feb 2009 02:54:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E07939967A; Sun,
 15 Feb 2009 02:54:36 -0500 (EST)
In-Reply-To: <4655551d70d8829a7a15219aef384deb4e63371a.1234642638.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat, 14 Feb 2009 21:23:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E68C6256-FB35-11DD-A481-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109972>

Thomas Rast <trast@student.ethz.ch> writes:

> +	MESSAGE="$GIT_DIR"/new-notes-$COMMIT
> +	trap '
> +		test -f "$MESSAGE" && rm "$MESSAGE"
> +	' 0
> +

Hmph, why not unconditionally rm -f "$MESSAGE" without test?
