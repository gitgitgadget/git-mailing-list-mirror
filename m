From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch.sh: support nearly proper tag name
 filtering
Date: Mon, 24 Mar 2008 18:14:21 -0700
Message-ID: <7v63vbr4eq.fsf@gitster.siamese.dyndns.org>
References: <47E7FACD.7020409@nrlssc.navy.mil>
 <47E8267D.5000405@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Mar 25 02:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdxkt-0008Qc-GT
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 02:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbYCYBOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 21:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbYCYBOa
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 21:14:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbYCYBO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 21:14:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0ABC1150E;
	Mon, 24 Mar 2008 21:14:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6EA6C150B; Mon, 24 Mar 2008 21:14:23 -0400 (EDT)
In-Reply-To: <47E8267D.5000405@nrlssc.navy.mil> (Brandon Casey's message of
 "Mon, 24 Mar 2008 17:09:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78139>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> I learned that the 'Q' command to sed is not portable, and most versions
> of sed require a newline after 'c\' like commands.

Both true.  If you want to be portable to esoteric ones (I suffered AIX
while hacking on autoconf long time ago), sed is a bitch to get right.

What I meant with my earlier comment was that it would have been more
robust if you did a sequence of:

	s/type .*/type $newtype/
        s/object .*/object $newobject/

instead of relying on the order in the existing objects, but I should have
been more explicit about c\ as well.
