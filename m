From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb and remote branches
Date: Thu, 30 Aug 2007 09:18:09 +0200
Message-ID: <cb7bb73a0708300018u37f5c465u5d87eae0eb23543c@mail.gmail.com>
References: <favitd$3ff$1@sea.gmane.org>
	 <cb7bb73a0708280253y7d31f347yb84a40982d59d9d2@mail.gmail.com>
	 <cb7bb73a0708280453k4315e80ej170238a52e66dcb6@mail.gmail.com>
	 <200708300001.39203.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 09:18:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQeIC-0004D3-89
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 09:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbXH3HSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 03:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbXH3HSL
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 03:18:11 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:2786 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbXH3HSK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 03:18:10 -0400
Received: by py-out-1112.google.com with SMTP id u77so2701929pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 00:18:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pwAw3te2EvBTcTcvNs1JmRdOFkpnE5B0/XCJxpChorzkJAejq0jxayRNJyUODdrIoE8ntQmxv2k7NV1yFFMW4aTN9px5djP5CL4WCbqvmekQhP3ZT+Qfi99Vz3eUGE0twm3YOzgJBn+axb4yBd9r2lPYGBzXZk+NPp1xhUdYcmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PLGnvZoHfZrW/7wFdAIGHZkxM0Udu+1CRxLAqjPVZLRYLPEryngEqf/1RcqXG/PpimfQSPqY4rY9CNz4Us+Go+vzZARZer0T+04vSK8vmGRZ8OCchAfxt7tlyxzTkJLO0r+QppZiuBO3cQfpgYdW5m+mkHlvn51UKtgkeKZIcq0=
Received: by 10.35.63.2 with SMTP id q2mr270107pyk.1188458289572;
        Thu, 30 Aug 2007 00:18:09 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Thu, 30 Aug 2007 00:18:09 -0700 (PDT)
In-Reply-To: <200708300001.39203.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57007>

On 8/30/07, Jakub Narebski <jnareb@gmail.com> wrote:
> For quick'n'dirty solution this might be enough. For proper patch to
> be accepted I don't think so.

That's fine, it wasn't meant to be :)

> First, in the idea to show also remote branches (from refs/remotes),
> I wanted to separate heads list from remotes list in the 'summary'
> view, and add 'remotes' view or modify 'heads' view to accept some
> parameter specyfying kind of refs.

What I had in mind was a way to modify 'heads' view with a boolean
option that enable/disabled remotes view. For their visualizations, I
had in mind a split 'heads' secion, with the lhs being as it is now,
and the rhs having the remotes.

However, I wasn't sure if such a view would have been appreciated, so
I went for the merged view and used the spans to make the heads appear
as they do in the shortlog, as a clear way to mark which ones were
local and which ones were remote.

> Second, what was stopping me from implementing that was an idea to
> separate remote branches into categories (like gitwbe-xmms2 categories
> of projects) defined by the remote it belongs to. And this is not so
> easy if we want to respect old .git/branches/ and .git/remotes/ remote
> config in addition to new config based remote config.

I don't know what gitweb-xmms2 does, but I think I understand what you
mean, and I like the idea. However, it's even harder if you consider
that even the latest git-svn plops all the svn-converted refs straight
into refs/remotes and not in a subdir such as refs/remotes/svn.

OTOH, we have to start from somewhere so we can build the feature step by step.

> > Giuseppe "Oblomov" Bilotta
> >
> > --- gitweb.cgi        2007-08-26 12:41:13.000000000 +0200
> > +++ gitweb.cgi-my     2007-08-28 13:47:15.000000000 +0200
>
> It is better to use git to manage source and to generate patches
> (use git-format-patch, check Documentation/SubmittingPatches),
> and use gitweb/gitweb.perl and not installed version.

Oh, I know, this was just a very quick hack on the thing installed by
my Debian distribution. I've since checkoued out the git.git
repository and I'll be working on that now.

> > @@ -3237,8 +3238,10 @@ sub git_heads_body {
> >               $alternate ^= 1;
> >               print "<td><i>$ref{'age'}</i></td>\n" .
> >                     ($curr ? "<td class=\"current_head\">" : "<td>") .
> > +                   "<span class=\"refs\"><span class=\"$ref{'class'}\">" .
> >                     $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'}),
> >                              -class => "list name"},esc_html($ref{'name'})) .
> > +                   "</span></span>" .
> >                     "</td>\n" .
> >                     "<td class=\"link\">" .
> >                     $cgi->a({-href => href(action=>"shortlog",
> > hash=>$ref{'name'})}, "shortlog") . " | " .
> >
>
> I don't understand this double span. First, you can set multiple
> classes for HTML element by separating them by space, e.g.
>
>                 "<span class=\"refs\ $ref{'class'}\">"
>
> And you could have given appropriate class to <td> or <a> element

Actually, that was just a quick hack to make the heads appear in the
heads list in the same way as they appear in the shortlog, to
differentiate between them. And that requires the double span ;)

Of course, I'd rather hack the CSS now that I've got the git repository.

I'll be working on it here

http://oblomov.dnsalias.org/git?p=git.git;a=shortlog;h=gitweb-allheads

and keep you posted on my progress.

-- 
Giuseppe "Oblomov" Bilotta
