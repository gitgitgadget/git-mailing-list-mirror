From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 17:51:05 -0400
Message-ID: <4BA937C9.9040004@gmail.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com> <201003231222.40745.jnareb@gmail.com> <41f08ee11003230523h2c5f93b1l7e94d6c85a93a706@mail.gmail.com> <201003231449.42190.jnareb@gmail.com> <41f08ee11003230823i1ca677b8q51b2413040c45c44@mail.gmail.com> <20100323195724.GA1843@progeny.tock>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bo Yang <struggleyb.nku@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 22:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuC0O-0001AS-7v
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 22:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab0CWVvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 17:51:15 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:32814 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab0CWVvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 17:51:14 -0400
Received: by qyk9 with SMTP id 9so1204481qyk.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=PZ6tFvhzjj/q4kTvRPhFfnGX+md8FJfeknC3iWs4CMY=;
        b=wdYpB07B4701xW4/6pekG2YpXEv6G/+mm4u/E+9HOIRa8BYpXNiohm4zjwaPRRbmJs
         lWL/ZG/BxCA22WzvUE6fv00gVoEA+KM9WFK5FGVWC0x0wU0f4gKW0x4DaZ08gvdDS96N
         G+FNoXBoogToX9T2Zpf1YXG9wUV6j9GlVyuGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=KRbfse9zN7EAzlueIAOtw6W8MYt3BmP2dxEBnoSoSjjOzvz93lB4Xa40uPHvzC2WhY
         XkYSmdOUMXPiud0fOqaoboeirtuE9cYXVuwcq5CWabFhKp/ojBisHiebMZObA+L1nFW4
         67WPcHeptaVyUzeLf4HGQfibzy4nTPBBrOXkA=
Received: by 10.229.231.132 with SMTP id jq4mr1965546qcb.55.1269381071319;
        Tue, 23 Mar 2010 14:51:11 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 2sm2982055qwi.11.2010.03.23.14.51.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 14:51:10 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20100323195724.GA1843@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143053>

Jonathan Nieder wrote:
> Bo Yang wrote:
>=20
>> It traces the preimage of the minimum related diff hunk carefully, i=
f
>> there is any case that there are more than one commit intersect with
>> the preimage, we will stop and ask the users to select which way to =
go
>> on tracing.
>=20
> That might be necessary, but I will admit that I suspect it to be
> harder to make useful.  One of the very nice things about =E2=80=98gi=
t log=E2=80=99 is
> that it is easy to browse through history in a nonlinear way in a
> pager (by using a pager=E2=80=99s search functionality).  The =E2=80=9C=
backend=E2=80=9D =E2=80=98git
> rev-list=E2=80=99 is easy to write scripts with, also because of its =
simple
> input and output.
>=20
> If your program requires input from the user, how will it paginate it=
s
> output?  Most pagers expect the standard input to be available for
> input from the user.
>=20
> One approach (I will not say it is a good one) to the problem of
> ambiguous origins for a line is to blame _both_ parents.  That is,
> start following both lines of history in your revision walking.
> Perhaps higher-level tools like =E2=80=98git log --graph=E2=80=99 and=
 gitk could
> visually represent the branched history you are showing.
>=20
> Another approach is to just choose one parent automatically: for
> example, prefer the first parent, or assign some score representing
> the relatedness of each parent and choose the most related one.

What I would like to see (and may be too much for a GSOC project) is th=
e=20
  result to be a simplified commit graph with additional annotations of=
=20
the line range mappings that could be fed into something like a modifie=
d=20
gitk to view the _history_ of the lines of interest.
