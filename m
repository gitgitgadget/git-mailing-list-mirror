From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 12:36:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121232120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 12 12:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZU1-0006WI-Cj
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 12:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbXBLLg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 06:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbXBLLg2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 06:36:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:42616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964867AbXBLLg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 06:36:28 -0500
Received: (qmail invoked by alias); 12 Feb 2007 11:36:26 -0000
X-Provags-ID: V01U2FsdGVkX19GeOd04S1GqAPVfH1XmXTByFYrzISfMT4fehNrIN
	cLsw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070212042425.GB18010@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39394>

Hi,

On Sun, 11 Feb 2007, Theodore Tso wrote:

> My proposal does require adding a file type to each file, as tracked
> metadata, which may doom it from the start.

I'd rather do that a la .gitignore, i.e. make this handling dependent on 
file name patterns. It is not only backwards compatible (from the 
viewpoint of the repository format), it also avoids having to specify over 
and over again that yes, this new .odt file _is_ an OpenOffice document.

> Then for each file type, we implement a set of interfaces (perhaps as
> simple as a series of executables named git-<type>-<operation>) which
> if present, transforms the file from its live format to the canonical
> format which is actually checked in and back again.

Again, I propose a slight change: Let's add a transformation driver like 
the merge driver: this allows inlining common operations like unzipping, 
CRLF->LF conversion, etc.

Ciao,
Dscho
