From: Anurag Priyam <anurag08priyam@gmail.com>
Subject: Re: Configuring the location of ~/.gitconfig
Date: Thu, 27 Sep 2012 12:10:01 +0530
Message-ID: <CAD1m08Wz7WqP8Yxgc6xuhBSntQ0PS6hGOzHWrcd0VAbARmkuUA@mail.gmail.com>
References: <CALkWK0nEP2gf4fYL=hjHg_U3X67M4PF1aupV+VJb9T6eBEo0MQ@mail.gmail.com>
 <7v6270t2tb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:40:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7m6-00053Y-5r
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab2I0Gkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 02:40:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32959 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab2I0Gkc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:40:32 -0400
Received: by pbbrr4 with SMTP id rr4so3101613pbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 23:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yTRPbGrZ0tAYCjsMYKM3xe0oVFA6WM2CcMG6hUL/EHU=;
        b=HSzU8lI9CHpmWEAjsD6p1VUd6o4IhpWSTCSSiWq8curbAER36so26YIm/L2PSq+dgR
         FjRC6X7JAr+y9RkkWZ67mBLdkfC6v7tACr+Mp78dWK8pyCqSw06dHSimt3jzS96hyCjj
         uCDjioNat9HfByF0rLGawHqA5XSVfUUgpkw+/w7DU6zgaTdqVA75SAt2DQRlsJvZD1aa
         sZTv4kztazVOrIqh+kN9lbe85pU3swGtWUFmU5yaRPuBsxEuCzMNUB8ZQS8/1elpy3Ln
         RWd5w6QynYYHt8LE3Ap2aKhT8dNDqWWeJyid1o9fb1CWKWtfLu7MUvTcm/LohwamzJya
         3XmQ==
Received: by 10.68.138.166 with SMTP id qr6mr8782911pbb.69.1348728032203; Wed,
 26 Sep 2012 23:40:32 -0700 (PDT)
Received: by 10.66.228.38 with HTTP; Wed, 26 Sep 2012 23:40:01 -0700 (PDT)
In-Reply-To: <7v6270t2tb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206465>

On Thu, Sep 27, 2012 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> I'd like to configure the location of ~/.gitconfig through an
>> environment variable.  My usecase is a simple enough: I have a
>> repository with all my dotfiles, and I don't want to symlink
>> ~/dotfiles/.gitconfig from $HOME after cloning it.  Does anyone else
>> think the feature will be useful?
>
> Not me. For that particular use case, my approach (long before I
> switched the vcs that controls my dotfiles to git) have always been
> to have ~/src that is version controlled, with a Makefile that
> builds/adjusts dotfiles appropriately for each box and installs them
> in the proper place.

Makefile is what I wanted to avoid when I suggested Ram that maybe Git
could _optionally_ read the location of global gitconfig from an
environment variable that can be exported in zshenv or bash_profile.

I don't think either way is the best way of managing dotfiles.  Just a
matter of preference.  The environment variable approach doesn't
require you to run `make` everytime you sync your dotfiles across
different machines, and that is what I like.

Also, Git allows configuring the location of template directory via an
environment variable (GIT_TEMPLATE_DIR).  Since Git has already fixed
the location of global gitconfig, it might as well read the location
of template directory from there (init.templatedir).  Why the added
flexibility?  Well, I have been exploiting the feature to manage git
templates through my zsh configuration.

-- 
Anurag Priyam
