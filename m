From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [FYI][PATCH] Execute testsuite on existing Git installation
Date: Fri, 03 Oct 2008 17:59:49 +0200
Message-ID: <48E64175.5090709@dawes.za.net>
References: <20081003131314.GS10544@machine.or.cz> <48E6314B.3090609@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Oct 03 18:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kln6F-0006cG-Nt
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 18:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbYJCQAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 12:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbYJCQAk
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 12:00:40 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:38902 "EHLO
	spunkymail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750904AbYJCQAj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Oct 2008 12:00:39 -0400
X-Greylist: delayed 4139 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Oct 2008 12:00:39 EDT
Received: from [192.168.201.101] (dsl-243-205-139.telkomadsl.co.za [41.243.205.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a10.g.dreamhost.com (Postfix) with ESMTP id 7E3911614CB;
	Fri,  3 Oct 2008 09:00:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48E6314B.3090609@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97433>

Rogan Dawes wrote:
> Petr Baudis wrote:
>> When I joined here, one of the first tasks I had was to "verify if the
>> existing system-wide Git installation works fine on the local Linux
>> setup (of unknown qualities)". I couldn't think of anything better than
>> to run the Git testsuite, but using the system-wide Git instead of
>> locally compiled one.
>>
>> This extremely dirty patch achieves this; patch testsuite of Git version
>> corresponding to the system-wide installation, of course. You will still
>> need to make the test helpers.
>>
>> I don't have any real interest on developing this further or tidying it
>> up, but I have thought that someone might find this useful to just use
>> or push forward, so here it goes.
>>
>> Signed-off-by: Petr Baudis <petr.baudis@novartis.com>
>>
> 
> Perhaps a stupid question, but might it not be easier to add the git 
> build dir to the front of the PATH, and then remove the explicit paths?
> 
> I realise that if the build was unsuccessful, you may end up executing a 
> different version of git than you expect, though.
> 
> Rogan
> 

Or, make a "BUILD_DIR" variable, and replace ../git with ${BUILD_DIR}git 
throughout, and make BUILD_DIR == '../' for the normal case, and '' for 
the less common case of testing the existing installation.

Or, make ../git a symlink to the installed git binary. This is probably 
the simplest, in fact, requiring the least surgery - i.e. none for those 
who don't need this functionality.

Rogan
