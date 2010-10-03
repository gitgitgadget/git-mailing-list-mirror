From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 5/6] Introduce the git fast-import-helper
Date: Sun, 3 Oct 2010 17:53:49 +0200
Message-ID: <AANLkTinZ6NCvKeALDBfP4z=ewkwWVwHBk=C_LmXM7OFh@mail.gmail.com>
References: <4CA86A12.6080905@dbservice.com> <1286108511-55876-5-git-send-email-tom@dbservice.com>
 <20101003153144.GA18001@burratino> <4CA8A504.50009@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 17:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2QtF-0003pt-1B
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 17:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab0JCPyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 11:54:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62849 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0JCPyL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 11:54:11 -0400
Received: by iwn5 with SMTP id 5so5869268iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2ZDXThkxcvvlBY6661esTuV022+pQyv5cqspMY+WXVM=;
        b=Zdj5S4Ax1X5+zkTRbSQeei6UyveLcy5TB72n/yuWWFRLQOOmnkGaqdcHrne3HqpvEC
         ZfFAuCQWbkA2RrpLdX1UKVBx15IKDfFAyn2rcpTwc97GB0KARFPu/JFamELaUC4Ng9Sf
         ZLHEj5IbXEK71+1y/EV+l1hCinj7Wd5SJQJKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TqVdPsRxrgKdE2OYBRlV481jN6YmcD21T+V52KsikLzAVtNmrYymNBTYD37RtyfCUa
         xLBlh+zgPEmkwjP+dB3EtQT0trS0He+t7mTByVkTRaP3qDprdtWoynHmvf7h6DPWLylb
         3ravKZKT4WcLydQQLJOqr9TA4OXbboUawHiiA=
Received: by 10.231.173.9 with SMTP id n9mr8708057ibz.146.1286121250801; Sun,
 03 Oct 2010 08:54:10 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 08:53:49 -0700 (PDT)
In-Reply-To: <4CA8A504.50009@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157884>

Heya,

On Sun, Oct 3, 2010 at 17:45, Tomas Carnecky <tom@dbservice.com> wrote:
> I agree. But when I started hacking on fast-import it seemed easier t=
o
> completely rip out parts that I didn't need and then add the few bits
> that I needed.

Sure, that would indeed be easier, but so much less maintainable :).

> I only need two new things from fast-import:
> =C2=A01) support non-numeric marks (and even this is maybe not strict=
ly
> required)

If this can be avoided, or worked around somehow, it would be a boon
to performance. The current marks implementation uses a hash table
index by the mark number, which is O(1), very efficient.

> =C2=A02) dump the mark->sha1 mapping immediately after creating the o=
bject
> (I heard there is a patch somewhere that does just that)

Why do you need that? Wouldn't the "write created object name to
stdout" not be sufficient?

> All other changes are not needed. Though I think there are a few thin=
gs
> which could be ported back to fast-import.c. I'll try to see which
> changes make sense to be backported and will post patches.

I'd be very interested in those :).

--=20
Cheers,

Sverre Rabbelier
