From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Sun, 29 Jun 2014 21:42:24 -0400
Message-ID: <CABURp0pwWRjocTbbRLG4tkd_W8ZPswMzwoUhe4geUF6bGdVoKQ@mail.gmail.com>
References: <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com>
 <66A60DA77398CD439FA676CEF593977D52477A@exchange.1.internal.pdinc.us>
 <CEAC9BE9F83B4CD0AFD73BBAC8A54232@black> <CABURp0okCDbwLOL3Osj2WtfQ_Qj3v=1FrAV28gJjPy1yzQU7Vg@mail.gmail.com>
 <CABURp0qZVMGMQ8X4P0P1OGF9gNqu__=Uk+Lr7GyBbscm5wL1=w@mail.gmail.com>
 <35E240FD8DD74A2F9B80FFCBD818A122@black> <CABURp0q1u_Hzz2ni63oHuinFpBTCzZ+=-6h5YpC0k_bQ_03TSA@mail.gmail.com>
 <CBA6D67B4439423CB4F73F3DD3C08952@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Mon Jun 30 03:42:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1QcL-0004iT-TD
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 03:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbaF3Bmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 21:42:45 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:60892 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbaF3Bmp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 21:42:45 -0400
Received: by mail-vc0-f171.google.com with SMTP id id10so6890098vcb.16
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LfDASqrfShIx8o30InKznkL267kX+nbfzn5z/DCYtRk=;
        b=PBsOCHRvMAfLrRhyIL7S4TB32a6HkzNJJtrKRxnv/oYrRfthOKtjJ7+4/FTFAb6Y/u
         0lDzR3j3iVE4PGnZ77V6CGj/b1Yr9Tm3leuvXtbC9a6SPo++NYPpaeznh26k0nTRjftN
         aKoRgoADR4LAfP9yZF8HzrUFYi+q3EkaWfBazyRG+ADPtoxQnpy5Y5Ov3W5FAdLUVq5N
         2/Qn83ibd0CT6QEr/TEjhd5CJ2BQPKsluIgmR5EooBBVcag6BoINsmm06jOIQBiAzhj+
         dGwWjLrMEv2uKRyy5VGaXWscPm22Irv7DKyzaiVYhI0nR0N2/5Qzt+7/shm18WyvJ7GP
         9UzA==
X-Received: by 10.52.96.8 with SMTP id do8mr29353808vdb.4.1404092564490; Sun,
 29 Jun 2014 18:42:44 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Sun, 29 Jun 2014 18:42:24 -0700 (PDT)
In-Reply-To: <CBA6D67B4439423CB4F73F3DD3C08952@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252651>

On Sun, Jun 29, 2014 at 5:13 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> -----Original Message-----
>> From: Phil Hord
>> Sent: Sunday, June 29, 2014 16:27
>>
>> On Sun, Jun 29, 2014 at 4:20 PM, Jason Pyeron
>> <jpyeron@pdinc.us> wrote:
>> >> -----Original Message-----
>> >> From: Phil Hord
>> >> Sent: Sunday, June 29, 2014 16:09
>> >>
>> >> On Sun, Jun 29, 2014 at 11:31 AM, Phil Hord
>> >> <phil.hord@gmail.com> wrote:
>> >> > On Fri, Jun 27, 2014 at 8:42 PM, Jason Pyeron
>> >> <jpyeron@pdinc.us> wrote:
>> >> >> Sorry for the http://pastebin.com/1R68v6jt (changes the merge to
>> >> >> 1ca13ed2271d60ba93d40bcc8db17ced8545f172, and manually
>> >> reconciles the merge),
>> >> >> but it was too long to be readable in the email.
>> >>
>> >> Ok, I think I understand the issue you are trying to solve now.
>> >>
>> >> Git (rather famously[1]) does not record renames or copies.  It is
>> >> expected instead that renames and copies will be detected
>> when it is
>> >> important after the fact. This allows us to ignore rename detection
>> >> and resolution when creating project history; in the future, better
>> >> rename/copy detection will "just work" on existing repositories and
>> >> the repos themselves will not need to be adjusted.
>> >
>> > Looking at http://pastebin.com/1R68v6jt , I have a work around.
>> >
>> > In summary, 7.git cherry-pick -x HEAD..rebranding , then
>> >
>> > git merge $(echo 'Merge of
>> 1ca13ed2271d60ba93d40bcc8db17ced8545f172 branch -
>> > rebranding' |\
>> >     git commit-tree -p HEAD -p rebranding \
>> >          $(git cat-file -p HEAD | grep ^tree | sed -e
>> 's/^tree //') )
>> >
>> > Now it is perfect in the blame and log --graph.
>>
>> Yes, but your workaround unnecessarily duplicates commits and
>> complicates the history of your project. You are munging your project
>
> But I want to avoid thet complicating, while still showing that line 42 was
> modified by X. Should this be possible with a merge, without using cherry-pick?

I think it should.  But there are other complications in your project
which may be getting in the way. You are merging two branches with no
common ancestor.  When git walks down either path looking for the
source commit for each line, it finds two sources for it.  For
example, it reaches commit 39ebb06 which appears to be the origin of
all lines in that file since it has no parent. I imagine this could
act as a short-circuit to further searching.  Furthermore, I'm not
sure how git should know any better.

It seems you already have a merge point for these two branches, but I
haven't looked deeply into how that merge was done.  But I think the
multiple disconnected branch histories may be the cause of the
confusion.

> Btw I am not able to pull up https://git.wiki.kernel.org/ or
> http://git.wiki.kernel.org/


That is strange.  It works for me here, and I am just a user like you.

Phil
