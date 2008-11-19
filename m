From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Retain multiple -q/-v occurrences in git pull
Date: Wed, 19 Nov 2008 23:47:28 +0100
Message-ID: <4ac8254d0811191447q7c9c475fka30a15c21b10524e@mail.gmail.com>
References: <1226959770-4252-1-git-send-email-tuncer.ayaz@gmail.com>
	 <85647ef50811190346x11aea0fay3a8a7dfd8ddf6abc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@vger.kernel.org
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 23:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2vqo-0007ZW-4y
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 23:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbYKSWra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 17:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbYKSWra
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 17:47:30 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:25044 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbYKSWra (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 17:47:30 -0500
Received: by yw-out-2324.google.com with SMTP id 9so105792ywe.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 14:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0NT8MTmZsRW5rK+5wSKcQYX9bsMMWhBkRgMrLze8OEg=;
        b=v/E9OydcV3N++fEzj8U5Hdtd4lYbLCgJmNA1j8ovuTgp+IXy8N0DXtUXjX6vzwHFE5
         l90Ey09DFiFQWo7Evxm09DDH1tfSiHmozU08Jaql+dJquz8wVGELMA5kJEuQUjCGuzJO
         ygdKShlMPL+1auW2bYl3XtqPKQqwUwIBbUgE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nUKAWdeLVegBQKdEquT39wexIc0ix95QhaEqmq9Osp2lGS2GSpT80rXQQDFPopYx/B
         j3tNZyCATBYLO0/GLtg9yShlnz+fgRLeUK95OluJYQfUpd3Q6KDnjSDexqSzgvX52ULj
         PiUoAHcn2AXEK4qVgjocaljy92Udtk0exIs8s=
Received: by 10.65.212.18 with SMTP id o18mr1617406qbq.21.1227134848346;
        Wed, 19 Nov 2008 14:47:28 -0800 (PST)
Received: by 10.64.119.3 with HTTP; Wed, 19 Nov 2008 14:47:28 -0800 (PST)
In-Reply-To: <85647ef50811190346x11aea0fay3a8a7dfd8ddf6abc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101379>

On Wed, Nov 19, 2008 at 12:46 PM, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> On Tue, Nov 18, 2008 at 1:09 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>> To support counting -q/-v options in git pull retain
>> them by concatenating.
>>
> [rest of message cut]
>
> By the way, there is yet another way to invoke git fetch. It is "git
> remote update". Possibly it should support "-v" and "-q" options for
> consistency as well.

Yes, we could add -q to builtin-remote and also make sure that it
passes the already existing -v and maybe a yet-to-be-added -q to
the fetch command.
I want to be first sure what the overall strategy regarding -q/-v is.

Right now we have some code which uses OPT__VERBOSE/OPT__QUIET
and some new code which uses the newly-added OPT__VERBOSITY.

These are the options I can see:
1) Use the old and new macros and decide in each module which one to use
2) Get rid off OPT__VERBOSE and OPT__QUIET and use OPT__VERBOSITY only
3) Think about new ways to handle all of this. Possibly some new print_* macros?

Any opinions?
