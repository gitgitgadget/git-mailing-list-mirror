From: Haitao Li <lihaitao@gmail.com>
Subject: Re: [PATCH] date.c: Parse timezone with colon as separator
Date: Wed, 7 Sep 2011 11:00:59 +0800
Message-ID: <CABk5KLh230zLfkdaEgv7SDC6ivKqwvaGJQFVEKkKtGjMyEmLog@mail.gmail.com>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com> <20110906202440.GD14554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 05:01:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R18OE-0007q9-Bp
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 05:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab1IGDBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Sep 2011 23:01:21 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54294 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab1IGDBT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 23:01:19 -0400
Received: by vxj15 with SMTP id 15so11426vxj.19
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 20:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mXSIripr0grAPJ/a0KnygmPyc3HNUpXR2Rcl/Dcn2/E=;
        b=djUGeDhhe5VySlDAlzslRV8X92yl6f3xlH9shyjgUAHXGL04E19Rew8DCRcbu6UeON
         0wgTxuEyhCH4vjiFbLFR5cJYxrMgUPBtpn8rd5/fZmE1G/ve6e933MWGhWFeJTjJ9kby
         KcPuLhLtgwyaaXDC60PnC/6n2cTGbwRVEEu60=
Received: by 10.52.28.233 with SMTP id e9mr1310167vdh.266.1315364479092; Tue,
 06 Sep 2011 20:01:19 -0700 (PDT)
Received: by 10.52.159.129 with HTTP; Tue, 6 Sep 2011 20:00:59 -0700 (PDT)
In-Reply-To: <20110906202440.GD14554@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180849>

> That seems like a sensible list to support, given that it is part of
> iso8601 (though I was a little surprised after reading your subject
> line, which would probably be better as "support iso8601 timezone
> formats").

I agree this is a better one! ;)

> We should probably have new tests, too. I was going to suggest squash=
ing
> in the ones below, but your patch doesn't seem to work with the first
> one:
>
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index f87abb5..9b326cd 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -40,6 +40,8 @@ check_parse 2008-02 bad
> =C2=A0check_parse 2008-02-14 bad
> =C2=A0check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
> =C2=A0check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0=
500'
> +check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
> =C2=A0check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' E=
ST5
>
> =C2=A0check_approxidate() {
>
> If I am reading your commit message correctly, that should work, righ=
t?
>

Yes, you are right. I will send an updated version to get this right.

Thank you for reviewing and giving suggestions!

/Haitao
