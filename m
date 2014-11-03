From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 18/19] update-index: test the system before enabling
 untracked cache
Date: Mon, 3 Nov 2014 19:16:46 +0700
Message-ID: <CACsJy8ASZX6rVMgUrScFh-RWWhuhQ+P_H1bwb9OvwmC+DRp9zg@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1414411846-4450-19-git-send-email-pclouds@gmail.com> <544FD474.3050805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 13:17:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlGZW-0001G0-9p
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 13:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaKCMRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2014 07:17:18 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:43845 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaKCMRR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2014 07:17:17 -0500
Received: by mail-ie0-f179.google.com with SMTP id rl12so4935699iec.24
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 04:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JvHEremZLfqDLvHYjwpL5tzIZBVG+fvQqf73ARTkDwU=;
        b=XB3Q473nPPU/4tavcJplV88Ezf030yRJ+1EOKI8RK98DMXw1kGHwmv0p6+TbqK/7Qs
         hTzUuFUpORj7agjzwi6FSUTpYM/Ha5/1OypJX3Lf5JM7R13nG3RNKQbh8GnPCHQrOZ4w
         kkr32jh+hEN4Q8AuNUPF0ZZ3tfXLxyf6KEH+8v7w4sBpn0rCd/H7A27gazXNxPcJEVGa
         ho31AdjOnL8JFYhn2vcSSYDsipkDSwBbVR4uo6szfivES5IIKdrspEEmKe+NUFDovj++
         IWG2J9kJgHxwVWEBYhkkttFrlSKcne5TPw16OvbEM38kFdlOiOtvdM89l2wEOaAeTxpk
         32Kw==
X-Received: by 10.42.114.18 with SMTP id e18mr41275976icq.42.1415017037077;
 Mon, 03 Nov 2014 04:17:17 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Mon, 3 Nov 2014 04:16:46 -0800 (PST)
In-Reply-To: <544FD474.3050805@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 12:37 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 2014-10-27 13.10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> []
>
>> +static void xmkdir(const char *path)
>> +{
>> +     if (mkdir(path, 0700))
>> +             die_errno(_("failed to create directory %s"), path);
>> +}
>
> Does it makes sense to ignore EINTR and do a "retry" ?
> Another question is if the function could be called mkdir_or_die() in=
stead?
>
> I realized that there are 2 families of xfunc() in wrapper.c, some di=
e, some retry.

This is only used interactively, I think it's ok to ignore EINTR as
long as we report clearly the case (and hope the user to re-enter the
command)
--=20
Duy
