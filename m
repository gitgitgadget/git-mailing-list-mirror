From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Fri, 6 Oct 2006 21:20:06 +0200
Message-ID: <20061006192006.GW20017@pasky.or.cz>
References: <20061006191801.68649.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 21:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVvF0-0006J6-IN
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 21:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422869AbWJFTUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 15:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWJFTUL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 15:20:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26317 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932458AbWJFTUI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 15:20:08 -0400
Received: (qmail 2509 invoked by uid 2001); 6 Oct 2006 21:20:06 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061006191801.68649.qmail@web31815.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28438>

Dear diary, on Fri, Oct 06, 2006 at 09:18:01PM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> Convert a string (e.g. a filename) into qtext as defined
> in RFC 822, from RFC 2183.  To be used by Content-Disposition.
> 
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> ---
>  gitweb/gitweb.perl |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)

Content-Description: 1207600725-p1.txt
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f848648..a35d02c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -520,6 +520,16 @@ sub esc_html {
>  	return $str;
>  }
>  
> +# Convert a string (e.g. a filename) into qtext as defined
> +# in RFC 822, from RFC 2183.  To be used by Content-Disposition.
> +sub to_qtext {
> +	my $str = shift;
> +	$str =~ s/\\/\\\\/g;
> +	$str =~ s/\"/\\\"/g;
> +	$str =~ s/\r/\\r/g;

\r? Not \n?

> +	return $str;
> +}
> +
>  # git may return quoted and escaped filenames
>  sub unquote {
>  	my $str = shift;

Other than that,

Acked-by: Petr Baudis <pasky@suse.cz>

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
