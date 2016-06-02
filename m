From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 01:38:37 +0100
Message-ID: <574F800D.6070107@ramsayjones.plus.com>
References: <20160601235233.21040-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 02 02:38:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Get-0008Nc-A1
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 02:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbcFBAin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 20:38:43 -0400
Received: from avasout04.plus.net ([212.159.14.19]:60532 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbcFBAim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 20:38:42 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 1cee1t0055VX2mk01cefqW; Thu, 02 Jun 2016 01:38:40 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=7bryU3Y1h2JDRQmfXrYA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160601235233.21040-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296181>



On 02/06/16 00:52, Stefan Beller wrote:
> In our own .gitattributes file we have attributes such as:
> 
>     *.[ch] whitespace=indent,trail,space
> 
> When querying for attributes we want to be able to ask for the exact
> value, i.e.
> 
>     git ls-files :(attr:whitespace=indent,trail,space)
> 
> should work, but the commas are used in the attr magic to introduce
> the next attr, such that this query currently fails with
> 
> fatal: Invalid pathspec magic 'trail' in ':(attr:whitespace=indent,trail,space)'
> 
> This change allows escaping characters by a backslash, such that the query
> 
>     git ls-files :(attr:whitespace=indent\,trail\,space)

Not having given this much thought at all, but the question which comes
to mind is: can you use some other separator for the <attr>-s rather than
a comma? That way you don't need to quote them in the <value> part of the
<attr>-spec.

(I dunno, maybe use ; or : instead?)

ATB,
Ramsay Jones
