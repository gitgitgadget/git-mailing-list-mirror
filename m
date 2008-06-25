From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix t5303 (the test case for pack corruptions) on Windows
Date: Wed, 25 Jun 2008 10:42:07 -0700
Message-ID: <7vskv11keo.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806232123420.2979@xanadu.home>
 <20080625164438.GA4039@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:43:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZ1U-00069i-DW
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 19:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbYFYRmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 13:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbYFYRmR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 13:42:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYFYRmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 13:42:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D5C51AF57;
	Wed, 25 Jun 2008 13:42:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 50DDA1AF54; Wed, 25 Jun 2008 13:42:11 -0400 (EDT)
In-Reply-To: <20080625164438.GA4039@steel.home> (Alex Riesen's message of
 "Wed, 25 Jun 2008 18:44:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0C790F70-42DE-11DD-A0CB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86308>

Alex Riesen <raa.lkml@gmail.com> writes:

> The perldiag(1) has following to say about this:
>
>     "Can't do inplace edit without backup"
>
> 	(F) You're on a system such as MS-DOS that gets confused if
> 	you try reading from a deleted (but still opened) file. You
> 	have to say -i.bak, or some such.

Thanks.  By the way, there are others.

t/t9106-git-svn-dcommit-clobber-series.sh:23:		perl -i -p -e "s/^58$/5588/" file &&
t/t9106-git-svn-dcommit-clobber-series.sh:24:		perl -i -p -e "s/^61$/6611/" file &&
t/t9106-git-svn-dcommit-clobber-series.sh:43:	perl -i -p -e 's/^4\$/4444/' file &&
t/t9106-git-svn-dcommit-clobber-series.sh:44:	perl -i -p -e 's/^7\$/7777/' file &&
templates/hooks--prepare-commit-msg.sample:25:    perl -i -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
templates/hooks--prepare-commit-msg.sample:28:#   perl -i -pe '
