From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sat, 10 Nov 2012 14:25:57 -0500
Message-ID: <509EAA45.8020005@gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>	<20121108200919.GP15560@sigill.intra.peff.net>	<509CCCBC.8010102@drmicha.warpmail.net>	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>	<509E8EB2.7040509@drmicha.warpmail.net> <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGh9-0004wa-GH
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab2KJT0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 14:26:06 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:56978 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2KJT0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 14:26:04 -0500
Received: by mail-yh0-f46.google.com with SMTP id m54so1000800yhm.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 11:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lnCcXj6qyO6xqmTnwdnWlA6Nfirg08dOt+Yche/F/eU=;
        b=eyiytOejnAcHz8t6WV7FH42ZedevPvHhQOEWA+BqDAzfKJhPRkKgAKfnZf2X6w7fB8
         eUuYOjCWrKRHtyg/rPUeAoggTwJiPIzOvfYGv+wIaeiBvKGnJ8tY6dzQvXARESAwfgUl
         N8a9bzWxPJUg1Lc2HpqzDAkGXNoGR6uRCORdg3m42JZ3CymyvESKk/PQ84jOTrUkW3iJ
         8ciKr4h8dl3Ou01GdwMnPWln7mTLMyLez+By6U9N7AIGyCyTh7XkbYoui5+7SPNYaZbQ
         KUnf6fAyfQYy7z50fofJI3uRQWUDa9piLU28qopTy7injsWaCJvlc8S5WgsXTYfwlAg+
         2nHA==
Received: by 10.236.123.136 with SMTP id v8mr15087850yhh.75.1352575563215;
        Sat, 10 Nov 2012 11:26:03 -0800 (PST)
Received: from [10.0.1.132] ([97.104.180.2])
        by mx.google.com with ESMTPS id e18sm2123505yhi.0.2012.11.10.11.26.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Nov 2012 11:26:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209300>

On 11/10/2012 01:43 PM, Felipe Contreras wrote:
> On Sat, Nov 10, 2012 at 6:28 PM, Michael J Gruber
> <git@drmicha.warpmail.net>  wrote:
>> Felipe Contreras venit, vidit, dixit 09.11.2012 15:34:
>>> On Fri, Nov 9, 2012 at 10:28 AM, Michael J Gruber
>>> <git@drmicha.warpmail.net>  wrote:
>>>
>>>> Hg seems to store just anything in the author field ("committer"). The
>>>> various interfaces that are floating around do some behind-the-back
>>>> conversion to git format. The more conversions they do, the better they
>>>> seem to work (no erroring out) but I'm wondering whether it's really a
>>>> good thing, or whether we should encourage a more diligent approach
>>>> which requires a user to map non-conforming author names wilfully.
>>>
>>> So you propose that when somebody does 'git clone hg::hg hg-git' the
>>> thing should fail. I hope you don't think it's too unbecoming for me
>>> to say that I disagree.
>>
>> There is no need to disagree with a proposal I haven't made. I would
>> disagree with the proposal that I haven't made, too.
>
> All right, we shouldn't encourage a more diligent approach which
> requires a user to map author names then.
>
>>> IMO it should be git fast-import the one that converts these bad
>>> authors, not every single tool out there. Maybe throw a warning, but
>>> that's all. Or maybe generate a list of bad authors ready to be filled
>>> out. That way when a project is doing a real conversion, say, when
>>> moving to git, they can run the conversion once and see which authors
>>> are bad and not multiple times, each try taking longer than the next.
>>
>> As Jeff pointed out, git-fast-import expects output conforming to a
>> certain standard, and that's not going to change. import is agnostic to
>> where its import stream is coming from. Only the producer of that stream
>> can have additional information about the provenience of the stream's
>> data which may aid (possibly together with user input or choices) in
>> transforming that into something conforming.
>
> We already know where the import of those streams come from:
> mercurial, bazaar, etc. There's absolutely nothing the tools exporting
> data from those repositories can do, except try to convert all kind of
> weird names--and many tools do it poorly.
>
> So, the options are:
>
> a) Leave the name conversion to the export tools, and when they miss
> some weird corner case, like 'Author<email', let the user face the
> consequences, perhaps after an hour of the process.
>
> We know there are sources of data that don't have git-formatted author
> names, so we know every tool out there must do this checking.
>
> In addition to that, let the export tool decide what to do when one of
> these bad names appear, which in many cases probably means do nothing,
> so the user would not even see that such a bad name was there, which
> might not be what they want.
>
> b) Do the name conversion in fast-import itself, perhaps optionally,
> so if a tool missed some weird corner case, the user does not have to
> face the consequences.
>
> The tool writers don't have to worry about this, so we would not have
> tools out there doing a half-assed job of this.
>
> And what happens when such bad names end up being consistent: warning,
> a scaffold mapping of bad names, etc.
>
>
> One is bad for the users, and the tools writers, only disadvantages,
> the other is good for the users and the tools writers, only
> advantages.
>

c) Do the name conversion, and whatever other cleanup and manipulations 
you're interesting in, in a filter between the exporter and git-fast-import.
