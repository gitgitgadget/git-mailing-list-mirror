From: Charles Bailey <charles@hashpling.org>
Subject: Re: git branch in Bash subshell "$(git branch -a)" including ls
 output as part of return?
Date: Mon, 7 Dec 2015 17:02:59 +0000
Message-ID: <20151207170259.GA25915@hashpling.org>
References: <CAJGk2Wx4B=AHFxkJep=yYVKU9UyJieazoNaC44W5yBXoMi+gdg@mail.gmail.com>
 <20151207165810.GA25856@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Jones <ajones@netsertive.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 18:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5zJG-0007zE-8N
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 18:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbbLGRKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 12:10:41 -0500
Received: from avasout06.plus.net ([212.159.14.18]:58658 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477AbbLGRKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 12:10:41 -0500
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2015 12:10:40 EST
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id qh2z1r0032iA9hg01h309T; Mon, 07 Dec 2015 17:03:02 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=E4sw3vpl c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=Ew9TdX-QAAAA:8 a=kj9zAlcOel0A:10 a=wUQvQvOEmiQA:10
 a=kA8IlAV2mvUhP3FQAPAA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1a5zBj-0006l5-BP; Mon, 07 Dec 2015 17:02:59 +0000
Content-Disposition: inline
In-Reply-To: <20151207165810.GA25856@hashpling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282100>

On Mon, Dec 07, 2015 at 04:58:10PM +0000, Charles Bailey wrote:
> 
> Looking at the two outputs, you are seeing the shell's glob expansion of
> the '*' current branch marker. You probably want to quote the command
> expansion to prevent this:
> 
> echo "$(git branch -a)"

Pressing send has, of course, caused me to think further. You probably
don't want to parse the output of a "porcelain" command such as "git
branch" at all, but instead look at using something like "git
for-each-ref", perhaps with the --format=%(refname) option, grepping out
master and iterating through the rest.
