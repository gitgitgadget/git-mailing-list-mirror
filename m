From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Sat, 06 Sep 2008 22:59:29 -0700
Message-ID: <7vd4jgpkce.fsf@gitster.siamese.dyndns.org>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl>
 <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl>
 <7vzlmkpltb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Sep 07 08:00:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcDKH-0002Ln-Ps
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 08:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYIGF7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 01:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbYIGF7g
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 01:59:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbYIGF7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 01:59:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C18E5F085;
	Sun,  7 Sep 2008 01:59:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CF3E85F083; Sun,  7 Sep 2008 01:59:31 -0400 (EDT)
In-Reply-To: <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 06 Sep 2008 22:27:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 255BD844-7CA2-11DD-804E-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95115>

Junio C Hamano <gitster@pobox.com> writes:

> I somehow suspect it might be much simpler, more contained and robust if you:

Ah, that would not work, sorry, because this if() statement is only about
an uninteresting case of --allow-empty.  You need to do this the hard way
and teach get_commit_format_string() quote % characters in branch names.
