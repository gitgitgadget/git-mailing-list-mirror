From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Tue, 25 Aug 2015 16:12:54 -0400
Message-ID: <CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Gabor Bernat <bernat@primeranks.net>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUKaZ-0005yv-SN
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 22:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbbHYUM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 16:12:56 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34126 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbbHYUMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 16:12:54 -0400
Received: by igui7 with SMTP id i7so20979108igu.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0XHFjxTLMDickoxKh5Z8YtLmEW2+y5jHQrV3SEo4acg=;
        b=cPB0aGG8xunHqx5kDqM7wkfkfW8oQGkRs545OuSBNQCRW1mDYBwvPYX6dSAo7RvqQD
         LHU99kBTiAxbKkvBM4syN2XsprObeg7rQ3dtr7BoHnELte7Zr6LUxhXevE3IIEISLkNk
         zOOk4TAMF79gI+Wc8NuEAuQJpdsaKsy6pzaHMRnrzU0h8mVUnORqssUFndDY007X20R6
         NPFASXDHaBV3lwTN1kQftSnYgRzX41+NRTvrmAFUt3gQ08sgGCUWkaFEloY6mot2w5Aa
         jl4b8uaec58lGCZJEAukSOJ6Qr48STRISO2rFPKNMYRUFz/0ddBESviFNg19NZpgTnA/
         8T2w==
X-Received: by 10.50.78.161 with SMTP id c1mr5962710igx.35.1440533574243; Tue,
 25 Aug 2015 13:12:54 -0700 (PDT)
Received: by 10.79.107.196 with HTTP; Tue, 25 Aug 2015 13:12:54 -0700 (PDT)
In-Reply-To: <20150825185414.GA10895@sigill.intra.peff.net>
X-Google-Sender-Auth: d6EzJDlIsXtwc4-DhMv7lo_Qdtk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276568>

On Tue, Aug 25, 2015 at 2:54 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 25, 2015 at 02:52:10PM -0400, Jeff King wrote:
>
>> Yeah, that would probably be a good solution, assuming there is a
>> portable "how many seconds" (I do not relish the thought of
>> reconstructing it based on the current hours/minutes/seconds).
>
> A little googling came up with:
>
>     awk 'END { print systime() }' </dev/null
>
> which probably (?) works everywhere.

On Mac OS X and FreeBSD:

    $ awk 'END { print systime() }' </dev/null
    awk: calling undefined function systime
    source line number 1
    $
