From: Ed Hutchins <eh@demeterr.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Wed, 3 Jul 2013 10:31:51 -0700
Message-ID: <CADL+T9bbnGSxCjUBqoL3qm7Ss-j9jxorED0L1A6v1NbeLBpRQg@mail.gmail.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
	<7v38rwlola.fsf@alter.siamese.dyndns.org>
	<CADL+T9ax0maws3GR24YV77Yge7knqHd5mfuPd_AqE9b4UmvYPg@mail.gmail.com>
	<CALWbr2zJFjbaCdA3d1eaFuP4HGShAwnK=gisRD=KHKWWi-XuTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 19:31:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuQuK-0007Sw-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 19:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471Ab3GCRbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 13:31:52 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:60148 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3GCRbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 13:31:51 -0400
Received: by mail-qa0-f50.google.com with SMTP id l18so296519qak.9
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 10:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=TYU1a/QKripBdGXRjEleVwWbnFvgNlPJ02qXNtSotIg=;
        b=g1yWe0j4jw86x6RCNxlrUmuVzGytdk3/GgHzUneMH03qQ+ARc2SkDQHLFMQvYJVBcU
         qFPC3XZroZQ9O0XG9ChD2JbOa5K7O6lpvY/h0J9ohdh1nLfS1s6AgxgG7lUIOOJnJQld
         /Z9DpX2TgLS9w2aD7bxlIdSQwKlM8TbljsI42ob+mPvw1OfxK33q/JMqAC+Mdx7xo6nr
         5GWAntBf6k5P9aVMdM9tjroZbCirrohj8NRntGYqnNyhNZ5qKPDxwf10k0ytorZKCjfk
         4tWNjNLL9xdhcvwwKuA1SuG24I5nKr3M6NHF0Sx8km10V1whJ6dPNCJHbP6gS2vnO471
         bc9g==
X-Received: by 10.224.38.133 with SMTP id b5mr5267109qae.78.1372872711115;
 Wed, 03 Jul 2013 10:31:51 -0700 (PDT)
Received: by 10.49.76.234 with HTTP; Wed, 3 Jul 2013 10:31:51 -0700 (PDT)
In-Reply-To: <CALWbr2zJFjbaCdA3d1eaFuP4HGShAwnK=gisRD=KHKWWi-XuTg@mail.gmail.com>
X-Gm-Message-State: ALoCoQmYn3rFYOFDpcdoStgXhZs5kzPXhjwCGL8QzLTNKOcN24aYOx++YCr8y//kj2h+qoTHf55t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229500>

I might be able to switch our corporate workflow to adding non-ff merge
commits, but the reason we moved away from using github's big red button
in the first place was to avoid the extra noise of merge-only commits.

Actually you've pointed out an inconsistency: why is it okay for merge
commits to automatically mention branch names, but for regular commits
this is considered harmful?

On Wed, Jul 3, 2013 at 9:16 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Tue, Jul 2, 2013 at 10:34 PM, Ed Hutchins <eh@demeterr.com> wrote:
>> On the other hand
>> trying to figure
>> out the history of events from a large directed graph of commits
>> without any clue about
>> what topics first spawned each commit is actively harmful in many
>> cases (trying to display
>> a clear history of who did what for what reasons, for example).
>
> I think this is exactly what Junio does with git.git:
> - Each branch is named "$initials/$topicname" before being merged.
> - Branches are always merged with --no-ff.
>
> I think it answers your question: Who (initials) does what (topic)
> The name of the branch is also stuck as part of the history as the
> merge reads the name of the merged branch:
>
> e.g. Merge branch 'rr/remote-branch-config-refresh'
>
> You can of course provide more information than the simple commit
> header line (that would give the "what reasons").
>
> Of course, it's even easier to read if you always merge in the same
> direction (that allows you to easily find the first commit of the
> branch).
>
> Hope that helps,
> Antoine
