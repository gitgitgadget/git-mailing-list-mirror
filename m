From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add Auto-Submitted header to post-receive-email
Date: Wed, 16 Jan 2013 16:49:59 -0800
Message-ID: <20130117004959.GD20620@google.com>
References: <E4715C92-2BE5-484E-A55B-273CAB5EB6B4@salk.edu>
 <67C048AA-0DA7-4397-A257-E0BE66089A5D@salk.edu>
 <7v392b8fv3.fsf@alter.siamese.dyndns.org>
 <258F0FE2-D014-4624-A1E2-721E51F0E12C@salk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kevin P. Fleming" <kpfleming@digium.com>
To: Chris Hiestand <chiestand@salk.edu>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvdge-0002UF-NU
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 01:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab3AQAuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 19:50:09 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:41509 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab3AQAuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 19:50:08 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so818850dak.19
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 16:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/QwSP/DLTZF8zxWDvQ7RRAaHbUMhd0RAkLKTxuO+sdM=;
        b=hegEeHUkIm9fHlmupYE8psYfHo2aplfdNJMbXauixdeRP+F2RsKNNGnLgwiTGubyBz
         Ok/HfCQXNGUB2nkW2hydqkpUoxumsBeQom0uKhxEoU+V8saMFlblPGFabL6UW0gfNP1x
         3t2FTIxR6mMkULWBmaXGvc6m6Xg9K7rJxqgK3WarYADw8o9RPnZ4kjLyA1UTDJ2ufb2l
         4fHE8KxR9dzNEvxXV6WaiOCRw0FHxfQBSX0rcX1QPUt4/N1gbMZBlY6dIT86IlR8brms
         Wy9dELj34+VwOnf0pxyC4pK7/4JoUwN/L77Zx+x/akZCCH1plsngZA/Vt9roB1MVAZeQ
         eg6Q==
X-Received: by 10.68.216.134 with SMTP id oq6mr7828552pbc.162.1358383807969;
        Wed, 16 Jan 2013 16:50:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id bc1sm164243pab.12.2013.01.16.16.50.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 16:50:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <258F0FE2-D014-4624-A1E2-721E51F0E12C@salk.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213831>

Hi Chris,

Chris Hiestand wrote:

> Andy, do you have any thoughts on adding this email header to
> contrib/hooks/post-receive-email? This patch shouldn't cause problems for anyone
> with a sanely configured mail delivery agent, and the additional header is very
> useful in toggling auto responses.

I'm not Andy, but it sounds very sane to me.  So for what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Jonathan

(patch left unsnipped for reference)

> This conforms to RFC3834 and is useful in preventing eg
> vacation auto-responders from replying by default
>
> Signed-off-by: Chris Hiestand <chiestand@salk.edu>
> ---
>  contrib/hooks/post-receive-email |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index b2171a0..0e5b72d 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -237,6 +237,7 @@ generate_email_header()
>  	X-Git-Reftype: $refname_type
>  	X-Git-Oldrev: $oldrev
>  	X-Git-Newrev: $newrev
> +	Auto-Submitted: auto-generated
>  
>  	This is an automated email from the git hooks/post-receive script. It was
>  	generated because a ref change was pushed to the repository containing
> -- 
> 1.7.10.4
