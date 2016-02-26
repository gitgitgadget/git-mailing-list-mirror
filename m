From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 3/3] git: submodule honor -c credential.* from command line
Date: Fri, 26 Feb 2016 14:20:34 -0800
Message-ID: <CA+P7+xqSZGAJD7ryvx2A2qM1wd0rKMmjT2tcBPann33sUUHGcA@mail.gmail.com>
References: <1456514328-10153-1-git-send-email-jacob.e.keller@intel.com>
 <1456514328-10153-3-git-send-email-jacob.e.keller@intel.com> <20160226220553.GA1835@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:21:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZQli-0000UT-TK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 23:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945946AbcBZWVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 17:21:03 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33501 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945934AbcBZWVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 17:21:00 -0500
Received: by mail-ig0-f180.google.com with SMTP id y8so47584232igp.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1ZVdyEN/cvuxLXfwdQQ6b35/fwic39zvqEyzjk4YJwE=;
        b=NkDQc66lExD62g9SJSgZWOsey9ocw9PMfcqZv179UuJ+W2k0EiyrqrIW5OIp1BI4L9
         zIPhI55poJiCsz729Cy+JZ/cG7zCjE1G7cBw0SSPojRagFcCAAML9Ziu779SnHH0VKzo
         CSMQoHB/T84V9KtrLYSwLbzRZ4Zv4Dt+X2tMpE+Vh1kc1GpnRG3+HmigKo68f1oXdJ2q
         jh+UB2VEMx/jrQrrIKVWptDtSqxSnSBH2rYeuT/kYqpF+sTcH+wbrA8RSxpMVuqbgdKW
         6ky5NgiNHUuCHuoVBqXJAo/heWgUsPXq4Vb08Hq4PnSwe2Zr8wy8/nGv1+ERTVUcV+uq
         kyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1ZVdyEN/cvuxLXfwdQQ6b35/fwic39zvqEyzjk4YJwE=;
        b=MzVxUCjL3+gnJkrQjzmmfutBtphQ75KaZsP3ndIKIMhJ+1IGxATZgiPm7rb+pHQ+dH
         RNctMLC8ed02JoAdP1qRCPFIVByj86QWgm8f0b05halBV2sgk/n5V1xrvC4ODw2wSSZG
         USvTzBGfXnBZKCSKAEydNZll9YzvdKcyKygj23HlElfDTivFA2aEz9rVYrTURbLkxlP/
         PVKT9Cab9Zvsxbuk65nK/RT9fW8YfxwKvnDHqNDxLtblwLpNkgSgY8XFcUjwmVhiO4lI
         qTxr/vXKbv98fYKouFlU8qb8DvCGRTU3mfeMpRKPzF1+b089//t08u8EuMMdr8km/PFG
         D1mQ==
X-Gm-Message-State: AD7BkJIuYZKsam3tkuJxqp2WBwnFhdLKy9eiZZCh0XsbqR1PUJfn7o5wVQHh4pi9nMvAu8SACobB1XeqwS6Bqw==
X-Received: by 10.50.137.35 with SMTP id qf3mr256699igb.92.1456525254270; Fri,
 26 Feb 2016 14:20:54 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 26 Feb 2016 14:20:34 -0800 (PST)
In-Reply-To: <20160226220553.GA1835@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287628>

On Fri, Feb 26, 2016 at 2:05 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 26, 2016 at 11:18:48AM -0800, Jacob Keller wrote:
>
>> +test_expect_success 'sanitize-config keeps credential.helper' "
>> +     git -c credential.helper=helper submodule--helper sanitize-config >actual &&
>> +     cat >expect <<-EOF &&
>> +     'credential.helper=helper'
>> +     EOF
>> +     test_cmp expect actual
>> +"
>
> This can (and should) be "<<-\EOF", right?
>

Yes, I actually meant <<-\EOF but forgot while writing it.

> I happened to be writing a test with the exact same problem (embedded
> single-quotes) today, and realized we have another solution which is
> used elsewhere in the test suite:
>
>   sq="'"
>   test_expect_success '...' '
>         echo "${sq}credential.helper=helper${sq}" >expect &&
>         ...
>   '
>
> that is slightly more verbose, but it does let us keep the main body
> inside single-quotes, without restoring to confusing backslash escaping.
>

I think I prefer the double quotes myself but will use this if people prefer?

> -Peff
