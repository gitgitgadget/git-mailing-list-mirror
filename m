From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 03/12] MINGW: compat/mingw.h: do not attempt to redefine
 lseek on mingw-w64
Date: Mon, 28 Apr 2014 17:19:55 +0200
Message-ID: <CABPQNSYLba_sn4FAvon7DP6fkKrhHXxX5cawuwBW3LGoKuW7rQ@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-4-git-send-email-marat@slonopotamus.org>
 <CABPQNSYOy3k4-4p08wRcWyiVW-SPqp4Ax_oMc8eACRcTSSHvaA@mail.gmail.com> <20140428150924.GA19167@seldon>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:20:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenMK-0007y7-Qw
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbaD1PUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:20:37 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:47226 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbaD1PUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:20:35 -0400
Received: by mail-ig0-f172.google.com with SMTP id hn18so4872539igb.11
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/aHXnjOid6uLSVgYf/hd92I+dEKGIsXb5TWh7Z+JWWU=;
        b=LE40U+a2Jt18qcqPnbcBxLdoQjDlt6UkXFYuEa05/TPhWnX3a1fUaqzO+RgM+lC18z
         zGNk4gIP6n954TQBa8VxqUnDIQJtXhwJqL3BOzNER3T7tIcy7ttchx1kn5dUYF/uzSCb
         3yb60x0064U8NBkoDaSMlKfBOrOpFiaKybrAXbQlxu47quJVPA4SjfhRmg084kN0+R5G
         gHMDpsQ9d9A6BGLl5EhY6kFMCfWmGeG51r8Fex/F+Ja7EsQwgr8CQbfVTT2PFoHTxtKF
         mBrUg38RgtUKEAvEeWUF+sICgET+4IoLoJ3O1FzNjgKW3Rr7f29DuGnSi2Uy+BdJt7H1
         EV/g==
X-Received: by 10.50.85.18 with SMTP id d18mr24405004igz.42.1398698435130;
 Mon, 28 Apr 2014 08:20:35 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:19:55 -0700 (PDT)
In-Reply-To: <20140428150924.GA19167@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247359>

On Mon, Apr 28, 2014 at 5:09 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> On Mon, Apr 28, 2014 at 05:02:09PM +0200, Erik Faye-Lund wrote:
>> msysGit has a declaration of it in io.h as well. But it's not a
>> preprocessor-definition... Are you saying that it's a
>> preprocessor-define in mingw-w64, that points to a 64-bit version? If
>> so, looks good.
>
> MinGW is x86 only.
>
> MinGW-W64, a separate project, provides both x86 and x86_64.
>
> And here's relevant part of io.h from MingW-W64:
> http://sourceforge.net/apps/trac/mingw-w64/browser/trunk/mingw-w64-headers/crt/io.h?rev=5437#L321

It looks like Line 335 is the real goodie:
https://sourceforge.net/apps/trac/mingw-w64/browser/trunk/mingw-w64-headers/crt/io.h?rev=5437#L335

#define lseek lseek64

So yeah, looks good to me.
