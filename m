From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Sun, 10 Apr 2016 17:51:06 -0400
Message-ID: <CAPig+cQzGmohkyshwi+yhQHPT_VVb2fr52OK_1Axw4Q2vLxRHw@mail.gmail.com>
References: <570965B9.9040207@jupiterrise.com>
	<20160409210429.GB18989@sigill.intra.peff.net>
	<57098259.1060608@jupiterrise.com>
	<20160409223738.GA1738@sigill.intra.peff.net>
	<xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
	<xmqq37qtthit.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 23:51:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apNGF-0006gb-QT
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 23:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbcDJVvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 17:51:08 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:32845 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbcDJVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 17:51:07 -0400
Received: by mail-io0-f179.google.com with SMTP id o126so165240783iod.0
        for <git@vger.kernel.org>; Sun, 10 Apr 2016 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=yVm6bJ4Ul9iNHqYbZNkQWqf0xBzVS6DrjqF8DJZmIvs=;
        b=lXrZiHAEr3pEqQy4+n3tAZtCBO8AEf1bOmBsz3M+i57u47cb2BMZt3opDddKZO/ZYX
         +aeuEgaHWu632DJYvorYw3yFAZakleKYnAed7VjZtulgp16YkF2lxiLthMDBUpZ8r+RA
         L6Ktc5qRCk/DdKMxFKokqYhtMB5oo4KP/jJ8S70LHbd/wK6+vH5kjMxUjfuVkZi2m+3W
         O8Balmw7KyJxqrR+YBcuR8nbkUkbql7GfcXHSq3aSKrEBjIahQIsRbBopQmLJO3R2JID
         aEZB3QdgsFBHuWnYFKKmltkQw/JAcVQbeAprxyQmaeWyq3tK4HNePmGDW34kFHz1oHVD
         EBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=yVm6bJ4Ul9iNHqYbZNkQWqf0xBzVS6DrjqF8DJZmIvs=;
        b=ecHLkSPQEaBpnsvA1VHpRaL6kuxO5A60N9fm/eJLyby43Yloe9LW6SvZVjMgDBk6zd
         pQMFSXzCGavXurnOk1bI6PkvSrqU2XIyYogXMxiCenfyRlJCsT2J1uWIC2m0lEqR5T3h
         G401tvcBTgiICRO/xf8JnnrIeIidxSyJIw937JuWDm2APi3pPKZGfGuCgmPBOgwPiSM1
         dAZeNFGHwJvIm1sXIU8+kPD4mO3ek79HVt12kffIVlu+GpVf2urVEW8F+nXAceqU0JuI
         nIJTH75sVgoQEz6ilOwJtSEeBowdXXsKl67KSZWnT5yt8kGZnpnLCGFVEPzIBJwuUzIs
         l/vQ==
X-Gm-Message-State: AD7BkJIR4WGDtbZVCYuWRcUb4KGjsjSQfNbcr8z2Am5wBKTtSxkj7TDNmGLCzunTPLOSoY4VsPA1vVNrNtWF5A==
X-Received: by 10.107.9.28 with SMTP id j28mr20297377ioi.104.1460325066125;
 Sun, 10 Apr 2016 14:51:06 -0700 (PDT)
Received: by 10.79.139.2 with HTTP; Sun, 10 Apr 2016 14:51:06 -0700 (PDT)
In-Reply-To: <xmqq37qtthit.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: YhrqGAZ11yEofKDWuNoyM9ZEdxE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291189>

On Sun, Apr 10, 2016 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: t1020: do not overuse printf and use write_script
>
> The test prepares a sample file "dir/two" with a single incomplete
> line in it with "printf", and also prepares a small helper script
> "diff" to create a file with a single incomplete line in it, again
> with "printf".  The output from the latter is compared with an
> expected output, again prepared with "printf" hance lacking the

s/hance/hence/

> final LF.  There is no reason for this test to be using files with
> an incomplete line at the end, and these look more like a mistake
> of not using
>
>         printf "%s\n" "string to be written"
>
> and using
>
>         printf "string to be written"
>
> Depending on what would be in $GIT_PREFIX, using the latter form
> could be a bug waiting to happen.  Correct them.
>
> Also, the test uses hardcoded #!/bin/sh to create a small helper
> script.  For a small task like what the generated script does, it
> does not matter too much in that what appears as /bin/sh would not
> be _so_ broken, but while we are at it, use write_script instead,
> which happens to make the result easier to read by reducing need
> of one level of quoting.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
