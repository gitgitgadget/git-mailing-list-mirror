From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 10/14] pull: set reflog message
Date: Thu, 21 May 2015 18:08:13 +0800
Message-ID: <CACRoPnRJH9QiouDHQasa515X6ECGZpRNfhnTGrJi8SyKt0ZWBQ@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-11-git-send-email-pyokagan@gmail.com>
	<390e789e8f84122d52185f22e6e798f2@www.dscho.org>
	<xmqqmw11a6yk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 12:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvNOl-0002ya-L4
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 12:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbbEUKIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 06:08:15 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34553 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbbEUKIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 06:08:14 -0400
Received: by lbcmx3 with SMTP id mx3so14304544lbc.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DYGGhPZHcBceCv5YI7RwcuuMWzzjPDUNfuWnTaZse3g=;
        b=Kv1tFZhDl2z2GZjNAxUAuLynC7VM8DhxMbFEkw0BzcVfXVMYa8c3gQ7wVdNfXPECwz
         zviL5juYzJBcbJ/PIlgXBOpTwZE5GN9PHxF7n9nat9yhYfqeXD7Hqk23ddkR3dRrlOFa
         9spXwZz7BWIgHykgXcwsXTGuLSe1Bz/VWiI/6/E3VCk+oKZNhVMUGgiiGBgmyV+JQ2y2
         5mJL5p/P9/h6fhlr9orKRCdd3Nqg6wsLzkg9JtjbMW1SJF3/1tz4jwMhcNnvbLx34App
         6DEOkPqmAl/fsY86Ug0ufnmfytYR0WN6OCPouZlozmzv0xlcIy81GRIQrPufm16RSMt2
         nxgg==
X-Received: by 10.112.205.69 with SMTP id le5mr1532132lbc.65.1432202893547;
 Thu, 21 May 2015 03:08:13 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 21 May 2015 03:08:13 -0700 (PDT)
In-Reply-To: <xmqqmw11a6yk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269578>

On Tue, May 19, 2015 at 5:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Yeah, either that, or "insert separator only before adding to
> something else" pattern, i.e.
>
>         for (i = 0; i < argc; i++) {
>                 if (i)
>                         addch(&msg, ' ');
>                 addstr(&msg, argv[i]);
>         }
>
> Both are easier to read than "always append SP and trim at the end".
> Besides, trimming at the end makes readers wonder if there are cases
> where argv[argc-1] ends with whitespaces and the code on purpose
> removes them.

Yeah, this looks better and is more correct.

Thanks,
Paul
