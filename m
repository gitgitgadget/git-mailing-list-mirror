From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Mon, 17 Aug 2015 14:54:09 -0400
Message-ID: <CAD0k6qRPxkdOgAo=0+_f8bcFoL70MSvLDJ_OjrFtVMKtcqVV_A@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
 <xmqqbne9ivry.fsf@gitster.dls.corp.google.com> <CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
 <xmqqwpwxha4r.fsf@gitster.dls.corp.google.com> <CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
 <xmqqtwrxesqa.fsf@gitster.dls.corp.google.com> <CAD0k6qTWojeWT10xw_Dc5=Fw5r3rP0PUQOyqO7JAz6Vu+tV54w@mail.gmail.com>
 <xmqq614deoq8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPYJ-0005cd-0Y
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbbHQSya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:54:30 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36421 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbbHQSy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:54:29 -0400
Received: by iodv127 with SMTP id v127so146639392iod.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P/1utv1CWA+BHOaHRW2dpM4oCi+sZsV65QOLN/nvU4M=;
        b=X5iHhZ70HlQ3SwZl+oa8K7F75qOo72V7t1YAGrDKjJjmSRmZ7QOByesTdBkpB/mGbt
         w1kuyRo5TGuxCmhGk13yvbcw4U1BuszumZNrqHwFYdFtNWwjQxKOMOAXfeCytrasrhXI
         BhUeqCbhWabHakFtfN/ID8eCt5WmPC2bj1WUorrBWl77y2cCOxH+jzigRQanNOFCEvks
         ZTUOf0K3oSLmHOX4oEHh/GRbEmcLHTNK85CDMmKnCW81bLuKuzmN3t98Jw49vdFvmXWh
         B8N2HeYZWN0QgBagBJRUduWse+KIqYXMikPlqYXaJ/etVtB+50bNFD9cIMkTogej7QRv
         yyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=P/1utv1CWA+BHOaHRW2dpM4oCi+sZsV65QOLN/nvU4M=;
        b=NAakbo0ViArXZnkSpRPESke70UxJ1bmmq2CzavPtnZ7vK+m15YaLbKC13lzh2TXG+1
         K4l6CHBBeNAmMMkCY5DFzXhsCkegTcZXr9UlTY6RzDite+y81yYrFdvcKfxykjx6b79Y
         a1VWSBUk3UTpSPxn3zpVEGNsn730/jFosp3P+0QRD8Eq1bbN+aYEGwCI0vrH22cACwzw
         Zt9zjSTChu8wzDVHJpdLNe2tO3FCRyDHtJjTh4M85pTLrsM6YnzmL0vf2OsHZt4saat+
         sZChtGDBG/CM0VAlM1wolXOoVwDd3MgRoHbpum979sSHXqZ46wZoG7UsjBJGsWOD217m
         Se2Q==
X-Gm-Message-State: ALoCoQnWZ1wwD9/AJRMYh6JA7n9EvtECNjw74JCWGn7Y8Hbxx2KOyL6VHbGr/QZpJiT7M/VSAWXD
X-Received: by 10.107.11.17 with SMTP id v17mr3223472ioi.184.1439837669025;
 Mon, 17 Aug 2015 11:54:29 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Mon, 17 Aug 2015 11:54:09 -0700 (PDT)
In-Reply-To: <xmqq614deoq8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276072>

On Mon, Aug 17, 2015 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> On Mon, Aug 17, 2015 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> My preference on Bikeshed 1. would probably be to add
>>>
>>>     --sign=yes/no/if-asked
>>>
>>> and to keep --[no-]signed for "no" and "yes" for existing users.
>>
>> Incidentally, I just looked up incidence of true/false vs. yes/no in
>> command line options,...
>
> My yes/no was a short-hand for "yes" (and various other ways to
> spell "true") and "no" (and various other ways to spell "false").  I
> was NOT bikeshedding to say "I do not like true/false but favor
> yes/no".
>
> I actually was expecting a short discussion on sign vs signed,
> though.  As "tag --sign" is not "tag --signed" even though we call
> the resulting object a "signed tag", "push --sign" may be a good
> enough way to spell "signed push".  I _think_ signed pushes are
> recent enough that we still have time to deprecate --signed form,
> but I do not think it is worth it.

I agree that "push --sign" would be better than "push --signed" for
consistency with tag, but will defer to you as to whether it's worth
it to do the deprecation.

> So an updated suggestion would be that we'd take (this is a pretty
> much exhaustive enumeration) these:
>
>     --no-signed
>     --signed
>     --signed=if-asked
>     --signed=yes/true/on/1/2...
>     --signed=no/false/off/0

Fine by me. Would you expect those to all be documented, or just
--[no-]signed|--signed=(yes|no|if-asked) and silently accept the rest?

Is there a common utility function that does what we want? Basically
git_config_maybe_bool but not specifically about configs.

> We might want to throw in 'always' and 'never' as synonyms for
> 'true' and 'false', but again I do not think it is worth the
> confusion factor, as 'always' and 'true' already mean different
> things in some other contexts.
>
> Thanks.
>
>
>
