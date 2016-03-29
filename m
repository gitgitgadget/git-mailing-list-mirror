From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Gitk "External diff" broken when using worktree
Date: Tue, 29 Mar 2016 16:40:50 +0700
Message-ID: <CACsJy8AJr8diCyv=ZfADtm=Aw96RjAHd7ZD2xR6VEQ-ZXQTCBg@mail.gmail.com>
References: <CAC4jX8FWs30v-Vh7XyPP9_ba3HKd4hAhRBrwfMpBPZd5ku8rUA@mail.gmail.com>
 <CACsJy8D84e4iQ6Pz_zyqsXuV6c2ier6s_W99+1hKszd0gHiUaQ@mail.gmail.com> <CAC4jX8E0URpxYmTU96xaFh-zEfT_q8RNfGy53DoNV5OFNjgxbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
X-From: git-owner@vger.kernel.org Tue Mar 29 11:45:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akq9O-0007ap-HK
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 11:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbcC2JlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 05:41:23 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34839 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbcC2JlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 05:41:21 -0400
Received: by mail-lf0-f53.google.com with SMTP id k79so7462576lfb.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iCp1MQ97+OPe8+5L72an71/boq52opGx+bthgNPXu2g=;
        b=FPwpyhsV4jaNh4yPxqyJEcb/wfjq0ZdSaG/+8znMURHrxDMpjt5S90ZHAbmnGaEDsh
         MLruoTIujRT2JhJA6FCDU/k2nMuqESSVh0HJoTXjtByJNkNfiF3Ci2oz8NWUM1RxzzLH
         V73P48BT7jReNwQq0bhVUty4TylV1uUfTwrBJo8I17FO6DxiEDJpcDc4AxvZdKQKU3rf
         F4/dNtFou9IlEPYal/ZLZQ8DAK+BcbhzNQWZ7KF6gGv5/qR1eSgkkHn05k4MoICBepJd
         7WyGiGGiRadKtxdOC0YTt7AIz57TafTd3qA1hva/pIYshEzDkfg4Gbs9wMA1zjR8/Aw+
         jdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iCp1MQ97+OPe8+5L72an71/boq52opGx+bthgNPXu2g=;
        b=fS51rOdXnpWzSeOmJL9bO10XlFbYXPZhvwSsIH45yoJGzJ2sMwEP1eyIWepglRpQxe
         dAvLq3HxEmeJumNUlhUC6RwP60RnLuizvhLrZBVG9BCD2TEH7XzwXk45hEjR7loDyhrn
         dZE4V7vOX4zXNUXOuo7qdPdkIgUmqlSsc77dIfKdCuXUPFxBoYu79QkU1nV7ND5umZQ3
         +4sgCMJa90VvlBlY/RR4rWQXoVNFK+zeDx7vtfllsvotD2BpeqrWq4Ni2t+Jd/kuWfKL
         pupC9e22Mp1pIzYcAZ/quVr+rCqf4ybblN1Dl+XdD49xQpvVM7vIuFR6VSB3uWCGfnAe
         gaKw==
X-Gm-Message-State: AD7BkJKMfg/Tsu6dvAYtdnc0009ggwwmcaHo76laAMTJHjDLVbKelhcqdsWQ8+M9FtzxtRDX/6Qay1O4KU/yrQ==
X-Received: by 10.25.212.213 with SMTP id l204mr673341lfg.118.1459244480164;
 Tue, 29 Mar 2016 02:41:20 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 29 Mar 2016 02:40:50 -0700 (PDT)
In-Reply-To: <CAC4jX8E0URpxYmTU96xaFh-zEfT_q8RNfGy53DoNV5OFNjgxbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290109>

On Tue, Mar 29, 2016 at 7:17 AM, Daryl Van Den Brink
<daryl.vandenbrink@maptek.com.au> wrote:
> I've done that, and here are the two arguments that it gives to the diff tool:
>
> From the main repository (in which case the it works):
>
> .git/.gitk-tmp.CCxPmN/1/[1980e260494cbd225d482b5d962e77bdcdb2321c]
> RemoteTransaction.C
> .git/.gitk-tmp.CCxPmN/1/[2759bf6053e73cb5f7c11c646aee206242db2cd4]
> RemoteTransaction.C
>
> From the auxiliary worktree (when the diff doesn't work):
>
> /home/daryl.vandenbrink/git-work/mdf_products/.git/worktrees/mdf2/.gitk-tmp.ZEdGpi/1/[1980e260494cbd225d482b5d962e77bdcdb2321c]
> RemoteTransaction.C
> /home/daryl.vandenbrink/git-work/mdf_products/.git/worktrees/mdf2/.gitk-tmp.ZEdGpi/1/[2759bf6053e73cb5f7c11c646aee206242db2cd4]
> RemoteTransaction.C
>
> I hope that helps.

I can only guess that the content in those two files are the same.
Which mean the bug is somewhere else. I'm afraid I can't help further
because I'm not familiar with gitk (not even its user for that matter)
-- 
Duy
