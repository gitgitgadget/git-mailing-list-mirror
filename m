From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 23:01:20 +0600
Message-ID: <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
	<CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
	<CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
	<CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
	<20131122151120.GA32361@sigill.intra.peff.net>
	<CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
	<CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 18:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vju6g-0005H7-GG
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 18:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab3KVRBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 12:01:21 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:61714 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab3KVRBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 12:01:21 -0500
Received: by mail-ve0-f173.google.com with SMTP id oz11so1088198veb.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wqaHN+cg1RpAKVOCkiJdxjMRL4FYLASRJSigXrZHgIw=;
        b=YcvN/IvI/na6xzK7IBEa+aVrXz6rPOatx9YZEsbmcbG9PDHYWq4lKTgoWTYbJeBRvl
         DN3KgvH1cGMJ/2Ow2Dxm9/ph3lfMGp2CcgQb21V4sYrp9uCMeG7pvig7ocybswlOWqdy
         XMKP6xENujEue2JiUWKFxHsyufdfuhqxeb6w0Oq1ApskhlLZarObI+r7wdBIsGKaoDq7
         K7BhTlISCChZZO2rsIYjW1fzjfjK2NShqXdyzcqBA9FDQqxybPcKqqct2EB3knNI5NtC
         Tf6GciCpnIdK3QuE8xrNlEDJv64qeXO9Eq+3kYrtHHw1XkwSaPl7GPftG2uJzvjDvgL5
         0AkQ==
X-Received: by 10.58.207.76 with SMTP id lu12mr79174vec.30.1385139680453; Fri,
 22 Nov 2013 09:01:20 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 22 Nov 2013 09:01:20 -0800 (PST)
In-Reply-To: <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238197>

Ah, didn't notice you're the author of that pull-request Ramkumar :)

So guess issue with arc can be considered solved now. But i'm still
collecting more details about how to manage to commit change addons
hash without arc command even (it happens to Campbell Barton really
often).

Will report back when we'll know something.

On Fri, Nov 22, 2013 at 10:35 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Sergey Sharybin wrote:
>> Ramkumar, not actually sure what you mean?
>>
>> For me `git diff --name-only HEAD --` ignores changes to submodules
>> hash changes.
>
> `git diff --name-only HEAD --` compares the worktree to HEAD (listing
> both staged and unstaged changes); we want `git diff --name-only --`
> to compare the worktree to the index (listing only unstaged changes),
> as Peff notes.
>
>> Also apparently it became a known TODO for phabricator
>> developers [1].
>
> That was me :)
>
>> So, after all is it expected behavior of ls-files or not and if not
>> shall i report it as a separate thread? :)
>
> Actually, I doubt it's worth fixing ls-files. Your problem should be
> fixed when this is merged (hopefully in a few hours):
>
>   https://github.com/facebook/arcanist/pull/121
>
> Cheers.



-- 
With best regards, Sergey Sharybin
