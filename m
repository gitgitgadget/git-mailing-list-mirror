From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Mon, 28 Feb 2011 10:27:06 -0500
Message-ID: <AANLkTimJWeZLJbPndTyE0EUW3R9EC=yV55jhHbpZnnJn@mail.gmail.com>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com> <4D6B6A8B.20709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Chanters <david.chanters@googlemail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 16:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu50f-0005kW-RM
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 16:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab1B1P1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 10:27:37 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46533 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1B1P1g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 10:27:36 -0500
Received: by iwn34 with SMTP id 34so3175467iwn.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=YapTkrya4lT3o2GKDq3XoaFyoZzKhcST3YdN/VJvnP8=;
        b=yCeFjnEvXmK1/NImGZlyAlfAPVd3MFeFa/F8IWFU4nSupU+xqKaZDmmPxBNopFRS8V
         utwt7MzNdS0V0hcrK4XAbtZ6/TLJn/J4PsJuCdHRpZ/vh8T0AyEjMSWOnmuu869jI2pP
         8r/Z4OEGzxoS7RES+N1Attn7qHr6g8xc0pkzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YC2oLEnSJq/WP5/RNA1gGydZevwakrw/XvvoZGTqT3bgilJZMwR3QF3Wk0T8e38BYw
         VO/G2kWCgLZy3WoFN0CVFXF1RKAbBjeTvd5QHXqDMTG5kjl1WNW8JIkBPu1bun3OxyZu
         2zN+2vzGH6XWx3WdCU3NCFs5HQYmTd1ydppxQ=
Received: by 10.231.182.5 with SMTP id ca5mr5464294ibb.144.1298906856141; Mon,
 28 Feb 2011 07:27:36 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 28 Feb 2011 07:27:06 -0800 (PST)
In-Reply-To: <4D6B6A8B.20709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168115>

On Mon, Feb 28, 2011 at 4:27 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> git grep -- $(git rev-parse --show-cdup)
>
> is the best we have right now. I think we're still looking for a good
> way to denote "root of repo" (like "." for cwd).
>
> Also, we're thinking of changing a few defaults (to repo-wide), but "git
> grep" is meant to stay close to ordinary grep.

I had the crazy thought that if git had a --cdup option, then this
would work with any command you wanted to run from the top:

  git --cdup grep ...

Maybe that's the best way to expose "from the top please" generically?

j.
