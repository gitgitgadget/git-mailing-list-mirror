From: Daniel Knittl-Frank <knittl89@googlemail.com>
Subject: Re: Possible git bug
Date: Wed, 14 Aug 2013 07:42:11 +0200
Message-ID: <CACx-yZ3Ba2vU4Jhjdtp1Ko=VjwarDkdHtN7ZFCzrU9Pz7-+S_Q@mail.gmail.com>
References: <9c9e5ea8a9d7e8ef37201cfb8ca9dcc3@davenport.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Hugh Davenport <hugh@davenport.net.nz>
X-From: git-owner@vger.kernel.org Wed Aug 14 07:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Tr9-0003w7-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 07:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab3HNFmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 01:42:32 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:36977 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab3HNFmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 01:42:32 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so7373258veb.37
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 22:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u/6tsi/FPbmjSbMkGBbQVn138/9SBu+WcUxqJ90uuPM=;
        b=RZwDp/KUisqkX8c1BalJ48dTT5dx7ogDPAwtxvcGwyR545s72lYTPrbMdlmv9xi316
         Z0AT7e/6+vHCzN7ml96FER98dHR1EUpGbyCByjLg9i8ovpOkg/7th1/RDRSLMNYrxU4F
         bnPDtew9l1UZ6FxG978oE4VIyfau/W9TK4BkyUCv5Z+RTJSse3CTzMA7aKdqxP6MwFwW
         NBKnw0UPAW1w5bzq66eXmINshDaFXNZK4dfVqgxrI1YDJSkUIQ+lwoXMy+JRPbtiDJ4R
         ZDa3/Y+sRoTacD5KhSpOPyDALUC3ciASzgIO6v/KbadIe+29OMiE85eaFfYoRV0xFKo4
         WPyw==
X-Received: by 10.58.100.234 with SMTP id fb10mr7965547veb.5.1376458951103;
 Tue, 13 Aug 2013 22:42:31 -0700 (PDT)
Received: by 10.58.199.37 with HTTP; Tue, 13 Aug 2013 22:42:11 -0700 (PDT)
In-Reply-To: <9c9e5ea8a9d7e8ef37201cfb8ca9dcc3@davenport.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232259>

On Wed, Aug 14, 2013 at 6:50 AM, Hugh Davenport <hugh@davenport.net.nz> wrote:
> Hey,
>
> Not sure if this is a bug or not. I commonly am finding myself wanting to
> remove some recent commits, either all or just a select few. So I use rebase
> in interactive mode for this. The problem I find is that when I do a rebase
> and leave no commits to pick (where I would think that this would do the
> same
> as a reset --hard) just tells me that there is nothing to be done.

This is left as a way to abort a rebase if you change your mind just
before actually executing it. This also works parallel to committing
with an empty commit message.

> So would that be a bug? Or maybe a feature? I would like it that when you do
> a rebase and select no commits, it will rebase ontop of the commit you
> chose,
> and remove all the commits not shown in the interactive listing (so all).

You can just use `git reset --hard <commit to rollback to>`  to
discard all commits after the given commit (Unless they're part of
another branch, of course). `git reset --soft` if you want to keep the
state of your current working directory.

Cheers,
Daniel

-- 
typed with http://neo-layout.org
