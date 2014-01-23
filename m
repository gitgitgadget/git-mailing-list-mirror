From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: libz and RHEL 5.9 compile of Git
Date: Thu, 23 Jan 2014 14:11:47 +0100
Message-ID: <52E11513.5010501@web.de>
References: <1390406392415-7602374.post@n2.nabble.com> <52E02310.9090609@web.de> <1390426029203-7602400.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: salmansheikh <salmanisheikh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 23 14:11:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6K4Y-0003Wb-1u
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 14:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbaAWNLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 08:11:49 -0500
Received: from mout.web.de ([212.227.15.3]:63576 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbaAWNLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 08:11:49 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MP047-1WC4pP0PqR-006SSH for <git@vger.kernel.org>;
 Thu, 23 Jan 2014 14:11:48 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1390426029203-7602400.post@n2.nabble.com>
X-Provags-ID: V03:K0:Nh1o2nqAeOQvKCkwgvW+5E7TZFX8TQhP+9d0Y/YYXhhDt2R6WEr
 0bkzwtu6WCFvfJ7vbp5oZuCcbby7JmupwLbsJtDYiEErn4X83n2aIeO2TbmcmOB0SPn9OLn
 o1KYn3chGmeR7yslLdc4p4+6KsYo4PkmyeR5NP1xhL45SFwfnAtUmf5Ig6GlKmXRaiQRnRp
 xQuDqgw4t85u9+Y8knJ+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240910>

On 2014-01-22 22.27, salmansheikh wrote:
> Got it working but then I had some issues with the perl portions of the
> install and I subsequently thought I could eliminate those portions and
> tried setting export NO_PERL=1 and that installed everything else...and got
> pass this error but when I tried to checkout a git repository as follows, I
> get some remote helper error. Is that related to the perl parts of the git? 

No

> git clone https://github.com/m-labs/migen.git
> Cloning into 'migen'...
> fatal: Unable to find remote helper for 'https'

Please have a look at libcurl.
It seems that libcurl on your system does not support https

The Makefile of Git is your friend:
# Define CURLDIR=/foo/bar if your curl header and library files are in
# /foo/bar/include and /foo/bar/lib directories.
