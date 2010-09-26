From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 05/12] gitweb: use fullname as hash_base in heads link
Date: Sun, 26 Sep 2010 19:57:43 +0200
Message-ID: <201009261957.43923.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 19:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzvU6-00051j-VS
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 19:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab0IZR5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 13:57:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32891 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab0IZR5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 13:57:53 -0400
Received: by fxm3 with SMTP id 3so1447781fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xNyQWs8HvTxJNesgCH3Z4b5mLejillXAZK8S5Cx0jcs=;
        b=AzOgzaxDkERSeYrSlA2N5GOzx2gJsr+oA+fW8GdqQXNrOmMxtOyAFNzsRHR5pfgODL
         U3S+4ncmpqQtY9PNtg+GaA8aftwgBA0ZucE2RGxryhtuvV0zNP8X/a5keeiQKoFWEhYv
         +1neeP8jvkkAyGagetEGLTuWBVjIY4K1lw1bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nSI80TvO7220dOD+RJ/ISeJnmObJqZtratydfhGIfHOpdHJz7Yp6Arq8kQIZIeAgEc
         DqZogiFPP2fCfzpIrcv+SNkN51t9lGzBGQ7bIDK2iCtBLaMIvm6ubb96HEJpPOJJkzwO
         ISVzMbVVvFVyjKVnzMOwhPU/s/oslbzmR77rY=
Received: by 10.223.112.76 with SMTP id v12mr6479089fap.59.1285523871921;
        Sun, 26 Sep 2010 10:57:51 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id j14sm2007806faa.47.2010.09.26.10.57.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 10:57:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157246>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> Otherwise, if names are manipulated for display, the link will point to
> the wrong head.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Well, of course of 'hash' parameter uses 'fullname' then 'hash_base'
also should.  Good futureproofing, no argument here.  FWIW

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c3ce7a3..e70897e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4977,7 +4977,7 @@ sub git_heads_body {
>  		      "<td class=\"link\">" .
>  		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "shortlog") . " | " .
>  		      $cgi->a({-href => href(action=>"log", hash=>$ref{'fullname'})}, "log") . " | " .
> -		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
> +		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'fullname'})}, "tree") .
>  		      "</td>\n" .
>  		      "</tr>";
>  	}


-- 
Jakub Narebski
Poland
