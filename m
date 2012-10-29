From: Phil Hord <phil.hord@gmail.com>
Subject: Re: merge --no-commit not able to report stats more verbosely?
Date: Mon, 29 Oct 2012 14:12:32 -0400
Message-ID: <CABURp0oX5aT=yEbYeDXoOPWj_aRscVBY327_E6uyrrp5TPvcxA@mail.gmail.com>
References: <k63iai$kbp$1@ger.gmane.org> <20121028112150.GD11434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 19:13:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TStpn-0007ou-54
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 19:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab2J2SMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 14:12:54 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41713 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756593Ab2J2SMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 14:12:53 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3272343lbo.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WZypwuEWbcmKQ7CnhAq82Muc85RBHcJO7lNr/IBFSUI=;
        b=sbQ+hxG8eU71EPx50u0PYK4qVgLVbYVKTX52GwwltZb9sQGtDD18mIpceYUAAmhb6G
         qJ2N2aWgP9HkDutaEgLDk1jVFPZA7RnQSaCmnQ9RWcHcbIJgLIZbmN6beAU0yD/8FCsZ
         dJqLZArRjROTe80/hFOqZB7pPFdxERQtMY5wZtUeFLLUieNKeoa5fU8+31zAqgzr2T3q
         gGCXilIbR4g7qUNLagkpxSulA7Xk30ZjfVIpixlPdzoSyNEtjnfNxBPrc0toLvL1veuy
         UYxBjpJhozfqS7fxrURZioTBWwjz8hc0yfrdFDEvlUFEBroN1qi6lKFRdz8tFae639+l
         zWvA==
Received: by 10.152.47.112 with SMTP id c16mr28391193lan.50.1351534372315;
 Mon, 29 Oct 2012 11:12:52 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Mon, 29 Oct 2012 11:12:32 -0700 (PDT)
In-Reply-To: <20121028112150.GD11434@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208633>

On Sun, Oct 28, 2012 at 7:21 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 22, 2012 at 09:39:31AM -0400, Scott R. Godin wrote:
>
>> As you can see from the below, I can't seem to get it to give me more
>> verbose results of what's being merged (as in the actual merge below)
>> with --stat or -v .. is it supposed to do that?
>
> Yes. The diffstat is shown for the completed merge, but here:
>
>> (develop)>$ git merge --no-commit --stat -v widget_twitter
>> Automatic merge went well; stopped before committing as requested
>
> You do not complete the merge.
>
>> (develop|MERGING)>$ git merge --abort
>>
>> (develop)>$ git merge widget_twitter
>> Merge made by the 'recursive' strategy.
>>  .../code/community/Dnd/Magentweet/Model/User.php   |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> Whereas here you do, and you get a diffstat.
>
> When you are in the middle of an uncompleted merge and want to know what
> is happening, you should look at the index using "git status" (to get an
> overview of what is ready to be committed and what is unmerged), "git
> diff --cached" (to see what was automatically merged and is ready for
> commit), and "git diff" (to see conflicted entries that still need to be
> resolved).

I think he is looking for this bit
    "Merge made by the 'recursive' strategy."

But he is seeing this instead:
    "Automatic merge went well; stopped before committing as requested"

Should the "what happened" output be silenced on --no-commit?

Phil
