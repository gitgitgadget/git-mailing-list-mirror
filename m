From: Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
Subject: Re: Gitk "External diff" broken when using worktree
Date: Tue, 29 Mar 2016 10:47:18 +1030
Message-ID: <CAC4jX8E0URpxYmTU96xaFh-zEfT_q8RNfGy53DoNV5OFNjgxbQ@mail.gmail.com>
References: <CAC4jX8FWs30v-Vh7XyPP9_ba3HKd4hAhRBrwfMpBPZd5ku8rUA@mail.gmail.com>
	<CACsJy8D84e4iQ6Pz_zyqsXuV6c2ier6s_W99+1hKszd0gHiUaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 02:17:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akhLa-0004Px-CP
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 02:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbcC2ARV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 20:17:21 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36388 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcC2ARU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 20:17:20 -0400
Received: by mail-yw0-f175.google.com with SMTP id g3so80430ywa.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 17:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maptek-com-au.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/rsZ3Roq018cFE5KLU9ZdIIpBhuzuwQ3+alriKLUTCU=;
        b=Bf05cWAiid48yqzXao9IZL5RjcxPQpWV1tn88D/9y2gtAL5B/ZHl9+TU9Hk95rndOl
         xeDuXBiC5EMYvuMssGnmwcFDWK3v6PsaMaq8LtKTU70Dk/0C85ymGr6f5V6XGaIp36oD
         J8LZrB4b0rOzRf+b4E0CBzNAPYrKR7MSHObfhNWUuifMweCgBudUyZRSvOKAnD4TF3ZT
         vE2p30e8zFBZT0t/H0CQgwcVrZH56/EdDGUVt4dvVm0h8cYUCmSAJqcnDq9ug8W5AXuv
         VZJcq/gOSRQM8q25yt3hathGf+4ZCYCPFgYz3Ufz6oQb77zrJNpYPVChx1kzXV3CJk3H
         X+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/rsZ3Roq018cFE5KLU9ZdIIpBhuzuwQ3+alriKLUTCU=;
        b=ZwTr+mB91ZRdApgRCbCNnmFh6Rd67ZbmKu3dA3ysOkE7Bx8fNcFHnbEnmDPKSicMIS
         jR2W4pgtvJhY4ySItmKwvikJG05VGPeQ+zNfvAH+8jWunMIj2wGTNMLqHe7SKetoyIFO
         yEJKRc28zVD/k0x1fQpLMFlrri9jWTDzPhPQzndnWkE99LkgKQLIH725v/7C3yIeKFPV
         zBScpAE9s6blCFTIz5LRE2ticCsZ5unYQxpC3mJQKh1aJAipBY3yljwxfol6VPMyUUCv
         Jn3FQp8SEneNJuslp1N5EHxKxbhOupHun6uQfkOccJ+9Rd8OJvvFYHRc4kbal313FwG5
         Y/gA==
X-Gm-Message-State: AD7BkJJUTgL+KKR3qJ3GEnrFRp+rpan6OkGh1DYB0pJ6v9I6HqOxU7OUHpsCZuFzkcXrMltNqwVdWdIMnO4B0djW
X-Received: by 10.13.231.5 with SMTP id q5mr14289331ywe.33.1459210638571; Mon,
 28 Mar 2016 17:17:18 -0700 (PDT)
Received: by 10.37.202.200 with HTTP; Mon, 28 Mar 2016 17:17:18 -0700 (PDT)
In-Reply-To: <CACsJy8D84e4iQ6Pz_zyqsXuV6c2ier6s_W99+1hKszd0gHiUaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290092>

I've done that, and here are the two arguments that it gives to the diff tool:

>From the main repository (in which case the it works):

.git/.gitk-tmp.CCxPmN/1/[1980e260494cbd225d482b5d962e77bdcdb2321c]
RemoteTransaction.C
.git/.gitk-tmp.CCxPmN/1/[2759bf6053e73cb5f7c11c646aee206242db2cd4]
RemoteTransaction.C

>From the auxiliary worktree (when the diff doesn't work):

/home/daryl.vandenbrink/git-work/mdf_products/.git/worktrees/mdf2/.gitk-tmp.ZEdGpi/1/[1980e260494cbd225d482b5d962e77bdcdb2321c]
RemoteTransaction.C
/home/daryl.vandenbrink/git-work/mdf_products/.git/worktrees/mdf2/.gitk-tmp.ZEdGpi/1/[2759bf6053e73cb5f7c11c646aee206242db2cd4]
RemoteTransaction.C

I hope that helps.


On 24 March 2016 at 19:52, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 24, 2016 at 9:55 AM, Daryl Van Den Brink
> <daryl.vandenbrink@maptek.com.au> wrote:
>> Hi,
>>
>> I'm using git 2.7.3 on cygwin, and have been taking advantage of the
>> new "git worktree" feature. I noticed that when I launch gitk from one
>> of the attached working directories, its "external diff" feature
>> doesn't seem to work. Nothing shows up in the diff tool at all.
>> However, it works if you launch gitk from the main repository.
>>
>> To reproduce:
>> 1. Create a new working tree with "git worktree add"
>> 2. From that new worktree, launch gitk.
>> 3. Right-click in a file in the bottom right pane and click "External diff"
>> 4. No useful diff appears.
>
> Works for me (on linux with 'master' branch). Maybe gitk selected
> invalid tempdir on cygwin. You can try replace your external diff
> program with a script or something that prints the whole command line.
> That should reveal if gitk given paths are correct or not (or if gitk
> fails even before that)
> --
> Duy



-- 
Daryl van den Brink
Software Engineer
Maptek | 31 Flemington Street, Glenside, SA 5065, Australia
Tel: +61-8 8338 9222 | Dir: +61-8 8338 9222 | Fax: +61-8 8338 9229
daryl.vandenbrink@maptek.com.au | www.maptek.com

Keep up to date with Maptek in our Forge newsletter.
