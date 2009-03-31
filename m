From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: strbuf name conflict on Mac OS
Date: Tue, 31 Mar 2009 16:26:45 -0400
Message-ID: <5ECAAD78-F8D4-4F86-A16B-C8DF483771D6@silverinsanity.com>
References: <E5D92A5D-B2CC-44CE-B117-0BB88C0E663E@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:28:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LokZK-0000Mo-Kx
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbZCaU0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbZCaU0u
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:26:50 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:58050 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbZCaU0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:26:49 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id B302F1FFC032; Tue, 31 Mar 2009 20:26:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E2BFC1FFC030;
	Tue, 31 Mar 2009 20:26:39 +0000 (UTC)
In-Reply-To: <E5D92A5D-B2CC-44CE-B117-0BB88C0E663E@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115311>


On Mar 31, 2009, at 4:17 PM, Joshua Juran wrote:

> Apple's OpenTransport.h from Universal Interfaces 3.4.2 defines its  
> own struct strbuf, with which git's collides.
>
> Since OpenTransport.h also defines some POSIX constants (such as  
> O_NONBLOCK) as enums, it's necessary to include OpenTransport.h from  
> fcntl.h (and other affected headers) so as to control the order in  
> which the definitions appear in the translation unit.

Just to be clear, this is related to your work on LAMP under Classic  
and not OS X, correct?  If so, perhaps you need to create a compat/ 
classic_mac.h file that's included (when the correct #defines are  
seen) from git-compat-util.h in the manner of compat/ 
{cygwin,mingw}.h.  I'm assuming that this naming conflict is not the  
only such you'll find and it's better to keep platform specific tweaks  
to a single place when possible.

~~ Brian
