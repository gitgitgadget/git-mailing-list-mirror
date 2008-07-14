From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git describe question
Date: Mon, 14 Jul 2008 01:00:54 -0700
Message-ID: <7vvdz8hp3d.fsf@gitster.siamese.dyndns.org>
References: <20080714085557.246f52b9@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 10:02:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIJ0T-0005QJ-RO
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 10:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656AbYGNIBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 04:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755618AbYGNIBA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 04:01:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbYGNIBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 04:01:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 166992A4FA;
	Mon, 14 Jul 2008 04:00:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7845F2A4F9; Mon, 14 Jul 2008 04:00:56 -0400 (EDT)
In-Reply-To: <20080714085557.246f52b9@crow> (Mark Burton's message of "Mon,
 14 Jul 2008 08:55:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEA0D6C0-517A-11DD-B32D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88395>

Mark Burton <markb@ordern.com> writes:

> Having just pulled the latest updates, git describe says:
>
> v1.5.6.3-315-g10ce020
>
> Why does it think there are 315 commits on top of the v1.5.6.3 tag?

Short answer.  Because there are.  Count'em ;-)

	$ git rev-list v1.5.6.3..master | wc -l

A longer answer.  v1.5.6.X releases are from 'maint'.  The branch has
forked from the mainline loooong time ago (at v1.5.6, to be exact), and
has only fixes.  'master' is a separate branch for development that would
eventually lead to the next major release (planned to be v1.6.0).
