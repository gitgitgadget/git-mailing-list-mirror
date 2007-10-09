From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Merge problems with git-mingw
Date: Tue, 9 Oct 2007 11:09:35 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710091108480.5039@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se> 
 <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com> 
 <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se> 
 <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com> 
 <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se>
 <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com>
 <Pine.LNX.4.64.0710090800220.26773@ds9.cixit.se> <470B2F7E.4080308@viscovery.net>
 <Pine.LNX.4.64.0710090953240.26773@ds9.cixit.se> <470B43D2.6090307@viscovery.net>
 <BA71DD45-9226-4661-9C92-60EEEA8638D0@zib.de>
 <470BB44B.3030500@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 20:11:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfJY1-0004ix-DF
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 20:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbXJISJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 14:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbXJISJ6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 14:09:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54994 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756781AbXJISJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2007 14:09:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l99I9acx029030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Oct 2007 11:09:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l99I9akH030834;
	Tue, 9 Oct 2007 11:09:36 -0700
In-Reply-To: <470BB44B.3030500@viscovery.net>
X-Spam-Status: No, hits=-2.734 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60425>



On Tue, 9 Oct 2007, Johannes Sixt wrote:
>
> +		extern const char *quote_arg(const char *arg);
> +		argv[0] = quote_arg(git_command);

Extern declarations inside a local scope will not work on more modern gcc 
versions. Don't do it. Do proper prototyping in proper scope.

		Linus
