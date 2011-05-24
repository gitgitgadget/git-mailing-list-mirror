From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: combined diff does not detect binary files and ignores -diff attribute
Date: Tue, 24 May 2011 10:40:34 -0400
Message-ID: <BANLkTikxcnR_f6UEATfKTDZcq51Cv8V0TQ@mail.gmail.com>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
	<4DDA618E.4030604@drmicha.warpmail.net>
	<BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
	<20110523181147.GA26035@sigill.intra.peff.net>
	<20110523201529.GA6281@sigill.intra.peff.net>
	<BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
	<20110523234131.GB10488@sigill.intra.peff.net>
	<7v39k4aeos.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 16:40:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOsmx-0005Qf-Ea
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 16:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795Ab1EXOkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 10:40:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57796 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704Ab1EXOkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 10:40:35 -0400
Received: by pvg12 with SMTP id 12so3002754pvg.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1zSXm1zCXVvSuMOtyNGE3A97eUtKy4QjD5K+EyOER3o=;
        b=ZZfsB0nP41EVOVbcevibeYYsxoM2GU9gUN0kJ9lJIape9XwPzMqlWBff4gvBsatDrJ
         CnYppZ5yjX2TkmZUnWV0V36Y+Fb3omzBWrgS5MgcqJZN/rkbqHUuIL0hlLlS29R5xV+R
         CGQGx9ZQ7fskfqXZG7BVZEx84T7gid517SvMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=M0PIWDtuzEn6cXspgohjbBncaqb0ZPdKFOZ10OJ/cl2JzyCWXxq6WyRxMygsJFatj7
         QjWYNrZQaWNr7slbP8/s7OXlrug7Qhoc8eZspiWxA4J+2XFDoK6eg6YkHjedSBvhvcTr
         gnxzA56VhuMSK/FKaG2iKAp3spPu+WwE3NccI=
Received: by 10.142.107.12 with SMTP id f12mr1179497wfc.226.1306248034912;
 Tue, 24 May 2011 07:40:34 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Tue, 24 May 2011 07:40:34 -0700 (PDT)
In-Reply-To: <7v39k4aeos.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174318>

On Tue, May 24, 2011 at 12:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>>> However, custom diff drivers (still) don't work. :-)
>>
>> Yeah, I didn't add any support for that. I'm not sure what it should do;
>> custom diff drivers don't know how to handle combined diff, do they?
>>
>> If you write me a test case that explains what _should_ happen, I'll see
>> what I can do. :)
>
> I do not think it is sensible to expect anybody to come up with a sane
> semantics for combined diff to work with GIT_EXTERNAL_DIFF (and external
> diff driver that can be specified via the attributes mechanism) in any
> meaningful way.

Indeed, it was a thinko that I even considered it. It turns out I had
been using an external diff command where I should have been using
textconv all along.

j.
