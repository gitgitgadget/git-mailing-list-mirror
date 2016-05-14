From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 29/33] refs: resolve symbolic refs first
Date: Sat, 14 May 2016 11:02:04 +0200
Message-ID: <44e99d76-a01f-b97c-65a7-d9b1b5e83eb4@web.de>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
 <66d33af21bd1e398973414435af43d06f2e2099c.1462550456.git.mhagger@alum.mit.edu>
 <20160512074528.GB10922@sigill.intra.peff.net>
 <20160512082526.GA20817@sigill.intra.peff.net>
 <5735C990.8080502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 14 11:03:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1VUE-0002bJ-Ts
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 11:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbcENJCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 05:02:36 -0400
Received: from mout.web.de ([212.227.15.14]:59303 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbcENJCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 05:02:34 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0Lo4Lo-1bYNIm0LPs-00fwXW; Sat, 14 May 2016 11:02:08
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <5735C990.8080502@alum.mit.edu>
X-Provags-ID: V03:K0:xP2X8TD58Qta5r4n9ERUuh3iQQbc7nX0JQhfHlI09g5JjOKoJTm
 /y04jNbJcv/3Ls3gUZlXQXS4q/h3nMaZ5HRMoyr9hRJFVgMZiktlXMAXGMRK9+9PfWEOet4
 e49f38sx14DSQLzm3EXm/XAKFHo1VS/Qyn2yc2RAyHatbTe2MVBVgDbs6Y4V4XxlemO5mTE
 wfhEdVbulKfszpYlThINA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OXWGc/6Ny1U=:9dFlTeUu3AVDhf9RJ00Hzu
 Us/SQGuQYYZDLSWihkKVwcMinc3eLr4eEuBL99bWtzpbXWs8vXPs3iFX6PqSvDWGgxnPTYQWd
 LvTdOJZSx5HBB65mjdaQ4f7ZFhJCdcKe3DNobsxMVSGqyo/nrCo+MnRbVChC08w5eqo+tZnPS
 UWYUUqdpNlz6Qbf1PtLBIc8d5eSpyZzugSk+Bi2ZZ0VMDY5ft+1rzcjsXBYk0Tu3h8uglMPEx
 P+YLp5IJ44ZIsuWS7CCoEd4omIKdZh6ba31p2sM+X+5/xCTjSoB65sQ+olNd5LTeiglEYvg8d
 y6ZNv4YI7splJdBg+s/ZtXfQnL5pyCK4iOnCY5/X2LIVWceuY12o0+WWTBO+PXtueKOPldqE+
 Y1K5GU+kRt5KwYhspwKLorlLZfey6GxCsokkMp0lQmGCWCRe0D/SOwM6IommU+4AXvqm1YCqy
 uHOp9UdzWKjh/vhPUfabhIAVlqzP9pU40n1CGLiptigJiTYm/myiDdruaMgND3/83EDxBVy11
 wtwWFKM/mvZMNI/mOwjO6yP8LxtxDlK3GJ1Ws/te0exlwWoLn18radKiluG9++VMTHBXxtnNe
 qDLBGvb/QalIlESZ6nTfj+0XqOW5o2/MM9NXxguHdapUxonwjhPf25DUVLXx88vIwCbX0EH0Q
 ROJ1ewJf//CM5GInxJAQlwRcJYfOCtNk7r303EfoXoloR7CUikr9P2jqjJkWerffqf0wSgOpT
 rp43/xsowl3JZC5HcqgksVkLRQHAPQzwmZ3/PSNVNFk25kRu5UWoMjilY/UJDRHa6k3IXReh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294605>

On 13.05.16 14:33, Michael Haggerty wrote:
> Torsten, thanks for the report. Peff, thanks for the analysis.
I didn't follow all the details.
The new "pu" passes with no errors on all of my test systems :-)
 
 
