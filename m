From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git interpret-trailers with multiple keys
Date: Wed, 6 Apr 2016 22:28:21 -0400
Message-ID: <CAP8UFD0Pw+yhO1jZTAbMkZ5d-usu3rx5N0Se=PNL=N7DD-BPcA@mail.gmail.com>
References: <20160406191054-mutt-send-email-mst@redhat.com>
	<vpqlh4qbrnt.fsf@anie.imag.fr>
	<20160406201509-mutt-send-email-mst@redhat.com>
	<xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
	<20160406212940-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 04:28:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anzgL-0001Y6-0p
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 04:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbcDGC2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 22:28:23 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38058 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbcDGC2W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 22:28:22 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so68118104wme.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 19:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ffiht+h1VaPN/Dl7+zCL4mW3Cbtk4N5Njieps1XnzqQ=;
        b=QDNlcyPXKaBOtOqKSxtb1rjiT53utoD62Pd+e2W79J3qIBWmyGA8LduPCZ6jzoHGl2
         +EaEWvTaE4JCaajwmYDzRynTd1SvugO2lA9x8cCOa0WlSMjG0bRHmL5pU5OUpY7Gcy7S
         lHncw9W3Rpej4TaaQwa9AMZMtC4OoBibaZqXobDHVb+O9GP8CWoS4zJ3ZUSb6+/VwFHw
         jvCyBEwn2eIUIZVQ2icjYJI/GjkNUPPTySQ8QE5AiZw8c4G7zYoYDL9bCkZS73Ufpgz5
         ubUh8/8S5HxEmhu4MjN0xxRS6Hw8txfvVPhXS0f2rCWbbCYsH/EQl1BfVpTfDV/oNBNo
         ronw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ffiht+h1VaPN/Dl7+zCL4mW3Cbtk4N5Njieps1XnzqQ=;
        b=G5aaIicYBYS49n/AbZoOqCvhiuynhVqOT7vTkqcPF+CsOCnOrLEVMtlCJBEihwXNkA
         FAeRs4pJuo+DWOWhCVpNRWqJamLCppsi3vaBlxFD1OHnml/erTIZJZaRwa4ZLyfjPYlt
         FS1Hnh505ycuBGfOVGEUa7Mhs7aCCRcobwD/JzAALSu0bm1OUUf820YJWoezP3IRdES8
         hM23rNO8xl74nuHzXO402jZ396/W4sAoO0RiekHZ6Ttr9a5j111rbvWB16+wdnLF8wcY
         hTJuCpCwiFQjePgGfmm/DQlKz9TQgbFYCYL3+Z5pNGK3vb1YQrgi/3EeBLsu/yPRoDkW
         SY3Q==
X-Gm-Message-State: AD7BkJJhRozWz+aZQ73WkmJs4Bh7svJbTZDXxpbLiwiezX0D6+ubfOCEA1/gWexrNN+RscNniYqKA8H/Q+KTiw==
X-Received: by 10.194.78.37 with SMTP id y5mr538425wjw.78.1459996101115; Wed,
 06 Apr 2016 19:28:21 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 6 Apr 2016 19:28:21 -0700 (PDT)
In-Reply-To: <20160406212940-mutt-send-email-mst@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290900>

On Wed, Apr 6, 2016 at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Apr 06, 2016 at 10:42:42AM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>
>> > On Wed, Apr 06, 2016 at 06:58:30PM +0200, Matthieu Moy wrote:
>> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> >>
>> >> > I have this in .git/config
>> >> >
>> >> > [trailer "r"]
>> >> >         key = Reviewed-by
>> >> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
>> >> > [trailer "s"]
>> >> >         key = Signed-off-by
>> >> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
>> >> >
>> >> > whenever I run git interpret-trailers -t r I see these lines added:
>> >> >
>> >> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com
>> >> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> >> >
>> >> > Why is Reviewed-by repeated?  Bug or feature?
>> >>
>> >> The first two lines are added unconditionally:
>> >>
>> >> $ echo | git interpret-trailers
>> >>
>> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com
>> >>
>> >> The last line is added because you've asked for it with --trailer r.

Yes, and because the default is to add the trailer at the end.

>> >> I don't think it's currently possible to get the behavior you seem to
>> >> expect, ie. to define trailer tokens fully (key and value) in your
>> >> config file but use them only on request.

Yes, because you could define for example a function like this:

reviewed() {
    git interpret-trailers --trailer 'Reviewed-by: Michael S. Tsirkin
<mst@redhat.com>' --in-place "$@"
}

So it is kind of easy already to make things requestable.

If people really want some configured trailers to be used only on
request, it is possible to add a config option for that.

>> >> (BTW, I think you wanted a closing > at the end)
>> >
>> > Is this worth fixing? It doesn't look like a behaviour anyone
>> > would want...
>>
>> CC'ing Christian who's done the "trailers" thing.
>>
>> Personally, I do not think adding any configured trailers without
>> being asked is a sensible behaviour, but it is likely that people
>> already depend on it, as we seem to see "How do I configure to
>> always add this and that trailer?" from time to time.  I do not
>> think it is unreasonable to disable the "automatically add
>> everything that is configured" when the command line arguments ask
>> for some specific trailer, but I haven't thought deeply about it.
>>
>> An additional (uninformed) observation is that the 'echo' looks like
>> an ugly workaround for the lack of "always use this string as the
>> value" configuration.
>
> Or at least a default.
>
>> Perhaps next to trailer.<token>.command, we
>> would need trailer.<token>.value?

Yeah, that is possible too.
It could be bit redundant if we already have a config option to say if
the trailer has to be requested.
