From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: OS X and umlauts in file names
Date: Fri, 27 Nov 2009 19:35:50 +0100
Message-ID: <4B101C06.1030300@syntevo.com>
References: <4B0ABA42.1060103@syntevo.com>	 <alpine.LNX.2.00.0911231403100.14365@iabervon.org>	 <4B0CEFCA.5020605@syntevo.com>	 <76718490911260927h9ff796bgbebcccab7e52ffbe@mail.gmail.com>	 <4B0FA388.4030507@syntevo.com> <4B0FA7D7.1050302@syntevo.com> <46a038f90911270256w57487e6cq9bda8b98a5384799@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5ef-0000OA-GD
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZK0Sel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 13:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZK0Sel
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:34:41 -0500
Received: from syntevo.com ([85.214.39.145]:57661 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbZK0Sek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:34:40 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 5317437C739
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <46a038f90911270256w57487e6cq9bda8b98a5384799@mail.gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133922>

Martin Langhoff wrote:
> have you tried calling git-update-index --add
> --stdin -z? Your original email stated

No, we don't do such a massive change immediately before a release.

>> we've got a problem report regarding our SmartGit GUI client
> 
> so it sounds like you are building a porcelain. In that case, the
> sanest approach is to invoke git-update-index and write to its stdin.

We will try this out after release.

For those who are interested: I've got it working on OS X and Git was not
the problem, but Java. A longer time ago directory.list() or
directory.listFiles() returned the file names with decomposed characters (as
they are stored on OS X hard disk). Now (don't know which Java update
introduced this change) these methods return file names with composed
characters, so I had to decompose them before handing them to the git
executable call.

Nevertheless, the cross-platform-problem remains: if you add files with
umlauts in their names on non-OS X, you will not be able to use them on OS X.

-- 
Tom
