From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to functions
Date: Fri, 29 Apr 2016 16:12:01 -0700
Message-ID: <CAGZ79kYy0TxmUAr-QdAw-KNqD0DyxfvdjB6Jkgg3bzRDTGWdrA@mail.gmail.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-5-git-send-email-dturner@twopensource.com>
	<xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
	<20160419071403.GA22577@sigill.intra.peff.net>
	<1461102001.5540.125.camel@twopensource.com>
	<20160419232243.GF18255@sigill.intra.peff.net>
	<1461109391.5540.138.camel@twopensource.com>
	<20160420011740.GA29839@sigill.intra.peff.net>
	<1461185215.5540.180.camel@twopensource.com>
	<20160420205726.GA17876@sigill.intra.peff.net>
	<1461602647.25914.2.camel@twopensource.com>
	<CAGZ79kYc+uMCJq5tTHujp1YYG5OcNSPiyWuGvVzipuBcwtLNYA@mail.gmail.com>
	<CAGZ79kYGi9bhRfGype7te4cGkxvnKww269kYoykB+76HNnTarg@mail.gmail.com>
	<1461971144.4123.38.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:12:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHZz-0007Lb-18
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbcD2XMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:12:05 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35020 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbcD2XMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:12:03 -0400
Received: by mail-io0-f177.google.com with SMTP id d62so122221256iof.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=mbuQR951ycu3vdkuX7Ml+Z4bLCBualJdCdR7HKUTB4o=;
        b=JUgzbjE3qZoIy7bzTWQuahiB+nyDtC6+3VuBgvOOd8YuoHs51WtMF/UIsDpaYxuqsy
         bgumqkzydm1p6esI/K+AIp1459B4Jc9e3H4s9DaCsEzqMDdoF4Rt+QysSjl5lJLq2heG
         LbGiZ+j3in6pZsT4RHkE62zXkoVE72dYyBeS79rq5Q+r0ifpzDGiStAgp5oWm3T1yCgE
         pYxluwbEYuV+VTqTqq8x9afLrhkoqdkp8uoiV69NHY7z7P7CCKMj2G50ALpt11J4DPU+
         lJIDpvkGvNH0F7/nm/oayf/BONQryyhZBbxE8roLDwkWOCBqArwln4FsahRp9p9PHbAb
         HDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mbuQR951ycu3vdkuX7Ml+Z4bLCBualJdCdR7HKUTB4o=;
        b=SrE3MVvIIIzc3FEaK6eRXhibrI1MWD3skggU307450xXDJXg+W60678l32wWzctM64
         Thq2hP0rTH/uo8OW96NQ4gVwV/PyygPxDBK0nl8CMCB1HyrSL+6I4YJvdVtr3bnWV/to
         4iDpyYqyB9+X+dnGejZHsIuiSc6BHlzaGnofpRkRxskCT4WwIT/Eie9/lQeop14R4NZ1
         CRoqyWhKwxx9KhWzYqbunoz3ZwYh1AQuIzdgy5rfqb4Fnm7BSe7VSM5WY/Hj5157ckuD
         lF7z9Ch1KPW3GsZu+vPw7U7ZQ/ZXlDJJ3aZOMl9nj7IOr1KotdhcymHLK3+C9zgECR3j
         LmqA==
X-Gm-Message-State: AOPr4FW5uLKK7I8CLbxwjKgKONt+hGadoaN32Fvsd2pBh/5PyqzMC3FInBHvti5hEenpj334jT8TWUNNVKPtCF/5
X-Received: by 10.107.161.68 with SMTP id k65mr30830989ioe.110.1461971522092;
 Fri, 29 Apr 2016 16:12:02 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 29 Apr 2016 16:12:01 -0700 (PDT)
In-Reply-To: <1461971144.4123.38.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293067>

On Fri, Apr 29, 2016 at 4:05 PM, David Turner <dturner@twopensource.com> wrote:
> On Tue, 2016-04-26 at 20:59 -0700, Stefan Beller wrote:
>> On Mon, Apr 25, 2016 at 3:10 PM, Stefan Beller <sbeller@google.com>
>> wrote:
>> > On Mon, Apr 25, 2016 at 9:44 AM, David Turner <
>> > dturner@twopensource.com> wrote:
>> > > On Wed, 2016-04-20 at 16:57 -0400, Jeff King wrote:
>> > > > On Wed, Apr 20, 2016 at 04:46:55PM -0400, David Turner wrote:
>> > > >
>> > > > > As you note, it appears that git-daemon does sort-of have
>> > > > > support
>> > > > > for
>> > > > > extra args -- see parse_host_arg.  So it wouldn't be hard to
>> > > > > add
>> > > > > something here. Unfortunately, current versions of git die on
>> > > > > unknown
>> > > > > args.  So this change would not be backwards-compatible.  We
>> > > > > could
>> > > > > put
>> > > > > a decider on it so that clients would only try it when
>> > > > > explicitly
>> > > > > enabled.  Or we could have clients try it with, and in the
>> > > > > event of
>> > > > > an
>> > > > > error, retry without.  Neither is ideal, but both are
>> > > > > possible.
>> > > >
>> > > > Right. This ends up being the same difficulty that the v2
>> > > > protocol
>> > > > encountered; how do you figure out what you can speak without
>> > > > resorting
>> > > > to expensive fallbacks, when do you flip the switch, do you
>> > > > remember
>> > > > the
>> > > > protocol you used last time with this server, etc.
>> > >
>> > > Right.
>> > >
>> > > [moved]
>> > > > > If I read this code correctly, git-over-ssh will pass through
>> > > > > arbitrary
>> > > > > arguments.  So this should be trivial.
>> > > >
>> > > > It does if you are ssh-ing to a real shell-level account on the
>> > > > server,
>> > > > but if you are using git-shell or some other wrapper to
>> > > > restrict
>> > > > clients
>> > > > from running arbitrary commands, it will likely reject it.
>> > >
>> > > Oh, I see how I was mis-reading shell.c.  Oops.
>> > > [/moved]
>> > >
>> > >
>> > > > Which isn't to say it's necessarily a bad thing. Maybe the path
>> > > > forward
>> > > > instead of v2 is to shoe-horn this data into the pre-protocol
>> > > > conversation, and go from there. The protocol accepts that
>> > > > "somehow"
>> > > > it
>> > > > got some extra data from the transport layer, and acts on its
>> > > > uniformly.
>> > >
>> > > OK, so it seems like only HTTP (and non-git-shell-git://) allow
>> > > backwar
>> > > ds-compatible optional pre-protocol messages.  So we don't have
>> > > good
>> > > options; we only have bad ones.  We have to decide which
>> > > particular
>> > > kind of badness we're willing to accept, and to what degree we
>> > > care
>> > > about extensibility.  As I see it, the badness options are (in no
>> > > particular order):
>> > >
>> > > 1. Nothing changes.
>> > > 2. HTTP grows more extensions; other protocols stagnate.
>> > > 3. HTTP grows extensions; other protocols get extensions but:
>> > >    a. only use them on explicit client configuration or
>> > >    b. try/fail/remember per-remote
>> > > 4. A backwards-incompatible protocol v2 is introduced, which
>> > >    hits alternate endpoints (with the same a/b as above).  This
>> > > is
>> > >    different from 3. in that protocol v2 is explicitly designed
>> > > around
>> > >    a capabilities negotiation phase rather than unilateral client
>> > > -side
>> > >    decisions.
>> > > 5. Think of another way to make fetch performant with many refs,
>> > > and
>> > >     defer the extension decision.
>> >
>> > I'd prefer 2,3,4 over 1,5.
>> >
>> > Speaking about 2,3,4:
>> >
>> > Maybe we can do a mix of 2 and 4:
>> >
>> >    1) HTTP grows more extensions; other protocols stagnate for now.
>> >    2) Come up with a backwards-incompatible protocol v2, foccussed
>> > on
>> >        capabilities negotiation phase, hitting alternative end
>> > points
>> >        (non http only, or rather a subset of protocols only)
>> >     3) if HTTP sees the benefits of the native protocol v2, we may
>> > switch
>> >         HTTP, too
>> >
>> > (in time order of execution. Each point is decoupled from the
>> > others and may
>> > be done by different people at different times.)
>> >
>>
>> Today I rebased protocol-v2[1] and it was fewer conflicts than
>> expected.
>> I am surprised by myself that there is even a test case for v2
>> already,
>> so I think it is more progressed that I had in mind. Maybe we can do
>> 1)
>> for now and hope that the non http catches up eventually?
>>
>>
>> [1] https://github.com/stefanbeller/git/tree/protocol-v2
>
>
> Do you plan to send these patches to the mailing list?  What's the next
> step here?

I can send them out if you want to. As I flip flop between
"they are perfect" and "they are horrible, nobody should see them",
I haven't done it so far (also time constraints).

Will send them later today, in case it's urgent you can fetch them from
my github account.

What's the next step?
I don't know. I guess we can either collaborate on a large
series (do-it-all) or rather work on many smaller series'
that solve it partially one by one.

I'll send the patches out later today.

Thanks,
Stefan
