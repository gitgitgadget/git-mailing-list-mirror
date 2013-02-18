From: James Nylen <jnylen@gmail.com>
Subject: Re: [PATCH 13/13] contrib/subtree: Remove --annotate
Date: Mon, 18 Feb 2013 14:46:56 -0500
Message-ID: <CABVa4NhyJ0FtYoFf9ZMnVt1eR9ezoCnd0oM5xGg1fgk0RwBUKg@mail.gmail.com>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
	<1360037173-23291-14-git-send-email-greened@obbligato.org>
	<7vobfzwd8g.fsf@alter.siamese.dyndns.org>
	<87pq0frnmb.fsf@waller.obbligato.org>
	<CABVa4NiyVksEn4+NqBPXpaWGYnP6FeUqeacLOnAOHtw9FgMJdA@mail.gmail.com>
	<87sj4t4gar.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Mon Feb 18 20:47:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7WgM-00030B-17
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096Ab3BRTq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:46:58 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:54283 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab3BRTq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:46:57 -0500
Received: by mail-vc0-f170.google.com with SMTP id p16so3829362vcq.15
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 11:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PogFmtCuGXfDFwg082/zsYFdjVGc/d/5uIGfmchCuFQ=;
        b=U0ErzruwPVfakTMIqJ68MsIj3RJZOr2SJsXk95L7g1gtOPpuWyTvEOtgUZsGbYq/T1
         f1DfTVhlyfPpK5BP6XTjjd39VXtlrW6Y5o3RGEmj/y+cHmR6zUzx85czSpNVrQgPJQFf
         PfZ2nIw4FlHeiQdNNZr37vt2ax+5j7quMD6YuF4uQsrQPP91V6xRAUxCkaHlmxOMugIe
         6DT0Z3Mck0yanH6CHoCb9ZquK8cn/BnjMivZTgEwB5bb2nyWCZ7TgiZfINGzRLKdpSye
         JUBMBf2mIE9oT1v9g8v12YtKFZiCNAAG8tiZlAJscd5l5IYQdVMz/6I0oc3apCarvpcB
         R/vQ==
X-Received: by 10.220.219.73 with SMTP id ht9mr16910854vcb.47.1361216816758;
 Mon, 18 Feb 2013 11:46:56 -0800 (PST)
Received: by 10.220.125.65 with HTTP; Mon, 18 Feb 2013 11:46:56 -0800 (PST)
In-Reply-To: <87sj4t4gar.fsf@waller.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216504>

On Mon, Feb 18, 2013 at 1:39 PM,  <greened@obbligato.org> wrote:
> James Nylen <jnylen@gmail.com> writes:
>>  - add "fancylib" as a subtree of "myprog"
>>  - commit to "myprog" repo: "fancylib: don't crash as much"
>>  - split these commits back out to "fancylib" main repo, and remove
>> the "fancylib: " prefix

> Should this really be a function of git-subtree?  It seems like it would
> fit better in a history-rewriting command.  Wouldn't rebase -i or even
> filter-branch be a better way to do this?

I'm not a git guru by any stretch, so I'm sure there are other ways to
accommodate the example use case above.  I really just want to be able
to split and merge repositories while keeping meaningful commit
messages with an appropriate level of detail.  Can you suggest an
alternative workflow?

> If there's no --annotate I don't see why git-subtree should have the
> --unannotate functionality.

Because they are not inverse operations - they both apply to `git
subtree split`.  I think that `--annotate` would only be useful as an
option to `git subtree merge`.  In that case it would be the inverse
operation of `git subtree split --unannotate`, and then I would agree
that if you remove one, you can/should remove the other.

> Again, I agree that your example is relevant, maybe even common, but I
> don't necessarily think git-subtree should be in the business of
> rewriting commit messages at all.

I'm willing to accept that.  Junio seemed to be leaning that way too
in earlier emails.

> I'd appreciate more thoughts from you on this.  I want to make sure we
> can support your use case.

I currently need to enable `git subtree` manually anyway, since it's
not part of the main distribution.  So it's not a burden for me to
support this feature with a customized script, or learn a new way to
do it.

Thanks for your consideration of this small and nit-picky issue.
