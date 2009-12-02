From: Shawn Pearce <spearce@spearce.org>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Wed, 2 Dec 2009 08:22:58 -0800
Message-ID: <ec874dac0912020822t58477e12y3e6d1ab37da4f7e5@mail.gmail.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com> 
	<4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com> 
	<4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com> 
	<4B14E934.9090304@viscovery.net> <4B150747.2030900@syntevo.com> 
	<m3k4x6na81.fsf@localhost.localdomain> <4B15668A.5050209@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 17:23:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFrzB-0000OM-Rz
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 17:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbZLBQXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 11:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbZLBQXO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 11:23:14 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:36480 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbZLBQXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 11:23:13 -0500
Received: by ewy19 with SMTP id 19so411942ewy.21
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 08:23:19 -0800 (PST)
Received: by 10.216.89.11 with SMTP id b11mr93566wef.171.1259770998672; Wed, 
	02 Dec 2009 08:23:18 -0800 (PST)
X-Originating-IP: [172.18.104.34]
In-Reply-To: <4B15668A.5050209@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134345>

On Tue, Dec 1, 2009 at 10:55 AM, Thomas Singer
<thomas.singer@syntevo.com> wrote:
>
> Jakub Narebski wrote:
> > If you use Git from Java, why don't you just use JGit (www.jgit.org),
> > which is Git implementation in Java?
>
> We are using JGit for the read-only stuff and the Git command line
> executable for all writing commands. We very much appreciate Shawn O.
> Pearce' (and the other JGit developers') effort, but Git is a fast moving
> target and (much) more complex than CVS or SVN, for which we use Java
> libraries communicating with the corresponding server which adds another
> sanity layer to the repository making repository corruption less likely than
> direct access.

Uhm.  I'm sorry, but this is just plain FUD.

JGit implements the current on disk formats and network protocols
completely[1].  In the area of disk formats and network protocols, Git
*IS NOT* a fast moving target.  This area of Git hasn't changed much
since pack files were first introduced.  As a community, we have been
very careful to avoid changes which break compatibility with older
implementations.

Git is also a lot less complex than CVS or SVN.  Its data model is
simpler on disk.  Its network protocol is *vastly* more simple than
SVN's WebDAV protocol.  And unlike SVN we haven't had to break the
network protocol on every 1.x release we make.


[1]  Actually, JGit lacks --depth support for shallow clones, but
otherwise is complete.
