From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Wed, 19 Dec 2007 19:44:57 +0100
Message-ID: <20071219184457.GC3015@steel.home>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 19:45:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J53vA-0005uS-5h
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 19:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbXLSSpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 13:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbXLSSpA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 13:45:00 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:26062 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbXLSSpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 13:45:00 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a72E=
Received: from tigra.home (Fc89a.f.strato-dslnet.de [195.4.200.154])
	by post.webmailer.de (fruni mo42) (RZmta 14.6)
	with ESMTP id J036dcjBJGkJv7 ; Wed, 19 Dec 2007 19:44:57 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BFDC8277AE;
	Wed, 19 Dec 2007 19:44:57 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 9D4A356D22; Wed, 19 Dec 2007 19:44:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68929>

Jonathan del Strother, Wed, Dec 19, 2007 15:32:20 +0100:
> I'm struggling to come up with a minimal test case that confirms this,
> but I seem to be hitting a bug in the pretty string formatter when
> trying to print bodies of commits that don't have bodies.

I tried

    $ git init
    $ git rev-list --pretty=format:"%s%n%b" \
	$(echo -n "Test" |git commit-tree $(git write-tree))

but it works. It is possible that the commit in question is created
with an older commit-tree code. Could you try

    git cat-file 18d2480ab689b483ef1ebbdb3f7420904049ba0b

(or any other problematic commit) and post its output here?
Or is the repo publised somewhere?
