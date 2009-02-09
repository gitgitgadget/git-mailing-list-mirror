From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
 as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 15:18:15 +0100
Organization: Beonex
Message-ID: <49903B27.8070608@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 15:21:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWX0x-0005QX-3U
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 15:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbZBIOS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 09:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbZBIOS7
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 09:18:59 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:39977 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbZBIOS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 09:18:58 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id 6F18C303C560;
	Mon,  9 Feb 2009 15:19:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <49903521.1060101@codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109076>

On 09.02.2009 14:52, Jeremy White wrote:
> I discovered that if I just injected charset=iso-2022-jp, format=flowed
> would stay off!<grin>
>    
(This was a hack, caused by the different use of spaces in Japanese / 
CJK, which means a different kind of "flow".)

> Ben, along those lines, we do have the ability to control the entire 
> body of a possible patch before Thunderbird sees it. Would it be 
> possible, or reasonable, for Thunderbird to look for and preserve a 
> 'format=fixed' setting inside a body that we generated?

I don't know how you're injecting the email to Thunderbird. mailto:?

What you propose is a header, not a body.
(I'm a bit irritated that TB would react to a charset header *in the 
body*, but maybe that's a hack specially for charsets, in some code part 
I don't know, given that they are unfortunately sometimes only marked in 
content.)

I think it would most likely work easily if you inject HTML (read before 
you scream):
mailto:fred@example.com?html-body=Here's patch revision abc from repo 
def:<p><pre>Patch: file ....<br>+++ bla<br>line 3<br></pre>
(properly escaped, of course)
It should invoke the normal rich editor, with the patch properly marked 
as preformatted. Once you send it, it would send it as plaintext, 
depending on your prefs. During the formatting, it would see the 
preformat section and should send it out with the lineendings as marked.
I haven't tried the full chain, but it's something to play with.

Ben
