From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-push through git protocol
Date: Mon, 22 Jan 2007 13:24:08 +1300
Message-ID: <46a038f90701211624y19e83999k291408764bccc645@mail.gmail.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	 <46a038f90701211549v1e3dbb9dgf4eb810c8756b5d7@mail.gmail.com>
	 <17843.65339.528621.549961@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 01:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8myt-0003pL-Pp
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 01:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbXAVAYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 19:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbXAVAYM
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 19:24:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:38641 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbXAVAYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 19:24:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1153244nfa
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 16:24:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aohGk6NcC6reX35/E12LWH5ezR+vEfsZNuYX9vBdrGFHO8xJDcEe6p+tImDb4ZIyJnIcupm7XRT0ifofif3midv80AwxGPAYq6tuH9S4Dx2HuV382qmbAqw0QbmxRuUDaIBrb8MPZVhreuuuFILp3ZBgllxIMgdUKZq2IXBT9GY=
Received: by 10.48.245.17 with SMTP id s17mr5825725nfh.1169425448971;
        Sun, 21 Jan 2007 16:24:08 -0800 (PST)
Received: by 10.49.35.7 with HTTP; Sun, 21 Jan 2007 16:24:08 -0800 (PST)
To: "Bill Lear" <rael@zopyra.com>
In-Reply-To: <17843.65339.528621.549961@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37369>

On 1/22/07, Bill Lear <rael@zopyra.com> wrote:
> On Monday, January 22, 2007 at 12:49:02 (+1300) Martin Langhoff writes:
> >On 1/22/07, Bill Lear <rael@zopyra.com> wrote:
> >> 2) we have run into problems
> >> with developers having different umasks ---
> >
> >This is a non-issue. Just do git-repo-config core.sharedrepository 1
> >on each repo.
>
> Does this have the same effect as 'git --bare init-db --shared'?
> If so, I thought that was the way we initialized our company repo,
> though our config file reads:
>
> [core]
>         repositoryformatversion = 0
>         filemode = true

You should check your repos, ours all have

[core]
        sharedrepository = true

which I manually set doing

  GIT_DIR=xx.git git-repo-config core.sharedrepository true

and the group is set to "git" which all our devs are part of. Works great.

WRT denyNonFastforwards -- even without that, git refuses to push if
it's not a fast-forward. Maybe if I had the branch set to +headname.
In any case, you have to try real hard to muck that up.

cheers


m
