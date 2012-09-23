From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] graph: avoid infinite loop in graph_show_commit()
Date: Sun, 23 Sep 2012 19:14:51 +0700
Message-ID: <CACsJy8ApYKOU8v_-HkUC5uOb8gsheugKaXKMjbm0_-ygW_4jiQ@mail.gmail.com>
References: <1348323880-3751-1-git-send-email-pclouds@gmail.com> <loom.20120923T135253-178@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, adam@adamsimpkins.net,
	Junio C Hamano <gitster@pobox.com>
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 14:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFl5v-0003f6-RH
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 14:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab2IWMPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 08:15:23 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47268 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab2IWMPW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 08:15:22 -0400
Received: by ieak13 with SMTP id k13so8839551iea.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=m+77xiXn91y+riht0VD83YXude203hJ7L2QHX2BrddI=;
        b=P2Kq2b90h6iJcUyHP9rQ1XsF7Jfq0M/vzs1UIlOETrCms48o/Jz6pA1sjnHa+H3zjG
         q7VfgIth6NnAcIFPHkF2oMMt9DBePeyYSfi11VezIcdNERCU5b0glVchMqMvDhhjrYg3
         mWZKLloj/04LmjP6y8STbb6FDsIfLAgYz8Phk05m1Ad5ver/2ivutwJC+hEBjWvhnRM5
         URJdGOnN6CQR/rCR4ty8b0mvdB3bbb+vHglB5ybN4E4ZPF7XMsbb+cJE/u04tbLgMfR0
         00Zil29WmN0EY58sazUHKT/1QOnnJG/CgbqZAlerjUuJwSuOYLfbBhJhNHh0ggaEc2BH
         23tw==
Received: by 10.50.170.98 with SMTP id al2mr2881808igc.47.1348402521646; Sun,
 23 Sep 2012 05:15:21 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Sun, 23 Sep 2012 05:14:51 -0700 (PDT)
In-Reply-To: <loom.20120923T135253-178@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206238>

On Sun, Sep 23, 2012 at 6:55 PM, Michal Kiedrowicz
<michal.kiedrowicz@gmail.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> wr=
ites:
>
>>
>> The loop can be triggered with "git diff-tree --graph commit" where
>> the commit is a non-merge. It goes like this
>
>
> Isn't this the same issue as in
> http://article.gmane.org/gmane.comp.version-control.git/123979
> ? (with slightly different fix)

I don't know. I'm not familiar enough with graph.c to tell. Maybe Adam
can have a look?

The patch that is cut out is
http://article.gmane.org/gmane.comp.version-control.git/206205
--=20
Duy
