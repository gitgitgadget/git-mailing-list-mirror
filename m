From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: git-p4: Importing a Git repository into Perforce without rebasing
Date: Tue, 19 Feb 2013 22:29:47 +0100
Message-ID: <CABYiQpnv6U2BVDB0v2Q3ia1x9FmYhNERDpE41TjE2qD5Y9L50A@mail.gmail.com>
References: <CAA5tD2sZiYcH+edbuO2Uh43zNUOyDYUO_JHpRhrLOjSqV-PfpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Russell Myers <mezner@russellmyers.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:30:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ulR-0005dR-Up
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 22:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933763Ab3BSV3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 16:29:50 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:56118 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757933Ab3BSV3t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 16:29:49 -0500
Received: by mail-vc0-f171.google.com with SMTP id p1so4562569vcq.16
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 13:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=i3qS0Q2W/Xuk4BqPrRUC8hzh1iYmO8EAQcrJUAVn57U=;
        b=Hkdkib5fyqR9+8ausPZNq93H3m5X8P1UmMCr/qk4GdZH1a5bkPJFtXLggkD+laQihX
         kLpVEYWgMx4x64+aFKK3y+W4+g1m/WIbeqTKyHm/U46c+p0Po98iu5dlUljAeu45uZy2
         uNlma38X4uQPNfGa3lRGJbIy94b19ZOrbdcHZ9AIvY3mpmk3gNd184g69/+yNI2qlY2s
         3fAXBQqzvkpUPzGOPijFUNu1411LWjRDRYzmIwUr8WvEKCxFIxnnmqje51nmTa5agSfC
         1tWz7vsJ4gtpRroD3dfo6W8z18FqoEZSG0ksSluvtoqRLjCIqRDvdhUDdg1xjD4cu+zG
         cbPw==
X-Received: by 10.52.94.17 with SMTP id cy17mr19870052vdb.68.1361309387649;
 Tue, 19 Feb 2013 13:29:47 -0800 (PST)
Received: by 10.58.135.132 with HTTP; Tue, 19 Feb 2013 13:29:47 -0800 (PST)
In-Reply-To: <CAA5tD2sZiYcH+edbuO2Uh43zNUOyDYUO_JHpRhrLOjSqV-PfpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216662>

Hi,

On Tue, Feb 19, 2013 at 3:40 AM, Russell Myers <mezner@russellmyers.com> wrote:
> I'm trying to take a Git repository which has never been in Perforce
> and push it to Perforce and having difficulty.
[...]
> I know that I could create another Git repository that has some
> commits in it cloned from Perforce and rebase on top of that; however,
> the repository I'm trying to import is rather large and rebasing would
> require me to change many merge commits. I'd like to avoid doing this.
> The repository has many thousands of commits in it.

So your history is not linear and contains merges.

> In short my question is this: Using git-p4, is there a way to push a
> Git repository into Perforce without rebasing on top of commits coming
> from Perforce?

No, this is not supported. Non-linear history would be a problem for
git-p4 too, so that alone wouldn't solve your problem. git-p4 does not
have the logic needed to submit merges back to Perforce.

- Thomas
