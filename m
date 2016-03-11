From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Fri, 11 Mar 2016 03:57:12 +0100
Message-ID: <CAHYJk3Sij4tH0i29Asahjj8KBdQj59jFRTCoYzO_XE_kt3SnDw@mail.gmail.com>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
	<CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
	<alpine.DEB.2.20.1603101417590.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 11 03:57:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeDGa-0007S9-Ok
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 03:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949AbcCKC5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 21:57:15 -0500
Received: from mail-qg0-f65.google.com ([209.85.192.65]:36252 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbcCKC5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 21:57:13 -0500
Received: by mail-qg0-f65.google.com with SMTP id 14so6486211qgg.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 18:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7eHq/VoUTPwJHBdwtXcFmGQACKUgdzCqBL+phop8tz4=;
        b=p4CBLnspxwkYVIldakGCsma3irEgb3SYZQpsZ+3OFLAXOrPONrrpDXn9Jlh43IVVJA
         mEkko7NwE1/iI8w8Y9Yqh6jr78UA3N6mJRnzf1bhz6CmpMtqk6DgNdL/7+u1BvbLFqeC
         TJmcR44rJZJkDmd5Yw3mHYtWzuepVtFBSsJMoDz8T5ucmhCVSlxayTwpfdvgL4iNRrHm
         60jnjLmwF9milabH0J3x6eultphGkghlYGzxMQeg8PybcsPNFRkYtYJn5iO2BGErP1fy
         BGPgzzc7fVfIso3BGTOfrSgsB+bAlgf+iuOnOeL6smGAIktH98StZjD2cXi7q5y9DlsK
         exZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7eHq/VoUTPwJHBdwtXcFmGQACKUgdzCqBL+phop8tz4=;
        b=b58/YaQVqD8dqnCDEMlpi/XrFQZq0/jT22pJC5ffZC7yFXIUCT2QSeSsyUUuRaNeX4
         Q1+wWlO4vaM23YlEoiXYpv1Ioy93BSK+AcqZJTsJTYiMS8Ln6o3BP9TWbZAxMyCQgLVx
         v23qAtVG+O+8C32aUNYZWdFP99l9v0WCN2OzEGTNuWV8gtGMgi5ryoVY/F6PWE7iPRGC
         0JoH36vwcRxoCQkRFM6Pn6aJxGfHY/KZcgMzw20efbr3hIz/oMCGJbLXKFaAbebyI+D2
         dqUXvoo7v0AHr0m9HcgSu5vV9hUfQiH2T+gyzaJI/Sl63W9QJ/HnaWlRu7PrQD74zBfN
         9WQA==
X-Gm-Message-State: AD7BkJIRuoAC7R0Nsnx58CWGMivL0Io0IwxxSR1tzXPzZPV9LiyzNbOPc5xuNG4wRNQzPwFJM8UxL3ykPwcgTg==
X-Received: by 10.140.236.68 with SMTP id h65mr9272120qhc.13.1457665032600;
 Thu, 10 Mar 2016 18:57:12 -0800 (PST)
Received: by 10.55.177.194 with HTTP; Thu, 10 Mar 2016 18:57:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1603101417590.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288671>

On Thu, Mar 10, 2016 at 2:21 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 10 Mar 2016, Duy Nguyen wrote:
>
>> On Thu, Mar 10, 2016 at 6:34 PM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > One possible improvement would be to add "/xyz/" to the parent
>> > repository's .git/info/exclude, but this developer hesitates to
>> > introduce that feature without the "delete" counterpart: those exclude
>> > entries would likely go stale very quickly. Besides, there might be a
>> > plan in the working to exclude worktrees automagically?
>>
>> That's needed because you add a worktree inside another worktree? I
>> know that feeling, but I've changed my layout from ~/w/git as main
>> worktree (and ~/w/git/.git as repo) to ~/w/git as a non-worktree dir
>> that contains all worktrees, e.g. ~/w/git/reinclude-dir,
>> ~/w/git/worktree-config, ~/w/git/lmdb... My typical worktree add
>> command is "git worktree add ../<some-name>" then move there and do
>> stuff. No nested worktrees, no need to update exclude file (and no
>> messing up emacs' rgrep command, which does not understand .gitignore
>> anyway)
>
> This feels to me like it is working around the problem rather than solving
> it. My worktrees are inside the corresponding top-level project for a
> reason: I work with multiple projects, and having all of their worktrees
> in a single $HOME/w/ directory would be rather confusing to me.
>
> I really want to keep my Git worktrees inside /usr/src/git/ (in Git for
> Windows' SDK).

You can have /usr/src/git/master, /usr/src/git/some-work-tree, etc,
and /usr/src/git itself is not a git repository at all. That way
/usr/src only has one git-related directory and no worktrees are
nested. The only downside is if you work in master most of the time,
you have to type "/master" more. I think this is what Duy suggested
too, but you interpreted it as having /usr/src/git-master,
/usr/src/git-some-work-tree etc?

-- 
Mikael Magnusson
