From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-hg : Enable use of,
 $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Sun, 20 Apr 2014 15:48:54 -0500
Message-ID: <535432b6494cf_4a5cd6130c16@nysa.notmuch>
References: <53076DFC.1000602@gmail.com>
 <53499bb02c140_285f9032ec58@nysa.notmuch>
 <CANNJ_zjVaymTUmSSFHfSpmcH7H2v62nsHaUoxRfi098zqLi_Ow@mail.gmail.com>
 <53540df5ad0fb_18fb153d2ec8b@nysa.notmuch>
 <CANNJ_zhpoRRTL1j8XKahrsqEgKfvFck-+aJ20X1OyAg73gGiqQ@mail.gmail.com>
 <535425d891e41_6b186d130cc5@nysa.notmuch>
 <CANNJ_zi=qrhmWjd0_QR5-LLjuf2yM8g88xhiwmwdqansvaYy3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Delcypher <delcypher@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 22:59:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbypc-0000yM-N2
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 22:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbaDTU7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 16:59:17 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:39688 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaDTU7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 16:59:16 -0400
Received: by mail-yk0-f177.google.com with SMTP id q200so2825623ykb.22
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=6Duc5bRonq9L0Tx63/h/CxnPg6TyCwoBkcaR3fTC1fs=;
        b=p20yiFbjK6rcwkvPvR6yL39GfbBBx5Vuk3FlpWR8UsMLWnaeIuPM2bDl08a7jwcu44
         pMVCCG36+KTjOmLC4r5f/lNSTg2OJ0GGNBR4GwR/IfPNOk8Quokj6GxDb8LW/J5BhSf6
         Z50d3JRM+3yWx2/jfy97mZ8HAu0aRDYnnUS3BB0ufTnpfoO/jjqzcwufQ4DG6JrHH/Dx
         Pww3gadjV6TNSfIvxtQUczLlV9VE17la8DkY1rO1LLoCiaMm7D4JT1p87xdgCu7vLkPb
         LSWNTLJwSGo7sf4fcuNwcEGjBP60chhaLI/tuXI/d0a1Yhu3hAM0RGLcXC6dshpNNGNS
         AP7w==
X-Received: by 10.236.84.227 with SMTP id s63mr47877555yhe.26.1398027555660;
        Sun, 20 Apr 2014 13:59:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id v60sm58225576yhc.40.2014.04.20.13.59.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 13:59:13 -0700 (PDT)
In-Reply-To: <CANNJ_zi=qrhmWjd0_QR5-LLjuf2yM8g88xhiwmwdqansvaYy3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246581>

Delcypher wrote:
> > Same as me. And which version of git-remote-hg are you using?
> 
> I'm using the version that ships with git 1.9.2
> 
> I've taken a look and it seems I made a mistake, sorry. It seems that
> 
> [ui]
> quiet = True
> 
> is being respected when placed in ``.git/hg/origin/clone/.hg/hgrc``
> 
> with the un patched version of git-remote-hg.
> 
> But it is still the case that authentication details are being ignored
> when present in  ``.git/hg/origin/clone/.hg/hgrc``
> 
> i.e. something like the following is ignored.
> 
> [auth]
> cc.prefix = hg.codeplex.com
> cc.username = USERNAME
> # Eurgh fixme this shouldn't live here.
> cc.password = PWD
> cc.schemes = https

I see now, I've taken the patch with repo.ui and applied on my repo:

https://github.com/felipec/git/commit/ee17fe1cf80d5196be382ebbbcb1a24c05e61658

If Junio wants to take that he can add my s-o-b.

Cheers.

-- 
Felipe Contreras
