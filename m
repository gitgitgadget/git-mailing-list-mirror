From: Johannes Schneider <mailings@cedarsoft.com>
Subject: Re: [OT?] Executing Git from bash script invoked by cron
Date: Sat, 03 Jul 2010 19:19:51 +0200
Message-ID: <4C2F7137.6020209@cedarsoft.com>
References: <4C290D88.80306@cedarsoft.com> <1277759597-sup-9397@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 03 19:21:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV6Pb-0004tN-Mc
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 19:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab0GCRVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 13:21:51 -0400
Received: from hosting.cedarsoft.com ([188.40.238.168]:37186 "EHLO
	cedarsoft.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278Ab0GCRVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 13:21:50 -0400
Received: from [192.168.0.36] (HSI-KBW-109-193-057-134.hsi7.kabel-badenwuerttemberg.de [109.193.57.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cedarsoft.eu (Postfix) with ESMTP id 684BB12E6003
	for <git@vger.kernel.org>; Sat,  3 Jul 2010 19:24:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <1277759597-sup-9397@nixos>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150195>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/28/2010 11:17 PM, Marc Weber wrote:
> sh -c 'your quoted command &> /tmp/logfile'
> 
> b) if this still does not work use strace:

That is it. Thanks.
Of course, git writes to stderr. And I did not redirect it properly.
I don't understand the details, but this line is working now:

sh -c 'myscript' >> logfile 2> err


The problem - by the way - is related to ssh authentification...
But that is another issue...


But here comes my question: Obviously all output created by git push is
written to stderr. I'd expected that most of the content will end up in
stdout.
But I am sure there is a good reason for it - so I just accept it ;-)


Thanks,

Johannes
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJML3E0AAoJEAytD9R7Qv6dZ5cIANpYYu5isncB3LcLaQgURQmP
esxkrtAVrcghItv+KkSts+qb8IBlEmA1mkzMYpmgVn6M/CQxh3atlaDsTbNtznAA
eZVJwXqQwoPlJS8ZvoDcSdldcL5Nmi+nyJgg408y5j3GB4AEt8IihxYVW7Xs0pFQ
GdBOSjV/TK1PEjcP7dNYJ9MSdUFA6Z7GrywRKQwlRZ4C611wCBpEoAeD0S1vcJcl
B78DTIqB+P3VF+mLW3u2LRXUdp3+tM2uutGR7DkG6GVomHJkwb5zAGXU4AmwHt2L
OdDwPAAZ5OzAgfyqLZ4YrOMv9Pg8sOjj+YLfljLUIXB/muJPACqNljv+liCmrac=
=X2Lj
-----END PGP SIGNATURE-----
