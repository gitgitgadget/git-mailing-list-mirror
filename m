From: William Pursell <bill.pursell@gmail.com>
Subject: Re: [PATCH 1/3] git-add -i/-p: Change prompt separater from slash
 to comma
Date: Mon, 02 Feb 2009 07:39:32 +0000
Message-ID: <4986A334.6070903@gmail.com>
References: <1233546159-30347-1-git-send-email-gitster@pobox.com> <1233546159-30347-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 08:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTtQc-0002cd-Jp
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 08:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZBBHjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 02:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbZBBHjj
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 02:39:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:36299 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbZBBHji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:39:38 -0500
Received: by nf-out-0910.google.com with SMTP id d3so197455nfc.21
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 23:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=FngnN8jq2sOpFFm/xpjWyB3HdMjUJU2LxiHFX2m3+gg=;
        b=CRmE+be26wgMhK/s1O6fibFLEM702Dn1gxgS7Wx1NsBDRZ2fPsjqCCpBEuJkDW4OmW
         mwtc10ic5eQ096jIk1okJIHNBjvY20RIFbcHOV4Zcp5xDey/vHXEKDwu8eQtDKxqfudR
         43DqXMiHml3zFeP0tpLbvmMRMk3zJQ0rEREmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QK5p/S/Scp2AGrQfSFanWmf9MVKH91uhZKnzKc9zmIq0zO5BD302ssJjRZo02cSVkU
         Kh/c11jQ07Y9Qajt8SLiU5jX8xV+n2sJYin4MrkDzuJ1FdynZPO/JwLoJsjnCKy8E7Nu
         S6+f8J0+dSzRcnoH8+mxX2fKLJXcNbuGDklAc=
Received: by 10.210.81.3 with SMTP id e3mr4435721ebb.30.1233560376553;
        Sun, 01 Feb 2009 23:39:36 -0800 (PST)
Received: from clam.local (5ad36962.bb.sky.com [90.211.105.98])
        by mx.google.com with ESMTPS id u14sm5777836gvf.31.2009.02.01.23.39.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Feb 2009 23:39:35 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <1233546159-30347-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108060>

Junio C Hamano wrote:
> From: William Pursell <bill.pursell@gmail.com>
> 
> Otherwise the find command '/' soon to be introduced will be hard to see.
> 
> Signed-off-by: William Pursell <bill.pursell@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-add--interactive.perl |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index ca60356..ca50363 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -929,22 +929,22 @@ sub patch_update_file {
>  		for ($i = 0; $i < $ix; $i++) {
>  			if (!defined $hunk[$i]{USE}) {
>  				$prev = 1;
> -				$other .= '/k';
> +				$other .= ',k';
>  				last;
>  			}
>  		}
>  		if ($ix) {
> -			$other .= '/K';
> +			$other .= ',K';
>  		}
>  		for ($i = $ix + 1; $i < $num; $i++) {
>  			if (!defined $hunk[$i]{USE}) {
>  				$next = 1;
> -				$other .= '/j';
> +				$other .= ',j';
>  				last;
>  			}
>  		}
>  		if ($ix < $num - 1) {
> -			$other .= '/J';
> +			$other .= ',J';
>  		}
>  		if ($num > 1) {
>  			$other .= '/g';
> @@ -958,13 +958,13 @@ sub patch_update_file {
>  		last if (!$undecided);
>  
>  		if (hunk_splittable($hunk[$ix]{TEXT})) {
> -			$other .= '/s';
> +			$other .= ',s';
>  		}
> -		$other .= '/e';
> +		$other .= ',e';
>  		for (@{$hunk[$ix]{DISPLAY}}) {
>  			print;
>  		}
> -		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
> +		print colored $prompt_color, "Stage this hunk [y,n,a,d$other,?]? ";
>  		my $line = <STDIN>;
>  		if ($line) {
>  			if ($line =~ /^y/i) {


Not a major complaint, but how about localizing the occurence
of the separator.  Something like this:



diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ca60356..bd8326d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -921,7 +921,7 @@ sub patch_update_file {

 	while (1) {
 		my ($prev, $next, $other, $undecided, $i);
-		$other = '';
+		$other = 'ynad';

 		if ($num <= $ix) {
 			$ix = 0;
@@ -929,25 +929,25 @@ sub patch_update_file {
 		for ($i = 0; $i < $ix; $i++) {
 			if (!defined $hunk[$i]{USE}) {
 				$prev = 1;
-				$other .= '/k';
+				$other .= 'k';
 				last;
 			}
 		}
 		if ($ix) {
-			$other .= '/K';
+			$other .= 'K';
 		}
 		for ($i = $ix + 1; $i < $num; $i++) {
 			if (!defined $hunk[$i]{USE}) {
 				$next = 1;
-				$other .= '/j';
+				$other .= 'j';
 				last;
 			}
 		}
 		if ($ix < $num - 1) {
-			$other .= '/J';
+			$other .= 'J';
 		}
 		if ($num > 1) {
-			$other .= '/g';
+			$other .= 'g';
 		}
 		for ($i = 0; $i < $num; $i++) {
 			if (!defined $hunk[$i]{USE}) {
@@ -958,13 +958,14 @@ sub patch_update_file {
 		last if (!$undecided);

 		if (hunk_splittable($hunk[$ix]{TEXT})) {
-			$other .= '/s';
+			$other .= 's';
 		}
-		$other .= '/e';
+		$other .= 'e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored $prompt_color, "Stage this hunk [" .
+			join(',', split("", $other)) . "]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {


-- 
William Pursell
