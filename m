From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 03/10] remote-hg: enable track-branches in hg-git mode
Date: Tue, 14 May 2013 15:17:40 -0500
Message-ID: <51929be4bdd7c_13a8f89e1816ed@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLhn-00056l-3y
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430Ab3ENUUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:20:05 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:51160 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758152Ab3ENUUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:20:03 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so1235225oag.32
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=A/Plfp3nRhEdK3cYt8aIYmwfYHX4edK49gPmGOoTvZc=;
        b=DZm+JPPuDDbyl786U8YR9MCWOnP4Y4jf+RBcVyEmqr5xIlJao9mrqvzAZnbzDD1XWL
         HvG4DcNbanHKO9poy8nVA2lqA9XPCxXkJ2ij80ZA34IKubPLr9RcXfWe727qnWZ4BcPa
         hE0MFxS07b/Tum3Ddub3Z/ISx4zn8/wyEhaZFoyxlS/9pDAbKnYUnxS/8DjgBEPBxkBG
         jFB3n0vPNpVLZS2oJQk3xosTyI8kwReeHFyE3UI3Q1oubut849/f7wm0TKX4AKJh5RCS
         Gl2twKCmc2OclrLpxfu0rpb/gelpoVVTDFEzrBKW+j2BIrWNAYdIhwtpxAQiaTH1mO/k
         dipg==
X-Received: by 10.60.59.74 with SMTP id x10mr17227498oeq.48.1368562803190;
        Tue, 14 May 2013 13:20:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm23068119obb.13.2013.05.14.13.20.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:20:02 -0700 (PDT)
In-Reply-To: <1368486720-2716-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224335>

No regression here either, we simply give more power to the user.

Felipe Contreras wrote:
> The user can turn this off.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg     | 1 -
>  contrib/remote-helpers/test-hg-hg-git.sh | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 9d6940b..de3a96e 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -909,7 +909,6 @@ def main(args):
>  
>      if get_config('remote-hg.hg-git-compat') == 'true\n':
>          hg_git_compat = True
> -        track_branches = False
>      if get_config('remote-hg.track-branches') == 'false\n':
>          track_branches = False
>      if get_config('remote-hg.force-push') == 'false\n':
> diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
> index 0c36573..7f579c8 100755
> --- a/contrib/remote-helpers/test-hg-hg-git.sh
> +++ b/contrib/remote-helpers/test-hg-hg-git.sh
> @@ -102,6 +102,7 @@ setup () {
>  	) >> "$HOME"/.hgrc &&
>  	git config --global receive.denycurrentbranch warn
>  	git config --global remote-hg.hg-git-compat true
> +	git config --global remote-hg.track-branches false
>  
>  	HGEDITOR=/usr/bin/true
>  
> -- 
> 1.8.3.rc1.579.g184e698

-- 
Felipe Contreras
