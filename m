From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] cg-commit: prefix the relative path to the message file
Date: Sat, 16 Sep 2006 17:07:06 +0200
Message-ID: <87fyerq291.fsf@rho.meyering.net>
References: <87d5aru4px.fsf@rho.meyering.net> <20060825000614.GF2817@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 17:08:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GObmG-000151-Bc
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 17:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWIPPHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 11:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWIPPHy
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 11:07:54 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64444 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751757AbWIPPHx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 11:07:53 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k8GF7eKB012532
	for <git@vger.kernel.org>; Sat, 16 Sep 2006 15:07:52 GMT
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A48A01686; Sat, 16 Sep 2006 17:07:06 +0200 (CEST)
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060825000614.GF2817@diku.dk> (Jonas Fonseca's message of "Fri,
	25 Aug 2006 02:06:14 +0200")
X-Virus-Scanned: ClamAV 0.88.4/1886/Sat Sep 16 10:39:23 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27117>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Makes the -M switch work from a subdirectory.
>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>
> ---
>
> Jim Meyering <jim@meyering.net> wrote Wed, Aug 23, 2006:
>> Hello,
>
> Hi,
>
>> I discovered that "cg-commit -M MSG-FILE ..." fails when run from
>> a subdirectory, and when MSG-FILE is a relative file name.
>> This is using cogito-0.17.3-2 from Debian/unstable, but the problem
>> remains when using the latest cogito sources, pulled minutes ago.
>
> The attached patch should fix this problem.
>
> ---
>
>  cg-commit |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/cg-commit b/cg-commit
> index 0cec58f..5cebd81 100755
> --- a/cg-commit
> +++ b/cg-commit
> @@ -398,7 +398,7 @@ fi
>
>  if [ "$msgfile" ]; then
>  	[ "$written" ] && echo >>"$LOGMSG"
> -	cat "$msgfile" >>"$LOGMSG" || exit 1
> +	cat "$_git_relpath$msgfile" >>"$LOGMSG" || exit 1
>  	written=1
>  fi
>
>

Thank you!
That solved the problem for me.
