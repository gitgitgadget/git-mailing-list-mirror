From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v14 05/16] Refactor write_name_quoted_relative, remove
 unused params
Date: Tue, 25 Jun 2013 19:51:13 +0800
Message-ID: <CANYiYbHTT=M7B3MWz4BvWf-8KGxJsfqhQfLbObgE2=v+stMx+A@mail.gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<6e5f34b62ff6a7d6b379a5cabc07b849539fb08f.1372087065.git.worldhello.net@gmail.com>
	<7v8v1z8gfu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 13:51:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrRmJ-0003Vv-Cm
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 13:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab3FYLvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 07:51:15 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49395 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3FYLvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jun 2013 07:51:15 -0400
Received: by mail-wi0-f178.google.com with SMTP id k10so645940wiv.17
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mQd6eD09OcmXqcTzNHLPVjgHvO0f1VKe7tvS5IRpGZM=;
        b=ZFrFOPYRBWZFLTp4Ld29iWZXrTu/HWb0Y5bJFkK/kymZjWQCOuCXP5dXVaiOjWPScp
         2SMuaWsu7WEtUDrRO9ll38ymkx5cWafvuFB/ejFC1nbkZEJXRJeQ5JdTDwkYwGw9SgeW
         fRJYRRGyA+69kRFKYQrUlvbJH2yDFxQXhCAEFfYlBBmhxmIjQw5sHw/uLN3fx6eAvdJK
         vSxA/PKk75xwTBCJMXxJ4j7wdirDWH175zuCwPgwzniIUMZeRttDbrSSc0/Bj0tpQ7y6
         jj59nquyim/bCMAdx9dYwuXVg1/hB9HFP7BH1axfHxD1LTNuXF1QqR2D4lhzcDXubVwL
         dcHw==
X-Received: by 10.194.24.40 with SMTP id r8mr11985583wjf.7.1372161073921; Tue,
 25 Jun 2013 04:51:13 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Tue, 25 Jun 2013 04:51:13 -0700 (PDT)
In-Reply-To: <7v8v1z8gfu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228957>

2013/6/25 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> -static void write_name(const char* name, size_t len)
>> +static void write_name(const char *name)
>>  {
>> -     write_name_quoted_relative(name, len, prefix, prefix_len, stdo=
ut,
>> -                     line_terminator);
>> +
>> +     /* turn off prefix, if run with "--full-name" */
>> +     write_name_quoted_relative(name, prefix_len ? prefix : NULL,
>> +                                stdout, line_terminator);
>
> Hmmm....
>
> Does this mean that ls-files has been broken in 03/16, because
> write_name_quoted_relative() was made to ignore prefix_len and
> measure the length of prefix with strlen(prefix), and this change
> fixes it?

I will rewrite and move this chunk to patch 03/16, but leave others
in this patch for clearity.


--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 18601196889
