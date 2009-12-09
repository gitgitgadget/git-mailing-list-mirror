From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 09 Dec 2009 11:55:44 +0100
Message-ID: <vpqaaxswh5b.fsf@bauges.imag.fr>
References: <20091208144740.GA30830@redhat.com>
	<7vfx7lcj18.fsf@alter.siamese.dyndns.org>
	<20091209103850.GD2977@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 11:56:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIKDI-0005Jx-8P
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 11:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbZLIKz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 05:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbZLIKz4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 05:55:56 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41796 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855AbZLIKz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 05:55:56 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nB9ArJZY019066
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Dec 2009 11:53:19 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NIKCu-0005H7-Sn; Wed, 09 Dec 2009 11:55:44 +0100
In-Reply-To: <20091209103850.GD2977@redhat.com> (Michael S. Tsirkin's message of "Wed\, 9 Dec 2009 12\:38\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Dec 2009 11:53:19 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134958>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> cherry-pick is a binary though while rebase is a shell script.
> Should I just exec git rebase? git-rebase?

See run-command.h :

#define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
int run_command_v_opt(const char **argv, int opt);

That should do the trick (grep 'run_command_v_opt.*GIT_CMD' *.c for
some example of uses).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
