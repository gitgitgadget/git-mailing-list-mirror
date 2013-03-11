From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 18:10:42 -0400
Message-ID: <CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
	<494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
	<CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
	<205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
	<CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
	<B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de>
	<CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
	<3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
	<513B8037.7060107@gmail.com>
	<C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
	<CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
	<E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Mar 11 23:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFAw2-0008Py-9g
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 23:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab3CKWKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 18:10:44 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36167 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab3CKWKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 18:10:43 -0400
Received: by mail-wg0-f43.google.com with SMTP id e12so5345352wge.34
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Vsi/IjWnU33M5Fs8y7I3r3O1gh9BZKN32T9F2oLPzSc=;
        b=zIUjHxjYOqeeld81zvHUH3v2UgA/WN/XcYhQJrOisUmmX2wituUbcgT0G+0eqKJd2L
         BdqTuIf2Y6BUpp1lSh2nNLBXxhdH/F1PuLduNnv9hqawptDHutRDO4NFamR+SrMem20R
         5y7LjfQKBOpZMAHxEqLi5e7NNCDcueDAFIm61rcJdXC2Du1/5MgupNNNUoN55mVAo/u7
         5VuS2oq55ZGAGNuGloXYgHoiCcy87UkBSTaluSJWqCWcxsxEIuGOMRrABGkEU2R/grZn
         Plncqb6tTR6Jg2SaP72XgMD8pZNWlwJyREmzzOZ+kpkpIwfvKXakKlTTRBXGLBoX6Qg7
         9l5Q==
X-Received: by 10.180.81.164 with SMTP id b4mr15689923wiy.34.1363039842316;
 Mon, 11 Mar 2013 15:10:42 -0700 (PDT)
Received: by 10.194.138.107 with HTTP; Mon, 11 Mar 2013 15:10:42 -0700 (PDT)
In-Reply-To: <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217918>

On 3/11/13, Max Horn <max@quendi.de> wrote:
> PS: Just as a side note, I should mention that I have done tons of rebases
> on various repositories on this very machine: same hard drive, same file
> system; the git version of course has changed over time, but as I already
> described, I can reproduce the same issue with older git versions.

What if you do a "git clone" from this repo to an entirely new repo? I
wonder if the rebase issue still happens in the new repo...

Could you also post the .git/config file from the repo?

If supported, git could actually make use of threading when doing
"stat"... it should be disabled by default though, but you could try
disabling it with this config:
    git config core.preloadindex false

But I don't know why that'd only affect this one repo and not the
others though...
