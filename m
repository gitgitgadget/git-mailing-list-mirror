From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] fetch: document that pruning happens before fetching
Date: Mon, 13 Jun 2016 23:18:51 -0700
Message-ID: <CA+P7+xq50QQEKxwdApPjd4-01wX7dsBwj5dsbLH+d7Ot05JjSQ@mail.gmail.com>
References: <20160613235850.GA8009@sigill.intra.peff.net> <CA+P7+xpk6HqeJfUcAkpTbW_hO6dyjanXoqaaKqdTU363n=-Stw@mail.gmail.com>
 <20160614061752.GA11935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Tom Miller <jackerran@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 08:19:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bChgy-0007xb-Jt
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 08:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbcFNGTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 02:19:13 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36596 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbcFNGTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 02:19:12 -0400
Received: by mail-yw0-f195.google.com with SMTP id w195so7974099ywd.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 23:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o3DQhrUPCG5sKxkqgUFlt1ylG5y4PZh6zv3zE4khc14=;
        b=zDzfPegqs5axUNqcvhxk2vuX8IfY7KCJvY5/9V9XFiqzARZ8hk6XVqqqQEpWIWmiHB
         TTmZlFay+NWldZs20mkv7fy1tvbmFcO/SaIjR6g/Qdnx/gybMjJ8MdKdsvbK0FOVcXn2
         /ReogbsabunlRaQCc4zXME7UqCy+n88eGDUn8eTPZCEDDLlICVBIUwSixMdFrpHQvoHL
         p4xJqGo+krLhmfcl2YzyBKy4p/74CXDtcTFd6S48SUO5NpLyPm8lwblXh2NsoJkIpeJk
         xBccHenGk6n/lPmvavwgF72AQ9XmlI02PkXNWUqDrYSnrc1S3QypRQWCB4M/XhjBmRXB
         Po4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o3DQhrUPCG5sKxkqgUFlt1ylG5y4PZh6zv3zE4khc14=;
        b=KZgv0eTnCxnMgaMMzJ1WHztGfSeXhvDUYpBpqQECmUlD4uc4vLjFMoWLOfafbFeh2Y
         t+AH4IbW9TuTHp7x4zaJFbrGtVeTdkkc4LEck6iL8zi39V3NPtF2XZM9LsSn7P9D+arz
         rZC0e5dx+G1yXLq5Et2c40rmpOuaUHhm01Gc2p9bGIWmaYSFYQoBlFOYmtDumokqaeVn
         7F8lg43omeAR9nB6dxjUimfuQ1MxRCih0J7jh3yJjphoyAOgCvDkp/zOaO0kcUz7JvCh
         2XFuwet8XElZrJvVKFi7X9l39/kGbW/Dd4snRoaQZqke6dB7Q1miqjew7R1xjaJPNoAl
         nqqA==
X-Gm-Message-State: ALyK8tI9TjReLyZqhDxwafE+fNwk3b3Tp5sV7hnChMKye4dtsJ/W/ggMlKi4kfZ4uf/mD9zWNbeeOzcoRgVoKQ==
X-Received: by 10.37.33.65 with SMTP id h62mr10115414ybh.58.1465885151265;
 Mon, 13 Jun 2016 23:19:11 -0700 (PDT)
Received: by 10.37.34.133 with HTTP; Mon, 13 Jun 2016 23:18:51 -0700 (PDT)
In-Reply-To: <20160614061752.GA11935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297268>

On Mon, Jun 13, 2016 at 11:17 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 13, 2016 at 11:14:36PM -0700, Jacob Keller wrote:
>
>> On Mon, Jun 13, 2016 at 4:58 PM, Jeff King <peff@peff.net> wrote:
>> > This was changed in 10a6cc8 (fetch --prune: Run prune before
>> > fetching, 2014-01-02), but it seems that nobody in that
>> > discussion realized we were advertising the "after"
>> > explicitly.
>> >
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>> > I include myself in that "nobody" of course. :)
>> >
>> >  Documentation/fetch-options.txt | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
>> > index 036edfb..b05a834 100644
>> > --- a/Documentation/fetch-options.txt
>> > +++ b/Documentation/fetch-options.txt
>> > @@ -52,7 +52,7 @@ ifndef::git-pull[]
>> >
>> >  -p::
>> >  --prune::
>> > -       After fetching, remove any remote-tracking references that no
>> > +       Before fetching, remove any remote-tracking references that no
>> >         longer exist on the remote.  Tags are not subject to pruning
>> >         if they are fetched only because of the default tag
>> >         auto-following or due to a --tags option.  However, if tags
>>
>> What's the difference in behavior due to pruning before instead of
>> after? Curious. It seems like pruning after would make more sense?
>
> See 10a6cc8. :)
>
> Basically, you have to prune first to make way for new incoming refs
> when there is a D/F conflict.
>
> The downside is that there is a moment where objects may be unreferenced
> (e.g., if upstream moved "foo" to "bar", we delete "foo" and _then_
> create "bar"). And due to the way refs are stored, we do not keep even a
> reflog for the deleted ref in the interim.
>
> -Peff

Ah that makes sense, thanks.

Regards,
Jake
