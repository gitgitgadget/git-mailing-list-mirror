From: Holger Freyther <zecke@selfish.org>
Subject: Re: Unable to clone via git protocol / early EOF / index-pack failed
Date: Sat, 26 Mar 2011 19:50:41 +0100
Message-ID: <4D8E3581.6020003@selfish.org>
References: <20110324102703.GH4534@prithivi.gnumonks.org>	<loom.20110326T180713-801@post.gmane.org>	<loom.20110326T183100-349@post.gmane.org> <vpq8vw1epc1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Mar 26 19:57:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3YfX-0003t3-GV
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab1CZS46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 14:56:58 -0400
Received: from gandharva.secretlabs.de ([78.46.147.237]:62710 "EHLO
	gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab1CZS46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:56:58 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Mar 2011 14:56:58 EDT
Received: from [192.168.0.101] (91-64-83-241-dynip.superkabel.de [91.64.83.241])
	by gandharva.secretlabs.de (Postfix) with ESMTPA id 59C701B10C05;
	Sat, 26 Mar 2011 19:04:35 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <vpq8vw1epc1.fsf@bauges.imag.fr>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170070>

On 03/26/2011 06:58 PM, Matthieu Moy wrote:

> 
> That reminds me an issue I had with git over SSH. The problem was indeed
> not Git-related:
> 
>   http://readlist.com/lists/securityfocus.com/secureshell/0/3071.html
> 
> In short, when sending 196481 bytes or more, _and_ if the server did not
> consume the data fast enough, then the connection was closed after
> 65536=2^16 bytes.
> 
> That was on RHEL, and upgrading the kernel solved the issue. Scary...
> 

Yes, scary. I assume that fflush(stdout) has no real meaning for sockets
either? So the next best thing would be to use ioctl and SIOCOUTQ on the
socket? Any other ideas?
