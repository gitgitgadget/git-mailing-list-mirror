From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 1/4] git-p4: Allow setting rename/copy detection threshold.
Date: Thu, 18 Aug 2011 22:50:36 +0100
Message-ID: <CAOpHH-VVniVZCG3KayLo8-C95Mhdj4e4gQTSyeMp2orNkOD9bA@mail.gmail.com>
References: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
 <1313629459-22937-2-git-send-email-vitor.hda@gmail.com> <20110818151847.GA2043@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 23:51:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAUm-0006nD-8D
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 23:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab1HRVvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 17:51:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47352 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab1HRVvH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 17:51:07 -0400
Received: by ywf7 with SMTP id 7so1819267ywf.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kvVqvIy2OGILg/w5wR9PGHoLBzVaarjHYbdbjzt7jmQ=;
        b=R3oBIvNDkMTnVxBrb2HBiQe3oV6YoiPA9wNdQic9iNRPtA1j2/vhUj6RTCczMUK/7J
         EWlWzslM9BCN7WN7B4JBLDyKgEqeKXGzgC7WVndomNhyiDSMAsmQ9OxrrN41iLNTT6Ss
         Q+3+AIxb4h+9nP5/9TdxGmCZdaWhFy63TLWCQ=
Received: by 10.42.150.66 with SMTP id z2mr1170797icv.383.1313704266331; Thu,
 18 Aug 2011 14:51:06 -0700 (PDT)
Received: by 10.231.19.8 with HTTP; Thu, 18 Aug 2011 14:50:36 -0700 (PDT)
In-Reply-To: <20110818151847.GA2043@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179630>

On Thu, Aug 18, 2011 at 4:18 PM, Pete Wyckoff <pw@padd.com> wrote:
> This is a good idea. =A0But I notice that -M, -C, -B can take
> a diverse set of option forms, including floating point and
> optional "%". =A0"-B" can take two args, separated by a "/".
>
> See diff_scoreopt_parse(). =A0It would be weird for git-p4 to limit
> that set to integers like you do here.
>
> Would you be willing to change it to pass the string blindly?
> Just filter out the special values, and pass everything else
> unchanged.
>
> =A0 =A0"true" -> "-M"
> =A0 =A0"false" -> ""
> =A0 =A0"" -> ""
> =A0 =A0".*" -> "\1"

This makes sense. I did notice that -M and -C supported, at least, a
'%' char at the end. But I decided to ignore it. I think your is idea
is not only good, but also a simpler solution. I'll send a new set of
patches shortly with this implemented.

> Dunno if you care about --break-rewrites. =A0Just pointing to it
> as a similar option to -M and -C in case you missed it.

I was completely unaware of this option, so I don't feel comfortable
in adding it as a configuration option for now. Will need to
understand it first ;)

--=20
Vitor Antunes
