From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH next] t7407: use 'cut' utility rather than bash's substring
 expansion notation
Date: Thu, 20 Aug 2009 08:56:30 +0200
Message-ID: <200908200856.30359.johan@herland.net>
References: <QHfHFS_5JGiL-O8GMDfdfscFUdxV1xVObzr6e5LPleagDRd7bCg8I9YUwL9xkbgM64vyf_EVLLg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 08:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me1Zh-0003KI-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 08:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbZHTG4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 02:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbZHTG4b
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 02:56:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:42641 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753333AbZHTG4b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 02:56:31 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KON00CH5XY7WA10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 20 Aug 2009 08:56:31 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KON00KUHXY6Z200@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 20 Aug 2009 08:56:31 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.20.64221
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <QHfHFS_5JGiL-O8GMDfdfscFUdxV1xVObzr6e5LPleagDRd7bCg8I9YUwL9xkbgM64vyf_EVLLg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126609>

On Thursday 20 August 2009, Brandon Casey wrote:
> From: Brandon Casey <drafnel@gmail.com>
>
> The substring expansion notation is a bashism that we have not so far
> adopted.  There is precedence for using the 'cut' utility for extracting
> a substring.  So do so here.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  t/t7407-submodule-foreach.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index de1730d..44ea8ac 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -207,8 +207,8 @@ cat > expect <<EOF
>   $nested2sha1 nested1/nested2 (heads/master)
>   $nested3sha1 nested1/nested2/nested3 (heads/master)
>   $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
> - $sub1sha1 sub1 (${sub1sha1:0:7})
> - $sub2sha1 sub2 (${sub1sha1:0:7})
> + $sub1sha1 sub1 ($(echo $sub1sha1 | cut -c 1-7))
> + $sub2sha1 sub2 ($(echo $sub1sha1 | cut -c 1-7))

Typo (both in the original, and the patch), should be:
	$sub2sha1 sub2 ($(echo $sub2sha1 | cut -c 1-7))

>   $sub3sha1 sub3 (heads/master)
>  EOF

Otherwise:

Acked-by: Johan Herland <johan@herland.net>

Thanks,


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
