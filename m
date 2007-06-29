From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How do I label conflict blocks in merge-recursive output?
Date: Fri, 29 Jun 2007 18:16:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706291806120.4438@racer.site>
References: <20070629232849.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1423664014-1183137360=:4438"
Cc: GIT <git@vger.kernel.org>
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 19:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4KAR-000205-Iq
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 19:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105AbXF2RV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 13:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbXF2RV4
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 13:21:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:60230 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752469AbXF2RV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 13:21:56 -0400
Received: (qmail invoked by alias); 29 Jun 2007 17:21:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 29 Jun 2007 19:21:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/q4w1duejqdxavKoSAwEO6aPeEQebldXSptjxi46
	ZYMyWPy3si1gRS
X-X-Sender: gene099@racer.site
In-Reply-To: <20070629232849.6117@nanako3.bluebottle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51181>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1423664014-1183137360=:4438
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 29 Jun 2007, しらいしななこ wrote:

> A trouble I am seeing is that there are large hexadecimal string after
> these markers, like this:
> 
>    <<<<<<< 13bd5d46b4a5d4ef44c53fab11e74801c18b16d0:A
>    side
>    revision
>    =======
>    local
>    modification
>    >>>>>>> 9aa4ad6a3bdf5340bed969f6e14abb4e07e794f7:A
> 
> I do not know what object these are, and I do not think it is useful to 
> show them to the user.  I want them to say something more useful.
>
> [...]
>
> How do I tell merge-recursive to do that?  I tried to read the 
> documentation for merge-recursive but there is no manual page.

Yes, it is unfortunately undocumented. To override the name for a given 
SHA-1 (which is the long hex string, and which you can obtain by 
"git-rev-parse <commit>"), set the environment variable

	GITHEAD_<sha1>="This is a much nicer message"

IOW If you would have done this (_before_ calling merge-recursive):

	export GITHEAD_9aa4ad6a3bdf5340bed969f6e14abb4e07e794f7=nanako

then the last conflict marker would have read

	>>>>>>> nanako:A

Hth,
Dscho

--8323584-1423664014-1183137360=:4438--
