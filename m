From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 23/32] prune: strategies for linked checkouts
Date: Sat, 20 Sep 2014 23:01:51 -0400
Message-ID: <CAPig+cRX6z2ReKqES_2SP4mVruCDNRyo62_deo3ukuUYcYaKiw@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-24-git-send-email-pclouds@gmail.com>
	<5411C16C.9010406@xiplink.com>
	<CAPig+cQGeEzrx9N1Rrxhf--gphWSam88BV06AJTA=6-YZvQ4Tg@mail.gmail.com>
	<CACsJy8BLEfB6RQZTxqF82-tJmKQgnNC12QvKu8KZq=Vr059s3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 05:01:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVXPQ-0001JX-SD
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 05:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaIUDBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 23:01:52 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:60156 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbaIUDBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 23:01:52 -0400
Received: by mail-yk0-f171.google.com with SMTP id 79so719726ykr.30
        for <git@vger.kernel.org>; Sat, 20 Sep 2014 20:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ETYHbJOCdFX1YIdfv4NFFCGQnAyz2QPoTUNIPlYBMeg=;
        b=Tnh03t1SURD6qEvWi1OWhWKI3iBvWm5RHyGYsm8Z2Q9QOuGBPluWxqZ3Om56ZZtpGH
         5bFg6Bl7ubnMG64CLGa54J6IBnkkzC2DQtJowh1BaeTMs0SM49mePZ5qIyBIPtzKrR/e
         j8Ti0qzolk8Bh6dgMpIMbLnubLinKjLYoErRDqRZJ5ZpOhC7y6R/TIyLCVX+z1FJL1LG
         3TKXypWX3UCTo1cfVPR33gP2cTjBTXDgF1j70qld2BGAqIi3Hrzw1aolP4mPIKbJFD6+
         UKXDZsJlsRhr3WxitTCKhuvmlhfzo2ErLj2gObjmt7SGT9ACeotkVmX7Af6NUoYezLLA
         I4Xw==
X-Received: by 10.236.66.137 with SMTP id h9mr15320345yhd.2.1411268511365;
 Sat, 20 Sep 2014 20:01:51 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Sat, 20 Sep 2014 20:01:51 -0700 (PDT)
In-Reply-To: <CACsJy8BLEfB6RQZTxqF82-tJmKQgnNC12QvKu8KZq=Vr059s3g@mail.gmail.com>
X-Google-Sender-Auth: Fxnu163M8PpBJIKhsMtOcbKS6OQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257337>

On Sat, Sep 20, 2014 at 10:54 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Sep 12, 2014 at 10:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> One minor addition for clarification would be to mention that the 'git
>> prune --worktrees' invocation applies to the main worktree:
>>
>>     When you are done with a linked working tree, you can simply delete
>>     it. You can clean up any stale $GIT_DIR/worktrees entries via
>>     `git prune --worktrees` in the main worktree.
>
>
> The command should work from any worktree (of course not the worktree
> that you just deleted). I try to make all operations work on all
> worktrees. How should I write this?

I realized that a bit after writing the above. You could qualify it as:

    When you are done with a linked working tree, you can simply delete
    it. You can clean up any stale $GIT_DIR/worktrees entries via
    `git prune --worktrees` in the main worktree or any linked tree.

But the "...in the main worktree or any linked tree" is likely
redundant, in which case Marc's rewrite is probably sufficient.
