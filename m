From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 17:24:20 +0100
Organization: Beonex
Message-ID: <499058B4.4070009@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 17:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYxs-0000lq-EN
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 17:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZBIQZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 11:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbZBIQZF
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 11:25:05 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:33755 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbZBIQZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 11:25:04 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id 32A93303C561;
	Mon,  9 Feb 2009 17:25:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <4990519C.8060601@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109091>

On 09.02.2009 16:54, Michael J Gruber wrote:
> I don't remember what else you need to quote within<pre></pre>.
>    

Escaping:

With mailto:, you send HTML (SGML) in a URL.

So, you first have to quote using HTML rules:
<   -> &lt;
 >   -> &gt;
&   -> &amp;
"   -> &quot;

If that's not done, TB/Mozilla may or may not fix it up: e.g. if you 
have html tags in your source code, it would probably go wrong without 
quoting.

After that, given that you put it in a URL, you need to escape it using 
"URL component rules" (same as you escape any URL GET parameter), using 
the %charcode rule, e.g.
(space)  ->   %20
=   ->   %3D
&   ->   %26
#   ->   %23
(Firefox does the URL escaping automatically when putting it in the 
URLbar, and you can also try it in JS using encodeURIComponent(), e.g. 
by opening the Firefox Error Console and writing 
encodeURIComponent("foo=bla&bar=baz bal"); or starting the 
yourfirefoxdir/js runner.)

E.g. "<" in original turns into "mailto:?html-body=<pre>%26lt;<pre>"

Sorry that it's non-trivial (I also hate escaping).
