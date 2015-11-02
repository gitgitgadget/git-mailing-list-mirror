From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v2] http.c: use CURLOPT_RANGE for range requests
Date: Mon, 2 Nov 2015 08:05:05 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511020804220.24283@tvnag.unkk.fr>
References: <1446245682-18087-1-git-send-email-dturner@twopensource.com> <20151031000837.GA25849@sigill.intra.peff.net> <alpine.DEB.2.11.1511012359150.24283@tvnag.unkk.fr> <20151102015157.GA25597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 02 08:05:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt9BV-0003vu-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 08:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbbKBHF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 02:05:28 -0500
Received: from giant.haxx.se ([80.67.6.50]:40891 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbbKBHF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 02:05:27 -0500
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-7) with ESMTP id tA27566p009421
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Nov 2015 08:05:06 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id tA2755YK009410;
	Mon, 2 Nov 2015 08:05:06 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20151102015157.GA25597@sigill.intra.peff.net>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280684>

On Sun, 1 Nov 2015, Jeff King wrote:

> While I have your attention, Daniel, am I correct in assuming that 
> performing a second unrelated request with the same CURL object will need an 
> explicit:
>
>  curl_easy_setopt(curl, CURLOPT_RANGE, NULL);
>
> to avoid using the range twice?

Correct. As the options stick until modified.

-- 

  / daniel.haxx.se
