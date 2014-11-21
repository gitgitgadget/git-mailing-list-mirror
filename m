From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/6] repack_without_refs(): convert to string_list
Date: Fri, 21 Nov 2014 11:57:22 -0800
Message-ID: <CAGZ79kaGuMNO7_ynRMO_8T2shRn=S-gctos6WJL=gMOsDitM+w@mail.gmail.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
	<546F4B5B.2060508@alum.mit.edu>
	<xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 20:57:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XruKe-0006aC-3t
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 20:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbaKUT5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 14:57:24 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54646 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaKUT5X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 14:57:23 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so5618341iec.33
        for <git@vger.kernel.org>; Fri, 21 Nov 2014 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vAzrhO1VtQJSBSgl+PgDBxdmpqs1Sl0TJ66+YxGQRrw=;
        b=Yf2NBiy3XrsA88kfKbhqXgLhEHz94jvyl0HzlO861MM00lyf9iIzkroLK+3u0N8jwY
         M36Hr884qAbFnEI3vcyxstvh3STXFmM5KqmKP/d05q0qqOeJzRrNC1Q4YrdY11hqWxAI
         K65YcMduGCQ1oHfYgQA+nmSILfGIWOw2VD9r4hbrXDJYg2LtmD+6BYU83nxZErOIjLox
         z9JLR6e3etB5fk5R71AwEaNvJfMua0Zh34gCGp1EnTEo1K/c4/h7+oQI+/bbC95uUwOo
         bQXSOCYivcL6vvdtYxkAbRV20Yn6UBC9wOV30j6vfP92C6RhMFk726TX9lY8eAayJzj6
         DVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vAzrhO1VtQJSBSgl+PgDBxdmpqs1Sl0TJ66+YxGQRrw=;
        b=NjlBMZ0C62uUemZDbqnY+KtBFSJ09rK4oANVvjCkBkY/gpgFFFTdGKqIjzukunsxAe
         sOs89d5XcM4vw6ol2WjwELANxi9RbRdSDMcC20ZMnB6fAOQESdbnMBzxP6r6r1m222RI
         ExKL0npU/HMLZqDJJYLR9RLYbVDFvrFUvlkkc6Tm02YmmTYlpLCpto4elIf/Q4jCBy8A
         2gGRjarA+fIDpPYPxDhAmt2PbKAbV8joh3904lOsm4p1gxyCttwd+BC79nCg1lW/mx/1
         3h5OrPzSIKaYZQDcEjFHdWCGVUHyR/mI7MON7uy5XxhXTgBeEnqgQURojCtGmvPrYnmn
         PGqw==
X-Gm-Message-State: ALoCoQkBjlwWR5r6OjsGYfdYFzBvbye6Q+LVLZVP/78k6exiSHFenEZ7ATqekmyo8oMzqprxeWd6
X-Received: by 10.42.212.83 with SMTP id gr19mr4202897icb.95.1416599842846;
 Fri, 21 Nov 2014 11:57:22 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Fri, 21 Nov 2014 11:57:22 -0800 (PST)
In-Reply-To: <xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 21, 2014 at 10:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I don't think that those iterations changed anything substantial that
>> overlaps with my version, but TBH it's such a pain in the ass working
>> with patches in email that I don't think I'll go to the effort of
>> checking for sure unless somebody shows interest in actually using my
>> version.
>>
>> Sorry for being grumpy today :-(

Sorry for causing the grumpyness.
I have compared the versions, and they do look pretty similar.
In refs.{c,h} we're just talking about variable names and comments,
that are different.

In remote.c prune_remote however we did have slight differences,
* early exit vs a large body below an if
* your approach seems more elegant to me as you seem to know what you're doing:
       for_each_string_list_item(item, &states.stale)
               string_list_append(&refs_to_prune, item->util);
 instead of
       for (i = 0; i < states.stale.nr; i++)
               string_list_append(&delete_refs, states.stale.items[i].util);
* You do not have a sort_string_list at the end before warn_dangling_symrefs,
   but you explained that it is not necessary.

On my continued journey on this mailing list I'll try to follow your
example and write lots of
small easy to review patches, as they are indeed way easier to follow.

However as Junio mentioned, we get other problems having too small changes.
In the review for the [PATCH v3 00/14] ref-transactions-reflog series you said:

> I was reviewing this patch series (I left some comments in Gerrit about
> the first few patches) when I realized that I'm having trouble
> understanding the big picture of where you want to go with this.

Maybe that was just my fault, not having stated the intentions in
the cover letter explicit enough. But having many patches will also not help
on presenting the big picture easily.

Thanks for bearing with me,
Stefan

>
> Is the above meant as a grumpy rant to be ignored, or as a
> discussion starter to improve the colaboration to allow people to
> work better together instead of stepping on each other's patches?
>
> FWIW, I liked your rationale for "many smaller steps".
>
> One small uncomfort in that approach is that it often is not very
> obvious by reading "log -p master.." alone how well the end result
> fits together.  Each individual step may make sense, or at least it
> may not make it any worse than the original, but until you apply the
> whole series and read "diff master..." in a sitting, it is somewhat
> hard to tell where you are going.  But this is not "risk" or "bad
> thing"; just something that may make readers feel uncomfortable---we
> are not losing anything by splitting a series into small logical
> chunks.
>
> Thanks.
>
>
