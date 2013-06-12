From: Laurent Alebarde <l.alebarde@free.fr>
Subject: Is Git multithreaded ?
Date: Wed, 12 Jun 2013 20:28:52 +0200
Message-ID: <51B8BDE4.7030008@free.fr>
References: <51B8BBC0.6020908@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 20:29:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umpn8-0004ID-9c
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 20:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757947Ab3FLS3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 14:29:01 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:51492 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755957Ab3FLS3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 14:29:00 -0400
Received: from [IPv6:2a01:e35:8b59:cce0::10] (unknown [IPv6:2a01:e35:8b59:cce0::10])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 19AED94019A
	for <git@vger.kernel.org>; Wed, 12 Jun 2013 20:28:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130513 Thunderbird/17.0.5
In-Reply-To: <51B8BBC0.6020908@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227662>

Hi list,

I wonder if Git is multithreaded ? For example, during a commit, does it 
process the files one after one, or does it use a set of threads, say 
10, to process 10 files in parrallel ?

In the Git_Guide (http://wiki.sourcemage.org/Git_Guide.html), I can read 
this :

"T/o enable aut-detection for number of threads to use (good for 
multi-CPU or multi-core computers) for packing repositories, use: /////

////

///$ git config --global pack.threads "0"/  "

But it is not a lot explanatory (to me). In particular, if Git is 
multithreded and can be configured regarding the number of workers, I 
wonder in which operations it uses it ?

A clear view of this may be of interrest for hooks or filters that may 
use a daemon, in order to not have this daemon be a bottle-neck. It 
would make sense to start as many workers in the daemon that there are 
authorized ones in Git.

Cheers,


Laurent.
