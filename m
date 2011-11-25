From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Fri, 25 Nov 2011 21:48:12 +0530
Message-ID: <CAMK1S_i8e4q8kJxkQam+Tim1mPfo7dGPbi8bmgLt=ZqeA=1MOQ@mail.gmail.com>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
	<CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
	<4ECF939D.8020706@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 25 17:18:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTyTi-0006kO-9W
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 17:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab1KYQSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Nov 2011 11:18:13 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59502 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab1KYQSN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2011 11:18:13 -0500
Received: by yenl6 with SMTP id l6so1252952yen.19
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8pxfP2CWZ4A2Sfjh5WMrQF7lMbgUKLdGtoZMdyJnBKc=;
        b=F7/pyKQ+qZlYFdLXJneGgV/Xxecuy2qNkbf9zsUue7soeLIolpgUfTqwJRNwuB7Czm
         Y3cNa9eT1dOEIzYt9s+BpEs4e3U2IXppzR7Kqi6VDapwEpVu7BhS/+H8DBlt824gwegu
         q8OmYg+coj0nF1qoFMUjiBa2rxS0FdO4tgu2U=
Received: by 10.182.2.225 with SMTP id 1mr10451237obx.30.1322237892779; Fri,
 25 Nov 2011 08:18:12 -0800 (PST)
Received: by 10.182.6.41 with HTTP; Fri, 25 Nov 2011 08:18:12 -0800 (PST)
In-Reply-To: <4ECF939D.8020706@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185938>

On Fri, Nov 25, 2011 at 6:39 PM, Andreas Ericsson <ae@op5.se> wrote:

> People who fetch but don't push is, by far, the vast majority of git =
users.
> Think of everyone fetching from any public software repository withou=
t
> having write access to it. If you think of git.git and linux.git alon=
e
> I think it's safe to assume the number of "fetch-no-push" outnumber t=
he
> "push-and-whatnot" group by some quarter million to one.

But in those environments the person pulling does not even have an ID
so how is he at risk with the hook running?

>> I may be wrong but I imagine shared environments are those where
>> almost everyone will push at least once in a while. =C2=A0It's a clo=
sed
>> group of people, probably all developers, etc etc etc...
>>
>
> Not really. We fetch from each other quite a lot at work, and from
> each others semi-public repositories on a shared server where we've
> all got accounts (ie, write access), but we very, very rarely push
> into each others repositories. The sharepoint is the "official" repo
> on the repo-server, which the buildbots gets its code from and where
> everything to be released, maintained or handled in some way in the
> future resides.

Yes, and this is the only situation where it does have the issue.  I'm
just not sure how common this is.

It's fine if you tell me I'm wrong and that this *is* still very
common.  I'll back off.

But everyone seems to be bringing in github and public repos as part
of the argument, and I don't see how they're relevant to the original
security issue of the guy who pulls having his account compromised.

> Anyways. Shooting down the arguments *against* pre-upload hooks are
> quite silly if it's not combined with some fresh arguments *for* such
> a hook.
>
> So... What usecase do you envision where you'd need one?

I'm writing a caching proxy that helps with bandwidth issues when too
many people in a bad-WAN site want to clone some huge repo from its
canonical site.  The only one I found by googling fiddles with the git
protocol itself, and I hate doing things like that.

Ignoring all the details, the pre-upload hook would have checked some
conditions and fired off a fetch from the remote site if those checks
passed.

It's easy enough to do it from cron but it would have been more
elegant this way.
