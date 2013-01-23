From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 09:46:04 +0100
Message-ID: <CAFXTnz6_8uUOCiR1MFJuYKjbtXKK4=8g-saz5Hf_KRF3EdPwEw@mail.gmail.com>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
	<CACsJy8CTJ--u+KCYmK-2+K3NpEn72xnYwh_Pb+3Wn7nEtL1gqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:46:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txvyc-0006Fi-6v
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 09:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab3AWIqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 03:46:08 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:57411 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab3AWIqG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 03:46:06 -0500
Received: by mail-bk0-f54.google.com with SMTP id w5so962814bku.41
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 00:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lddRhUycAECtEDsO/S3YbIVDk/zNQ0oFIGZxw9Lb5xk=;
        b=STS9bitA4Y5AMOhy5R8y7FRuYXth/7X0+4r6SCj52JUTIZc5zPBjK7jyjpd/SFXN1s
         5NziwlVxbZ0WP5jPNnC3kKkLZWXMjAVsCdU48JF2yGdQkLi7d1G5ylBGZweLEgoN706r
         kHHkTTNOJIngrvgHucb14p7tcA9gSpx54cVFZZ6DFKxqrtqhaXCX5etgh1DPCIJVU3sO
         ve8+v71v30Gk2xYL6FPlJyJ7cNxuqbf91VKSvGbKLQ7tzmbmphtHK9JEXMzyVbmw29BB
         l1nYdHvPokSumesKnAcdfbIfB9pULslMUMMJeAcRHo5hyYRs/w3zZ+7Sfdl7i6LiMosy
         Y1Zw==
X-Received: by 10.204.147.67 with SMTP id k3mr127028bkv.117.1358930764651;
 Wed, 23 Jan 2013 00:46:04 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Wed, 23 Jan 2013 00:46:04 -0800 (PST)
In-Reply-To: <CACsJy8CTJ--u+KCYmK-2+K3NpEn72xnYwh_Pb+3Wn7nEtL1gqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214299>

On Wed, Jan 23, 2013 at 9:39 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 23, 2013 at 4:10 AM, Lars Hjemli <hjemli@gmail.com> wrote:
>> When working with multiple, unrelated (or loosly related) git repos,
>> there is often a need to locate all repos with uncommitted work and
>> perform some action on them (say, commit and push). Before this patch,
>> such tasks would require manually visiting all repositories, running
>> `git status` within each one and then decide what to do next.
>>
>> This mundane task can now be automated by e.g. `git all --dirty status`,
>> which will find all git repositories below the current directory (even
>> nested ones), check if they are dirty (as defined by `git diff --quiet &&
>> git diff --cached --quiet`), and for each dirty repo print the path to the
>> repo and then execute `git status` within the repo.
>
> I think it should leave out the execute part. The command, say
> ls-repo, lists repositories in specified state. The execute part could
> be easily done by
>
> xargs -I{} git --git-dir={} status blah

Not so easily on windows, which I need to use at $WORK :(

--
larsh
