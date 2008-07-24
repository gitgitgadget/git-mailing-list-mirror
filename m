From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] In perforce, RCS keywords are case-sensitive
Date: Thu, 24 Jul 2008 09:05:21 +0200
Message-ID: <200807240912.18546.simon@lst.de>
References: <alpine.LNX.1.00.0807221235000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 09:20:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLv7k-0005ax-D4
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 09:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbYGXHT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 03:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbYGXHT2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 03:19:28 -0400
Received: from hoat.troll.no ([62.70.27.150]:52071 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbYGXHT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 03:19:28 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 9BD8F202F9;
	Thu, 24 Jul 2008 09:19:22 +0200 (CEST)
Received: from rhea.localnet (rhea.troll.no [10.3.4.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 9103020124;
	Thu, 24 Jul 2008 09:19:22 +0200 (CEST)
User-Agent: KMail/1.10.0 (Linux/2.6.24-18-generic; KDE/4.0.98; x86_64; ; )
In-Reply-To: <alpine.LNX.1.00.0807221235000.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89844>

On Tuesday 22 July 2008 18:48:57 Daniel Barkalow wrote:
> At least, this is true in 2007.2, according to the documentation.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

Acked-By: Simon Hausmann <simon@lst.de>

Thanks,
Simon

> A line of perl with the variable $file in a string followed by a different
> variable not in the string, for example, doesn't get mangled by p4 and may
> therefore appear in a p4 depot.
>
> I don't know if the "old-style keyword expansion" is case-sensitive,
> though, so I'm leaving that alone.
>
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index d8de9f6..1ee612e 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -902,7 +902,7 @@ class P4Sync(Command):
>              if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
>                  text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
>              elif stat['type'] in ('text+k', 'ktext', 'kxtext',
> 'unicode+k', 'binary+k'): -                text =
> re.sub(r'(?i)\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\
>$',r'$\1$', text) +                text =
> re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r
>'$\1$', text)
>
>              contents[stat['depotFile']] = text
