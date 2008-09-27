From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] for-each-ref: Fix --format=%(subject) for log message without newlines
Date: Sun, 28 Sep 2008 07:08:58 +0900
Message-ID: <20080928070858.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Sep 28 00:12:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kji1m-0000T4-JW
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 00:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbYI0WJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 18:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbYI0WJc
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 18:09:32 -0400
Received: from karen.lavabit.com ([72.249.41.33]:60583 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbYI0WJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 18:09:31 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 221EDC7B61;
	Sat, 27 Sep 2008 17:09:31 -0500 (CDT)
Received: from 2699.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id K1UREYFU2TF1; Sat, 27 Sep 2008 17:09:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=KpLCqdQ5ru9tn5oH3fDrvJbGelTqZkqMKQm+DeydbXHqwfXPkilGR/MQ7B/duXt9eRhgxZCUKKaTyjMkFYPjdYNEMR4rfuTFP6rrLDVNGfowNE1LHsh1PSGpivP9KQkw9adTfPRmVKLqWZCRcsPIpx7N9J3vTCEiP8wX7kkiT7g=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96922>

Johan Herland <johan@herland.net> writes:

>  builtin-for-each-ref.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 9b44092..e59bd80 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -321,8 +321,8 @@ static const char *find_wholine(const char *who, int wholen, const char *buf, un
>  static const char *copy_line(const char *buf)
>  {
>  	const char *eol = strchr(buf, '\n');
> -	if (!eol)
> -		return "";
> +	if (!eol) // simulate strchrnul()
> +		eol = buf + strlen(buf);
>  	return xmemdupz(buf, eol - buf);
>  }

Why does this C++ style comment talk about "simulate"?

Don't other parts of git already use strchrnul()?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
