From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 03/10] setup: convert setup_git_directory_gently_1 et
 al. to strbuf
Date: Mon, 28 Jul 2014 19:23:35 -0400
Message-ID: <CAPig+cQM2g2LoiwBQxy7ZwbQT0RZt_sKZQahpjJEH7Fn4MyBkg@mail.gmail.com>
References: <53D694A2.8030007@web.de>
	<53D695E0.2050209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:23:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuGa-00079z-Lo
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbaG1XXh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 19:23:37 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:40609 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaG1XXg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2014 19:23:36 -0400
Received: by mail-yh0-f44.google.com with SMTP id f73so5330323yha.31
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Qk0BupC01w1R2fqoFnXAtOxqrvO0hyRjH2R+WaKZaIE=;
        b=lBWceMvASYFn7T9U41zSeXSRtB0+YVUSRMywXNdghlXn846ZmBba5XFL+O9MEWLr6W
         WB76Ukn/nEGb0AFi8X6eqysE+bMtXoqB1vrdt0XLYTXcbAwlN2ceq2z5JXEgtWeFj5cp
         89E7i/ZYY373swSZP3YNzwXxBUTk9QWgGn9u+SciEts9u433NIHBFrVB2lJq2UWeUaay
         /2w9qPGeIBrR4F5a7AGlPj1AXQjhbCOCqNsIVfg1RC/hmWS8uGPqKr8501Uj0qO2ywzO
         /6jW1saXWrXrzXHeobvr82hY1d3ZRMsnd3xRuFRxFtugjJJ+pgaKQRt73NLO4+vZXHqM
         Y+FA==
X-Received: by 10.236.43.112 with SMTP id k76mr8114175yhb.151.1406589815558;
 Mon, 28 Jul 2014 16:23:35 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Mon, 28 Jul 2014 16:23:35 -0700 (PDT)
In-Reply-To: <53D695E0.2050209@web.de>
X-Google-Sender-Auth: Nv7a1zP8OFbhje6c_nlUDxPiDP0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254381>

On Mon, Jul 28, 2014 at 2:26 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Convert setup_git_directory_gently_1() and its helper functions
> setup_explicit_git_dir(), setup_discovered_git_dir() and
> setup_bare_git_dir() to use a struct strbuf to hold the current worki=
ng
> directory.  Replacing the PATH_MAX-sized buffer used before removes a
> path length limition on some file systems.  The functions are convert=
ed

s/limition/limitation/

> all in one go because they all read and write the variable cwd.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
