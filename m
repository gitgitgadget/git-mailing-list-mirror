From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Big Java repositories to play with?
Date: Wed, 7 May 2014 16:01:01 +0200
Message-ID: <CACBZZX7STWGniKtn7yB=Ea6YVkHkzNW4CtLBxFHwr0JDWs3q+Q@mail.gmail.com>
References: <CACsJy8ArsQMBA3hq92u-6N9MCLYBgTRa_NYDm3QKjmKq25__oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 16:01:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi2PY-0004ab-EH
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933164AbaEGOBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:01:23 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:41335 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933258AbaEGOBW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:01:22 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so1269595oag.28
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HA8iL1h+9gPo8NQpmaaUl5GMW8sgeLQLsXRjwO9PF0Y=;
        b=qFPs4c63aUVpw0bOGxaeDsbIEGC1JQ0ECaYgAPFobFkaW4F9Q2D1f3qyk600YDOd8n
         X3sQcMehcnsxnPcgjobHLHLDyIZYq5JAQOiT+F2VpGLNN9OmSbj9RtUqFLfEgIUtvAO1
         9L7xoRsVqDZ4BvTccfrk15Snsy0Qgg4dNJ0D70LpeSbredvFYefIt0B5o0W6EfI01Q+h
         813zggd49twNRd3HnKH4nxpwMDbx2oUG9/e/uCVc0yE9fVfRBaF5sW3vSlw4NJrH9zZV
         kNJevei59vc/UAF1cgCxLNlgyi7lLZbN00bkMegrk+LY9JNBkiXVeJMkNsz0HSJz2QJe
         vhrg==
X-Received: by 10.182.38.199 with SMTP id i7mr3166836obk.68.1399471282047;
 Wed, 07 May 2014 07:01:22 -0700 (PDT)
Received: by 10.76.176.40 with HTTP; Wed, 7 May 2014 07:01:01 -0700 (PDT)
In-Reply-To: <CACsJy8ArsQMBA3hq92u-6N9MCLYBgTRa_NYDm3QKjmKq25__oQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248303>

On Wed, May 7, 2014 at 3:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> I need some big Java repos (over 100k files) to test "git status".
> Actually any repos with long path names and deep/wide directory
> structure are fine, not only Java ones. Right now I'm aware of
> gentoo-x86 and webkit. Let me know if you know some others. I'm afraid
> my Google-foo is not strong enough to search these repos.

1. Take a small repo with a small src directory
2. for i in {1..100}; do cp -Rvp src src-$i; done
3. git add src-*; git commit -m"bigger"

For some value of 100 you'll end up with a big repo to test "git status" on.

You just need lots of files to stat(), git status doesn't care about
history, so there's no reason why you need to track down an existing
large repository.
