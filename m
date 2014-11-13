From: Olaf Hering <olaf@aepfle.de>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 13:21:20 +0100
Message-ID: <20141113122119.GC15503@aepfle.de>
References: <20141113111444.GA15503@aepfle.de>
 <1415880149.4825.43.camel@knuth.computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Roger Gammans <roger@gammascience.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:21:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XotOx-0006n3-2h
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 13:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbaKMMVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 07:21:23 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:25202 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbaKMMVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 07:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1415881280; l=774;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=ULhxW87EietU98CWkKASeDKxCXs=;
	b=q6Wie++0Xoue2Ldcerh1Z/la8iQhgBAxd3WA+kZq7oW+Cfol1Y2nL6xQ+jjn0NIEwZ/
	e/eJZkmdJ6Wb5NsFfD/uEOs4gEfUBSvIUB8TrNCfiOBVQaRzRUiCzwQ8NuCTBdF0LO22g
	Cw/tOQILBXmIH9CSnGhaNqM1Wz8CWwjh0zg=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.11 AUTH)
	with ESMTPSA id Y01991qADCLKkWZ
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Thu, 13 Nov 2014 13:21:20 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 403D250172; Thu, 13 Nov 2014 13:21:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1415880149.4825.43.camel@knuth.computer-surgery.co.uk>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, Roger Gammans wrote:

> Note the first sentence of the second paragraph.
>  eg:
>  # git clone git://host/repo.git repo-master
>  # git clone repo-master repo-branchA
>  # cd repo-branchA
>  # git checkout -b branchA origin/branchA

It fails right here because in this dir only "master" exists, but
branchA is expected.

So far the sequence of commands is:

# git clone git://host/repo.git repo-master
# cd repo-master
# git checkout -b branchA origin/branchA
# git checkout -b branchB origin/branchB
# cd -
# git clone -l -b branchA repo-master repo-branchA
# git clone -l -b branchB repo-master repo-branchB

Next step will be:
# $do_work ; git commit -avs ; git push 

Will that work as expected? Will find out after lunch..


Olaf
