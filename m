From: John Szakmeister <john@szakmeister.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sat, 7 May 2011 04:24:58 -0400
Message-ID: <BANLkTi=DreFEHWf0Ndd-3cAiaCtFgZHe2A@mail.gmail.com>
References: <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
	<4DB9329E.7000703@op5.se>
	<88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
	<7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506172334.GB16576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 07 10:25:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIcp1-0005Nc-J9
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 10:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab1EGIZC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2011 04:25:02 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61626 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab1EGIZA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2011 04:25:00 -0400
Received: by wya21 with SMTP id 21so2877093wya.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tHEOfpxN+8tsjXifjOJvwb8vspxAJQKIldc9DTfl4tM=;
        b=u/pE9JKRBDl6V9+8b1LqBRNKz5xjHhq1/tkO7pAuJ5kbj3MqMxhIlbzWT/p9yCl6uK
         K1kfMErWJHKdZgyH2GBC3AFFiIz7/HbvFljtOg1r6isG2Uvj0VslHW/FXuPdqitg2z2H
         kvyam8zGzKKxMlebUJHFTEFqGhNvg/jqDtW0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=rLCXtzaFNxL//x4ZyaZdRERMVeuXWwM1fzFqJjobx2CWydTUn5SS1/e8yZL3lPLQ8V
         aRT75tqvTL6zWWNiGvk8q8u+sOJp+isL3Zc98bY24m3AZU6yXh4ZiPVmHmutSPn5UgEk
         Rn9fN39NIqshFT6LyIj9Jf/STNXuosc8Z06ns=
Received: by 10.216.152.170 with SMTP id d42mr1590477wek.39.1304756698712;
 Sat, 07 May 2011 01:24:58 -0700 (PDT)
Received: by 10.216.86.204 with HTTP; Sat, 7 May 2011 01:24:58 -0700 (PDT)
In-Reply-To: <20110506172334.GB16576@sigill.intra.peff.net>
X-Google-Sender-Auth: qFJw8kcgS2WSRVssbC-dKu5u1ZI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173041>

On Fri, May 6, 2011 at 1:23 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 07, 2011 at 12:07:14AM +1000, Jon Seymour wrote:
>
>> I think the problem we are trying to solve is this: how to make it a=
s
>> easy as possible to install, and get operational, an extension to gi=
t.
>>
>> If git supported the concept of a standard place to put extensions,
>> then it could be as simple as:
>>
>> =C2=A0 =C2=A0 unzip -d $(git --plugins-dir) plugin.zip
>>
>> with no need to configure or choose a prefix and no need to edit the
>> an .profile or .bashrc to permanently add a directory to the PATH.
>
> This seems slightly backwards to me. You are asking git "where should
> plugins go?" and then putting them there. But that leaves no room for
> plugins going in _multiple_ places. IOW, the usual hierarchy of:
>
> =C2=A01. distribution-packaged extensions (in /usr/share/git/plugins)
>
> =C2=A02. local system-wide extensions (in /usr/local/share/git/plugin=
s)
>
> =C2=A03. per-user extensions (in $HOME/.gitplugins)

Exactly!  I'd really like to see (3) and stop cluttering up my
~/.local/bin folder with wrapper scripts.

-John
