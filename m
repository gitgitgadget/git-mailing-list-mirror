From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git interpret-trailers with multiple keys
Date: Sun, 10 Apr 2016 18:57:53 +0200
Message-ID: <CAP8UFD1hSg9RXLavzQgff-QioVU28_ZYhrfAvrhzNe8zXwwv5w@mail.gmail.com>
References: <20160406191054-mutt-send-email-mst@redhat.com>
	<vpqlh4qbrnt.fsf@anie.imag.fr>
	<20160406201509-mutt-send-email-mst@redhat.com>
	<xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
	<20160406212940-mutt-send-email-mst@redhat.com>
	<CAP8UFD0Pw+yhO1jZTAbMkZ5d-usu3rx5N0Se=PNL=N7DD-BPcA@mail.gmail.com>
	<20160410182750-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 18:58:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apIgT-0006RF-4A
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 18:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbcDJQ54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 12:57:56 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38802 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbcDJQ5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 12:57:55 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so76427291wme.1
        for <git@vger.kernel.org>; Sun, 10 Apr 2016 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=9C9GMipK2hPFbionF1phQB0sJWHo6kx+DnXFBQwhxHQ=;
        b=nLg9h+d9vcOVxz6lIx8X3/ovez6vaWlf8g+jZIrUrCLeZkBYZ5fuMJ6AJts8I2EoEv
         n/W8EyjyPqiiYDyy8Q8Poo022I6FKYoqY8bYGI5n01W1yhjg1ubIO+ie04tOT381V5n+
         ULX/UsOP1NR2Es6PzfDxM4FWrAF9Antqc1nE6wEdSfcM0/Hzwk+r5eDXI3Qqf82zaFaZ
         yrZVLjleb70WWqKskr1KffxtLGO9atDVatiHMCPSVXpLJX9onU79KHVZKzL6RTnkIgck
         cF2aOXjFQFPG62SukjMXfVqEa6U8f5lmxjtg/A3sAgeFYSyEKMGgtp6PCd3GYVXWPgZU
         Mj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9C9GMipK2hPFbionF1phQB0sJWHo6kx+DnXFBQwhxHQ=;
        b=aDG5Bsnx08Sk3Vy546GN2YQpIDpS2fvzrNNdWzINTjEWz7URXGvJPAH4Gf3nv/sNXZ
         3Ldc3UMq8JSEmPv393J35GiF1AmXM99AO6R93GGN9Xs0BaEmW/PVTjC2w74kj6BgdtBC
         QIBjjjKF6ERte+xp5pwK8+6JzVrY3xrY10FfGz1j1Q3M8bvBPEuRAh2ElP7mpBNfF0UY
         yTaM+KYe6lShAn1GYAe24n8oWv1RX44OGEtnmAAMRACW04dC7ZJPhARmx1uKVd0MeEkn
         R3qnQty9bKqJ3QHuHXpsEIkD3mUwEfFdPalnLRsgSMg2O0R89QeR+X5OyjM/mp7/aeQO
         J/gQ==
X-Gm-Message-State: AD7BkJIniQTmNGwRxSbtKZdwwLvnzlxBzd9DeMOC4yVbu2X8F6QJ5No9IEsrH7jCL62snEmBf5TXjNPmpD8Uag==
X-Received: by 10.194.117.70 with SMTP id kc6mr20973236wjb.94.1460307473598;
 Sun, 10 Apr 2016 09:57:53 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Sun, 10 Apr 2016 09:57:53 -0700 (PDT)
In-Reply-To: <20160410182750-mutt-send-email-mst@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291179>

On Sun, Apr 10, 2016 at 11:32 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Apr 06, 2016 at 10:28:21PM -0400, Christian Couder wrote:
>> On Wed, Apr 6, 2016 at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Wed, Apr 06, 2016 at 10:42:42AM -0700, Junio C Hamano wrote:
>> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> >>
>> >> > On Wed, Apr 06, 2016 at 06:58:30PM +0200, Matthieu Moy wrote:
>> >> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> >> >>
>> >> >> > I have this in .git/config
>> >> >> >
>> >> >> > [trailer "r"]
>> >> >> >         key = Reviewed-by
>> >> >> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
>> >> >> > [trailer "s"]
>> >> >> >         key = Signed-off-by
>> >> >> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
>> >> >> >
>> >> >> > whenever I run git interpret-trailers -t r I see these lines added:
>> >> >> >
>> >> >> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> >> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com
>> >> >> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> >> >> >
>> >> >> > Why is Reviewed-by repeated?  Bug or feature?
>> >> >>
>> >> >> The first two lines are added unconditionally:
>> >> >>
>> >> >> $ echo | git interpret-trailers
>> >> >>
>> >> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> >> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com
>> >> >>
>> >> >> The last line is added because you've asked for it with --trailer r.
>>
>> Yes, and because the default is to add the trailer at the end.
>>
>> >> >> I don't think it's currently possible to get the behavior you seem to
>> >> >> expect, ie. to define trailer tokens fully (key and value) in your
>> >> >> config file but use them only on request.
>>
>> Yes, because you could define for example a function like this:
>>
>> reviewed() {
>>     git interpret-trailers --trailer 'Reviewed-by: Michael S. Tsirkin
>> <mst@redhat.com>' --in-place "$@"
>> }
>>
>> So it is kind of easy already to make things requestable.
>
> Not if any commands are configured. interpret-trailers will
> insist on running them in any case.

If one want something requestable instead of automatic, one should
definitely not configure any command.

>> If people really want some configured trailers to be used only on
>> request, it is possible to add a config option for that.
>
> this is not what the documentation says though:

What I meant is that we could create new options called maybe
trailer.autocommands and trailer.<token>.autocommands that default to
'true' and if 'false' the command would not be run automatically and
the corresponding trailer would not be added.

> I would say that if people really want to run all trailers while also
> passing some on command line, *that* should be a config option.
> Current default violates the principle of least surprise.

Current default is documented and is the most powerful default.
Yes, it might be surprising though.

>> >> >> (BTW, I think you wanted a closing > at the end)
>> >> >
>> >> > Is this worth fixing? It doesn't look like a behaviour anyone
>> >> > would want...
>> >>
>> >> CC'ing Christian who's done the "trailers" thing.
>> >>
>> >> Personally, I do not think adding any configured trailers without
>> >> being asked is a sensible behaviour, but it is likely that people
>> >> already depend on it, as we seem to see "How do I configure to
>> >> always add this and that trailer?" from time to time.  I do not
>> >> think it is unreasonable to disable the "automatically add
>> >> everything that is configured" when the command line arguments ask
>> >> for some specific trailer, but I haven't thought deeply about it.
>> >>
>> >> An additional (uninformed) observation is that the 'echo' looks like
>> >> an ugly workaround for the lack of "always use this string as the
>> >> value" configuration.
>> >
>> > Or at least a default.
>> >
>> >> Perhaps next to trailer.<token>.command, we
>> >> would need trailer.<token>.value?
>>
>> Yeah, that is possible too.
>> It could be bit redundant if we already have a config option to say if
>> the trailer has to be requested.
>
> Seems unrelated - if one just wants a string, using echo as
> a command is inefficient and inconvenient.

Efficiency is not very high in the list for this kind of things. Also
when these features were developed, many people wanted different
powerful things and many people said they could help develop them
though very few did help. So if you think trailer.<token>.value is
really needed you are welcome to develop it.

Thanks,
Christian.
