From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: [PATCH 3/3] Add "%w" to pretty formats, which rewraps the
 commit message
Date: Wed, 23 Sep 2009 23:00:56 +0200
Message-ID: <20090923210055.GA25197@dualtron.vpn.rwth-aachen.de>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org>
 <1253655038-20335-1-git-send-email-heipei@hackvalue.de>
 <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232233330.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232233590.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 23:01:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqYxi-00083Y-AU
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbZIWVBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZIWVBG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:01:06 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:50474 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZIWVBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 17:01:06 -0400
Received: from u-6-181.vpn.rwth-aachen.de ([137.226.102.181]:46458 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1MqYxT-00067g-4N; Wed, 23 Sep 2009 23:01:03 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0909232233590.4985@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.102.181
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128999>

On 23/09/09 22:34, Johannes Schindelin wrote:
> With "--pretty=format:%w(8,6,70)" you will get the commit messages
> reformatted to width 70 where the first line has indent 8 and the
> subsequent lines have indent 6.

Hey Johannes,

you sent me your patches earlier (and I really liked the idea and could 
use it too, especially with svn-mindset people). One thing that bothers 
me about the %w flag is that is includes subject and body, when we 
already have atoms for both of these flags. So having a subject(x,y) and 
body(x,y) tag (where x is indent and y is textwidth to be rewrapped) 
would be nicer and more in the spirit of the existing format options 
imho.

Having said that I also have to acknowledge a clear advantage of your 
patch, which is that one doesn't need to clear trailing newlines when 
the subject is < wrapwidth and the body is empty (and one used 
%s(x,y)%n%n%b(x,y) as a format-tag). With my %B, %B(n) patch which is on 
pu (and which you should probably consider in case it gets into next ;) 
I do this by calling strbuf_rtrim after adding the body.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
