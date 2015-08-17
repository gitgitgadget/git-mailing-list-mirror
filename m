From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 4/8] notes: allow use of the "rewrite" terminology for
 merge strategies
Date: Mon, 17 Aug 2015 11:28:41 -0700
Message-ID: <CA+P7+xq5qTPVsSq0JOSUm5o9w=szD1c2oFm0e3s_f97E0=Zh+A@mail.gmail.com>
References: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
 <1439801191-3026-5-git-send-email-jacob.e.keller@intel.com> <CALKQrgfLzWdRxC5saBXJ_-iKmVDfs+mBfDKKrSU2-tP7eO5+Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRP9f-0001e2-Os
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbbHQS3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:29:03 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32823 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbbHQS3B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:29:01 -0400
Received: by iods203 with SMTP id s203so161700816iod.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IV96dsFxNIdFbgqPxQzlc4Vr9vtR1PQGqdnkEh0YRq4=;
        b=0NIJku57Crq/8455l5azEwo6/+vDw/+jJILkVXa1Lka6dfXz8SQTqyLIJQUNZRpbnL
         Uhx7P6U9rVArsB4CDlZHE5Zt+B0i4FoJNdG9lae5L/NwVeXMbrP44FEiZyqYgZRFvCTq
         TAKtMs8vRYWFxXXK1TpJtGONIpNQWUR2ILgDlFsgl+0At5eaaUrGw1yFGJjbfgb5aP4d
         TQ3nbDy54AButSS8XdjmVQ2iAUH20pphpNmvj7wwslmIOuql8vqQs476z1Yeyk7dCAWo
         h8iTo0u7yu4+x7uOjbxn0hiRjI9kTSlUI8iAQtmaxbO2KHDSnaOIEa5yKqKNbo/U3EsK
         As6Q==
X-Received: by 10.107.133.137 with SMTP id p9mr2736406ioi.146.1439836140985;
 Mon, 17 Aug 2015 11:29:00 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Mon, 17 Aug 2015 11:28:41 -0700 (PDT)
In-Reply-To: <CALKQrgfLzWdRxC5saBXJ_-iKmVDfs+mBfDKKrSU2-tP7eO5+Zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276068>

Hi,

On Mon, Aug 17, 2015 at 5:54 AM, Johan Herland <johan@herland.net> wrote:
> On Mon, Aug 17, 2015 at 10:46 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> notes-merge.c already re-uses the same functions for the automatic merge
>> strategies used by the rewrite functionality. Teach the -s/--strategy
>> option how to interpret the equivalent rewrite terminology for
>> consistency.
>
> I'm somewhat negative to this patch. IMHO, adding the rewrite modes as
> merge strategy synonyms adds no benefit - only potential confusion -
> to the existing merge strategies. Words that have a sensible meaning
> in the context of rewrite, do not necessarily have the same sensible
> meaning in the context of merge (and vice versa). I'd rather have the
> rewrite code map ignore/overwrite/concatenate to ours/theirs/union,
> without teaching the notes-merge code about these words. Or maybe even
> drop this patch (and the next?) entirely, and let the future author
> (who implements notes rewrite in terms of notes merge) decide how to
> deal with this? By committing to these synonyms now, you might
> actually be making things harder for the future author: once the
> synonyms are part of the user-visible and documented interface, they
> cannot easily be removed/changed again.
>
> ...Johan
>

I am ok dropping these, I really only added them after Junio brought
it up. I think that documenting union/concatenate is fine, but I think
that ours/theirs is very confusing. However, I think you're right that
a future author can deal with this when working on rewrite -> merge. I
don't think we need to do this now.

I'll drop these patches, but I will leave the
parse_notes_merge_strategy in it's location here.

We could document concatenate as a synonym of union but I don't think
that is a big deal.

Regards,
Jake
