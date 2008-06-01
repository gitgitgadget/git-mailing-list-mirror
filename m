From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH] gitweb: Add charset info to "raw" blob output
Date: Sun, 1 Jun 2008 14:16:56 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806011415270.4055@fbirervta.pbzchgretzou.qr>
References: <m3tzgg1a06.fsf@localhost.localdomain> <20080531112513.30913.44393.stgit@localhost.localdomain> <7vprr2fi5z.fsf@gitster.siamese.dyndns.org> <200806011306.45945.jnareb@gmail.com> <alpine.LNX.1.10.0806011413110.4055@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 14:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2mVV-0001GL-Cx
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 14:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbYFAMQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 08:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYFAMQ7
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 08:16:59 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:51383 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbYFAMQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 08:16:58 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id D382B18DD22EF; Sun,  1 Jun 2008 14:16:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 867581D1DEE08;
	Sun,  1 Jun 2008 14:16:56 +0200 (CEST)
In-Reply-To: <alpine.LNX.1.10.0806011413110.4055@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83447>


On Sunday 2008-06-01 14:15, Jan Engelhardt wrote:
>On Sunday 2008-06-01 13:06, Jakub Narebski wrote:
>>> +	# Type specific postprocessing can be added as needed...
>>> +	if ($mime =~ /^text\//i &&
>>> +	    $mime !~ /charset=/i && $default_text_plain_charset) {
>>> +		$mime .=  '; charset='.$default_text_plain_charset;
>>> +	}
>>> +
>>> +	return $mime;
>>
>>I'm not sure about it.  I worry a bit about text/html, which can, and
>>usually do, contain charset info inside the document.  I'm not sure
>>what happens when charset information from HTTP headers contradict
>>charset information from presented file.
>
>The HTTP header takes -- as stupid as it looks -- precedence
>over the HTML header. As such, a charset in the HTTP Response Header
>should ONLY be sent if the file is guaranteed to be text/plain only.

Minor correction; s/file/output/. gitweb normaly produces HTML for
all its normal views, so no Charset header here; but when it
outputs "raw", it should provide one.
