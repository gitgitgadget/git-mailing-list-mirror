From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Mon, 5 Aug 2013 15:30:04 -0500
Message-ID: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
References: <1375733541-9099-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 22:30:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6RPy-0004MX-9F
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 22:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab3HEUaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 16:30:08 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:44983 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab3HEUaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 16:30:07 -0400
Received: by mail-lb0-f169.google.com with SMTP id u10so2454903lbi.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bS1fFmP1+JKmsI44eoH7TeZKLEbNaQmAw9Uf3v0cggc=;
        b=M5z1dpBMMwyXpdOZIX8ZhS4msVCJgYyQYOKPfY9nMAbjwE1G/PtEhOObScRlJqvmCk
         LxffCk6IWziTllL7oyeFdNHrPlT/ZTdxwB5PFc+m2sdtuumjj+9NuNyB177ZK6hmIZfy
         a5sBbIJVaI0SIwt9ec2E5MdLuEjVjsMhecZj2kKOF3K3dzPF0noCZAYF/r4IZ0nfTG3f
         GJPt3ij0WMdUfREzGrc2WY6dnIHS8K3RBZyJiV7WtoEweyLd/4YDAM0oEHEfs0BS4G+x
         zz00XRBJbaLYHpjz6zZwzsvPXVeuVEbZpPP7/g3i6zjCdcwszDIapd30ebzV2BskAGo8
         6WnA==
X-Received: by 10.112.209.2 with SMTP id mi2mr4976081lbc.63.1375734604966;
 Mon, 05 Aug 2013 13:30:04 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 5 Aug 2013 13:30:04 -0700 (PDT)
In-Reply-To: <1375733541-9099-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231701>

On Mon, Aug 5, 2013 at 3:12 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> The current code fixes the path to make it absolute when cloning, but
> doesn't consider tilde expansion, so that scenario fails throwing an
> exception because /home/myuser/~/my/repository doesn't exists:
>
>     $ git clone hg::~/my/repository && cd repository && git fetch
>
> Fix that by using python os.path.expanduser method.

Shouldn't that be the job of the shell? (s/~/$HOME/)

-- 
Felipe Contreras
