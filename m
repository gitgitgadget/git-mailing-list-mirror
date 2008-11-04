From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intensive rename detection
Date: Mon, 03 Nov 2008 17:39:02 -0800
Message-ID: <7vy700s215.fsf@gitster.siamese.dyndns.org>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com>
 <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Andrew Arnott" <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 02:40:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxAuI-0004eL-4i
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 02:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbYKDBjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 20:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbYKDBjU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 20:39:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYKDBjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 20:39:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 00EA178354;
	Mon,  3 Nov 2008 20:39:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B7AF178351; Mon,  3 Nov 2008 20:39:09 -0500 (EST)
In-Reply-To: <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com>
 (Andrew Arnott's message of "Mon, 3 Nov 2008 17:18:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6531E2F0-AA11-11DD-BC17-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100023>

"Andrew Arnott" <andrewarnott@gmail.com> writes:

> I'm refactoring a library including renaming both files and
> directories.  A few lines of each file are also changed, but they are
> substantially unchanged in content.  I've done a git add to put all my
> changes into the index, but a git status shows that git only detected
> a few of the renames... most of them are delete-add operations.  Is
> there anything I can do to help git recognize the rename so that
> history is preserved across this commit?

There is no need to do anything at commit time.

After making the commit, you can look at it with lower similarity
threashold, e.g.

	git show --stat -M1 HEAD

The default behaviour IIRC corresponds to -M5 (that is 50%).
