From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 12:49:21 +1000
Message-ID: <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>, david@lang.hm,
	Pau Garcia i Quiles <pg
X-From: git-owner@vger.kernel.org Thu Apr 28 04:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFHIG-0006lY-Ow
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 04:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab1D1CtX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 22:49:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62009 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab1D1CtW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 22:49:22 -0400
Received: by ewy4 with SMTP id 4so693814ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 19:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=NJ1hyX5ll1mrO6AVUwzkow9o356TGAU3/41AxaRTPTs=;
        b=vpdylbBLv549xI+BE8hjjwEHX91ltOF6hWpfpteMc1qqfHClBxpbCKqm85nk6KqrOx
         JDCY5P+645XgjwIv5y2a3cnOk4K/FZ93qkx1SDHevFiZLvfwcKsjf2GOc5YQVK9SuigX
         2g+66YGIKDD5S1DzSPl6smWJWEYQmZnVJy0p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ROjXUTyxu2GK4BDtvAKKo953LrpgXWhBYSAzEjnKMJfSVRlJhv25xWT6cSWqTa+NFX
         1Be70IE36fHlTdOAyDdvrZ4xcHY26OC1PVO1HD0/MFY6eTM3LyFem/Z+znLYlypaSDH4
         MI/vHBmuaQ3vGxJowxbDXNkPDtHEhYn5ccFYo=
Received: by 10.14.123.9 with SMTP id u9mr1279517eeh.53.1303958961595; Wed, 27
 Apr 2011 19:49:21 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 19:49:21 -0700 (PDT)
In-Reply-To: <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172312>

On Thu, Apr 28, 2011 at 12:15 PM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
> Then a command like:
>
> =C2=A0 =C2=A0git install gitwork
>
> would trivially work across all distributions precisely because the
> distribution has provided the implementation of the git install
> interface contract that git-core has helpfully mandated.
>

Or better yet, git-core could provide a trivial git install
implementation that selects between different distribution manager
supplied plugins selected according to some heuristic, allowing
several distribution managers to happily manage plugins in the same
git instance.

I have to ask.

Is such an architecture really "absolutely horrid"? Is it  "crap"? Real=
ly?

jon.
