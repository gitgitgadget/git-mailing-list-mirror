From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: update index mtime etc metadata
Date: Tue, 15 Dec 2015 18:17:14 +0700
Message-ID: <CACsJy8DUxBxQJxe0RzJAs7oeu0FbVhEF3OZFpHNp==1DD_Ht4w@mail.gmail.com>
References: <20151214204429.GA31013@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Dec 15 12:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8nc7-0001Ug-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 12:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbbLOLRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 06:17:46 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36348 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964803AbbLOLRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 06:17:45 -0500
Received: by mail-lb0-f175.google.com with SMTP id lt2so3433447lbb.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 03:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Asb1DgLB5WY81FN20V5Ng1Gj5HFMcDgBa3zCqLFtUGw=;
        b=UFE+z4tZTJm9FAr+8DhKv9jBlmELRBBGqnmC7SbNFvH5wEaL6lsYFG3FjJzl6DStNm
         c9CsY7FWJdgWpKTxncon9REfXrwuItErltRFG2nqErpX7+pfR3iUQqKDILt2OfMAIAAs
         3kSBHKjKBLlaztIOBZE5i1EFMMDobWIIMrQEuZUA9yKcLDMvtuv/ojuuc97Sl1gAS9iw
         lT4P8Dc1XAETVakWtwEG3fyBV1FaFNHBPZEmzWOAOdeH2OjQzijrDuYtiMcHyETfrjdo
         wetJj9Pd+xXM8UU8lfDpCc/nFEzvgPmksezXEoXDd1KaOOHXm96cCbvqr7VOkXpYquci
         c9Lw==
X-Received: by 10.112.202.168 with SMTP id kj8mr14897018lbc.12.1450178263837;
 Tue, 15 Dec 2015 03:17:43 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 15 Dec 2015 03:17:14 -0800 (PST)
In-Reply-To: <20151214204429.GA31013@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282472>

On Tue, Dec 15, 2015 at 3:44 AM, Joey Hess <id@joeyh.name> wrote:
> Is there any available plumbing that can change the mtime etc metadata
> that is recorded in the index for a file, to user-provided values? Or,
> to force the current file stat metadata to be updated in the index?

I don't think there is a way. We probably should improve ls-files and
update-index to examine and update basically everything in the index..
But so far, nothing yet.

> I know, git update-index --refresh, but I have a case where that's too
> expensive. I'm using smudge filters; I know that the cleaned version of
> the file will be unchanged from what's in the index now and only the
> stat metadata will change, and so I want to avoid
> git update-index --refresh running the clean filter, which can
> be quite expensive for a large file.
>
> At the moment I don't see a way to do it other than using eg libgit2 to
> update the appropriate fields in the index structure.

Yeah. I see libgit2 has a haskell binding, probably best for you.
-- 
Duy
