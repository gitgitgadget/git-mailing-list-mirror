From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] imap-send: create target mailbox if it is missing
Date: Sat, 2 Aug 2014 23:38:08 -0700
Message-ID: <CAPc5daWPiCj7Uap4J+AOfebYYVewhnQX-pbT=ByuzOE-K2tA_A@mail.gmail.com>
References: <alpine.LSU.2.00.1407312034410.25674@hermes-1.csi.cam.ac.uk>
 <alpine.LSU.2.00.1408010915500.23775@hermes-1.csi.cam.ac.uk>
 <xmqqppgju9kj.fsf@gitster.dls.corp.google.com> <53DCEB4A.1030009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tony Finch <dot@dotat.at>, Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 03 08:38:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDpRF-0008GL-Sn
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 08:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbaHCGic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2014 02:38:32 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:61117 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaHCGib convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Aug 2014 02:38:31 -0400
Received: by mail-lb0-f178.google.com with SMTP id c11so4316276lbj.37
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 23:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=FLxBRMgM+eYgEX0MGqtViiJNnVtiqjkN3tERMJlya+s=;
        b=LwBgFO7KTffR7e0C4Qeh0aAiVU0cM46G5vUz5shLcnoUrpxMjZWq7TGlMgnqtfFDSO
         dXWxRGCobNt9+JvF+jrMk3l8HKkZWjO/nYf7JTbFHUTfoH0kXIdwtozpKbNgv4qia4Gr
         14+CalRbdo5A8/tdmMFlncfC7LcbmNl3QFY7am8WRL04xx71vnCPNJFqlffyXYuRoSvV
         1gahVxmcTRuGFJ9LWmXHDMsGez1ndvOCq81w8d3UGLHSDB8dCZ+R/IDMYEeTf5hCm6Xl
         +XaagEmARery3v5vIvjGK2cYRt3chP5MzcXPT2qrxqzFAgopblyyyAar1183ZpvKiIYQ
         kMUA==
X-Received: by 10.112.181.131 with SMTP id dw3mr13526950lbc.13.1407047909790;
 Sat, 02 Aug 2014 23:38:29 -0700 (PDT)
Received: by 10.112.199.102 with HTTP; Sat, 2 Aug 2014 23:38:08 -0700 (PDT)
In-Reply-To: <53DCEB4A.1030009@ramsay1.demon.co.uk>
X-Google-Sender-Auth: KK02_IDG-eM-Mjz3C9VpWQ0HT6I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254719>

Yup. I think I also queued a fix-up on top.
Thanks for reporting.

On Sat, Aug 2, 2014 at 6:44 AM, Ramsay Jones <ramsay@ramsay1.demon.co.u=
k> wrote:
> On 01/08/14 23:30, Junio C Hamano wrote:
>> Tony Finch <dot@dotat.at> writes:
>>
>>> Some MUAs delete their "drafts" folder when it is empty, so
>>> git imap-send should be able to create it if necessary.
>>
>> Thanks for an update; queued.
>
> BTW, this provokes a warning from gcc (v4.8.2) for me:
>
>         CC imap-send.o
>     imap-send.c:561:25: warning: =E2=80=98issue_imap_cmd=E2=80=99 def=
ined but not used [-Wunused-function]
>      static struct imap_cmd *issue_imap_cmd(struct imap_store *ctx,
>                              ^
> It seems the change to get_cmd_result(), in commit 7ebac713, removes
> the only remaining (two) calls to issue_imap_cmd().
>
> HTH
>
> ATB,
> Ramsay Jones
>
>
>
