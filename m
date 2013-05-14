From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 07/10] remote-hg: don't push fake 'master' bookmark
Date: Tue, 14 May 2013 15:25:35 -0500
Message-ID: <51929dbfeab24_13a8f89e18207f@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:27:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLp6-0001ms-O9
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791Ab3ENU1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:27:44 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:44839 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895Ab3ENU1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:27:44 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so1114181obb.17
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=744VSw703cBp/xEeTRfTfUNw23hrNhzof2zsznFjxKA=;
        b=PkEedihKnYKYSRgI3HyqjLH8JVDazb2QZWa3HQ40Ko6VjmS/DQMnezQ0PSCI+eLNzE
         9HSNe3b9eyEjUzUkHlSFBbf01uFp6wS+ogrvgmjDB/iPA2Pe+6JXXPCPeSGNMeL2YIqV
         8vxmoShtQIDUj9XCQV4Aes4FB/xcniAzFVdROfKy8i6GpblfITU/TkblR4BK/PO5RSvL
         QVW3wn5imK8p5/574hV11CW9opHhF3KOdWe5emscEJ5CVh+9zFlV5QYjHDq5DUX0Q0f1
         eiBPnT76rTqf8yOIY/bCKr62EJfWbSxoaeIx9S22z+QS3RJSzl537UizaT4wp+DodWQi
         TEcg==
X-Received: by 10.182.97.168 with SMTP id eb8mr15528719obb.89.1368563263803;
        Tue, 14 May 2013 13:27:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm23153258obi.8.2013.05.14.13.27.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:27:42 -0700 (PDT)
In-Reply-To: <1368486720-2716-8-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224339>

We obviously don't want to push our fake 'master' bookmark to the remote. This
is an obvious good change.

Felipe Contreras wrote:
> We skip it locally, but not for the remote, so let's do so.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 53412dd..beb864b 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -873,7 +873,8 @@ def do_export(parser):
>  
>          if bmark == 'master' and 'master' not in parser.repo._bookmarks:
>              # fake bookmark
> -            pass
> +            print "ok %s" % ref
> +            continue
>          elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
>              # updated locally
>              pass
> -- 
> 1.8.3.rc1.579.g184e698

-- 
Felipe Contreras
