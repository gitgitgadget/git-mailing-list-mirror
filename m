From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: BUG?? INSTALL MAKEFILE
Date: Tue, 06 Jan 2009 11:26:13 -0500
Message-ID: <49638625.3090109@tedpavlic.com>
References: <49635BF8.1010700@sadau-online.de> <vpqiqosa3fc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Sadau <lars@sadau-online.de>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jan 06 17:27:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKEmO-0006U4-Sl
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 17:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbZAFQ0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 11:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZAFQ0S
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 11:26:18 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:46031 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751235AbZAFQ0R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 11:26:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A09C380D8038;
	Tue,  6 Jan 2009 11:20:44 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IKOiVfDcmyHJ; Tue,  6 Jan 2009 11:20:44 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.166.97])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 88EF280D8037;
	Tue,  6 Jan 2009 11:20:44 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <vpqiqosa3fc.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104699>

> but then realized that prefix is set to $(HOME) by default. Are you
> sure you didn't edit the Makefile or run any sort of ./configure
> before "make install" ?

After doing a

	git clean -f

in my local git repo, I notice that:

	config.mak.autogen

still exists, and inside it:

	prefix = /usr/local

That file is included in the Makefile *after* prefix is set, and so if 
it's not updated, the Makefile will default to /usr/local.


According to the INSTALL doc, the default prefix should be ~. However, 
this is certainly not the case. Either the INSTALL doc needs to be 
updated or a new default config.mak.autogen needs to be checked in (or 
perhaps config.mak.autogen needs to be omitted from the repo?).

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>
