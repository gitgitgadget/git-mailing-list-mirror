From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Set file modification time on checkout
Date: Thu, 13 Nov 2014 06:04:15 +0100
Message-ID: <54643BCF.5000900@web.de>
References: <54643780.7060504@stormcloud9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Patrick Hemmer <git@stormcloud9.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 06:04:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XomaK-0007aJ-Km
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 06:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbaKMFEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 00:04:40 -0500
Received: from mout.web.de ([212.227.15.14]:65114 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaKMFEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 00:04:39 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LoYJu-1YVEsh0zuM-00gZu1; Thu, 13 Nov 2014 06:04:37
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54643780.7060504@stormcloud9.net>
X-Provags-ID: V03:K0:LlM9WGE9p+v6RtjwSQ799xXK5Dsf+uHbzmiF/QdpXeWXkIS5QDZ
 1hqoDaV0JWKYdo9DwEBmTtHylwy4k8FktWAoy8QeN/2xCvf0H2u3Pq0h7/lDy0zEllT6eJO
 Rb1fr4J758GxoDo6CCb+/JROfxB5Og98xziPGNkl30TE0Smv3+/BbK4TYjSta9xKF8Q1vHA
 fx5ToEFEFW+QWChNHLGNA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-13 05.45, Patrick Hemmer wrote:
> The request is to allow git to set the file modification time on
> checkout to the commit-author-date of the commit which last modified the
> file.
> Yes I know this is in the FAQ, but the FAQ entry is missing an
> increasingly common use case: docker.
> When docker builds an image, it generates layers of images based on each
> build step. Adding a file would be a build step, and for this action it
> generates a hash based on the file modification time & content.
Why do they do this?
The file content is the only thing that matters.

The other thing is to use a hook, utilizing test-chmtime
from test-chmtime.c
