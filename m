From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Tue, 1 Jan 2013 09:17:38 -0800
Message-ID: <CAJo=hJsZedd0kfYJnXPhcud8bz3mgU0NMf6O6-_PY1yqv-EfDg@mail.gmail.com>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net> <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net> <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net> <20121230120542.GA10820@sigill.intra.peff.net>
 <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
 <20121230213124.GA15946@sigill.intra.peff.net> <CAJo=hJtjtpiPVd6Koy9q5je7s7A4EyDa-CptJNCnHLSLgd9W7g@mail.gmail.com>
 <CACsJy8CygfaM+Ee6rURFB-cP2khO8URGDJMG2f3mqg0ebYz+8Q@mail.gmail.com> <CACsJy8DpnO6X6jdQVsr1NwrXF2MDBBcHZQTay=TyLFc5p_z9eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 18:18:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq5UI-0002Nx-FS
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 18:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3AARSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 12:18:01 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:55073 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab3AARSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 12:18:00 -0500
Received: by mail-ie0-f170.google.com with SMTP id k10so16074536iea.1
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZYf447TMJTUoBeI/TAiKpaljdnjHwycrEKFqMb5GRgc=;
        b=AZNkTEh4/Irr356Fn2QtorhyJTrTYFpNwz/3S6oEQwCKRRiTklj3HkJMlF3LWrL6yr
         raH/FCd8C9Gs+r/jsfDviu7pzUi3iuIneW1kx6VJvL3ulIRRNEn+5pcsm+qQjGgZmJwj
         2V+Si1qOF95rIujI6E/NHfhXMHhfz1FGz6+lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=ZYf447TMJTUoBeI/TAiKpaljdnjHwycrEKFqMb5GRgc=;
        b=Cj6jloSznxxspUKNqwDyXbfWOhHMbGOVKfCAuJ+fUpFQ/Vxd8e+t6gXlxwlVQJ0CUf
         54cZQC6aCmjWMQiGuO59Yehq18y0ryXD+R2GV3h0Bqtba9Si1cOBpsL9HLIuR/Gg44X3
         wIV/H4jxJPTBfs8vgW2CHHbQTTHv+rXC9p1s/pWLwAzhpkyMftVE8Va87OPuacSA38o1
         lCSWc5Cs2mJq3Zo04TFgKLvFQbYdK4d9uSSj8pHRI+89EDCiIFQXAqUzfDWy4KKisnJI
         Am3BP5iQbDBiw9htUZdJpPKvVh9+kBIRPcnewSjDp0vfBl6B4ZJV0cW/Wz17NQsmguEf
         kcaA==
Received: by 10.42.58.202 with SMTP id j10mr32812179ich.39.1357060679345; Tue,
 01 Jan 2013 09:17:59 -0800 (PST)
Received: by 10.64.142.102 with HTTP; Tue, 1 Jan 2013 09:17:38 -0800 (PST)
In-Reply-To: <CACsJy8DpnO6X6jdQVsr1NwrXF2MDBBcHZQTay=TyLFc5p_z9eg@mail.gmail.com>
X-Gm-Message-State: ALoCoQl0RIWYUTeuzjdrwlFRwrWtJup8Z8aw0PO9Tjw27ak2URsLK1bRRhdOIPTQvevbMEZRP3Hi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212427>

On Tue, Jan 1, 2013 at 4:10 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jan 1, 2013 at 11:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> Fix pack-objects to behave the way JGit does, cluster commits first in
>>> the pack stream. Now you have a dense space of commits. If I remember
>>> right this has a tiny positive improvement for most rev-list
>>> operations with very little downside.
>>
>> I was going to suggest a similar thing. The current state of C Git's
>> pack writing is not bad. We mix commits and tags together, but tags
>
> And I was wrong. At least since 1b4bb16 (pack-objects: optimize
> "recency order" - 2011-06-30) commits are spread out and can be mixed
> with trees too. Grouping them back defeats what Junio did in that
> commit, I think.

I think you misunderstand what 1b4bb16 does. Junio uses a layout
similar to what JGit has done for years. Commits are packed, then
trees, then blobs. Only annotated tags are interspersed with commits.
The decision on where to place tags is different, but has a similar
purpose. How blobs are written is very different, Junio's
implementation is strictly better than JGit's[1].

So we can use pack ordering. There will be a gap because of tags, but
if we assume there are less tags than commits, it will still be a
reasonable cache file size.

[1] I have known this since he was developing this commit. We talked
about clustering by delta chain and the improvements it showed in
CGit. I tried to implement a similar delta chain clustering in JGit
but broke something in the packer and caused data corruption, so its
stalled.
