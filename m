From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: git with https and client cert asks for password repeatedly
Date: Wed, 25 Feb 2009 09:24:23 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0902250920540.28808@yvahk2.pbagnpgbe.fr>
References: <ca433830902241911x10b08a4fg8e790000a5cf9f3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:29:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcF8Z-0006vp-7q
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbZBYI1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103AbZBYI1f
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:27:35 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:34327 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbZBYI1e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:27:34 -0500
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n1P8RWXw023505
	for <git@vger.kernel.org>; Wed, 25 Feb 2009 09:27:32 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <ca433830902241911x10b08a4fg8e790000a5cf9f3b@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111390>

On Tue, 24 Feb 2009, Mark Lodato wrote:

> I think the root problem is that git creates a completely new http(s) 
> connection for every request, rather than using one persistent connection. 
> Using a persistent connection would theoretically speed up the transfers, in 
> addition to fixing the password prompt issue. I'm pretty sure that calling 
> `curl_easy_cleanup()' after every request is causing this behavior; I don't 
> think this is necessary.

This may or may not be true depending on several circumstances. You didn't 
mention what libcurl version nor did you say if you build git to use the multi 
interface. But assuming that you don't use multi or that the libcurl is fairly 
old, your conclusion is correct.

-- 

  / daniel.haxx.se
