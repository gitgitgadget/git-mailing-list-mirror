From: Brian Koehmstedt <bkoehm@gmail.com>
Subject: Re: git-svn: Fetch svn branches only and have git recognize them as branches?
Date: Thu, 12 Mar 2015 23:51:40 +0000 (UTC)
Message-ID: <loom.20150313T004740-11@post.gmane.org>
References: <CAMMCKnc9AKjuwQ_RNxD_g3tn=xFQkbO1i-U=rP2VLWPi7qizGA@mail.gmail.com> <xmqq385924j3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 00:55:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWCwf-0005gu-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 00:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbbCLXzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 19:55:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:50102 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161039AbbCLXzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 19:55:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YWCwS-0005UY-RQ
	for git@vger.kernel.org; Fri, 13 Mar 2015 00:55:05 +0100
Received: from airbears2-136-152-142-50.AirBears2.Berkeley.EDU ([136.152.142.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 00:55:04 +0100
Received: from bkoehm by airbears2-136-152-142-50.AirBears2.Berkeley.EDU with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 00:55:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 136.152.142.50 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265384>

Junio C Hamano <gitster <at> pobox.com> writes:
> 
>      git svn init --minimize-url \
>       --trunk http://repository-root/foo/trunk \
>       --branches http://repository-root/foo/branches \
>       --tags http://repository-root/foo/tags
> 
>     And this is where the new --minimize-url command-line switch
>     comes in to allow for this behavior to continue working.
> 
> The description of the commit makes me think that mimicking the
> sample command line without minimize-url ought to work, i.e.
> 
>     git svn init \
>         --trunk    http://abc.com/repo/trunk \
>         --branches http://abc.com/repo/branches \
>         --tags     http://abc.com/repo/tags
> 

Sounds like what I need.  But both of these are yielding the following error:

"E: 'http:/abc.com/foo/trunk' is not a complete URL  and a separate URL is
not specified"

Notice the one slash after http:.

Here's the exact script I'm running to test:

$ cat sample.sh 
#!/bin/sh

rm -rf .git

git svn init \
      --trunk http://abc.com/foo/trunk \
      --branches http://abc.com/foo/branches \
      --tags http://abc.com/foo/tags
