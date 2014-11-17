From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 01/22] dir.c: optionally compute sha-1 of a
 .gitignore file
Date: Mon, 17 Nov 2014 14:31:04 -0500
Organization: Twitter
Message-ID: <1416252664.9065.3.camel@leckie>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	 <1415439595-469-1-git-send-email-pclouds@gmail.com>
	 <1415439595-469-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 20:31:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqS16-0001Rr-6W
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 20:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbaKQTbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2014 14:31:12 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:63497 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbaKQTbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 14:31:11 -0500
Received: by mail-qg0-f43.google.com with SMTP id f51so15911546qge.30
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 11:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=vVcPUmm9MyiJvq8kgsq6UFLLgABupLmhtJyQGJ0puI0=;
        b=d6W5MXOfT75aDHtt58X1GdOrrV0cDsDQHIsG+6ab+pxQcs6GnyYSadpBz/VNftHnrv
         J8SaY9aFsF9/9/XA7sdM7HrUumc92jSuVwVk+aZi6HKxvIW2nPZ/L00s8G0qptu72mrF
         jMNqu2HYMaVZ0s0u82NLYI27UAIW6DsvC8N02Jbih021Hac9Rr3hZ1MUg6+BoxvTpmVy
         2wvuVxLLWoYum3s5SEFTvG4w+20/wB+dgdHD31W+85GXvLCjU7qJOOPD0OzMilJLbV6g
         WQTaa/3IqBTJckwvrWwe6eKqXz40bUrML8JvUN5qr+cRxIgYZ7JcUYsTc5OZLN6efene
         lBDw==
X-Gm-Message-State: ALoCoQmvOmzHXcTqvqM2TcyBKEluGr8q0qYI54I8qdZ7WmVX5VhyxCDlF/Y4CUZTEC3O0aaqak10
X-Received: by 10.140.89.10 with SMTP id u10mr36181417qgd.70.1416252668128;
        Mon, 17 Nov 2014 11:31:08 -0800 (PST)
Received: from [172.18.25.176] ([8.25.196.25])
        by mx.google.com with ESMTPSA id w75sm3295479qgd.14.2014.11.17.11.31.06
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 11:31:07 -0800 (PST)
In-Reply-To: <1415439595-469-2-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2014-11-08 at 16:39 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> + * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
> + * stat data from disk (only valid if add_excludes returns zero). If
> + * ss_valid is non-zero, "ss" must contain good value as input.

ss and ss_valid should be sha1_stat and sha1_stat.valid

> +struct sha1_stat {
> +	struct stat_data stat;
> +	unsigned char sha1[20];
> +	int valid;
> +};

It might be good to document what "valid" means here e.g. "a sha1_stat
is valid if both sha1 and stat_data match the working tree's version of
the file" or whatever.
