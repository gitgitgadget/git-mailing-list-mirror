From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout: add --sparse for restoring files in sparse
 checkout mode
Date: Sun, 24 Mar 2013 11:17:52 -0700
Message-ID: <20130324181752.GA4543@elie.Belkin>
References: <514C3249.7000100@ivt.baug.ethz.ch>
 <1364101583-6035-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kirill.mueller@ivt.baug.ethz.ch
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 19:18:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJpVD-0003A5-3v
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 19:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab3CXSSD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 14:18:03 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:61248 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab3CXSSC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Mar 2013 14:18:02 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so2901056dae.31
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Hxe/pU7qnk21chl3fGPPVeCSk4COGu15nCF7WYhs3Hk=;
        b=GVdy1t9TvY3VDik2dy3I2zfuUhxQJ/2+K+RjMp+eAnRpXuBitN0p7PAfy5FZwwPig2
         0wyYz2kxKFwQjsru7cUuRrsV9QhsKKQkAKjDBse2jsieiNTvv7Nc7H4eYpN/J53TyaRV
         d7ykemNKbQcCpRynswj3I8H7ff/vSWaOmuXGqg1BUEkepS/izTW5r439JjcGVUmNASS8
         vU8rTvJ5JDMQGz3iOMmD7kBoZOJtvpLGPA9uJkv2gO8eYkgWWfdCjaWZLt4SodJSFiYV
         z0IrtD3CjZ29dU+LodslivHYzdtVVsW0kWc/fB3TfYBNC+iD7pjbm77+2VN62WTSDyLI
         nc+Q==
X-Received: by 10.66.148.136 with SMTP id ts8mr14018052pab.12.1364149081459;
        Sun, 24 Mar 2013 11:18:01 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id xc4sm10302996pbc.41.2013.03.24.11.17.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 11:17:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218963>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -180,6 +180,13 @@ branch by running "git rm -rf ." from the top le=
vel of the working tree.
>  Afterwards you will be ready to prepare your new files, repopulating=
 the
>  working tree, by copying them from elsewhere, extracting a tarball, =
etc.
>
> +
> +--sparse::
> +	In sparse checkout mode, `git checkout -- <paths>` would
> +	update all entries matched by <paths> regardless sparse
> +	patterns. This option only updates entries matched by <paths>
> +	and sparse patterns.

Hm, should this be the default?

In principle, I would expect

	git checkout -- .

to make the worktree match the index, respecting the sparse checkout.
And something like

	git checkout --widen -- .

to change the sparse checkout pattern.  But of course it is easily
possible that I am missing some details of how sparse checkout is
used in practice.

What do you think?
Jonathan
