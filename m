From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Tue, 9 Jul 2013 09:55:31 +0700
Message-ID: <CACsJy8B0E-jM+HHuhJD0fdZL2rat3ctDbSrCPo990WPnDA17RQ@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net> <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org> <CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
 <CALkWK0ktNK49zBM4tD8fpNN3VMan7DegfWRtDcOEgTyEbSK9Uw@mail.gmail.com>
 <CACsJy8Dffc2WgtDyUS2g2gmDWG_rTxs389fHcj0ztm6pdJddjQ@mail.gmail.com> <CALkWK0k0xiNFaFmqL2t4ba2g+HSrQ8kU+W_HvnSMcMYY8VgJyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 04:56:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwO64-0001A5-SY
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 04:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab3GIC4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 22:56:05 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56363 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab3GIC4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 22:56:02 -0400
Received: by mail-oa0-f49.google.com with SMTP id n9so7214818oag.36
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AWcjYWmnd3oPNzOBoGuGCjGqTSA33GIf9GbUvfh8R6w=;
        b=MGUMu8ME+GBGcnjZ2ajY4k9nq7mIMAyDbxG5VG6OvGHVb8IShgcAIxamJBPy6rjbMO
         mqhFwSuL4XXa8fVojGdJx660/1tyvsB/zHshpodllXwZh568dP4iIyWo9QjID+oFuJGd
         vjvVMdu55GZfULfG6mM4DgYAOgrt77xyL0UtNWfgBzzpwuU0uj/uLj3P3+fJQJC9zlHH
         CrLBncK40+dsGm7lq8Ftu1zoy/9xPaOCqiS7js3KrH9EXGaR6+tW1SxTDiR1Xg3EHfUF
         x7i+iU18LqwL6chN8DPX5VuHMbE83XhruBhWvYeJw3YUFUSld2Zz9U6rweyNoXhj+RxL
         SR8w==
X-Received: by 10.182.110.164 with SMTP id ib4mr13998860obb.87.1373338561997;
 Mon, 08 Jul 2013 19:56:01 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Mon, 8 Jul 2013 19:55:31 -0700 (PDT)
In-Reply-To: <CALkWK0k0xiNFaFmqL2t4ba2g+HSrQ8kU+W_HvnSMcMYY8VgJyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229902>

On Mon, Jul 8, 2013 at 8:37 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> The short/long naming is the least I worry about. We could add long
>> names to pretty specifiers. The thing about the last attempt is, you
>> add some extra things on top elsewhere, but format_commit_item code
>> may need to be aware of those changes, which are not obvious when
>> sombody just focuses on format_commit_item. Having all specifiers in
>> one place would be better (hence no hooks, no callbacks) because we
>> get a full picture. And yes we need to deal with specifers that make
>> no sense in certain context.
>
> Yeah, it would certainly be nice to have all the format-specifiers
> that one unified parser acts on, but isn't this just a matter of
> refactoring?  Shouldn't we be starting with cheap callbacks, get
> things working, and guard against regressions in the refactoring phase
> first?  How else do you propose to start out?

I prefer a series merged to master is a complete change. If
refactoring is needed, it should be done as part of the series as
well. Two reasons:
 - We might overlook something. The best way to avoid missing is
finish and verify it.
 - A promise to do things later could happen really late, or never
happens. As you are sastisfied with the functionality you have less
motivation to clean the code. Meanwhile the maintainer takes extra
maintenance cost.
--
Duy
