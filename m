From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 00/11] Protocol version 2, again!
Date: Mon, 1 Jun 2015 10:49:45 -0700
Message-ID: <CAGZ79kZxFnkneixquUijd2yfKBh6+XnYiYzCh8L9Mkourh64Fw@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<20150527061818.GA885@peff.net>
	<20150527070838.GA6873@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:49:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTqR-0005vd-Jy
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbFARts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:49:48 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:33345 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbbFARtq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:49:46 -0400
Received: by qcmi9 with SMTP id i9so50548806qcm.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EU0jPkuEFRRdRos7/lI+2ClEwsda1PItwen+rZE0sUU=;
        b=HpbI22zhg6VbmkW1waEi5R0KPMkHKVG8vKPSTs0RMq0sx74AbptgJAhg9h02Uvt7uF
         +hlE0pBCUDskC6O9U8JkpQYo9ChdpuZY72Fz8cGL9R/kUmh0n0zb6JNfLG2AHaIJwb/H
         SlYzxiYpeGhyOcqwYP0tegJRlQ73wA0AoCTyArn85Q54yplgSt4oJXBmInAk8sdyIVUO
         vtfVAlSes8LvdGw/nrUl0MRGIGeXatx1fp6mflF60YlKpG84ewnGbSQEeVAz18oRr6gb
         r1LjNfXXcSbzSlakSroN186VmFbdxomBOHu6YxNNuNEvFLS61GKmh8WGlIGLSRXRy7+3
         39+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EU0jPkuEFRRdRos7/lI+2ClEwsda1PItwen+rZE0sUU=;
        b=aW2s9+JW5tk758z9L+nFIoJMb+VxqhASa5ScN66xpjLYUkO0Aq2AyFfdYQww4dPQFU
         mbz2lAO4f6jfjaZOuh76cMpd9wu0NjyiNHL/ZaHYXCuUKBZb65D+RCoglgmTTEGWaa0m
         DqNpa2A7hkAtf5tsgt98UGHdGhggKDR8PKWKwcyn0j5KAc8EOVwvuC7uh5JLLlbv8P8s
         8r5yWZdTTAbdfSqNCfYGFESebyoe0qKScvTZF3YumWZ2QHfIhlOcDoASE0b/V6HBCsNo
         vCTg922c/1uCtBkDiHq4++H/NKfVd89iw2lznw8zhUwTxBATmmw/06pp4RU2oX1AQfc0
         Y2sw==
X-Gm-Message-State: ALoCoQmcFa8hMxAR5EDJ4ObAQbXYYU2ogIixziHZoqIcuvbQfDdYPCUmuXjuMIA+t8Yc/kNCIpPO
X-Received: by 10.55.22.143 with SMTP id 15mr40538596qkw.85.1433180985789;
 Mon, 01 Jun 2015 10:49:45 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Mon, 1 Jun 2015 10:49:45 -0700 (PDT)
In-Reply-To: <20150527070838.GA6873@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270448>

On Wed, May 27, 2015 at 12:08 AM, Jeff King <peff@peff.net> wrote:
> On Wed, May 27, 2015 at 02:18:18AM -0400, Jeff King wrote:
>
>> > The new protocol works just like the old protocol, except for
>> > the capabilities negotiation being before any exchange of real data.
>>
>> I like this approach. [...]
>
> So now I've read through all the patches. I still like it. :)
>
> There's a lot of work to be done still, but I think this is a great
> start. Thanks for getting the ball rolling.
>
> -Peff

Thanks for the reviews. I think I got them all covered by now and
I am pretty happy about the upload-pack part for now.

However the client side with builtin/fetch, builtin/fetch-pack, fetch-pack
is a bit of a mystery to me, as I cannot fully grasp the difference between
 * connect.{h,c}
 * remote.{h.c}
 * transport.{h.c}
there. All of it seems to be doing network related stuff, but I have trouble
getting the big picture. I am assuming all of these 3 are rather a low level,
used like a library, though there must be even more hierarchy in there,
connect is most low level judging from the header file and used by
the other two.
transport.h seems to provide the most toplevel library stuff as it includes
remote.h in its header?

The problem I am currently trying to tackle, is passing the options through all
the layers early on. so in a few places we have code like

    switch (version) {
    case 2: /* first talk about capabilities, then get the heads */
        get_remote_capabilities(data->fd[0], NULL, 0);
        select_capabilities();
        request_capabilities(data->fd[1]);
        /* fall through */
    case 1:
        get_remote_heads(data->fd[0], NULL, 0, &refs,
                 for_push ? REF_NORMAL : 0,
                 &data->extra_have,
                 &data->shallow);
        break;
    default:
        die("BUG: Transport version %d not supported", version);
        break;
    }

and the issue I am concerned about is the select_capabilities as well as
the request_capabilities function here. The select_capabilities functionality
is currently residing in the high level parts of the code as it both depends on
the advertised server capabilities and on the user input (--use-frotz or config
options), so the capability selection is done in fetchpack.c

So there are 2 routes to go: Either we leave the select_capabilities in the
upper layers (near the actual high level command, fetch, fetchpack) or we put
it into the transport layer and just passing in a struct what the user desires.
And when the users desire doesn't meet the server capabilities we die deep down
in the transport layer.

Any advice on how to proceed there welcome!

Thanks,
Stefan
