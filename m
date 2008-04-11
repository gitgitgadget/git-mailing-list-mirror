From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH/RFC 3/7] git-submodule: Fall back on .gitmodules if info
 not found in $GIT_DIR/config
Date: Fri, 11 Apr 2008 16:24:26 -0700
Message-ID: <7v3apsotzp.fsf@gitster.siamese.dyndns.org>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-4-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-6-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-7-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 01:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkScV-0002zp-P5
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 01:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757971AbYDKXYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 19:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757870AbYDKXYj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 19:24:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbYDKXYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 19:24:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7904122F5;
	Fri, 11 Apr 2008 19:24:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D7CDC22F4; Fri, 11 Apr 2008 19:24:33 -0400 (EDT)
In-Reply-To: <1207842625-9210-7-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Thu, 10 Apr 2008 23:50:21 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79312>

Ping Yin <pkufranky@gmail.com> writes:

> Originally, the submodule workflow enforces 'git init' in the beginning
> which copies submodule config info from .gitmodules to $GIT_DIR/config.
> Then all subcommands except 'init' and 'add' fetch submodule info from
> $GIT_DIR/config and .gitmodules can be discarded.
>
> However, there may be inconsistence between .git/config and .gitmodules
> when always using 'git init' at first. If upstream .gitmodules changes,
> it is not easy to sync the changes to $GIT_DIR/config.

Maybe you missed an earlier thread with Roman Shaposhnik where this issue
was discussed and a solution more in line with the original intent of the
design of the submodule system was mentioned (actually I should not take
credit for that suggestion as it was not mine but somebody else mentioned
it back when git-submodule command was initially being designed.  I only
recalled there was that one issue in the discussion)?
