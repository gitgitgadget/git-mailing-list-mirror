From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 14:55:15 -0800
Message-ID: <7vprx553u4.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
	<20071215004230.GF7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
	<20071217200920.GB19816@mail.oracle.com>
	<alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
	<20071217211317.GC19816@mail.oracle.com>
	<20071217213049.GG13515@fieldses.org>
	<alpine.LFD.0.999999.0712171646230.8467@xanadu.home>
	<20071217215709.GH13515@fieldses.org>
	<7vtzmh55lu.fsf@gitster.siamese.dyndns.org>
	<20071217223055.GI13515@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:55:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OsN-0001aV-T8
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbXLQWzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755051AbXLQWzc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:55:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbXLQWzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:55:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C0134295;
	Mon, 17 Dec 2007 17:55:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7F74291;
	Mon, 17 Dec 2007 17:55:17 -0500 (EST)
In-Reply-To: <20071217223055.GI13515@fieldses.org> (J. Bruce Fields's message
	of "Mon, 17 Dec 2007 17:30:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68646>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Hm.  We tell people to set up public repo's by doing something like:
>
> 	git clone --bare ~/proj proj.git
> 	touch proj.git/git-daemon-export-ok
> 	scp -r proj.git example.com:
>
> Is that going to hit the same problem if the public server has an older
> git version?

It will, but I think you should teach people --mirror pushing these
days, which was specifically invented for priming the public
repository.

That way, the administrator at example.com, as long as he initializes an
empty repository with suitable daemon-export-ok and necessary hooks
(which can be automated via templates), does not even have to allow you
a full ssh access.
