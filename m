From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Fri, 10 May 2013 17:33:20 +0700
Message-ID: <CACsJy8AjrPvcSDBm2GZQ_HAEhXKz9d06QxSjBthX2fCU0QNUGA@mail.gmail.com>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
 <518C8EAC.6000106@viscovery.net> <7vzjw349y0.fsf@alter.siamese.dyndns.org>
 <CACsJy8CopioiTrEDfuZK=n1DfJ8_chxV9dEObqpVfHHmJvzyqQ@mail.gmail.com> <7vvc6r4855.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 12:33:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UakeB-0001fl-Jv
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 12:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab3EJKdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 06:33:51 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:60670 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab3EJKdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 06:33:50 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so4689099oag.2
        for <git@vger.kernel.org>; Fri, 10 May 2013 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=c1gO5j0uCudT/Dud3P0uBHSrWnUThwpfQpWxvbe1wgU=;
        b=YyLObOHBJ0qKp4VzL7OGBAuuHKeRnnh84zFW+JcyIrJMm9E02rF0jJ+SAF8VaHIOzb
         eZMTLS/6cjiXtGIrNI8fHaeY9plJdWzuTHXcoEnbCP+9+3/M0PNbVz5r+VPL80e+339j
         Dri6rQw0d/areu8yzVbrvwZaFqZ1ET2zJYhOOOZtk2Po4fB6ixzXHntLuSKfJrRT2yJ2
         rg0NcBqCq/vgKYFiYLLN+RiuF6t6MFwwNmfOXNLXtLucdPa/I2mxd6pcTQ8Mli/QeHiY
         Xeur7dSqqalcpLJRyBHsOGzyq9U+xIevkhRA5wL16lWlGYfohMHZvtjOQa+cpy2sOjz8
         kv8A==
X-Received: by 10.60.84.102 with SMTP id x6mr6621163oey.73.1368182030354; Fri,
 10 May 2013 03:33:50 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Fri, 10 May 2013 03:33:20 -0700 (PDT)
In-Reply-To: <7vvc6r4855.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223831>

On Fri, May 10, 2013 at 2:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, May 10, 2013 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> Imagine that a user runs "git rebase" on a history leading to commit
>>> X to create an alternate, improved history that leads to commit Y.
>>> What if we teach "git rebase" to record, perhaps by default, an
>>> "ours" merge on top of Y that takes the tree state of Y but has X as
>>> its second parent, and "git log" and its family to ignore such an
>>> artificial "ours" merge that records a tree that is identical to one
>>> of its parents, again perhaps by default?  "git log" works more or
>>> less in such a way already, but we might want to teach other modes
>>> like --full-history and --simplify-merges to ignore "ours" to hide
>>> such an artificial merge by default, with an audit option to
>>> unignore them.
>>
>> What about git-merge? Will it be fooled by these merges while looking
>> for merge bases?
>
> I thought it was obvious that we should ignore the side branches
> that were superseded this way, as by definition they did not
> contribute to the end result at all.
>
> But there must be something huge that I missed; otherwise you
> wouldn't be asking such a question. It is already late and my brain
> is no longer quite working, so I cannot figure out what it is X-<.

No, I was at work and could not spend more time thinking about it (I
asked stupid questions all the time, you should know ;). You were
right, these multiple parent commits have nothing to do with merge
bases.

Although I think this is an abuse of merge commits. Maybe git-notes is
a better way to publish rebase history.
--
Duy
