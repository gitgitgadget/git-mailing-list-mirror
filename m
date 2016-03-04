From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t9700: fix test for perl older than 5.14
Date: Fri, 4 Mar 2016 21:12:23 +0100
Message-ID: <CAP8UFD2Jh4NAaJ-1DPSUB5A00XqQNNhEq34oDP-Nqo0W2zKVhg@mail.gmail.com>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
	<20160304085649.GA29752@sigill.intra.peff.net>
	<1457089104.2660.79.camel@kaarsemaker.net>
	<20160304114321.GA569@sigill.intra.peff.net>
	<1457094068.2660.85.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 21:12:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abw5O-0006GV-5C
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 21:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759087AbcCDUMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 15:12:25 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36654 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbcCDUMY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 15:12:24 -0500
Received: by mail-lb0-f174.google.com with SMTP id x1so73539091lbj.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iANsmYPUXhUzzqTPFrZkcqJ6nrsdvs1sY3BmAWc5rwE=;
        b=DXXQf2KhVhgBm0lpbMM6Tf5D9eIH1k2wd5anNCc+gkcXYkajjULKqlsXxT+prYlfas
         U7OYvtiTAwTY9bI2BI5B8qQ/fMg0hm1VABRCcu/J1OhFSoZe0T0AwtW0Xk5gTysuGcRS
         eMAWiArlCBbZhpF9WWSCnAlM0Ase12WYk8kOOryfw/TNXncEOmNo59RR8S6g1j8je449
         XIOIK2DboG+N7VC3ZrItIHm0KWdU9iJn9f8I78BeqA9YA0DySEfsrrr3YdIvGm40vaUO
         xxiJh9rH2/q/MPr5UIg2Ju8ggEIqOIDHjfBja5VGH+az2+aEmbSRKC3uo4fRK1CkPdPn
         VGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iANsmYPUXhUzzqTPFrZkcqJ6nrsdvs1sY3BmAWc5rwE=;
        b=E86y7tlzvYCXyH9Li96cfCc5OWSQnSs3CpAUMEgLly1QeONwN3wJ/GHzK1N6aoZLHo
         ciQFZskbuGBdt1GKShqxBYVxp9doirLhHsbnmrcY/OLaBNdnDS8k8xwYuglr871sZGP6
         TcyEDt+N8re8saKIqCGiJYZTcOx3oygNccgxRD2iSLgu3G48+ct7Fc6fQNqGK5Fzgxri
         Qo71iZXNo8Y3liQvR2inO/f0WrRlKoBvnyaOZctyGrBEVmovs/79TmzQdEEc/0RXp7rV
         L/xHg/K03TLXTHklCNiXdX923osgsRiXGwJzseOpNA1xSobI1Zv9ZYBuHUAYtkuypUCQ
         TiKQ==
X-Gm-Message-State: AD7BkJKW3SHxMZ+1jpmSYE3hCcQ1NSI7kgqeosK3UUrKrg58UuC5DMuVsgzsgPbioIYkzLyh842SCz3emUxAwA==
X-Received: by 10.25.26.83 with SMTP id a80mr3737423lfa.36.1457122343139; Fri,
 04 Mar 2016 12:12:23 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Fri, 4 Mar 2016 12:12:23 -0800 (PST)
In-Reply-To: <1457094068.2660.85.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288274>

On Fri, Mar 4, 2016 at 1:21 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On vr, 2016-03-04 at 06:43 -0500, Jeff King wrote:
>> On Fri, Mar 04, 2016 at 11:58:24AM +0100, Dennis Kaarsemaker wrote:
>>
>> > On vr, 2016-03-04 at 03:56 -0500, Jeff King wrote:
>> > > ? Those are just guesses, but if we are tickling a bug in perl's parser,
>> > > this might avoid them. I also wondered when "/r" appeared. It was in
>> > > 5.14, so you're presumably good there. The "use" statement at the top of
>> > > the script says "5.008", so perhaps we should be writing it out longhand
>> > > anyway (that version is "only" 5 years old, so I suspect there are still
>> > > systems around with 5.12 or older).
>> >
>> > Knowing the system Christian is testing on, I think the problem is that
>> > the tests are actually being run against perl 5.10, which RHEL 6 ships
>> > as system perl. As that's still a supported OS, writing tests in a form
>> > compatible with it would be a good thing :)
>>
>> That would make sense. `perl` in t9700-perl-git.sh (and all of our
>> scripts) is actually a shell function:
>>
>>   perl () {
>>           command "$PERL_PATH" "$@"
>>   }
>>
>> to make sure we respect PERL_PATH everywhere. And that defaults in the
>> Makefile to /usr/bin/perl. Christian presumably has 5.14 in his $PATH,
>> but /usr/bin/perl is the system 5.10.
>
> Yeah, that's how our systems are set up.

Yeah, you are both right.

Thanks for debugging this,
Christian.
