From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: http: a non-curl_multi interface?
Date: Mon, 2 Mar 2009 14:26:47 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0903021412120.15587@yvahk2.pbagnpgbe.fr>
References: <be6fef0d0903020514h28995ec2v2acd9f65131c1515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 14:31:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le8Ew-0006de-5R
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 14:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbZCBN35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 08:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbZCBN35
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 08:29:57 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:35966 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbZCBN35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 08:29:57 -0500
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n22DTmN0011971;
	Mon, 2 Mar 2009 14:29:48 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <be6fef0d0903020514h28995ec2v2acd9f65131c1515@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111939>

On Mon, 2 Mar 2009, Tay Ray Chuan wrote:

I'm replying on this topic as a libcurl guy, I don't know much of git 
internals.

> Do you guys think this would bring any benefits, apart from requiring
> the user to use a curl library with the multi interface?

You mean NOT requiring then I guess.

What I don't quite grasp (and I must admit I have not followed the critique on 
this matter) is why using the multi interface of libcurl is a problem to 
anyone as all libcurl versions in modern times features it. And if you have a 
libcurl with it working badly, you have a too old libcurl anyway and should 
rather upgrade...

> Based on what I read in the docs, this would mean less open/closed 
> connections,

I don't see how that is true. In fact, properly used I would claim that an 
application using the multi interface would in general use less connections 
and do more connection re-use than otherwise. But of course it depends on a 
lot of factors.

Again, this requires a reasonably recent libcurl (since 7.16.0 - october 2006 
- libcurl keeps the "connection cache" in the multi handle instead of in each 
individual easy handle.)

> minimized credential prompting (if authentication is required), more 
> backward compatibility, but it would also mean a possible performance 
> degradation in git, since all http requests are sequential.

I figure you can test that fairly easy now when you have a patch pending for 
this change and the existing code base is using the multi interface 
approach...

-- 

  / daniel.haxx.se
