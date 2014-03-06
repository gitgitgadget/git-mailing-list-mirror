From: Maurice Bos <m-ou.se@m-ou.se>
Subject: Re: [PATCH] git-prompt.sh: make '+' work for unborn branches
Date: Thu, 6 Mar 2014 22:19:43 +0100
Message-ID: <CABbCQwsKFWjk1Nzc9jmpyNdbXC+mOf5qfNg77PoiXrUOmrq6uA@mail.gmail.com>
References: <20140305233219.A6FF54284F@server> <20140306204026.GC29659@sigill.intra.peff.net>
 <CABbCQwskqZzzRXm5K3dnOfRoAcx8jpsdskngmN7f1EvY6BONgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 22:20:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfiA-0001Xe-94
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbaCFVUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:20:07 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33967 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaCFVUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:20:06 -0500
Received: by mail-wg0-f47.google.com with SMTP id x12so3935729wgg.30
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 13:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:dkim-signature:mime-version:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=finKZNm4lZaUajlWVHkdx+2veUm64p9zY7Yuz4NuDxI=;
        b=AbMoHDmz2r28ppLytVL3IIoTeFY8MfoJfOY83eE9LgIN4VR0W2xB2PilAyG4RW7ihU
         sDyNpFYFsFmW/i53vR9BGn6T9kiRv1Cv8CHOrJWT7kgbGDIucc9d8/509/AV5abEbjZu
         pGhUbHvVa4t6hLNTYYYj3CL4L8ZXevqMZ3C/ycYLRaBWTfAcyGImwfxsNwwwauCl3Y80
         KVatMyJxDZWNMWSDmZNJ7edHIXu/HQ709T6nFcyechpfvjPfLQ95O4G9rdjwVZPj93lY
         K7pF2a/j+brDfxe8EZl/lrFUemq9eeA4dgQN4S8XgTd3uhQkjaj8429yNrAYrPmHKBn9
         /zQg==
X-Gm-Message-State: ALoCoQmvmB7lHecEyXKI6WjV5MmPo/H9zQU3Atoi4y8ywupHgrUR1MMDmObtTbmXEA23viaWi6Dw
X-Received: by 10.194.170.167 with SMTP id an7mr13562351wjc.39.1394140803883;
        Thu, 06 Mar 2014 13:20:03 -0800 (PST)
Received: from mail-wg0-x229.google.com (mail-wg0-x229.google.com [2a00:1450:400c:c00::229])
        by mx.google.com with ESMTPSA id g5sm3764847wjs.8.2014.03.06.13.20.03
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Mar 2014 13:20:03 -0800 (PST)
Received: by mail-wg0-f41.google.com with SMTP id n12so3942137wgh.12
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=m-ou.se; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=finKZNm4lZaUajlWVHkdx+2veUm64p9zY7Yuz4NuDxI=;
        b=XVjQYzRZ/t3b97aVnWjlUwZb39GJE38YRNfZ/TV+jzzmq1fa7NzN0JY0afLvkhgc+c
         N99ds7MNJmPWkeSuuBNe8sKmXU+qAHLEta5W31AdpD45X5B3Iv+UIQon+zn08sTRtoH5
         0iKi20G8e1nVf2EV3SP/E3qLZ70yznEq5itgc=
X-Received: by 10.194.82.69 with SMTP id g5mr13291937wjy.85.1394140803219;
 Thu, 06 Mar 2014 13:20:03 -0800 (PST)
Received: by 10.227.205.3 with HTTP; Thu, 6 Mar 2014 13:19:43 -0800 (PST)
In-Reply-To: <CABbCQwskqZzzRXm5K3dnOfRoAcx8jpsdskngmN7f1EvY6BONgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243554>

I have no clue why git diff --cached isn't used instead of git
diff-index. I was wondering about it, but I decided I don't know
enough about git and there are probably valid reasons for doing it
this way. Though, replacing it with with git diff --cached seems to
have the exact same behaviour, as far as I tested. That would make the
patch a little prettier, as it doesn't contain the empty tree id any
more:

@@ -407,12 +407,11 @@ __git_ps1 ()
         if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
            [ "$(git config --bool bash.showDirtyState)" != "false" ]
         then
-            git diff --no-ext-diff --quiet --exit-code || w="*"
-            if [ -n "$short_sha" ]; then
-                git diff-index --cached --quiet HEAD -- || i="+"
-            else
+            if [ -z "$short_sha" ]; then
                 i="#"
             fi
+            git diff --no-ext-diff --quiet --exit-code || w="*"
+            git diff --no-ext-diff --quiet --exit-code --cached || i="$i+"
         fi
         if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
            [ -r "$g/refs/stash" ]; then


Unfortunately, I don't know much about git diff-files, so I don't know
whether it could be used instead.

In another version I used myself, I indeed used 'git status
--porcelain' and used regexes /^\w/ /^.\w/ and /\?/ on the output. It
seemed to work fine, but it's a bit stupid that it lists all the files
when it could stop almost directly. An
--extremly-short-porcelain-or-whatever-you-would-call-this option that
would just output whether any file is dirty and/or indexed or
something might be useful, though maybe a bit too specific.
(--summarized ?)

-Maurice-


 2014-03-06 21:40 GMT+01:00 Jeff King <peff@peff.net>:

> On Thu, Mar 06, 2014 at 12:05:24AM +0100, Maurice Bos wrote:
>
> > For unborn branches, it now compares the index against the empty tree.
> > (Just like git status does.)
>
> Sounds sensible, although...
>
> > -                     git diff --no-ext-diff --quiet --exit-code || w="*"
> > -                     if [ -n "$short_sha" ]; then
> > -                             git diff-index --cached --quiet HEAD -- || i="+"
> > -                     else
>
> I notice the old code uses "git diff" immediately above. If we used "git
> diff --cached" here, too, I think it already knows about this empty-tree
> magic.
>
> That being said, it seems odd that we are using "git diff" in the first
> place, and not "git diff-files". This seems to blame all the way back to
> 738a94a, when the functionality was added in the first place. Am I
> missing some reason we can't use diff-files (maybe we want the
> index-refreshing side effect)?
>
> -Peff
>
> PS I thought at first that this could just use "git status --porcelain",
>    which also knows the empty-tree trick.  But that command has no way
>    to quit early on the first change.
