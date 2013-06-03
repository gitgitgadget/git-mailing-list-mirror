From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Tue, 4 Jun 2013 06:22:44 +0700
Message-ID: <CACsJy8AbhCSSrFnLiS-Gz4GrDiEuK9PM=CGv7fq0pa6Mm6LgRw@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
 <CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com> <7v38t5sg7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 01:23:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uje5v-0008Mc-7a
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 01:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758878Ab3FCXXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 19:23:16 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:34081 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758747Ab3FCXXO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 19:23:14 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so1410121oah.26
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/LuD/Kcun4pDiGj1N2X56sOe6u4Z3uj6J6NvALZ+0uY=;
        b=PpSaCgTo6TAcrZ3xNmQuvotkpsL5s9VLh9cqtMWy62vdkNzCEtCoUzrTjYoIaOzpF3
         7iQNivCUDBj9X8NxrRq1bM6eT1QbBeA4M1DbpnDJiXFTmdPpWWiO4Dhyl67qdatYknpJ
         YpUc4gaMIzwaq/WGZh0AEjeAFSG+q4qRv77jsRxuup9OlP6zLpw4ZiGuXdyC3sPs4Xyl
         wmFHeyShzmB5uDM3lCCuh/3S57khsi+cpke+F6Qnpvk0F8z6/DPmtIZLK1pYxgGAGCCN
         AIe6K/JtxVGYobQiqbah5Zli4+fBBXjEioTtOh5QqxUPby2uoBqMVy7OC7r4H+M6us7E
         xbKA==
X-Received: by 10.60.97.232 with SMTP id ed8mr10092135oeb.96.1370301794097;
 Mon, 03 Jun 2013 16:23:14 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Mon, 3 Jun 2013 16:22:44 -0700 (PDT)
In-Reply-To: <7v38t5sg7k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226307>

On Thu, May 30, 2013 at 3:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> *1* "blame" is an oddball (and I suspect the recent log -Ln,m:path
>     may share the same) in that it really wants a concret path, not
>     a pathspec, so you cannot even say
>
>         cd Documentation; git blame :/Makefile
>
>     I think the right fix is to teach it that the argument it has
>     been taking as a pathname is actually a pathspec, match the
>     pathspec with appropriate place (either in the working tree, or
>     in the commit we start digging from), and use the path that the
>     pathspec matches to a single one (otherwise barf).

You should have CCed me when it's about pathspec :) At least we can
safely turn on :/ trick for git-blame and reject other features (like
globbing) that blame can't handle. I'll look into how easy/hard to
make git-blame support pathspec.
--
Duy
