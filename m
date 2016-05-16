From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 14:36:28 -0700
Message-ID: <CAGZ79kZuMdWdw2kcfs_P-_Ax1zXpKNHqMjNL80hBj3=SSp2zSQ@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	<xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
	<xmqqlh391z2v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 23:36:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2QBn-0004cB-5v
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbcEPVga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:36:30 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36405 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcEPVga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:36:30 -0400
Received: by mail-ig0-f170.google.com with SMTP id qe5so58186795igc.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=QQprVBtrZkjF7YgG8HKcGnf7bSung/qgDuu/NICJsaE=;
        b=aL40LOJIZr7iZ4KBq83whhapy6UgCf+Md+s5g+J5aw+SQ+jEcPhLvOoA4REu7s+LV/
         AiHaiMgeW4HroJy/oZOnj41HFycAwcyEvNl9KS9Noj22sBnx1hz+77ACF4GR4JD+zJ3e
         gpGFF3vxzkjfoSCn6Iugv8zcd9Ojvi/nKzUUor2GSItAhsig4AyWdZydeMxo+yj+/lif
         4uSoC8NtmFUZffCthSQvPlhZcVlxRWGvtQwZI24WHiTm86MjvaTSLDZW0IBrXZl/kMBA
         Q13ATd2oDQx1RRzTGopyOh7U7+AeFt3B081KTaDUwLIRH3kZB1bcC/kH2AcGbKysfove
         IyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QQprVBtrZkjF7YgG8HKcGnf7bSung/qgDuu/NICJsaE=;
        b=FvN+rrOX8F9XFrltKkdF8fZc87PpMGK2kJk9TYKnmc4xLfJ6fcxzXwItBzzi/DZobu
         S1OXeSdZA8YJ3NQ9xoZ0x24QLbyvwU1o0PK0G05mH2/I1/k+oSTOkgdH073w2MysZB8F
         JKClGX9f3g5dbD+7bDB+aFp18PvHDLwP3Q+4wt/K4fu8XZyTXLPZxKaFX6oNrBEbWQKH
         34kF9iXhQv6SDPsK0O/Wtp8a5b3AuF6Wj77wIWJ5UrIMH7KeBDTMe7+CVDKIIq4/lHpf
         ePwH9PMMHawyELlPufCsoK1zQB7g0jE7bE1avVZd5OpDe3DIFwNjklo74IM8sGovkDXW
         AcgA==
X-Gm-Message-State: AOPr4FX+1KJpbj4t7Klbzb57ge6eBMUFJRvwJU7saHNQSvNrM7Al/2Wvpp32FYmziyMK+sf+8zRAKojQyHhFIX1w
X-Received: by 10.50.30.228 with SMTP id v4mr12459148igh.85.1463434589051;
 Mon, 16 May 2016 14:36:29 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 14:36:28 -0700 (PDT)
In-Reply-To: <xmqqlh391z2v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294800>

On Mon, May 16, 2016 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This is another case for using ':' instead of '='.
>> So I think ':' is better for this future enhancement.
>>
>> Also this future enhancement may ask for
>>
>>       git ls-files ":(attr:label=foo)"
>>
>> or
>>
>>       git ls-files ":(attr:-label)"
>>
>> so the user can circumvent the warn and ignore strategy. :(
>
> That is exactly what we want, I would say, if we want to accept
> "arbitrary set of attributes with their states".
>
> The "warn and ignore" comes only from "with '(:label=X Y Z)', we
> inspect attributes X, Y and Z and insist them to be set to true; it
> is a configuration error to set the label to anything but a string",
> and accepting "arbitrary set of attributes with their states" makes
> it moot (as I said earlier in $gmane/294776).
>
> So are we leaning towards ":(attr:<state>)", where <state> is one of
>
>     var=value
>     var
>     -var
>     !var
>
> now?  It makes the pathspec magic parser a bit more complex (and I
> am not sure if we have to worry too much about quoting "value" part
> to allow arbitrary sequence of bytes), though.

And we want to have both "label=A B C" and attr:label=A B C" or *just* the
attr query?

We should not allow the user to add arbitrary attributes (i.e. labels).
Instead each of the "attr for labeling purposes" needs to follow a clear scheme
that allows us to add attributes later on that are outside of that scheme.

In a very first implementation we could require the attribute to start with
"label=". ;)
