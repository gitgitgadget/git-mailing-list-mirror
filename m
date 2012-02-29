From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Wed, 29 Feb 2012 11:46:03 +0100
Message-ID: <4F4E01EB.3070707@seap.minhap.es>
References: <4F4CCE8A.4010800@seap.minhap.es><20120228191514.GD11260@sigill.intra.peff.net><4F4D2AAD.3040107@vilain.net> <20120228193443.GB11725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, sam.vilain@catalyst.net.nz
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 10:48:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2g9K-00064q-Su
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 10:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757462Ab2B2Jsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 04:48:37 -0500
Received: from luthien1.map.es ([82.150.0.102]:4401 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757158Ab2B2Jsf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 04:48:35 -0500
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id A0C1A24B44;
	Wed, 29 Feb 2012 10:47:34 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 00AF5D4E00;
	Wed, 29 Feb 2012 10:47:22 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <20120228193443.GB11725@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: A0C1A24B44.B07A1
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331113658.0272@63DMec8+csMOqnjbzq37ZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191830>

On 02/28/2012 08:34 PM, Jeff King wrote:
> On Tue, Feb 28, 2012 at 11:27:41AM -0800, Sam Vilain wrote:
> 
>> On 2/28/12 11:15 AM, Jeff King wrote:
>>> Usually we would prefer environment variables to config. So that:
>>>
>>>   $ git config http.proxy foo
>>>   $ HTTP_PROXY=bar git fetch
>>>
>>> would use "bar" as the proxy, not "foo". But your code above would
>>> prefer "foo", right?
>>
>> Apparently I'm the author of the http.proxy feature, though I barely
>> [snip]
> 
> Good point. We sometimes follow this order:
> 
>   1. git-specific environment variables (i.e., $GIT_HTTP_PROXY, if
>      it existed)
>   2. git config files (i.e., http.proxy)
>   3. generic system environment (i.e., $http_proxy).
> 
> So thinking about it that way, the original patch makes more sense.

So, in PATCH 2/3, apart from expanding the commit message.. do we want
to support HTTP_PROXY or only http_proxy ? HTTP_PROXY seems to not be
very used by existent programs, but support it it's only a gentenv call..
