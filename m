From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Passing tar(1) options via git-archive(1)
Date: Tue, 23 Sep 2014 23:49:24 +0200
Message-ID: <5421EAE4.30704@virtuell-zuhause.de>
References: <87bnq6jhbk.fsf@brockman.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Daniel Brockman <daniel@brockman.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 23:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWXxo-0006Gb-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 23:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757006AbaIWVtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 17:49:32 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:52106 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757000AbaIWVtb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2014 17:49:31 -0400
Received: from p5ddc00a0.dip0.t-ipconnect.de ([93.220.0.160] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XWXxg-0007aM-0n; Tue, 23 Sep 2014 23:49:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <87bnq6jhbk.fsf@brockman.se>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1411508971;84824eda;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257447>

Am 23.09.2014 um 20:57 schrieb Daniel Brockman:
> Some background from the git-archive(1) man page:
> 
>     git-archive behaves differently when given a tree ID versus when
>     given a commit ID or tag ID.  In the first case the current time is
>     used as the modification time of each file in the archive.  In the
>     latter case the commit time as recorded in the referenced commit
>     object is used instead.
> 
> Would it make sense to add an --mtime option to git-archive(1) to enable
> explicitly setting the mtime for all files in the archive?  It could
> just pass through to the tar(1) --mtime option.
> 
> My use case is `git archive HEAD | docker build -`, in which the Docker
> cache is prevented from working because the mtime keeps getting bumped
> on all files.  I would like to have the mtime always be the same.
> 
> See, e.g., <https://github.com/deis/deis/issues/1334>.
> 
> Otherwise, how about a generic way to pass options to tar(1)?

Actually I wanted to just hint to TAR_OPTIONS
as in
TAR_OPTIONS="--mtime 2014-09-23\ 00:00" git archive -o ausg.tar HEAD
but that does not work here (on windows).

The questions is should it be supported?
