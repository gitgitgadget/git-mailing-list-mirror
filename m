From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move read_revisions_from_stdin from builtin-rev-list.c
 to revision.c
Date: Sat, 05 Jul 2008 17:57:28 -0700
Message-ID: <7vbq1brfrb.fsf@gitster.siamese.dyndns.org>
References: <7vod5crydx.fsf@gitster.siamese.dyndns.org>
 <1215290434-27694-1-git-send-email-adambrewster@gmail.com>
 <1215290434-27694-2-git-send-email-adambrewster@gmail.com>
 <20080705204849.GJ4729@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Brewster <adambrewster@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, Adam Brewster <asb@bu.edu>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 02:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFIaT-0005WD-8b
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 02:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYGFA5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 20:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYGFA5o
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 20:57:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbYGFA5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 20:57:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C0F31816C;
	Sat,  5 Jul 2008 20:57:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 62CD718169; Sat,  5 Jul 2008 20:57:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 885A76E0-4AF6-11DD-B9FB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87478>

Miklos Vajna <vmiklos@frugalware.org> writes:

> I think it's fine to move such a function, but this is a false commit
> message, you can use read_revisions_from_stdin() from builtin-bundle if
> it lives in builtin-rev-list.c as well.

At the mechanical level, yes you _can_, but it is simply a bad taste to do
so.  More library-ish files such as revision.c are better home for utility
functions to be shared between builtins and commands.
