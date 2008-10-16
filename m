From: "Lars Hoss" <lars@woeye.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 13:53:03 +0200 (CEST)
Message-ID: <c0d0f236cf60a006a7780058835737e2.squirrel@webmail.highteq.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
    <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
    <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
    <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org>
    <3520b7a9009f072cfc3aeb82ae205e6b.squirrel@webmail.highteq.net>
    <48F7280C.3080205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Lars Hoss" <lars@woeye.net>, "Pedro Melo" <melo@simplicidade.org>,
	"Pieter de Bie" <pdebie@ai.rug.nl>, "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 13:51:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqRNq-0004Cl-Ua
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 13:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132AbYJPLuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 07:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbYJPLuB
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 07:50:01 -0400
Received: from mail.codewut.de ([78.47.135.140]:53871 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130AbYJPLt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 07:49:59 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 059817BEF1; Thu, 16 Oct 2008 13:53:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id 072777BE4C;
	Thu, 16 Oct 2008 13:53:03 +0200 (CEST)
Received: from 194.127.8.17
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Thu, 16 Oct 2008 13:53:03 +0200 (CEST)
In-Reply-To: <48F7280C.3080205@viscovery.net>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98370>

>> So something between 1.5.6.5 and 1.6.0-rc0 broke it for me.
>> A quick diff between the two version revealed a lot of changes. Thus
>> tracking down the issue might not be easy for someone who is not
>> involved
>> in the code.
>
> Start with:
>
> $ git bisect start v1.6.0-rc0 v1.5.6.5 v1.6.0~6^2 v1.6.0.2~16^2  # [*]
>
> and test the version that this command gives you. Then say either
>
> $ git bisect good  # if the version works
> $ git bisect bad   # if the version fails
>
> Test again and repeat until the command tells you "First bad revision
> is..." and report back. (Finally, say 'git bisect reset' to get you back
> to where you started.)
>
> [*] The revisions v1.6.0~6^2 v1.6.0.2~16^2 are from gitk and git-gui,
> which we assume are good.
>
> -- Hannes

Wow, thank you Hannes! Will do so.
