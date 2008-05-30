From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-fast-export: Remove double spaces in author line
Date: Fri, 30 May 2008 13:27:37 -0700
Message-ID: <7vtzgfk05i.fsf@gitster.siamese.dyndns.org>
References: <1212143475-48255-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri May 30 22:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BDK-0002Cx-Fx
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbYE3U1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbYE3U1q
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:27:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbYE3U1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:27:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0AC7E238F;
	Fri, 30 May 2008 16:27:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5B171238E; Fri, 30 May 2008 16:27:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB46A892-2E86-11DD-92EF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83325>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> It produces 
>
> 	"author Samba Release Account <samba-bugs@samba.org>  831196245 +0000"
>
> The git-fast-import syntax says there can only be a single space after the >
> sign. This Samba commit breaks bzr-fast-import, for example.
>
> I'm not sure how to properly fix the problem, as I'm not very deep into Git's
> code. I included this patch in case anyone else has the same problem and wants
> a quick fix. I'm also not sure if it's a fast-export problem, or if the Samba
> repository is just invalid :)

You can call that repository broken if you want, but we can try to be
liberal when receiving and be strict when generating.  IOW, fast-import
could accept such a minor deviation and generate a commit after fixing it.
The same thing can be said about fast-export --- read, fix and generate.

By the way, your quick hack would however squash multiple SPs anywhere on
the line, wouldn't it, not just the one between '>' and the timestamp?
