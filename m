From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Running git gui on Windows.
Date: Sun, 27 Jul 2008 08:02:44 -0700
Message-ID: <20080727150244.GA7687@spearce.org>
References: <g6hubi$8op$1@ger.gmane.org> <g6huoj$9rh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jurko Gospodnetiii <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Sun Jul 27 17:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN7mk-0008D8-Af
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 17:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbYG0PCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 11:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYG0PCp
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 11:02:45 -0400
Received: from george.spearce.org ([209.20.77.23]:55758 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbYG0PCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 11:02:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9854C383A5; Sun, 27 Jul 2008 15:02:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <g6huoj$9rh$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90340>

Jurko Gospodnetiii <jurko.gospodnetic@docte.hr> wrote:
>>   Is there a way to run git gui on Windows so it does not block the  
>> calling process?

In traditional UNIX shells this is "git gui &", requesting that the
shell background the process, but still monitor it for exit status.
On Windows there is no such easy concept.

>   I now realized my question did not say exactly what I intended it to.  
> I know I can start 'git gui' using:
>
>   start "" /b cmd /c git gui
>
>   from the command prompt and get the desired effect. I was wondering  
> why git gui does not do this in the first place and whether it could be  
> modified so that this is the default behaviour?

git-gui and gitk won't automatically background themselves, as they
are primarily developed on UNIX and have a UNIX like interface to
them, including backgrounding behavior.

We could add a -f flag to git-gui, such that "git gui -f" causes it
to fork+exec a new wish process, completely disconnecting it from the
calling shell.  (-f stolen from OpenSSH's ssh -f host xterm example)
I'd accept a patch for it, but its not high on my list of things to
write and debug myself.

-- 
Shawn.
