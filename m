From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] gitweb: Option to chop at beginning and in the
 middle in chop_str
Date: Sun, 24 Feb 2008 17:46:58 -0800
Message-ID: <7v8x19st7x.fsf@gitster.siamese.dyndns.org>
References: <200802222014.13205.jnareb@gmail.com>
 <20080224125920.24448.2179.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jean-Baptiste Quenot <jbq@caraldi.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 02:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTSRg-0003Gr-7f
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 02:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322AbYBYBrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 20:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbYBYBrU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 20:47:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYBYBrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 20:47:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9F5E290C;
	Sun, 24 Feb 2008 20:47:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 55AFA290B; Sun, 24 Feb 2008 20:47:06 -0500 (EST)
In-Reply-To: <20080224125920.24448.2179.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Sun, 24 Feb 2008 14:01:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74981>

Jakub Narebski <jnareb@gmail.com> writes:

> Make use of new feature of chop_str to better cut matched string and
> its context in match info for searching commit messages (commit
> search), as proposed by Junio C Hamano.  For example, if you are
> looking for "very long ... and how" in the first paragraph of this message
> (if it were all on a single line), you would now see:
>
>     ...st this with <<very long ... and how>> the actual out...
>
> instead of:
>
>     Could som... <<very long search stri...>> the actual out...
>
> (where <<something>> denotes emphasized / colored fragment).

This part needs rewritten; the first paragraph of what message is that?  

Also I think the subject is wrong.  Yes, it is adding an option
to an internal subroutine but who cares?  The net effect the
"gitweb" users see is that the way the grep result is shown
differently, hopefully in a more understandable way, and that
change is not _optional_ at all.

The code looks easier to read than before, but I may be partial
;-)
