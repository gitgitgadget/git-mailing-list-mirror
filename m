From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin-reflog: fix deletion of HEAD entries
Date: Sat, 09 Aug 2008 17:44:27 -0700
Message-ID: <7vhc9t4s2c.fsf@gitster.siamese.dyndns.org>
References: <1218324810-35376-1-git-send-email-pdebie@ai.rug.nl>
 <1218324810-35376-2-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Aug 10 02:45:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRz43-0003C3-Sw
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 02:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbYHJAoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 20:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYHJAoe
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 20:44:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbYHJAoe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 20:44:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7D02535C2;
	Sat,  9 Aug 2008 20:44:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D144535C1; Sat,  9 Aug 2008 20:44:29 -0400 (EDT)
In-Reply-To: <1218324810-35376-2-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Sun, 10 Aug 2008 01:33:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7F81C204-6675-11DD-8680-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91796>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> dwim_ref() used to resolve HEAD to its symlink (like refs/heads/master),
> making a call to 'git reflog delete HEAD@{1}' to actually delete the second
> entry in the master reflog.
>
> This patch makes a special case for HEAD (as that's the only non-branch
> reflog we keep), fixing the issue.

What happens to remotes/origin/HEAD that points at remotes/origin/master?
