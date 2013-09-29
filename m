From: Johan Herland <johan@herland.net>
Subject: Re: Local tag killer
Date: Sun, 29 Sep 2013 11:30:10 +0200
Message-ID: <CALKQrgdG3FzA=8A9TyuGGumqWJ05zYK1r2uaAOrhNaAUju-6jw@mail.gmail.com>
References: <52327E62.2040301@alum.mit.edu>
	<CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
	<xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>
	<523D3FD2.4090002@alum.mit.edu>
	<20130924075119.GD7257@sigill.intra.peff.net>
	<alpine.LFD.2.03.1309251834210.312@syhkavp.arg>
	<5246C975.1050504@alum.mit.edu>
	<CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com>
	<5247ACB9.40208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 29 11:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQDQi-0004dw-UA
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 11:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab3I2Jg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 05:36:28 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:52742 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3I2Jg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 05:36:26 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VQDQO-0006sW-BM
	for git@vger.kernel.org; Sun, 29 Sep 2013 11:36:24 +0200
Received: from mail-pb0-f43.google.com ([209.85.160.43])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VQDQO-0003qE-2r
	for git@vger.kernel.org; Sun, 29 Sep 2013 11:36:24 +0200
Received: by mail-pb0-f43.google.com with SMTP id md4so4308625pbc.30
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 02:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E4rVLTL1VpqNBX9cmrq5s56grAntH1P25YxES36TiMY=;
        b=RV/jDDG9Jiapt/X1ZSpsQEXeSob2fEreHmlst0V7XfDnV2J89Q4zDoJz3RQPjtyctk
         U2bvcnh8zvMZT33AtC3AKSrA13+CQIC97lmemDvaYIV3+gplTm37bM7FqSV2kzuiZMEo
         G/L2ckQnnoAT3Lx87A6joIzQJxl0W3UYOKXF55HTcKSac1iyPSEbyAfRfb/XYg6DMo7v
         51Ck5MacfX1/eGWFua+kYP+U2kNfMrsuv4Dol5wAESGGEYXYx9mEGGchRZNjI757zcex
         eSU5SzP0r2fWQM0QXGFRDAiNXMn4ZJAuWxjVHdBQyIYxeUeBIYWGp3EjKSqRjS6mtfA/
         /9ig==
X-Received: by 10.66.171.204 with SMTP id aw12mr21476264pac.7.1380447010636;
 Sun, 29 Sep 2013 02:30:10 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Sun, 29 Sep 2013 02:30:10 -0700 (PDT)
In-Reply-To: <5247ACB9.40208@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235594>

On Sun, Sep 29, 2013 at 6:29 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I wonder whether remotes.group could sensibly be used to group remotes
> into logical groups for value lookups:
>
>     [remotes]
>             gitk = gitk-origin
>             gitk = second-gitk-repo
>
> Then DWIM could be taught to seek "gitk/foo" under
> "refs/remotes/gitk-origin/tags/foo" and
> "refs/remotes/second-gitk-repo/tags/foo" in addition to
> "refs/tags/gitk/foo" (insisting, of course, that if more than one of
> these are present that they are all consistent).

This is an interesting idea. AFAICS, remotes.<group> is currently only
used by "git remote update" and "git fetch". According to git-remote(1)
it's used like this:

    [git remote] update
        Fetch updates for a named set of remotes in the repository
        as defined by remotes.<group>. If a named group is not
        specified on the command line, the configuration parameter
        remotes.default will be used; if remotes.default is not
        defined, all remotes which do not have the configuration
        parameter remote.<name>.skipDefaultUpdate set to true will
        be updated. (See git-config(1)).

I believe this would work well when extended to ref lookup as well:

 - Defining remotes.$group allows you to lookup refs across the grouped
   remotes by using the "$group/<ref>" syntax, as you describe above.

 - If remotes.default is defined, ref lookup happens by default across
   only those remotes, i.e. "$tag" will be sought under refs/tags/$tag
   and then refs/remotes/$remote/tags/$tag for each $remote in
   remotes.default.

 - If remotes.default is not defined, ref lookup happens across all
   remotes. This is analogous to what happens with tags today; they
   are all dumped into refs/tags/* and lookup considers all of them.

> Remote groups might also be used to configure the remotes that describe
> considers when describing a commit:
>
>     [remotes]
>             describe = junio
>             describe = jrn
>
> or maybe (using the above config)
>
>     git describe --remote-group=gitk

Hmm. I'd like to apply the same rules here, to stay consistent:

 - "git describe --from=$remote1 --from=$remote2" considers tags
   from refs/remotes/$remote1/tags/* and refs/remotes/$remote2/tags/*

 - "git describe --from=$group" considers tags from
   refs/remotes/$remote/tags/* for each $remote in $group

 - "git describe" considers tags from all remotes mentioned in
   remotes.default, or _all_ remotes is remotes.default is unset.

Additionally:

 - "git describe" (without --from) also considers (and prefers?) local
   tags.

 - "git describe --from=foo" does NOT consider local tags, but will
   also consider them if "--from=." is used.


...Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
