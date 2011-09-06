From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [RFC/PATCH git] http: avoid empty error messages for some curl
 errors
Date: Tue, 6 Sep 2011 14:20:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1109061023010.3841@tvnag.unkk.fr>
References: <20110905222202.GA32071@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 14:27:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0uk1-0001d1-4v
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 14:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413Ab1IFM04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 08:26:56 -0400
Received: from giant.haxx.se ([80.67.6.50]:37859 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372Ab1IFM0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 08:26:55 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Sep 2011 08:26:54 EDT
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p86CK15d003824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Sep 2011 14:20:01 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id p86CK07V003820;
	Tue, 6 Sep 2011 14:20:00 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20110905222202.GA32071@elie>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.8 (giant.haxx.se [127.0.0.1]); Tue, 06 Sep 2011 14:20:01 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180797>

On Mon, 5 Sep 2011, Jonathan Nieder wrote:

> +			if (!curl_errorstr[0])
> +				strlcpy(curl_errorstr,
> +					curl_easy_strerror(results.curl_result),
> +					sizeof(curl_errorstr));

(as libcurl hacker)

For the record, in libcurl we work on providing "extra" information in the 
error buffer when there is additional info to provide that would help. In some 
cases we deem there isn't (or we just to provide any) and then the generic 
error message is good enough and could indeed be used like this...

-- 

  / daniel.haxx.se
