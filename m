From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: update_linked_gitdir writes relative path to .git/worktrees/<id>/gitdir
Date: Mon, 8 Feb 2016 11:56:59 +0700
Message-ID: <CACsJy8D-dk7aHttHxeGYPuqRUQFx40AJyQQ39gVQvmM2Ttr1pA@mail.gmail.com>
References: <1454789548.23898.223.camel@mattmccutchen.net> <xmqqlh6w9isp.fsf@gitster.mtv.corp.google.com>
 <1454893478.2511.5.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matt McCutchen <matt@mattmccutchen.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 05:57:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSdtd-0005y4-8j
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 05:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbcBHE5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 23:57:31 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35661 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbcBHE5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 23:57:30 -0500
Received: by mail-lf0-f50.google.com with SMTP id l143so88301702lfe.2
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 20:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3lW4JVL2na4DCtHEM/Q0AGGuoRWs/kDD33C/FIJWzOE=;
        b=xtWsodHSgBfyJn9Cw7A7ZB+iu3fn5qkauegv5496I2ZsQBjKyH6HZvj6a9tX64+vid
         n6s5bTsQNebSwoBpEfdxHQxZfFB+luP1wBa3zsVnqjcUzUdTh8xNyCwIlNYmU3SHR5ul
         bi2qk4h1q/XYv4IaPPEcd4vwcSuYJL92QzE+orAFhq2spJBaG4hNB5yaNbRTDI6Bo2HG
         o5kSzcRQmfPAakTET2fMnq6BxLPp1fy425xvijdhdJBKr2OVH65vbr1WGsF9ZPqYYNr8
         lCQ6+pJ4QBR/zp9ywTcCGyycuh7uX+6t6P8k049beqlfdZN9s/q+vRFYF59K65zjG4KW
         HQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3lW4JVL2na4DCtHEM/Q0AGGuoRWs/kDD33C/FIJWzOE=;
        b=HGAMRsnocc4yLzKCa7BHV7HWWTY/uc7epWge2wtSPTLFRu5GUTcdaFR2CP8Br3HItp
         kIJMEmAPJ1duL4Hp6bgep8jPL2DawjwcB18rxOgMzuuRbRYLrPQD8ZZEdRbxehtBvnoT
         Kclbz3/v2T4WENpwp6BJYPWykTPmjTv6jE2hUM7cW1VIC2fcVey1EL5YnGsJxma1FLsn
         dopbx7AVEqhWbWoKr0aeoa3Bx13bJAt/LsxTmstFATJythhkPGC7m5ah1BNSZH2JmwJH
         Q2LMmUGN43f5Ww9lrmsDX6JG4IebG1uL+vq+AZDHPhWpYpyK48z/sL9QzDkePqOyc4eO
         YN5Q==
X-Gm-Message-State: AG10YOStOGLzOeJbGzlEWaG5AjgK6FkGvgL3uaiOu8qaiw7azEO33NKm0DJodk6VRMQcAIkC+GZ7CP6rbJutmw==
X-Received: by 10.25.5.6 with SMTP id 6mr8643998lff.3.1454907449118; Sun, 07
 Feb 2016 20:57:29 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 7 Feb 2016 20:56:59 -0800 (PST)
In-Reply-To: <1454893478.2511.5.camel@mattmccutchen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285746>

On Mon, Feb 8, 2016 at 8:04 AM, Matt McCutchen <matt@mattmccutchen.net> wrote:
> On Sun, 2016-02-07 at 15:56 -0800, Junio C Hamano wrote:
>> Matt McCutchen <matt@mattmccutchen.net> writes:
>>
>> > I noticed that when update_linked_gitdir chooses to update
>> > .git/worktrees/<id>/gitdir, the path it writes is relative, at
>> > least
>> > under some circumstances.  This contradicts the gitrepository-
>> > layout
>> > man page, which says:
>>
>> Duy, is it safe to say that the fix has already been cooking in
>> 'next' as nd/do-not-move-worktree-manually topic,
>
> Yes, looks like that topic removes the buggy functionality.

I'm also pretty sure it's update_linked_gitdir() that writes relative
path. So yes nd/do-not-move-worktree-manually should "fix" it. We
don't have a way to recover broken gitdir files though.
-- 
Duy
