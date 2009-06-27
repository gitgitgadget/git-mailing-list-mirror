From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 2/9] gitweb: uniform author info for commit and commitdiff
Date: Sat, 27 Jun 2009 18:10:22 +0200
Message-ID: <200906271810.23119.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 18:10:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKaUB-00086y-W2
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 18:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbZF0QK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 12:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754692AbZF0QK2
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 12:10:28 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:40706 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbZF0QK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 12:10:27 -0400
Received: by bwz9 with SMTP id 9so2524814bwz.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vvvhhX2BnudMaMrsz8VXu5fsumiEtSnMv4/kJJegwpY=;
        b=rhhIgsOXarOQdQiJGvgdnzaQ9u5zH+7oV0klEqkaFkcM3vRFpebV/nURfprptjKw6o
         S4+PlaKZiFSTbcbgbHtOqCJxi2KoD+opth2ENwgFJdl5DwD2eU/Hql9+45yD10xTNZb6
         l0dojy/zDzWMd3dvE+f6gnVlkR6E6UhkUt3rM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NKaiKC9knhOj8TqVrfXuaH2Bn/JheWver2VG2Y+FNvHTv8ZjFH8dOORdod3BPLthx2
         BqL787hfdpgpATM0bFl7nKR1Gn/yhC1OFm26d4bx8KvUglYf/CERuSyvrhtIBN2ztsK1
         O9JGqje7nEgOo9pCOKBaEu9/G3Y/Vf7vIFwDU=
Received: by 10.103.242.14 with SMTP id u14mr2949931mur.106.1246119029104;
        Sat, 27 Jun 2009 09:10:29 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id 25sm6290831mul.50.2009.06.27.09.10.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 09:10:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122374>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:
> Switch from
> 
> A U Thor <email@example.com> [date time]
> 
> to
> 
> author	A U Thor <email@example.com>
> 	date time
> committer	C O Mitter <other.email@example.com>
> 	committer date time

I would use:

  Switch from form similar to the one used by 'log' view

  	A U Thor <email@example.com> [date time]

  to the form used in 'commit' view

	author       A U Thor <email@example.com>
  	 	     date time
  	committer    C O Mitter <other.email@example.com>
  	             date time

(i.e. use spaces and not tabs to align).  But this is minor
issue, not worth worrying about IMVHO.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I am still not sure about this change.  On one hand side it is unifying
of 'commit' and 'commitdiff' view; most other web interfaces have single
view equivalent to git-show, which displays both commit info, and the
diff.  (And 'commitdiff' with 'hp' parameter i.e. between two commits
has to be redesigned anyway, so this issue doesn't enter this 
consideration).

On the other hand side IIRC 'commitdiff' uses short (one-line) 
authorship info because the main point is the diff, and multi-line
author and commit info like the one used in 'commit' view takes
a bit of vertical space.  Also one can use similarity between
'log' and 'commitdiff' views (git-log and git-show) as a counter
for argument that 'commitdiff' has to look like 'commit'.

But otherwise I quite like this patch.

> ---
>  gitweb/gitweb.perl |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9be723c..0d8005d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5599,7 +5599,11 @@ sub git_commitdiff {
>  		git_header_html(undef, $expires);
>  		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
>  		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
> -		git_print_authorship(\%co, 'localtime' => 1);
> +		print "<div class=\"title_text\">\n" .
> +		      "<table class=\"object_header\">\n";
> +		git_print_authorship_rows(\%co);
> +		print "</table>".
> +		      "</div>\n";
>  		print "<div class=\"page_body\">\n";
>  		if (@{$co{'comment'}} > 1) {
>  			print "<div class=\"log\">\n";

Nice and short, thanks to earlier (re)factoring.

BTW. after this change the -localtime part of git_print_authorship()
subroutine is unused... just saying ;-)  Not something terribly 
important.

-- 
Jakub Narebski
Poland
