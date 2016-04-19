From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to functions
Date: Tue, 19 Apr 2016 11:04:13 -0700
Message-ID: <CAGZ79kZOY9guHWYmxh+J4-BXzFCMWLFhF0sDS3Kau3oXqWsSxg@mail.gmail.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-5-git-send-email-dturner@twopensource.com>
	<xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
	<20160419071403.GA22577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:04:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asa0Y-0004Yo-P8
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbcDSSEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 14:04:15 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34340 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbcDSSEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 14:04:14 -0400
Received: by mail-io0-f182.google.com with SMTP id 2so27248477ioy.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=WucxX0qMQMnx//7wSttPnW4xxQamAwTLhqbnJXEUWmU=;
        b=HAJuCwdPol/SNi/AiFJ3b3/yKwqDJK83p7jWwerz/KqHiuaR/kqQfn/pHws8m0AV51
         1DLsFyqiIHB7h7sRWZIt/yUJaYdtMmdBb00BKIysjK9Z41TUVvzmeXqGQxpv32ccfdQm
         T9HSAFugwCGMMfiveT9x9h2yPwvzHKYq9qEb0wRQJoHPfSYPMDThy4ZYYJiTJvPEyOi7
         T1o5oYSIdqspnK8QcZeEA880jI5Q9viatYMs3Gle2YTXDdA4oH2C23dz3GeYO+bKx+ix
         ICqhE5OaoEERR9Ln/j9Sp4sxWuf/IVpJVGL5L6Mbj+0gjnYQ+vNJBG5t73WKgLmaL2NJ
         JTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WucxX0qMQMnx//7wSttPnW4xxQamAwTLhqbnJXEUWmU=;
        b=Xa/bEpPDwIR7QHdt3KHSyklaUHHCesrPEiQZCVOP6HBRrUTclzRXw9J+2nuwvVx4HA
         tQDdwHqW719hW4cZu3KvMWaBxTKLnVUoc7IGaPRXqnZwQMpI3yd6E0MuLk+fYQXY7/v3
         rrzzA/xs3qIAhhcB3dhT20S/HXzvliNJ/fqbzKa5CGZfQfFO/obCAgoO3VWbTF2yvNnb
         2hNhm4oWy+3yTuQf4AcFWuks+BUybO4P6EYj6ypxtFyzFKU5m5dTKus5xx2L1PLtqk1p
         fqP4m7AD5RB2PHbxt7t7zSSij0edAd1yZZoz1/B5EtF9apg9qvmmkn6CXjcdDsnvzpL1
         IrqA==
X-Gm-Message-State: AOPr4FXMiZsgRZZjgJUVfWk9JpNKIHvP28WI4ZK4y+syyCpZoN2XdQXRLQ7ib5ZIwhDzkr/GEuhETJSN2NcgAHfW
X-Received: by 10.107.184.8 with SMTP id i8mr5146108iof.96.1461089053471; Tue,
 19 Apr 2016 11:04:13 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 19 Apr 2016 11:04:13 -0700 (PDT)
In-Reply-To: <20160419071403.GA22577@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291895>

On Tue, Apr 19, 2016 at 12:14 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 18, 2016 at 11:45:54AM -0700, Junio C Hamano wrote:
>
>> David Turner <dturner@twopensource.com> writes:
>>
>> > Add parameters for a list of refspecs to transport_get_remote_refs and
>> > get_refs_list.  These parameters are presently unused -- soon, we will
>> > use them to implement fetches which only learn about a subset of refs.
>> >
>> > Signed-off-by: David Turner <dturner@twopensource.com>
>> > ---
>>
>> What the code tries to do I am more than halfway happy.  It is
>> unfortunate that we cannot do this natively without upgrading the
>> protocol in a fundamental way, but this is a nice way to work it
>> around only for Git-over-HTTP transport without having to break the
>> protocol.
>
> I dunno, I am a bit negative on bringing new features to Git-over-HTTP
> (which is already less efficient than the other protocols!) without any
> plan for supporting them in the other protocols.
>
> I thought Stefan's v2 protocol work looked quite good, but it seems to
> have stalled. The hardest part of that topic is figuring out the upgrade
> path. But for git-over-http, we can solve that in the same way that
> David is passing in the extra refspecs.

Yeah it stalled, though I hope to revive it eventually.

I was positive about these changes for that same reason: If http and native
protocol move apart even more, it will be easier to make the native only
v2 protocol without needing to fiddle with http, i.e. this series would reduce
scope of the v2 series drastically?

>
> So I'd rather see something like:
>
>   1. Support for v2 "capabilities only" initial negotiation, followed
>      by ref advertisement.

And the client needs to talk in between capabilities and ref advertisement.
Even if it is just a flush for now. That can be extended later to the actual
desired capabilities, but the server needs to at least wait for a client packet
in here.

Note that the server side for v2 capabilites only first is done, the client side
is missing as I found that to be the hard part.


>
>   2. Support for refspec-limiting capability.
>
>   3. HTTP-only option from client to trigger v2 on the server.
>
> That's still HTTP-specific, but it has a clear path for converging with
> the ssh and git protocols eventually, rather than having to support
> magic out-of-band capabilities forever.
>
> It does require an extra round of HTTP request/response, though.
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
