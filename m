From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] proper C syntax (inline has to be placed before the return type).
Date: Sun, 24 Sep 2006 14:46:33 +0200
Message-ID: <20060924124633.GP20017@pasky.or.cz>
References: <11563008693465-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 14:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRTNh-0002GI-Ry
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 14:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWIXMqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWIXMqf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 08:46:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40877 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750721AbWIXMqf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 08:46:35 -0400
Received: (qmail 11711 invoked by uid 2001); 24 Sep 2006 14:46:33 +0200
To: Pierre Habouzit <madcoder@debian.org>
Content-Disposition: inline
In-Reply-To: <11563008693465-git-send-email-madcoder@debian.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27667>

Dear diary, on Wed, Aug 23, 2006 at 04:41:09AM CEST, I got a letter
where Pierre Habouzit <madcoder@debian.org> said that...
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  strbuf.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/strbuf.c b/strbuf.c
> index 9d9d8be..c8174b4 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -13,7 +13,7 @@ static void strbuf_begin(struct strbuf *
>  	strbuf_init(sb);
>  }
>  
> -static void inline strbuf_add(struct strbuf *sb, int ch) {
> +static inline void strbuf_add(struct strbuf *sb, int ch) {
>  	if (sb->alloc <= sb->len) {
>  		sb->alloc = sb->alloc * 3 / 2 + 16;
>  		sb->buf = xrealloc(sb->buf, sb->alloc);

Bogus, look at C99 A.2.2:

   declaration-specifiers:
   storage-class-specifier declaration-specifiers
   type-specifier declaration-specifiers
   type-qualifier declaration-specifiers
   function-specifier declaration-specifiers

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
