From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 17:34:09 +0600
Message-ID: <CANCZXo7j=5zcjhxXAeEKagRmUVTNVyaDTzyt1LL_-uufGARCKA@mail.gmail.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<1537731273.629800.1434713654223.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 19 13:34:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5uYp-0001nL-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 13:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbbFSLeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 07:34:11 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:36157 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbFSLeK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 07:34:10 -0400
Received: by lacny3 with SMTP id ny3so72300614lac.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mdhqlUieXRI1TWVshdKjciX/JzKzbLwEql4zgz4FTqI=;
        b=Ns9fh0mk0HxEkh3FcLJxF+hpAxrs+4szBEPc4EO0Y37mh/dx0Pdx8vMUxmVXYHwf1l
         6SQj7FnzcA5UxgD+yLzD7XwvG7yHTLqprSz6iSneWNEG99X8PkPfYopls1YTmW7V8cWn
         F5PzHKns4iI63SFnC4NpvcRSOOPGldDO1A08rNkRkgqPAaiKcnYnm+ObLBE3qSujNEtp
         hL/jyljOJ5FdTZdHfYQz0j2V6GBCvsKs0UM6skGUErqGae0ALje1jctW4HuPQPbKc+cf
         vtIoecHoRlMfeqUHvMzXVxCExZBmhd5krprxeHCX9XYL32waX0dvgZzsZeZeU8uOwuRo
         HXpQ==
X-Received: by 10.112.156.97 with SMTP id wd1mr17103976lbb.30.1434713649226;
 Fri, 19 Jun 2015 04:34:09 -0700 (PDT)
Received: by 10.25.62.150 with HTTP; Fri, 19 Jun 2015 04:34:09 -0700 (PDT)
In-Reply-To: <1537731273.629800.1434713654223.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272131>

Hello,

Yes, thank you for advice.

2015-06-19 17:34 GMT+06:00 Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr>:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>> +test_expect_success "format-patch format.outputDirectory option" '
>> + git config format.outputDirectory "patches/" &&
>> + git format-patch master..side &&
>> + cnt=3D$(ls | wc -l) &&
>> + echo $cnt &&
>> + test $cnt =3D 3 &&
>> + git config --unset format.outputDirectory
>> +'
>
> You should probably do:
>> + test_config format.outputDirectory "patches/" &&
>
> instead of:
>> + git config format.outputDirectory "patches/" &&
>> [...]
>> + git config --unset format.outputDirectory
>
> This way there shouldn't be any problem with the
> tests following yours if your test fails in the middle.
>
> R=C3=A9mi
