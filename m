From: demerphq <demerphq@gmail.com>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 22:48:51 +0100
Message-ID: <9b18b3110903191448x4cd62306idae9ce70630a389d@mail.gmail.com>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net>
	 <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com>
	 <49C24D9B.1060301@drmicha.warpmail.net>
	 <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>
	 <20090319151610.GO23521@spearce.org>
	 <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com>
	 <20090319201405.GD17028@coredump.intra.peff.net>
	 <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com>
	 <20090319214317.GU23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:50:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQ8J-0006jY-19
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758751AbZCSVsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 17:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758603AbZCSVsy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:48:54 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:28366 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758293AbZCSVsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 17:48:53 -0400
Received: by an-out-0708.google.com with SMTP id d14so566028and.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7Rhw0yE+pLRvJpQNZWIS4Ic5JdlGR8/xj1C5gNSmXu0=;
        b=ejnKVJSb2j+U3PWspZ/W2pvY4XIRjl4F3Ok/9I0EMSmv0jT3SN9+LYY0P9g3DgKt98
         hrV10lv5W/H9YZXG/w9dbzbu7y1MF5pSHrBfukzHQYfBYo9fX4UguwrhnQshbTa3p2pl
         qACykbwKmlu9Bv6aLsHNda1EpzJ65Z5xyGFuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=APBIqQYi/hds+GUkuTsaNgZMnsdQRG3AAB3oifoBltiBxAOy6rkNlNoY6PR730PwAW
         IVNJdzNSb1IRMUjDGxFUU0SW9pq5HRDODslAa2X5QiZ9rbh1Nr1rcOJDrEgFgKuFFZll
         CQS7Zc90LlDEfjHS9K7CwK2OB+/2NLjKLuTaU=
Received: by 10.231.15.74 with SMTP id j10mr957530iba.48.1237499331095; Thu, 
	19 Mar 2009 14:48:51 -0700 (PDT)
In-Reply-To: <20090319214317.GU23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113837>

2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> demerphq <demerphq@gmail.com> wrote:
>> Outside of parsing the reflog directly, (which feels wrong and dirty
>> to me), how does one find out the times that a reflog entry was
>> created?
>>
>> The closest thing i could find was git log -g, but that shows the ti=
me
>
> =A0git reflog -g branch@{now}
>
> the @{now} suffix is the magic to make it show the time.

Ah cool. Its not documented but that at least would have sorted my
immediate needs.

But for a logging tool it would be nice to get something like:

2009-03-19 21:46 > de9b652... HEAD@{0}: commit: pod/perlreftut.pod:
keep example in tune with the times
2009-03-19 21:44 > 53102b2... HEAD@{1}: HEAD^: updating HEAD
2009-03-19 21:40 > a9a8f59... HEAD@{2}: commit: must stay contemporary

instead of:

$ git reflog -g HEAD@{now}
de9b652... HEAD@{57 minutes ago}: commit: pod/perlreftut.pod: keep
example in tune with the times
53102b2... HEAD@{61 minutes ago}: HEAD^: updating HEAD
a9a8f59... HEAD@{61 minutes ago}: commit: must stay contemporary

But thanks a lot for the info. I take this is documented in a newer
release than i currently have?

Yves





--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
