From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 07/15] contrib/git-credential-gnome-keyring.c: ensure
 buffer is non-empty before accessing
Date: Mon, 23 Sep 2013 00:43:18 -0500
Message-ID: <523fd4f6965ad_b79d67e786506@nysa.mail>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
 <1379912891-12277-8-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:49:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNz18-0008ON-AH
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab3IWFtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:49:02 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:46308 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3IWFtB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:49:01 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so3061367obc.38
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+Jv8O90KA1WMrgBHj0jk+FERqflA910zC32vLBcvHKg=;
        b=mr8dHwoRepP7mfg7hCW1Yv877bHpoxaPQEYEjzUL3U0D6pd9h/qtqkK/eE/+JPADsX
         KRPFWwBIaTa4cV8Tlki8eeiQDoDjBXsRgfFIfiI/jFnUbpun3mK34fhkRHIKOmnsQ/uD
         esReAWc1nfMD4oDknWq1TrjDtbIsWgk5mPcrWpUoMYqdED0SmyAqjvhQZwuE4JJtTPxE
         W9gBi9dmVQb16XHEfarYXQXcIqLOe/jTdYVUqTZvg8T660qeDnxrVCTBn4KlWNrfaBF5
         2RjasKTz48tHcQSQwdEMoOjFrAXPsE4V8rHLvdHAdoZIdPd7LcDtgKSXekar+C83t92g
         9NxQ==
X-Received: by 10.182.29.233 with SMTP id n9mr305426obh.38.1379915340537;
        Sun, 22 Sep 2013 22:49:00 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm11850164oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:48:59 -0700 (PDT)
In-Reply-To: <1379912891-12277-8-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235201>

Brandon Casey wrote:
> Ensure buffer length is non-zero before attempting to access the last
> element.
> 
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>  contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> index 1081224..8ae2eab 100644
> --- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> +++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> @@ -315,7 +315,7 @@ static int credential_read(struct credential *c)
>  	{
>  		line_len = strlen(buf);
>  
> -		if(buf[line_len-1]=='\n')
> +		if(line_len && buf[line_len-1] == '\n')

The style is if ().

-- 
Felipe Contreras
