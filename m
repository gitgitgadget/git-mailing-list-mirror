From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Tue, 28 Feb 2012 11:27:41 -0800
Message-ID: <4F4D2AAD.3040107@vilain.net>
References: <4F4CCE8A.4010800@seap.minhap.es> <20120228191514.GD11260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	sam.vilain@catalyst.net.nz
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:27:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SiE-0004m6-Op
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191Ab2B1T1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:27:46 -0500
Received: from uk.vilain.net ([92.48.122.123]:57385 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965989Ab2B1T1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:27:45 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 62FB18278; Tue, 28 Feb 2012 19:27:44 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 6D9FA820C;
	Tue, 28 Feb 2012 19:27:42 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120228191514.GD11260@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191771>

On 2/28/12 11:15 AM, Jeff King wrote:
> Usually we would prefer environment variables to config. So that:
>
>    $ git config http.proxy foo
>    $ HTTP_PROXY=bar git fetch
>
> would use "bar" as the proxy, not "foo". But your code above would
> prefer "foo", right?

Apparently I'm the author of the http.proxy feature, though I barely 
remember what problem I was actually solving at the time.  At the time I 
justified it on the grounds that a user might want to use a different 
proxy for git and/or a particular remote.  The "http_proxy" environment 
variable is likely to be a global system default, or perhaps a desktop 
setting, and therefore I'd say probably less and not more specific than 
a git configuration variable.

As to this matter of "HTTP_PROXY", I'm not sure about whether that helps 
or confuses matters to support.  I must admit I'm still confused by the 
motivation of this patch series.

Sam
