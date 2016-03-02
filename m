From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 14:37:53 +0700
Message-ID: <CACsJy8DcNrOmrKKPibV6GuSqspovBmHzUv_mRB6fZyLjw5wWzQ@mail.gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk> <xmqq8u215r25.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 08:38:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab1Ma-00027k-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 08:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbcCBHiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 02:38:25 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36664 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCBHiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 02:38:24 -0500
Received: by mail-lb0-f177.google.com with SMTP id x1so113017410lbj.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 23:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IoVG+kCJF1DuoEkZ1bwCHHYngjZqUvL+zAqT/5ZOiec=;
        b=DtFwXtrHsB/5sTzSp6/WtkkkzZeVsgYjo5HFnIPv9JmFZqSAnOsDXvH92yLwEcih7V
         qBV291eNwkGca2fhM/I0sdEzN1mgVyD69YlZWn2LwPiLYTBaVIRU9rRSSK0mgJaWli7v
         fZeYviRMMwzOwE3frJkyi6/IXukAJwI8hchHDHq3QLPKfV5Z/8D1LeP5l35cJI9R2ny2
         +QjoQm+er2a8itM5ECKV5sx9vHX7cLa67ZYbqy6nxTAIvoLu23KP7pceA0WdmMdGLvH0
         kLQUTiwaH1uwJZEekysxRvnF3PYGbHlidDvKyMRspctzV2nY8ZhZfB/DsMMbqoDepmCO
         Qv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IoVG+kCJF1DuoEkZ1bwCHHYngjZqUvL+zAqT/5ZOiec=;
        b=dn+EVd6rOu5tr0gUnSW5x4rrQdc65qV6O0SGtb7Knscka84uZqKuOdQe1YTLKdrSWI
         KJSm/Ny44sdJhqwFTYUjDwYSAz5NTIl8Cw5Np4yPsWFit5jNV2Cnsc97OQCwMgHOK9LA
         Z8K5MSqJuFoaWrqFJHvSEMV5FhmgcU3/guPKk/p4xJ07C0aIIyFC2zfNJzls0ZBK40jq
         pC7MC6eoqo1l2HpPR4zTEIcvMj153wDExCTHweK9aGd8yyShQMZbOKXKlxoeN8sjYggc
         +F2QCpF72fk9NXSiKYyXYBRs52+3jdznJ1TI6QJ65GzMKY1ze/+OeQzcauQDcETxAEGd
         VjIg==
X-Gm-Message-State: AD7BkJJGeNrm3aST6Z6CeOc7PcclZl/2+cdsrRB69WJfncAwCF5wucSmwSs2QSmFith56WQqAr3aGUx96qhgQg==
X-Received: by 10.112.140.129 with SMTP id rg1mr9996692lbb.80.1456904302890;
 Tue, 01 Mar 2016 23:38:22 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Tue, 1 Mar 2016 23:37:53 -0800 (PST)
In-Reply-To: <xmqq8u215r25.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288099>

On Wed, Mar 2, 2016 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Al Viro <viro@ZenIV.linux.org.uk> writes:
>
>> FWIW, I wasn't proposing to recreate the remaining bits of that _pack_;
>> just do the normal pull with one addition: start with sending the list
>> of sha1 of objects you are about to send and let the recepient reply
>> with "I already have <set of sha1>, don't bother with those".  And exclude
>> those from the transfer.
>
> I did a quick-and-dirty unscientific experiment.
>
> I had a clone of Linus's repository that was about a week old, whose
> tip was at 4de8ebef (Merge tag 'trace-fixes-v4.5-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace,
> 2016-02-22).  To bring it up to date (i.e. a pull about a week's
> worth of progress) to f691b77b (Merge branch 'for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs, 2016-03-01):
>
>     $ git rev-list --objects 4de8ebef..f691b77b1fc | wc -l
>     1396
>     $ git rev-parse 4de8ebef..f691b77b1fc |
>       git pack-objects --revs --delta-base-offset --stdout |
>       wc -c
>     2444127
>
> So in order to salvage some transfer out of 2.4MB, the hypothetical
> Al protocol would first have the upload-pack give 20*1396 = 28kB

It could be 10*1396 or less. If the server calculates the shortest
unambiguous SHA-1 length (quite cheap on fully packed repo) and sends
it to the client, the client can just sends short SHA-1 instead. It's
racy though because objects are being added to the server and abbrev
length may go up. But we can check ambiguity for all SHA-1 sent by
client and ask for resend for ambiguous ones.

On my linux-2.6.git, 10 letters (so 5 bytes) are needed for
unambiguous short SHA-1. But we can even go optimistic and ask the
client for shorter SHA-1 with hope that resend won't be many.

> object names to fetch-pack; no matter how fetch-pack encodes its
> preference, its answer would be less than 28kB.  We would likely to
> design this part of the new protocol in line with the existing part
> and use textual object names, so let's round them up to 100kB.
-- 
Duy
