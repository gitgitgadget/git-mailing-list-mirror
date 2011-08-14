From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH resend] Makefile: Use computed header dependencies if the
 compiler supports it
Date: Sun, 14 Aug 2011 15:02:55 -0500
Message-ID: <20110814200255.GC16819@elie.gateway.2wire.net>
References: <1313347512-7815-1-git-send-email-frekui@gmail.com>
 <20110814190050.GA16819@elie.gateway.2wire.net>
 <CALx8hKRBjXr44gM1JA+d=RU80pmruPV56s-G3JvViz87eJ=ajQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 22:03:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsgtj-0000aE-QE
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 22:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab1HNUC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 16:02:59 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48872 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab1HNUC6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 16:02:58 -0400
Received: by gxk21 with SMTP id 21so2880496gxk.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ak2h0uCUhh8zOtHDfg6CybeqKfIGcf26jRL7VoouZK4=;
        b=wIZz/x1XooakGnH2pC2csPqz8McPvZxZO2xEQhaHh8LP4Qr22n38WsVccrbOBZN/WF
         GNDHPK1zk5ryOIAgiYSwGyFsWefa2iC38WgHKkcAXVBYhp0PcRG9l6syT7iq6H/Idhzz
         CnYRej03BmTb/p0rYD1Fw2/P2Khl0CuxKVta0=
Received: by 10.100.82.19 with SMTP id f19mr3174887anb.46.1313352178277;
        Sun, 14 Aug 2011 13:02:58 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-76-206-233-80.dsl.chcgil.sbcglobal.net [76.206.233.80])
        by mx.google.com with ESMTPS id s13sm4513634anm.6.2011.08.14.13.02.56
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 13:02:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALx8hKRBjXr44gM1JA+d=RU80pmruPV56s-G3JvViz87eJ=ajQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179346>

=46redrik Kuivinen wrote:
> On Sun, Aug 14, 2011 at 21:00, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> I wonder if we can make do with a faster check, like
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) -c -MF /dev/null -MMD -MP git.c --h=
elp >/dev/null 2>&1
>>
>> What do you think?
[...]
> Without patch (with COMPUTE_HEADER_DEPENDENCIES=3DYes):

The case to compare against is when COMPUTE_HEADER_DEPENDENCIES is not
set, I'd think, since that is the status quo.  And I was talking about
commands like "make clean" that do not care about that feature, not
"make all".

[...]
> With patch, but changed to use git.c instead of ++empty.c:

Did you try with "--help"?
