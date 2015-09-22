From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Mon, 21 Sep 2015 23:50:05 -0700
Message-ID: <CA+P7+xpv_0Sf94FqMKJa0v0pSSEWXPRD2KQ0kmNBKC=2hrunhw@mail.gmail.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
 <1442441194-5506-2-git-send-email-jacob.e.keller@intel.com> <xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 08:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeHPK-0001hF-SB
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 08:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbbIVGu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 02:50:26 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35166 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbbIVGuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 02:50:25 -0400
Received: by igbkq10 with SMTP id kq10so75553792igb.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CmNuXeZ65/s2NkiKFycdjn/RM5c0QHrUFiwidlnvj3k=;
        b=Cj30+BaHJRzc2pbcU74pXHDOa3mpDidZegxke3OEpKLwOgZYKqv8+ahIJlmi59jZ6R
         qAUuC8CjrfRN5mWpfddNyBCo8ENJNJ6auSsD9Y7kHF/W7BykOyMLtddic/EgpFsyFP+Q
         Pdiqu2Xba7kAepqWuUWDsW2xyhMhNx7tAT8apGZr8razmF8RJeOasnccWV/uJQ+mT6V+
         2shfMV8JOop866xqdSXS4Gyxyq7dkWHJmV5Xv4hKGA/G2XLflku/TWUHV8Rxd5V88Vsh
         PPr3V8RVjmG5QKhwK+w/p4YcodzofMfrdhHWToj+ugfaozkWM80WdRjtVwFT4qeuf8A6
         1HkQ==
X-Received: by 10.50.85.12 with SMTP id d12mr647823igz.73.1442904624382; Mon,
 21 Sep 2015 23:50:24 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 21 Sep 2015 23:50:05 -0700 (PDT)
In-Reply-To: <xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278382>

On Wed, Sep 16, 2015 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The documentation for --refs says that it will treat unqualified refs as
>> under refs/notes. Current behavior is to prefix refs/notes to all
>> strings that do not start with refs/notes or notes/, resulting in
>> performing actions on refs such as "refs/notes/refs/foo/bar" instead of
>> attempting to perform actions on "refs/foo/bar".
>
> That actually sounds like a sensible thing to do, if you replace
> 'foo' with 'heads', for example, i.e. refs/notes/refs/heads/bar is a
> notes about commits reachable from the branch whose name is 'bar'.
>
> So given "refs/heads/bar", which is unqualified in the context of
> talking about references that hold notes trees, the current
> behaviour to turn it into "refs/notes/refs/heads/bar" is very
> sensible, I would think.
>

I never got any better suggestion on how to allow the behavior
desired, which is to enable merging from a non-notes location, in
order to provide a standard location for remote notes, ie:
refs/remote-notes/<remote>/<ref>

Any suggestions, if you're against this particular change?

Regards,
Jake
