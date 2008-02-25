From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move worktree setup out of setup_git_directory*
Date: Mon, 25 Feb 2008 11:01:08 -0800
Message-ID: <7v7igskgi3.fsf@gitster.siamese.dyndns.org>
References: <20080224044650.GA25343@laptop>
 <7vr6f1sur3.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0802250517x2192b51epf2a162b0a984e99c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTiaQ-0003ll-0J
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbYBYTB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbYBYTB0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:01:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbYBYTBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:01:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77CCF212F;
	Mon, 25 Feb 2008 14:01:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 75859212E; Mon, 25 Feb 2008 14:01:13 -0500 (EST)
In-Reply-To: <fcaeb9bf0802250517x2192b51epf2a162b0a984e99c@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Mon, 25 Feb 2008 20:17:36 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75047>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> Interesting. It currently does chdir(). But it is pointless now as
> worktree should not be accessed until setup_work_tree() is called.
> setup_git_directory* should not return a prefix at all.
> ...
> I guess I just need to verify your statements and put them to
> Doc/technical/api-setup.txt ;)

The above, as I said, was written out of thin air without
re-reading the current code nor carefully reading what your
patch does, so I am afraid there needs a lot more than that
to happen before we have something to validate the callers
against, but I think you got why I think it is a good idea to
have that documented.
