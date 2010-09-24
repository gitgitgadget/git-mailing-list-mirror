From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [msysGit] [PATCH] mingw: do not crash on open(NULL, ...)
Date: Fri, 24 Sep 2010 15:22:58 +0100
Message-ID: <AANLkTikEvoXuN+vrxry5mz7CM2AuzgBUvUoQxW+zs5oY@mail.gmail.com>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
	<201009232208.56916.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 16:23:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz9B4-0005qk-5v
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 16:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290Ab0IXOXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 10:23:00 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47799 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268Ab0IXOW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 10:22:59 -0400
Received: by qyk33 with SMTP id 33so4060245qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=607nM4gA06UQ6FvFxnvOVj0i6ub9mey+bGpKkJ7S/vc=;
        b=azqWc+hJM2/XsT5OzJJCeEO1MtuPzLikK1lV8QlSgBLAh6GN2wvKtk48oF+5WnYTxt
         3Vuvamc0w7AF/M7IHu2vUTwdFAM4GOFJaBzzIVrWIEMetpSlgyCKcCWzn/DEsAmxl2VB
         jrxHRFcYVOdXQ648ycbfVAlGT7rJE4dlki78Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mOBruMz651+OgwD3oiaVSRsN8NKydr3PdWvr/oEuIcsEJk0ivrymto432xVRnOqYQW
         j6YD4S6JBod9IjADgaKT4eRZZjCWTgLcrXaVZFE8TNngT8dLxaJgOStWbx9iRXT6BjGF
         XxA4cPkeE9RGbzVRyP3ZqlcIotImxbISmdSvs=
Received: by 10.224.28.134 with SMTP id m6mr2533056qac.150.1285338178585; Fri,
 24 Sep 2010 07:22:58 -0700 (PDT)
Received: by 10.229.30.212 with HTTP; Fri, 24 Sep 2010 07:22:58 -0700 (PDT)
In-Reply-To: <201009232208.56916.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156993>

On 23 September 2010 21:08, Johannes Sixt <j6t@kdbg.org> wrote:
> On Donnerstag, 23. September 2010, Erik Faye-Lund wrote:
>> @@ -297,7 +297,7 @@ int mingw_open (const char *filename, int oflags=
, ...)
>> =C2=A0 =C2=A0 =C2=A0 mode =3D va_arg(args, int);
>> =C2=A0 =C2=A0 =C2=A0 va_end(args);
>>
>> - =C2=A0 =C2=A0 if (!strcmp(filename, "/dev/null"))
>> + =C2=A0 =C2=A0 if (filename && !strcmp(filename, "/dev/null"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D "nul";
>>
>> =C2=A0 =C2=A0 =C2=A0 fd =3D open(filename, oflags, mode);
>
> Good catch, thank you!
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>
>
> -- Hannes

Applied to devel and pushed.
