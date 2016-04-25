From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to functions
Date: Mon, 25 Apr 2016 15:10:37 -0700
Message-ID: <CAGZ79kYc+uMCJq5tTHujp1YYG5OcNSPiyWuGvVzipuBcwtLNYA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:10:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoiJ-0005WL-Px
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 00:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbcDYWKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 18:10:40 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36937 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965020AbcDYWKj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 18:10:39 -0400
Received: by mail-ig0-f176.google.com with SMTP id g8so87450491igr.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4AhngTT6Ej7H+bqf9M/5/EAF4PgtX23bHYk0dW88pBk=;
        b=fHvA51iw0Hy6pTYgE0cXMuI8L/NbnEi0acjyFu4Up0sGA9Bd782a/Mth1+SpE8MA3d
         V0sg7PECi0A8yofHam0g4UMyQMDrXFYBazhIQ/aU5rJCGSHjFNaGHgEzrB6qCuGTy+5M
         BjchQtvlWqPMIiR16AyFTDuYX29QpSRViriy7T+I1j4CprmRiJZ2DV9NpBm8d3uGyE8a
         ULy0CGBPiriwhv7oXIO2kD1qyv0Ba4X+wRf/DtIBwPUbuTsxnLzwC9ueWpmL5kQScKgx
         PoMQi0tvflTkZSQQlDi+Vgu3R44hxuRZh8SUnI+UXn1W7s/vI4dOAMzQVccj6lfYk6Xq
         TZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4AhngTT6Ej7H+bqf9M/5/EAF4PgtX23bHYk0dW88pBk=;
        b=RYpsL9ab6Fu9RcxZ2LRgpb6NGGSI6PboVq6hfVcrUJ6ibUZEvwPzpSfqsIzqj0yzhY
         zco0xejbP+LJRO6RaJsYeVGnZ7glKG43H+z8z0TZ+Hec28tig77c9chIoI16jt5bFTzV
         phla8d5BK/2+80icrbzBAmToRcGpBDRMQ2f3HBJlmmkWHqUaqWtxorO6aYiH2edpU6Zh
         2q4HgColToPzC+i4CQ1TEmIKRT15hBrx/Bs/xUbe683IveVm4EdcOmGjPsqvbca949Pe
         Q8yEeLaWC68Ja7Z9H5S1CSt3fnyAX2pYVWhYRH+egSUjI/rFN754OJHP1FFB8G9q2iL0
         dBLQ==
X-Gm-Message-State: AOPr4FWwNtqRmXDgxISrJsgIbDMnWT5e2IVYkJQ5UaWu49vwkncZWmL/TTjNyz6L2DKH5NSWH4SNbH7U/5WJWufW
X-Received: by 10.50.111.15 with SMTP id ie15mr15944122igb.94.1461622237973;
 Mon, 25 Apr 2016 15:10:37 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 15:10:37 -0700 (PDT)
In-Reply-To: <1461602647.25914.2.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292576>

On Mon, Apr 25, 2016 at 9:44 AM, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2016-04-20 at 16:57 -0400, Jeff King wrote:
>> On Wed, Apr 20, 2016 at 04:46:55PM -0400, David Turner wrote:
>>
>> > As you note, it appears that git-daemon does sort-of have support
>> > for
>> > extra args -- see parse_host_arg.  So it wouldn't be hard to add
>> > something here. Unfortunately, current versions of git die on
>> > unknown
>> > args.  So this change would not be backwards-compatible.  We could
>> > put
>> > a decider on it so that clients would only try it when explicitly
>> > enabled.  Or we could have clients try it with, and in the event of
>> > an
>> > error, retry without.  Neither is ideal, but both are possible.
>>
>> Right. This ends up being the same difficulty that the v2 protocol
>> encountered; how do you figure out what you can speak without
>> resorting
>> to expensive fallbacks, when do you flip the switch, do you remember
>> the
>> protocol you used last time with this server, etc.
>
> Right.
>
> [moved]
>> > If I read this code correctly, git-over-ssh will pass through
>> > arbitrary
>> > arguments.  So this should be trivial.
>>
>> It does if you are ssh-ing to a real shell-level account on the
>> server,
>> but if you are using git-shell or some other wrapper to restrict
>> clients
>> from running arbitrary commands, it will likely reject it.
>
> Oh, I see how I was mis-reading shell.c.  Oops.
> [/moved]
>
>
>> Which isn't to say it's necessarily a bad thing. Maybe the path
>> forward
>> instead of v2 is to shoe-horn this data into the pre-protocol
>> conversation, and go from there. The protocol accepts that "somehow"
>> it
>> got some extra data from the transport layer, and acts on its
>> uniformly.
>
> OK, so it seems like only HTTP (and non-git-shell-git://) allow backwar
> ds-compatible optional pre-protocol messages.  So we don't have good
> options; we only have bad ones.  We have to decide which particular
> kind of badness we're willing to accept, and to what degree we care
> about extensibility.  As I see it, the badness options are (in no
> particular order):
>
> 1. Nothing changes.
> 2. HTTP grows more extensions; other protocols stagnate.
> 3. HTTP grows extensions; other protocols get extensions but:
>    a. only use them on explicit client configuration or
>    b. try/fail/remember per-remote
> 4. A backwards-incompatible protocol v2 is introduced, which
>    hits alternate endpoints (with the same a/b as above).  This is
>    different from 3. in that protocol v2 is explicitly designed around
>    a capabilities negotiation phase rather than unilateral client-side
>    decisions.
> 5. Think of another way to make fetch performant with many refs, and
>     defer the extension decision.

I'd prefer 2,3,4 over 1,5.

Speaking about 2,3,4:

Maybe we can do a mix of 2 and 4:

   1) HTTP grows more extensions; other protocols stagnate for now.
   2) Come up with a backwards-incompatible protocol v2, foccussed on
       capabilities negotiation phase, hitting alternative end points
       (non http only, or rather a subset of protocols only)
    3) if HTTP sees the benefits of the native protocol v2, we may switch
        HTTP, too

(in time order of execution. Each point is decoupled from the others and may
be done by different people at different times.)


>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
