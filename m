From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git --reference bug(?)
Date: Wed, 19 Oct 2011 07:01:27 +0200
Message-ID: <4E9E59A7.7070307@alum.mit.edu>
References: <CAK-xaQaUxJ5c_kN48g7-J9fosDv6awbAFQSFLpF2fA+hc-i-MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Andrea Gelmini <andrea.gelmini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 07:01:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGOHZ-0001TN-Mv
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 07:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609Ab1JSFBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 01:01:33 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59148 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab1JSFBc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 01:01:32 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED3A2.dip.t-dialin.net [84.190.211.162])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9J51RJ9008237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Oct 2011 07:01:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CAK-xaQaUxJ5c_kN48g7-J9fosDv6awbAFQSFLpF2fA+hc-i-MA@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183915>

On 10/19/2011 12:04 AM, Andrea Gelmini wrote:
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> /tmp/3.1 --reference /home/gelma/dev/kernel/linus/
> Cloning into /tmp/3.1...
> fatal: Reference has invalid format: 'refs/tags/3.1.1.1^{}'
> fatal: The remote end hung up unexpectedly

The upstream repo reports what look like non-reference references:

$ git ls-remote --tags
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git | head
5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11-tree
c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11-tree^{}
26791a8bcf0e6d33f43aef7682bdb555236d56de	refs/tags/v2.6.12
9ee1c939d1cb936b1f98e8d81aeffab57bae46ab	refs/tags/v2.6.12^{}
9e734775f7c22d2f89943ad6c745571f1930105f	refs/tags/v2.6.12-rc2
1da177e4c3f41524e886b7f1b8a0c1fc7321cac2	refs/tags/v2.6.12-rc2^{}
0397236d43e48e821cce5bbe6a80a1a56bb7cc3a	refs/tags/v2.6.12-rc3
a2755a80f40e5794ddc20e00f781af9d6320fafb	refs/tags/v2.6.12-rc3^{}
[...]

I've never seen this format before; is this the remote protocol for
peeled refs or maybe the behavior of an old version of git?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
