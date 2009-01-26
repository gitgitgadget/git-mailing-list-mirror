From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Mon, 26 Jan 2009 09:02:57 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0901260901320.32450@yvahk2.pbagnpgbe.fr>
References: <be6fef0d0901242208p635264e5jc1f95d784cd51450@mail.gmail.com>  <7vpribdszr.fsf@gitster.siamese.dyndns.org> <be6fef0d0901251752p5b34c053pb24dce8a35b06fce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 09:22:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRMk5-0003Wm-3c
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 09:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbZAZIV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 03:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbZAZIV0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 03:21:26 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:41837 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZAZIVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 03:21:25 -0500
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jan 2009 03:21:25 EST
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n0Q86qJ2014395;
	Mon, 26 Jan 2009 09:06:52 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <be6fef0d0901251752p5b34c053pb24dce8a35b06fce@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107175>

On Mon, 26 Jan 2009, Ray Chuan wrote:

>>> -     curl_easy_setopt(slot->curl, CURLOPT_URL, url);
>>> +     curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
>>
>> The original code gave a separate "url" to setop() but this gives the same
>> string.  Does curl_easy_setop() copies the given string away?  IOW is this
>> change safe?
>
> curl strdup's it, so this is safe.

I'm not sure what the oldest possibly libcurl version git can deal with, but 
here's a related quote from the curl_easy_setopt man page:

        NOTE: before 7.17.0 strings were  not  copied.  Instead  the  user  was
        forced keep them available until libcurl no longer needed them.

-- 

  / daniel.haxx.se
