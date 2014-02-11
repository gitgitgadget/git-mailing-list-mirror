From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Profiling support?
Date: Tue, 11 Feb 2014 20:18:52 +0700
Message-ID: <CACsJy8BAD3cm2BLSapJ2fhkGiYjDKqW1TQ1yu0XPwTyEfL2oLQ@mail.gmail.com>
References: <87d2itc2zv.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 11 14:19:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDDFI-0004QG-KT
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 14:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbaBKNTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 08:19:24 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:64392 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbaBKNTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 08:19:24 -0500
Received: by mail-qa0-f45.google.com with SMTP id ii20so11542487qab.18
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K5LwnMLe3KFIpoV/EupbvqPWLsEbwNAOcrPKNnL0ccs=;
        b=rDq5ywo41lg75M/p03ytTpXebhwdA4+2T+bhoOsyvqCiB566esmSPpH7t6em/4B9Id
         gBspnJmUr8wFyCYVOVaOhZk0/p9VjSHbO12F9ON9ssR+OAY7fZsUhsz0LrTACDhYZ+rh
         TtbxbS2d9zn434K9KKi1gBiXq8mqS5YvSz8t20kNkbKeBXTuTf1ENLZOLeoWPpq3p2nu
         e/CywYKvmfTxlftQdOFB0ypZ/9kXbFdUZycOS1GkF3/bHdRqmLsSv/ZVEGbqr0UtTqNq
         glic+W9+OgcyTsaeXcJzFwfAYm9W67IGqCWjwa2gNwZKcK/BhnFRFAfSgVQYgMbMhdym
         3HQA==
X-Received: by 10.224.49.69 with SMTP id u5mr57519956qaf.88.1392124763265;
 Tue, 11 Feb 2014 05:19:23 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 11 Feb 2014 05:18:52 -0800 (PST)
In-Reply-To: <87d2itc2zv.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241943>

On Tue, Feb 11, 2014 at 6:17 PM, David Kastrup <dak@gnu.org> wrote:
>
> Looking in the Makefile, I just find support for coverage reports using
> gcov.  Whatever is there with "profile" in it seems to be for
> profile-based compilation rather than using gprof.
>
> Now since I've managed to push most of the runtime for basic git-blame
> operation out of blame.c proper, it becomes important to figure out
> where most of the remaining runtime (a sizable part of that being system
> time) is being spent.  Loop counts like that provided by gcov (or am I
> missing something here?) are not helpful for that, I think I rather need
> the kind of per-function breakdown that gprof provides.
>
> Is there a reason there are no prewired recipes or advice for using
> gprof on git?  Is there a way to get the work done, namely seeing the
> actual distribution of call times (rather than iterations) using gcov so
> that this is not necessary?

Would perf help? No changes required, and almost no overhead, I think.
-- 
Duy
