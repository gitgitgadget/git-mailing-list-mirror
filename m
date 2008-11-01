From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Sat, 1 Nov 2008 18:23:44 +0100
Message-ID: <4ac8254d0811011023r10a4ce45ka962344ceef564f0@mail.gmail.com>
References: <1224606624-5082-1-git-send-email-tuncer.ayaz@gmail.com>
	 <20081027190816.6117@nanako3.lavabit.com>
	 <7vprllh0ao.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 18:30:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwKIy-0003i1-Ex
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 18:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYKAR3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYKAR3S
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 13:29:18 -0400
Received: from hs-out-0708.google.com ([64.233.178.244]:4885 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYKAR3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 13:29:17 -0400
Received: by hs-out-0708.google.com with SMTP id 4so945484hsl.5
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ur+NLB2eQNmI2n0B40UFV3a/rPUdf8bt662Eo3I7Dek=;
        b=tcmpHNyA1ofIZStqnnqUV9xf5ZDcSi53ySfM+ftfKGxYX1p+uuwAdL9VYapWIEDGVu
         8J/YGHActUYHLb8+7g9hFIzANOfPAaL3Pmv2Q0M5kFUc/ev4fz1JrEUEmwWFPk1Wd2IB
         UU8IX5WJONzGUZ2KUcPaZLY5CC50kv2C2o06k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QA0P/68dxR+rggbTr948u57o8+2hLxQNZwngAmlX/tpHXVvPSHExHG1yFssyGv7HXV
         u+BcfSGOtEH6n0g7bvWtOLrdHXfyE/VhlRCZFc+Fg7o8LO95fwVyTaVssNmmG/P49WNF
         yDpyeUA0OBxbEM8HcDvoMKVlGza1LWT1fcGms=
Received: by 10.64.21.10 with SMTP id 10mr6736302qbu.8.1225560224324;
        Sat, 01 Nov 2008 10:23:44 -0700 (PDT)
Received: by 10.65.114.10 with HTTP; Sat, 1 Nov 2008 10:23:44 -0700 (PDT)
In-Reply-To: <7vprllh0ao.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99749>

On Tue, Oct 28, 2008 at 4:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Quoting Tuncer Ayaz <tuncer.ayaz@gmail.com>:
>>
>>> After fixing clone -q I noticed that pull -q does not do what
>>> it's supposed to do and implemented --quiet/--verbose by
>>> adding it to builtin-merge and fixing two places in builtin-fetch.
>>
>> Junio, may I ask what the status of this patch is? Maybe the patch was
>> lost in the noise? The commit log message is written very differently from
>> existing commits in the history of git, and I am thinking that maybe that is
>> why you did not like the whole patch? Or is it lack of any test script?
>
> Well, perhaps you've been with us long enough to get too picky like
> myself, but this was genuinely lost in the noise and my scrambling to get
> back to normal.  We do not typically say "I did this, I did that", but the
> first paragraph in Tuncer's message is perfectly fine.  I would probably
> liked the second paragraph better if it were after --- lines (it is more
> about the possible enhancements in other areas, and does not belong to the
> commit log message for this change), but it is not a grave enough offence
> to get the patch rejected.

Should I resend the patch with a short and simple commit message
like the following?
--8<--
Implement git-pull --quiet and --verbose by adding the
options to git-pull and fixing verbosity handling in git-fetch.
-->8--

> The patch itself looks Ok; the lack of test script additions does indeed
> bother me somewhat, but it is not too big a deal.

I took a look at t/ and am not quite sure whether I should test -v/-q
by analyzing stdout output's length & content.

I think testing -q and -v makes more sense on a global and not
git-pull or git-fetch level. For that to be possible I envision building
common verbosity-based logging functions/macros.

I don't like the idea of scanning stdout for length or content as
long as we're not sure that all errors and warnings are sent
to stderr and stdout is for info and verbose only.

> P.S. We are having fun at GitTogether'08 in the first half of this week,
> so please expect slower response than usual.
