From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] revert: make commit subjects in insn sheet optional
Date: Fri, 9 Dec 2011 13:35:28 -0600
Message-ID: <20111209193527.GD20913@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-3-git-send-email-artagnon@gmail.com>
 <20111207070223.GC11737@elie.hsd1.il.comcast.net>
 <CALkWK0nkPB5WptJ9nSkSOif5_0R_f39Dg_HR3Rmg02hG_4Q1Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:35:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6EM-0007e8-S6
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab1LITfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 14:35:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46603 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540Ab1LITfc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 14:35:32 -0500
Received: by yenm11 with SMTP id m11so2362016yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g4VAhB9NLh3Zk3KhYN/KTGQop9OuX1kEBMCmjDuLyr0=;
        b=rGdXNshH+VfxM5HbWB6RstM9Bmxx47WdmJycs9Dg8CnfehVfxtIEDvixkM3hNQXNXy
         GP6ETAADKSKUAypcPxSsakX8cdC8KshudIhxXZHTg2/6p+T5f81UQnGGL21qwU+Wkos3
         E032aDNkYh4L/cs6HHFwdpYn96Wd+CFyDkpF0=
Received: by 10.236.73.166 with SMTP id v26mr14258181yhd.100.1323459331872;
        Fri, 09 Dec 2011 11:35:31 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 11sm15521884anp.13.2011.12.09.11.35.30
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 11:35:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0nkPB5WptJ9nSkSOif5_0R_f39Dg_HR3Rmg02hG_4Q1Tg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186670>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:
>> Ramkumar Ramachandra wrote:

>>> [...]
>>> While at it, also fix a bug: currently, we use a commit-id-shaped
>>> buffer to store the word after "pick" in '.git/sequencer/todo'. =C2=
=A0This
>>> is both wasteful and wrong because it places an artificial limit on
>>> the line length. =C2=A0Eliminate the need for the buffer altogether=
, and
>>> add a test demonstrating this.
>>
>> Reading the above does not make it at all obvious that I should want
>> to apply this patch because otherwise my prankster friend can cause =
my
>> copy of git to crash or run arbitrary code by putting a long commit
>
> Working backwards:
> get_sha1() is what will finally misbehave: how?

Not sure what you're talking about.  I was saying that any commit that
goes from "git can segfault in such-and-such circumstance" to "git no
longer segfaults in that circumstance" should loudly proclaim so!
Otherwise, when my script is causing git to segfault, I will not know
which commits to point my risk-averse sysadmin to when advocating
upgrading our copy of git.
