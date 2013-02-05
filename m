From: James Nylen <jnylen@gmail.com>
Subject: Re: [PATCH 13/13] contrib/subtree: Remove --annotate
Date: Tue, 5 Feb 2013 08:27:34 -0500
Message-ID: <CABVa4NiyVksEn4+NqBPXpaWGYnP6FeUqeacLOnAOHtw9FgMJdA@mail.gmail.com>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
	<1360037173-23291-14-git-send-email-greened@obbligato.org>
	<7vobfzwd8g.fsf@alter.siamese.dyndns.org>
	<87pq0frnmb.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Feb 05 14:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2iZ5-0000SV-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 14:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab3BEN1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 08:27:37 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36848 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab3BEN1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 08:27:36 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so81740vby.33
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 05:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9o6fCz6oS64mNk2N1DWbYncsGyejgiyXJZEWnGK7Nho=;
        b=OqXOsSQFiKMfWcN6Zy/gb/ng2SKXnCfrg6OCB5H6AKGn/2eJpj0PYdvPkauJ6UrPfc
         xe2uV3scd+ec4yRqX1peM03gl7QijCpdIgolhxBSgG0qjpSycsLPffugixbNf3LvOqPv
         ENXqQIwyWXiIJM6DqzKeutiugZRhmj66D26ePDjq2qTROyOz8wwaWIPO2UglRruile0j
         b1tlsW1r/zaBwkCZaDo2jC7mIIPZxhc8gmr41a0nmrvx3pj+His3gKLCe9TNunZBkzOy
         Nj6UruaNVIvIW1RAe4lTKwBR76iQXHTzicsF9AjnCdyxp4Ih1kUqKSTG/i9njm9MCFzA
         RmUg==
X-Received: by 10.58.171.38 with SMTP id ar6mr23689513vec.23.1360070854845;
 Tue, 05 Feb 2013 05:27:34 -0800 (PST)
Received: by 10.220.125.65 with HTTP; Tue, 5 Feb 2013 05:27:34 -0800 (PST)
In-Reply-To: <87pq0frnmb.fsf@waller.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215500>

On Tue, Feb 5, 2013 at 6:44 AM,  <greened@obbligato.org> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Remove --annotate.  This obviates the need for an --unannotate
>>> command.  We really want a more generalized commit message rewrite
>>> mechanism.
>>
>> That may be a good goal as the end result, but wouldn't it be a bit
>> unhelpful to remove these before adding such a "more generalized"
>> mechanism to replace them?
>
> I did think about that.  I sent out an e-mail some time ago asking for
> opinions on this.  No one responded.  Since this is in contrib/ I feel
> comfortable getting rid of this option early so that people don't get
> too attached to it.  :)

I don't agree that removing `--annotate` obviates the need for `--unannotate`.

I responded on 1/17 with what I think is a typical and normal use case
for that option:

 - add "fancylib" as a subtree of "myprog"
 - commit to "myprog" repo: "fancylib: don't crash as much"
 - split these commits back out to "fancylib" main repo, and remove
the "fancylib: " prefix

In my opinion this is a pretty normal workflow.  Commits to "fancylib"
in the "myprog" repo are prefixed with "fancylib: ", and that prefix
becomes redundant and should be removed if those commits are split
back out into the "fancylib" main repo.

I also tried to come up with another situation that would justify a
more general commit message rewriting facility, and I couldn't think
of any other good use cases that don't involve removing a prefix.  But
that doesn't mean there aren't any.

`--unannotate` is a clunky name, but I think this functionality is
worth taking another look at.  Maybe it could be called
`--remove-prefix` ?
