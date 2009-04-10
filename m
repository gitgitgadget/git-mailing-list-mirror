From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-stash fails on OSX 10.5
Date: Fri, 10 Apr 2009 10:26:34 -0700
Message-ID: <7vy6u8whbp.fsf@gitster.siamese.dyndns.org>
References: <be4ebbe10904100944p6ec2c0dao8607fcff75d2754e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Kaplan-Moss <jacob@jacobian.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 19:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsKWW-0005cv-85
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 19:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759817AbZDJR0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 13:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758439AbZDJR0m
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 13:26:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbZDJR0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 13:26:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F220AA92C3;
	Fri, 10 Apr 2009 13:26:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EDC3FA92C1; Fri,
 10 Apr 2009 13:26:35 -0400 (EDT)
In-Reply-To: <be4ebbe10904100944p6ec2c0dao8607fcff75d2754e@mail.gmail.com>
 (Jacob Kaplan-Moss's message of "Fri, 10 Apr 2009 11:44:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BFE94E18-25F4-11DE-95E8-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116267>

Jacob Kaplan-Moss <jacob@jacobian.org> writes:

> Hi folks --
>
> I'm stumped; git-stash simply won't work on my machine. On any
> repository I've tried, with various permutations, I keep getting::
>
>     $ git stash
>     cp: `.../.git/index': No such file or directory
>     Cannot save the current worktree state

Are you exporting 

	GIT_INDEX_FILE=.../.git/index

into the environment, and that path perhaps does not exist?

Otherwise the above error message wouldn't have said ".../.git/index"; it
is coming from the only invocation of "cp" command in git-stash.sh
