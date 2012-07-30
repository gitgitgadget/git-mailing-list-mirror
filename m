From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: inconsistent logs when displayed on screen / piped to a file
Date: Mon, 30 Jul 2012 15:39:31 +0200
Message-ID: <50168E93.2090202@drmicha.warpmail.net>
References: <CALBOmsYh5AgpRQe28yUcChqemQ7HFMHahesGj_MPwQXDF-EM=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mojca Miklavec <mojca.miklavec.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 15:39:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvqCM-0002Gk-P0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 15:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab2G3Njo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 09:39:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35460 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753931Ab2G3Njd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 09:39:33 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B95C620A34;
	Mon, 30 Jul 2012 09:39:32 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 30 Jul 2012 09:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Cs2Y4Q0/iYBBeTh0BLdtNz
	YYSTA=; b=EqWit0Plg8/yJBipIiPCtkGmjI4pa7MdgAGVxCQ3Wx0zI7uZQlHhbo
	OUgCR5APMzjKlwttBlivkfEMCHW2oLobb/hByFBte4qRdMYg9QHDiLxqNPFNxJep
	5s8gdCx//howyieU8bnZRzn8DVmAED1tUWcmddHrMu/3KC+nL44hQ=
X-Sasl-enc: Ii0q7celBcLyizFUWC5XPU2dMx0leVHqDwmqlpenqdu+ 1343655572
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4018D4837F6;
	Mon, 30 Jul 2012 09:39:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <CALBOmsYh5AgpRQe28yUcChqemQ7HFMHahesGj_MPwQXDF-EM=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202542>

Mojca Miklavec venit, vidit, dixit 30.07.2012 14:25:
> Hello,
> 
> I'm trying to use "git log" to generate ChangeLog for a project
> recently migrated from CVS.
> 
> The problem is that
>     git log --summary --stat --no-merges --date=short --decorate=short
> behaves differently when the result is displayed on screen and when it
> is piped to a file.
> 
> For example, running the commands:
>     a) git log --summary --stat --no-merges --date=short
> --decorate=short e9f65aa976
>     b) git log --summary --stat --no-merges --date=short
> --decorate=short e9f65aa976 > /tmp/log.txt
> would result in two different outputs:
> 
> a)
> 
>  aquaterm/Docs/gptProtocol.rtf                         |  316
> ++++++++++++++++++++++++++
>  aquaterm/English.lproj/GPTInfoWindow.nib/classes.nib  |   12 +
>  aquaterm/English.lproj/GPTInfoWindow.nib/info.nib     |   12 +
>  aquaterm/English.lproj/GPTInfoWindow.nib/objects.nib  |  Bin 0 -> 1010 bytes
>  aquaterm/English.lproj/GPTInfoWindow~.nib/classes.nib |    4 +
>  aquaterm/English.lproj/GPTInfoWindow~.nib/info.nib    |   12 +
>  aquaterm/English.lproj/GPTInfoWindow~.nib/objects.nib |  Bin 0 -> 1232 bytes
>  aquaterm/English.lproj/GPTWindow.nib/classes.nib      |   13 ++
>  aquaterm/English.lproj/GPTWindow.nib/info.nib         |   12 +
> 
> b)
> 
>  aquaterm/Docs/gptProtocol.rtf                      |  316 ++++++
>  .../English.lproj/GPTInfoWindow.nib/classes.nib    |   12 +
>  aquaterm/English.lproj/GPTInfoWindow.nib/info.nib  |   12 +
>  .../English.lproj/GPTInfoWindow.nib/objects.nib    |  Bin 0 -> 1010 bytes
>  .../English.lproj/GPTInfoWindow~.nib/classes.nib   |    4 +
>  aquaterm/English.lproj/GPTInfoWindow~.nib/info.nib |   12 +
>  .../English.lproj/GPTInfoWindow~.nib/objects.nib   |  Bin 0 -> 1232 bytes
>  aquaterm/English.lproj/GPTWindow.nib/classes.nib   |   13 +
>  aquaterm/English.lproj/GPTWindow.nib/info.nib      |   12 +
> 
> 
> The project where the results could be easily reproduced is the following:
>     https://github.com/AquaTerm/AquaTerm
>     git://github.com/AquaTerm/AquaTerm.git
> 
> It is possible that I screwed up something when importing the project
> from CVS. In that case I would be happy if someone could point me out
> what exactly I did wrong, and I can still rewrite the history before
> the first release of the project using git.
> 
> But in any case I find it weird that I get two different outputs.
> 
> I would be grateful for any clues or hints about what goes wrong.
> 
> Mojca
> 

The only difference that I see is the formatting. ("..." is merely an
abbreviation for a leading path.)

a) probes your terminal for the number of columns and uses all available
space.

b) goes to a file and has no connected terminal, thus uses a default
column number. You can change that number using

COLUMNS=YourNumber git log YourArgs > YourFile

Michael
