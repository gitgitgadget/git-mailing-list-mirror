From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Thu, 23 Jan 2014 15:56:14 -0800
Message-ID: <CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	<xmqqsises3u0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6U8C-0000e5-U6
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbaAWX4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:56:16 -0500
Received: from mail-ve0-f180.google.com ([209.85.128.180]:36295 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbaAWX4P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 18:56:15 -0500
Received: by mail-ve0-f180.google.com with SMTP id db12so1565773veb.11
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 15:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=X3iyHqVmtxix6ck5MKBmAiZmozaJ6cXbomiOd4LJAxI=;
        b=npN5FtW52ojSNlqtvhlLMoMiee1nXNOZp+RV/ieEZWPRYEqmWR8CBfEiALNGtiS2Fc
         na9/YgUUai1rBxlAZbPhXFMNnRzVB7FMrY790byooq1XeQaoUQpPuC9fGzwiNiufzcjf
         4YF0xxHG07wOS5dNamUP+RPPraXzbWVehD8NHCOmz+gepaUoII/MitAIs64n30Dl2HqP
         vnaMGLudi9n3UGsyeVCLdYGnjRC+ctwFkmrF44paqgdjEBTh3e32j5Af8ptQsOyq0NkU
         B0AvPvM6SJF7x5k0Zl5w7eXwYkaT7ZfXFBNcw5nayd4y0E4lk3oRrBRHiy4nU/8SitrG
         EeLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=X3iyHqVmtxix6ck5MKBmAiZmozaJ6cXbomiOd4LJAxI=;
        b=TF0DAO0YTiiOoShL1kl6+hESXUqHnFpDgg3jHtgnwR/knkGrUvN/Du8SwsDl+8lTRR
         olo0145GUPPCQN19fMe8qT6LHB0nyGaHfkRjPGPZtPofctEpUn1Z62bTj8ZmTpt2IgQ6
         qh0ujhzdzQ+m8tMhcaEzMXnG/sCfN9tshx8XE=
X-Received: by 10.58.37.232 with SMTP id b8mr6067691vek.27.1390521374313; Thu,
 23 Jan 2014 15:56:14 -0800 (PST)
Received: by 10.221.8.73 with HTTP; Thu, 23 Jan 2014 15:56:14 -0800 (PST)
In-Reply-To: <xmqqsises3u0.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: MePDID3fZaJvAQv2U5YSojqVNro
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240978>

On Thu, Jan 23, 2014 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Will be fine, provided if they always use local:remote syntax, I'd
> agree.

Why? No sane user should actually need to use the local:remote syntax.

The normal situation should be that you create the correctly named
branch or tag locally, and then push it out under that name.

So I don't actually think anybody should need to be retrained, or
"always use the local:remote" syntax. The local:remote syntax exists
only for that special insane case where you used (the same)
local:remote syntax to push out a branch under a different name.

[ And yeah, maybe that behavior is more common than I think, but even
if it is, such behavior would always be among people who are *very*
aware of the whole "local branch vs remote branch name is different"
situation. ]

                   Linus
