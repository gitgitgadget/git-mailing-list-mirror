From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty
 line chunk heuristic
Date: Fri, 15 Apr 2016 14:22:48 -0700
Message-ID: <CA+P7+xp7oJoOXBhexe9zhrG1dMkz8jA3yQLzyTiqMwNQ1AQVdg@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
 <20160415165141.4712-3-jacob.e.keller@intel.com> <CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
 <xmqq8u0ebpru.fsf@gitster.mtv.corp.google.com> <CA+P7+xoWbrSaONH5xq=w5W190Jknk0Qsc5brS4UKFAs2_dTceg@mail.gmail.com>
 <xmqqzisuaa3t.fsf@gitster.mtv.corp.google.com> <CA+P7+xqe4ng9-gn1DRqhjebRXuHXbqZ6f3QsJ798k6DRo3bYyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:23:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBCs-00028u-8D
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbcDOVXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:23:09 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34904 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbcDOVXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:23:08 -0400
Received: by mail-ig0-f176.google.com with SMTP id gy3so30298119igb.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mTskLySUe4k80nmbsyPb7RZCqi+PdJPP+W0MYKLe8io=;
        b=Q0ILAH+B6jIwCxEz8UpSuUUZ33IHredjdzWakGSul6458eQzQmKVY40aXE7q4OTkca
         X6AmK4+rrb3T/uLI3gRFLA4a2eN2f4LnoyL//hUdvx5yXK0H4bTofyKfaZUuMQa1Jiws
         NlNPaGW0IKnXHJ4FUHckNzkyBCBp0zTtrbV4RS1+/BGbks6zJDfVpcc1Bu1nWVEtHrrw
         phXHarRqf+l0/JJzq0yblxF1Z9L7PCEyez76jrm/1MQRtKghKyzHjBgsiCP9h9i10cA1
         4eI+VBp8DXsyBDShnnr4uPIOiLDxco6eoGd8qqdi+fLLO0orkjMJQMnQ+KaVr0J6mn1Y
         MxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mTskLySUe4k80nmbsyPb7RZCqi+PdJPP+W0MYKLe8io=;
        b=hkBQJTVQE8JZwfafbh8AJkXfqi1E90mTRlxajzxhr55Wq3/aq4o/cZK//c9EKgZyH8
         SKS/tSHck47wYyU00rklCNyGA3TFE73ufdk8clWx1Y3N0mg7eiu+IqQ8sVEgOX8v11Aj
         UKRitD8w4N11oPPbXvyUax/D6nqsWoWctszmuH1es7/cJHJXzVNnlpDmZtcx5z4299ka
         9RRlp1yLSWPn8uT+FlecMH4v2q7un5KaK1LfDkqawAupfZueQA5JWsFSh8MFaK5/nCov
         vND0TeBBrjiGkeu+tc1PXt3s6ZVU+gpbO5hz3NCY9Rye6pbRu2btdR7P6IWMZWGWPhde
         OhLg==
X-Gm-Message-State: AOPr4FXtPYW5LJNzHEM1Wo+s34/ca4gjTW8HzGaIUTxsx/HNCFnZv3N55NKSmmfc1Xyd4psC2TDNmV+DqnNk8w==
X-Received: by 10.50.189.233 with SMTP id gl9mr6953177igc.73.1460755387382;
 Fri, 15 Apr 2016 14:23:07 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 14:22:48 -0700 (PDT)
In-Reply-To: <CA+P7+xqe4ng9-gn1DRqhjebRXuHXbqZ6f3QsJ798k6DRo3bYyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291667>

On Fri, Apr 15, 2016 at 2:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Apr 15, 2016 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> On Fri, Apr 15, 2016 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> I actually do not think these knobs should exist when the code is
>>>> mature enough to be shipped to the end users.
>>>>
>>>> Use "diff.compactionHeuristics = <uint>" as an opaque set of bits to
>>>> help the developers while they compare notes and reach consensus on
>>>> a single tweak that they can agree on being good enough, and then
>>>> remove that variable before the code hits 'next'.
>>>>
>>>> Thanks.
>>>
>>> I was under the impression that we would want a longer lived
>>> configuration until we had enough data to say whether it was
>>> helpful to make it default. I guess i had thought it would need to
>>> be longer lived since there may be cases where it's not optimal
>>> and being able to turn it off would be good?
>>
>> Once you start worrying about "some cases this may misbehave", a
>> configuration variable is a wrong mechanism to do so anyway.  You
>> would need to tie this to attributes, so the users can say "use this
>> heuristics for my C code, but do not apply it for my AsciiDoc
>> input", etc.
>>
>
> I think this makes perfect sense to apply this as an attribute,
> however.. why isn't the current diff algorithm done this way?
>
> Thanks,
> Jake
>
>> What you have is a pure developer support; aim to come up with "good
>> enough" way, giving developers an easier way to experiment with, and
>> remove it before the feature is shipped to the end user.


What are your thoughts on adding this do the gitattributes diff
section? Ie: modifications to the diff driver.

Thanks,
Jake
