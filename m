From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from Windows 
	Explorer
Date: Mon, 28 Sep 2009 11:36:54 +0100
Message-ID: <2faad3050909280336r61e11b20nb52629a8fe95b0c0@mail.gmail.com>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org>
	 <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com>
	 <20090925225940.GB14660@spearce.org>
	 <bdca99240909251658q395a62b6r8d5998382ac3fc7b@mail.gmail.com>
	 <20090926000500.GE14660@spearce.org>
	 <bdca99240909260245i6ba10dd4j1b2ee9e74ea5282d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	mstormo@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 12:43:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsDhG-0000y6-4N
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 12:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbZI1Kgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2009 06:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZI1Kgw
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 06:36:52 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:55632 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZI1Kgv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Sep 2009 06:36:51 -0400
Received: by ewy7 with SMTP id 7so4285699ewy.17
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JNOotdpxG9AqMpYpWit9Bl1nzuTWbStZVYCAKQe8ppY=;
        b=ePV3ES0ZwnIq17Vhfj+hdBkOlat5gYVHwub9fFZsaF1ddYQGn5cIujyyzPLdir08zy
         ursMeCCh2ZnM7gUWUESW5GV94vaIVNcZZkNa7o65U6a9pzCQ+03I5H6dYl+JgqA4RSWd
         6Xz+WydJv7D0WUKKB4icjShELj/J3ccmM7eJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ozvV8gpCqiJA9vqfs1fI7u1wQa9Cr1f4ikmetIK6dbUer6Ae+2eiK6M4t/N/m4nLjw
         QcsEW7sI6N5DW2Q8MKMLS7m9kRXbY/Gr/byZYGKQiV5Dog2XRlA9YvmEciLrvDJ13lQe
         VDwCH2z2ip32dkrZycBWwehYcXmcW0+vUzq7I=
Received: by 10.216.72.19 with SMTP id s19mr725807wed.45.1254134214187; Mon, 
	28 Sep 2009 03:36:54 -0700 (PDT)
In-Reply-To: <bdca99240909260245i6ba10dd4j1b2ee9e74ea5282d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129246>

2009/9/26 Sebastian Schuberth <sschuberth@gmail.com>:
> On Sat, Sep 26, 2009 at 02:05, Shawn O. Pearce <spearce@spearce.org> =
wrote:
>
>> Odd. =C2=A0If I copy and paste from Thunderbird, its fine. =C2=A0But=
 if I
>> save the body out as an attachment from mutt, it fails.
>>
>> I wonder if it has to do with the From header appearing in the top
>> of the body; this header has to be escaped with a leading space in
>> mbox format. =C2=A0It looks like Thunderbird might be doing some mag=
ic to
>> remove that leading space from the context lines, while mutt isn't.

=46YI: the Thunderbird version included this header:
Content-Type:  text/plain; charset=3DISO-8859-1; format=3Dflowed

The format=3Dflowed part shows that Thunderbird is reformatting
whitespace. You can disable that:
http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_pl=
ain_email

'flowed' is a lossy transformation of text, so git won't attempt to
fix patches that have  been mangled that way. There's a longer
explanation from Junio here:
http://kerneltrap.org/mailarchive/git/2008/2/15/867294

Hope this helps,
Baz

>>
>> Next time, don't include the first From line?
>
> Will try. So what about these two patches? Should I re-send them with
> the first "From" stripped?
>
> Or will *.patch files that are attached to emails, instead of sending
> the patch inline, be accepted?
>
> --
> Sebastian Schuberth
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
