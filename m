From: John Keeping <john@keeping.me.uk>
Subject: Timezone with DATE_STRFTIME
Date: Mon, 8 Feb 2016 14:33:17 +0000
Message-ID: <20160208143317.GN29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 15:41:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSn09-0001wC-SG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 15:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbcBHOlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 09:41:14 -0500
Received: from mta1-jackal.aluminati.org ([72.9.247.211]:38152 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751328AbcBHOlN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 09:41:13 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2016 09:41:13 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A05CDCDA5D3;
	Mon,  8 Feb 2016 14:33:26 +0000 (GMT)
X-Quarantine-ID: <EttbS9LdG7b6>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EttbS9LdG7b6; Mon,  8 Feb 2016 14:33:26 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 971F7CDA5A8;
	Mon,  8 Feb 2016 14:33:19 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285770>

I have just noticed that with DATE_STRFTIME, the timezone in the output
is likely to be incorrect.

For all other time formats, we print the string ourselves and use the
correct timezone from the input, but with DATE_STRFTIME strftime(3) will
always use the system timezone.
