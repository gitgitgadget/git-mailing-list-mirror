From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore certain
 stat fields
Date: Tue, 15 Jan 2013 08:02:45 +0100
Message-ID: <50F4FF15.2080803@viscovery.net>
References: <7vmwwb8m25.fsf@alter.siamese.dyndns.org> <1815551092.2039693.1358207014937.JavaMail.root@dewire.com> <7vy5fv71ad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 08:03:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv0YF-0000da-Mt
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 08:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab3AOHCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 02:02:54 -0500
Received: from so.liwest.at ([212.33.55.24]:40350 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab3AOHCv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 02:02:51 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Tv0Xm-0000A9-NS; Tue, 15 Jan 2013 08:02:46 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4BAD01660F;
	Tue, 15 Jan 2013 08:02:46 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vy5fv71ad.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213601>

Am 1/15/2013 1:11, schrieb Junio C Hamano:
> I'd say a simplistic "ignore if zero is stored" or even "ignore this
> as one of the systems that shares this file writes crap in it" may
> be sufficient, and if this is a jGit specific issue, it might even
> make sense to introduce a single configuration variable with string
> "jgit" somewhere in its name and bypass the stat field comparison
> for known-problematic fields, instead of having the user know and
> list what stat fields need special attention.

It was my suggestion to have a list of names to ignore because the answer
to this question

> Is this "the user edits in eclipse and then runs 'git status' from the
> terminal" problem?

was "It is purely for performance in some situations" back then. But
today, the answer is "Yes". With this new background, your suggestion to
have just a single option that contains the token "jgit" may make more
sense. (core.ignoreCygwinFSTricks may serve as a precedent.) The original
patch was along this way, and the name contained "minimal", which I
objected to.

-- Hannes
