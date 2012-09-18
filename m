From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Tue, 18 Sep 2012 11:00:34 +0200
Message-ID: <CAKPyHN2_RShv8Emr+OfZF_m1oP7Ann5tNuio4+yuSjfHXc043Q@mail.gmail.com>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
	<20120917030143.GA19986@pearl.mediadesign.nl>
	<7vy5k9w7eh.fsf@alter.siamese.dyndns.org>
	<20120918025229.GB19986@pearl.mediadesign.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Mischa POSLAWSKY <git@shiar.nl>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDtfg-00032Q-KE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 11:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab2IRJAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 05:00:36 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65171 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab2IRJAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 05:00:35 -0400
Received: by oago6 with SMTP id o6so5781913oag.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 02:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DP17UBbWD0J56Mo816HKhNK+VboJa1ln6XEXePSq4aU=;
        b=xM5c/nCDq6tNmWHBshNhooBTSycI+aHIC06EAdlLPi6qTDxZtCHUTrhd9cVT2lalql
         AU//8SrIJYUBwpqv72YgCuzjXLQjlPjuz/e7E0VZDCKgXkW1CNslYXEb4v5jANEjpuNy
         xAVW7YyXpDJE1/F4MWMGjYbGZtjg9VIJ8BhYdGaCCvFY7eRjzc3DL8arLV+bWgXoKTx4
         l2zaevj/faDJq2z37ST71nrc6SH7IEhP6kS67pej9onk3MJqgUTNY5uEGMZEgLutndky
         7wven/frMNOOHGeHMSOn1fkkxXReRB6WdlniHIlmmqP71fkllR4HQi2A4OsNj4h1WB30
         mIsA==
Received: by 10.60.172.19 with SMTP id ay19mr14000278oec.68.1347958834553;
 Tue, 18 Sep 2012 02:00:34 -0700 (PDT)
Received: by 10.76.141.167 with HTTP; Tue, 18 Sep 2012 02:00:34 -0700 (PDT)
In-Reply-To: <20120918025229.GB19986@pearl.mediadesign.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205816>

On Tue, Sep 18, 2012 at 4:52 AM, Mischa POSLAWSKY <git@shiar.nl> wrote:
> Junio C Hamano skribis 2012-9-16 22:22 (-0700):
>
>> Mischa POSLAWSKY <git@shiar.nl> writes:
>>
>> > Subject: [PATCH/RFC] format-patch: force default file prefixes in diff
>> >
>> > Override user configuration (eg. diff.noprefix) in patches intended for
>> > external consumption to match the default prefixes expected by git-am.
>> >
>> > Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
>> > ---
>>
>> Not all projects expect to see a/ & b/ prefix and these are
>> configurable for a reason.  Robbing the choice that has been
>> supported for quite a long time from them is an unacceptable
>> regression.
>
> My bad, I was assuming format-patch would mostly interact with git am.
>
>> Why did you think this may be a good idea in the first place?
>>
>> Perhaps you had configured your diff.noprefix in a wrong
>> configuration file?  This is primarily per-project choice, and your
>> clone of git.git should not have diff.noprefix set, neither your
>> $HOME/.gitconfig unless you always work on projects that want
>> diff.noprefix.
>
> Then I'm not using it as intended.  For me it's just a personal
> preference of how I'd like to review commits (diff/show) so I can easily
> copy-paste file names (less essential since my discovery of git jump,
> but still).  It's not something I'd like to be communicated with any
> upstream project (format-patch).
>
> So it seems I'm asking for a new feature: to be able to configure local
> and inter-project diff options differently.  In this case I'd be helped
> by either format.noprefix=0 or a to be bikeshedded localdiff.noprefix=1.
> I don't know about other options though.  Does anybody actually want
> mnemonicprefix to be sent out as well?

I once had the same idea and posted a patch for it:

http://article.gmane.org/gmane.comp.version-control.git/146215

The implementation differs though, the pure path without any
mnemonicprefix is in its own line 'path <path>'. But my current patch
also differs to this old one, in the current one, the path is at the
end 'index' line. But I do not need this feature anymore.

Bert

>
> Another solution could be a single option defining behaviour exceptions:
> format.diff = normal | textconv | noconfig
> Expanding on the existing --(no-)textconv difference in format-patch.
>
> --
> Mischa
