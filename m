From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use common parameter parsing and generation for "o", too.
Date: Sat, 19 Aug 2006 12:55:57 +0200
Organization: At home
Message-ID: <ec6qnp$aal$1@sea.gmane.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <ec1d6q$823$2@sea.gmane.org> <20060817191300.GA11477@admingilde.org> <200608172134.38751.jnareb@gmail.com> <20060818202013.GB30022@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 19 12:56:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEOV2-000873-Ti
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 12:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWHSK4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 06:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWHSK4R
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 06:56:17 -0400
Received: from main.gmane.org ([80.91.229.2]:25835 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751305AbWHSK4R (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 06:56:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GEOUo-00083v-Mz
	for git@vger.kernel.org; Sat, 19 Aug 2006 12:56:07 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 12:56:06 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 12:56:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25713>

Martin Waitz wrote:

> Perhaps introduce a new function which is used to access the parameters?
> This new function could check the URL or CGI->param or whatever and then
> return the requested value.

CGI->param. There is no reason to duplicate CGI module.

> Then the action functions could get all parameters they need, validate
> them themselves and then act on them.
> This would suit my "break out parameter parsing from actions" and your
> "validate parameters in the action function".
> (And I really interpret your sentence in such a way that you only want
> to move the _validation_, not the actual parsing (which is done inside
> CGI->param at the moment.)

Validation and accessing. Parsing via CGI->param.

There is another reason I want to move accessing and validation of
parameters to the "action" function (perhaps, as you suggested, via
"wrapper" function), namely removing some global variables. Perhaps it is
unnecessary, but I wonder how well that works with mod_perl. Other global
variables are configuration and do not change form execution to execution
of script...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
