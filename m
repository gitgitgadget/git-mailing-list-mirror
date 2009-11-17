From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Tue, 17 Nov 2009 22:20:39 +0100
Message-ID: <m2lji43l20.fsf@igel.home>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
	<20091117073426.GB4007@coredump.intra.peff.net>
	<20091117074930.GB11636@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 22:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAVTm-0002Ul-5B
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 22:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbZKQVUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 16:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbZKQVUi
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 16:20:38 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:36639 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbZKQVUh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 16:20:37 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 107451C152CA;
	Tue, 17 Nov 2009 22:20:41 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id E5D0F90254;
	Tue, 17 Nov 2009 22:20:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id UUKb9U1KKQTC; Tue, 17 Nov 2009 22:20:39 +0100 (CET)
Received: from igel.home (DSL01.83.171.175.126.ip-pool.NEFkom.net [83.171.175.126])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 17 Nov 2009 22:20:39 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 69DAACA28F; Tue, 17 Nov 2009 22:20:39 +0100 (CET)
X-Yow: Send your questions to ``ASK ZIPPY'', Box 40474,
 San Francisco, CA 94140, USA
In-Reply-To: <20091117074930.GB11636@glandium.org> (Mike Hommey's message of
	"Tue, 17 Nov 2009 08:49:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133102>

Mike Hommey <mh@glandium.org> writes:

> On Tue, Nov 17, 2009 at 02:34:26AM -0500, Jeff King wrote:
>> Maybe:
>> 
>>   A leading path component of "~user" is expanded to the home directory
>>   of "user"; "~" is expanded to the home directory of the user running
>>   git.
>> 
>> would be more clear?
>
> Add "real" before "user running git" and you have my vote. Or maybe
> using the effective user would be better, and the patch should use
> geteuid() instead of getuid(), I don't know. ident.c uses getuid(), but
> I'm wondering if that's what it should use (although it doesn't seem to
> have been a problem to anyone)

"~" should just expand to the value of $HOME, like in the shell,
independent of the real home directory of the real or effective user.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
