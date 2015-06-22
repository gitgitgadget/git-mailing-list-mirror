From: Charles Bailey <charles@hashpling.org>
Subject: Re: [Question] Is it normal for accented characters to be shown as
 decomposed Unicode on GNU/Linux?
Date: Mon, 22 Jun 2015 16:04:28 +0100
Message-ID: <20150622150428.GA14100@hashpling.org>
References: <55880AF4.4000206@traverse.email>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bastien Traverse <bastien@traverse.email>
X-From: git-owner@vger.kernel.org Mon Jun 22 17:04:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73H3-0003dV-At
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbbFVPEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 11:04:33 -0400
Received: from avasout05.plus.net ([84.93.230.250]:40148 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbFVPEb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:04:31 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id jT4U1q0032iA9hg01T4V5e; Mon, 22 Jun 2015 16:04:30 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=FZvKv8K6 c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=8nJEP1OIZ-IA:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=pGLkceISAAAA:8 a=WD2LWnyPD4gZlWdZajwA:9
 a=wPNLvfGTeEIA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z73Gu-0003gT-9M; Mon, 22 Jun 2015 16:04:28 +0100
Content-Disposition: inline
In-Reply-To: <55880AF4.4000206@traverse.email>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272368>

On Mon, Jun 22, 2015 at 03:17:40PM +0200, Bastien Traverse wrote:
> test case:
> $ mkdir accent-test && cd !$
> $ git init
> $ touch r=EAve r=E9union
> $ git status
> On branch master
>=20
> Initial commit
>=20
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>=20
> 	"r\303\251union"
> 	"r\303\252ve"

Note that these aren't "decomposed" (in the unicode decomposition
sense) but are merely octal escaped representations of the utf-8
encoded file names.

My understanding that this is normal and probably dates back (at least
for status as far as:

	commit a734d0b10bd0f5554abb3acdf11426040cfc4df0
	Author: Dmitry Potapov <dpotapov@gmail.com>
	Date:   Fri Mar 7 05:30:58 2008 +0300

	Make private quote_path() in wt-status.c available as
quote_path_relative()

	[...]

The behaviour can be changed by setting the git config variable
"core.quotePath" to false.
