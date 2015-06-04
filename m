From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 00/11] Protocol version 2, again!
Date: Thu, 4 Jun 2015 09:44:49 -0700
Message-ID: <CAGZ79ka1qjspbbE4ZKHrys9TOmKbS30KA1PJkwzA47ptjxQfSA@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<20150527061818.GA885@peff.net>
	<20150527070838.GA6873@peff.net>
	<CAGZ79kZxFnkneixquUijd2yfKBh6+XnYiYzCh8L9Mkourh64Fw@mail.gmail.com>
	<20150604130902.GA12404@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 18:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0YGK-0005EJ-It
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 18:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbbFDQoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 12:44:54 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:36223 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbFDQov (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 12:44:51 -0400
Received: by qcxw10 with SMTP id w10so20054983qcx.3
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tkyR3dv84zQpS4ALkfA8A9llaINudjYHST4DDk3GFls=;
        b=ernRn5A36gsMq1+Cb8foFRQS+RDIOvBtSC/AzyBy4gVl4GqawD3AxF5NDjMlFw5OVT
         i7HyEYxpeef34CGmi8D1jmX6WsbeR3ha55xlMftjhv3AXnSu9tCynZ+pHbiDNIkk181j
         ySZ7P+HKbzYHznqBpFHfodz8KqZesYhnSnsmwc6XeB0WWJWpDoeKTKgfunPWFAsp2IME
         SNR3nM7ZCjMlMfb5xEEc7uDJo0j2m0qc8TvUJWR6Nl7uQwsnWaGV9kIFBN6E5AfQ++yB
         EOJaTCGgL71mcKnw++4hwbqkWPDWmKIRP/8PKjNBiMgbqxffoQo6QTfTSpcRgfzgSNAY
         PxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tkyR3dv84zQpS4ALkfA8A9llaINudjYHST4DDk3GFls=;
        b=gZemjaIN7+xxznHTe4vcYWs6DCMs408OEQv1cZVOx/kqAnhJIaQ/qP3lbxLp9FMyJl
         XPqc8K/wNBfK+5sR+3f0HiFxot1qwIZwBrh76nJZeXTpGBxygKb3d7LHHHEo3WenT6gz
         vUqfYRl1n131owNt1YTy97M+jdU3yj6GnWSq1L1B+VExvMz4bjxJfqP7VWZJH9yZ22ya
         EtgcxbClrDtR/Qa6/axgFzHzPfRIELSqTRcpPuky3+iiV82nZKTLBJAj2Nh1QHYTI7me
         CIgGFtFr7o8Tt4IH7awLMUZe4x/ajOJWFLcI8K40qRdV2YIRN5W3N9uBz9oJkgCj8boi
         XkOQ==
X-Gm-Message-State: ALoCoQl7eh65T5kVrqntGRBoAUJPQFdIIwSS8hZuvXtaP2/Ipc+shzW9IBqlUGpDY2K+AbTh0sx0
X-Received: by 10.140.96.202 with SMTP id k68mr43211197qge.102.1433436289358;
 Thu, 04 Jun 2015 09:44:49 -0700 (PDT)
Received: by 10.140.101.115 with HTTP; Thu, 4 Jun 2015 09:44:49 -0700 (PDT)
In-Reply-To: <20150604130902.GA12404@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270782>

On Thu, Jun 4, 2015 at 6:09 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 01, 2015 at 10:49:45AM -0700, Stefan Beller wrote:
>
>> However the client side with builtin/fetch, builtin/fetch-pack, fetch-pack
>> is a bit of a mystery to me, as I cannot fully grasp the difference between
>>  * connect.{h,c}
>>  * remote.{h.c}
>>  * transport.{h.c}
>> there. All of it seems to be doing network related stuff, but I have trouble
>> getting the big picture. I am assuming all of these 3 are rather a low level,
>> used like a library, though there must be even more hierarchy in there,
>> connect is most low level judging from the header file and used by
>> the other two.
>> transport.h seems to provide the most toplevel library stuff as it includes
>> remote.h in its header?
>
> connect.c was originally "the git protocol", and was used by send-pack
> and fetch-pack. Other individual programs implemented other transports.
> Later, as the interface moved towards everybody running "fetch" and
> "push", and those delegating work to the individual transports, we got
> transport.c, which is an abstract interface for all transports. It
> delegates actual git-protocol work to the functions in connect.c (or
> bundle work elsewhere, or handles remote-helpers itself).
>
> And then remote.c contains routines for dealing with the remotes at a
> logical level. E.g., which refs to fetch or push, etc.
>
> So in theory, the flow is something like:
>
>   - fetch.c knows "the user wants to fetch from 'foo'"
>
>   - fetch asks remote.c: "who is remote 'foo'"; we get back a URL
>
>   - fetch asks transport.c: "what are the refs for $URL"
>
>   - it turns out to be a git URL. transport.c calls into connect.c to
>     implement get_refs_via_connect.

Currently the distinction which protocol to speak is made
here (in get_refs_via_connect), which may be a bit late. Though I updating
the git protocol only first would also be feasible.

So for the next git protocol

 - get_refs_via_connect first asks for the capabilities and gets an answer from
   upload-pack-2. Now what?

 - we could have a callback in struct transport, which must be set
accordingly by
   fetch in step 4 (it turns out to be a git URL. transport.c ...)
   This callback is called with each pkt-line such as

        void parse-capability(char *line, struct
*transport_capabilities, void *cdata);

The line would contain the pkt-line, while the transport_capabilities
would be a struct
similar as in "[RFCv2 06/16] remote.h: add new struct for options",
where the fetch
implementation must select the right bits. Looking at fetch-pack.{c,h}
we only expose
one do-it-all method there, so we currently don't have file wide
easily accessible variables,
but rather all in a struct fetch_pack_args, which carries important
information for the
selection process such as verbosity or desired options. This is why a
void* comes in
handy as well. (It will be easy later to adapt that to the sending
side as well).

Instead of a full grown line by line callback we could also just
collect all the capabilities
first in a string list and then only call back once into a

    void select_capabilities(struct string_list *available, struct
string_list *selected);

I think I'd find this second approach more handy as there are subtle
details you'd miss in
the first approach. Looking at fetch-pack.c, do_fetch_pack (line 790),
we have one
selection (no_done) conditioned on another (multi_ack_detailed), so
having the full list
there makes the code easier.

This second approach however might not be as future proof as the
first, because we store
all received capabilities (which may grow large in the future) and not
throw unknowns away
immediately.

I tend to rather implement the second one (easier to read/maintain trumps a
maybe-performance-problem-in-the-future).

This performance-problem-in-the-future could be mitigated easily by having a
preselection in transport.c get_capabilities, which ignores any capabilities not
white listed there (harder to maintain though, as we have a more than one spot
where to put a list)

By writing this mail I realized another thing. I have had the patch
    "[RFCv2 09/16] remote.h: add get_remote_capabilities, request_capabilities"
which has request_capabilities just translating from a struct
containing some bits
into a sequence of pkt-lines containing the actual protocol
capabilities. Maybe we
should not have that in the connect file, but rather as proposed in
this email, the
high level command directly selects the strings to put back on the
wire. (By having
"struct string_list *selected" as part of the select_capabilities arguments.)
then the request_capabilities in connect.c would be dumbed down to just:

    void request_capabilities(int out, struct string_list *list)
    {
        struct string_list_item *item;
        for_each_string_list_item(item, list) {
             packet_write(out, item->string);
        }
        packet_flush(out);
    }

I think that would be reasonable?

>
>   - after fetch gets back the list of refs, it uses routines in remote.c
>     to figure out which refs we are interested in, handle refspecs, etc
>
>   - now fetch asks transport.c: "OK, fetch just these refs"
>
>   - transport.c again calls into connect.c to handle the actual fetch
>
> Of course over the years a lot of cruft has grown around all of them. I
> wouldn't be surprised if there are functions which cross these
> abstractions, or other random functions inside each file that do not
> belong.
>
>> and the issue I am concerned about is the select_capabilities as well as
>> the request_capabilities function here. The select_capabilities functionality
>> is currently residing in the high level parts of the code as it both depends on
>> the advertised server capabilities and on the user input (--use-frotz or config
>> options), so the capability selection is done in fetchpack.c
>>
>> So there are 2 routes to go: Either we leave the select_capabilities in the
>> upper layers (near the actual high level command, fetch, fetchpack) or we put
>> it into the transport layer and just passing in a struct what the user desires.
>> And when the users desire doesn't meet the server capabilities we die deep down
>> in the transport layer.
>
> I think you have to leave it in the fetch-pack code. As you note, it's
> the place where we know about what the user is asking for and can
> manipulate the list. And not all transports even support capabilities
> like this.
>
> -Peff

Okay
