From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v3 2/7] gettext: Add a Gettext interface for shell 
	scripts
Date: Wed, 2 Jun 2010 08:53:39 +0000
Message-ID: <AANLkTim-z6JYmyvl5QWycPV9orsUu8qLg2ZVFP6ZeVLC@mail.gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
	<1275435597-4017-3-git-send-email-avarab@gmail.com>
	<4C05FAEF.2040205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 02 10:54:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJjiK-0001Yq-7S
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 10:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab0FBIxn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 04:53:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39803 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab0FBIxl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 04:53:41 -0400
Received: by iwn6 with SMTP id 6so1214313iwn.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Jc5s9jxWnNkXGlC5le1wchkHFJfEhcuoZ0H7rcchYVE=;
        b=mGTrmEBMbie/mmbqjTdmmHjyTJbk/6142hhINxcn4LpxMr+i2Q1lGhomYFw6fruhTA
         MnuM8x+kHRw1sQruIibCJrMPo8eBYNCPg2Iv1rRPER/7sVRFbqo32TNojjWuWeFxI6cT
         aZQBnk3H6dtpT2FV/eQTZz3SL3PldowIQoPXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kHHLfaqqyWUtTZhAhEB1h1utH89MrZoxlvlo2GoNECyvWY7hcK1f5Egh2sxlYmdt/x
         ZJ1eDKJvfUfPnc7NZ0I22ykbc89tUazx57ACks2ztPvUFif64HXmqR5whCQF+mnxuHwK
         Z7nB30g3y35nlMGCQbwrgk/+2q0hftSXsDZls=
Received: by 10.231.59.199 with SMTP id m7mr9523961ibh.30.1275468819416; Wed, 
	02 Jun 2010 01:53:39 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 2 Jun 2010 01:53:39 -0700 (PDT)
In-Reply-To: <4C05FAEF.2040205@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148231>

On Wed, Jun 2, 2010 at 06:32, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> [When you resend the series in such a manner that you collect a Cc li=
st
> manually, please do *not* include me. I'm not interested in this seri=
es.]
>
> Am 6/2/2010 1:39, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> + =C2=A0 =C2=A0# Not everyone has echo -n
>> + =C2=A0 =C2=A0case $(echo -n) in
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0\-n) =C2=A0 =C2=A0Xn=3D =C2=A0 ; Xc=3D'=
\c' ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*) =C2=A0 =C2=A0 =C2=A0Xn=3D-n ; Xc=3D
>> + =C2=A0 =C2=A0esac
>
> Don't use 'echo'; use 'printf %s'.

I didn't write this code (as the comment says) but I /thought/ that
the whole point of it was to autodetect if echo -n worked, and if so
use it because it'd be faster than printf "%s", otherwise use some
evil foo\n\c hack.

That hack doesn't work on bash ('\c' produces a space), maybe it
doesn't work anywhere. Do you have a shell that doesn't support echo
-n? What does it output there?

I wouldn't be surprised if it did need to be changed to printf
"%s". I'm just curious where it broke and how.
