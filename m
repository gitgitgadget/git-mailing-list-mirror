From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Another bench on gitweb (also on gitweb caching)
Date: Thu, 14 Feb 2008 02:01:53 +0100
Message-ID: <200802140201.55420.jnareb@gmail.com>
References: <20080210030919.GA32733@c3sl.ufpr.br> <200802131317.48815.jnareb@gmail.com> <1202929923.2687.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 02:02:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPSUt-0005vv-3m
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 02:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762825AbYBNBCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 20:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbYBNBCG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 20:02:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:25176 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbYBNBCE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 20:02:04 -0500
Received: by ug-out-1314.google.com with SMTP id z38so903224ugc.16
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 17:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=tgfMkAGly3teAZEO+9KBKiWR5+O/Ha3cskSGECoAX7g=;
        b=eLWOQuC/hDNm0QNCMy6KdVqcstcQy9KfBdc32b7XdeFyTPsnjJ4I5n1FjwkheXrc4+pXanOS4k8dafqmrS7srz6oJ0P1LHC2FHifQDL142HVmoJSlNH6AEJmcc3SbL7pNL3Ec8NfdOYcQqe2gaiwrnAbMnFVzFOef1EN3HNtPXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=fBfZt315zV3Xs3EgHCdY7aGtQY5bkGg6xxPJ/ZPCkDZh9rFI9hiM89asxLOQD8/xhSKb51mF+KWth7SuF9c/Hvxx4ZnGlhOivpIrmuNVsMq59Od6um3AptcmWcuA+09GuAhbwIfF8GPH3aDDtouYa6veUMNRvq0pVPn5Hc0XEIo=
Received: by 10.67.19.17 with SMTP id w17mr2631424ugi.33.1202950922798;
        Wed, 13 Feb 2008 17:02:02 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.196.88])
        by mx.google.com with ESMTPS id q1sm13750862uge.7.2008.02.13.17.01.59
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Feb 2008 17:02:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1202929923.2687.15.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73834>

On Wed, 13 Feb 2008, J.H. "Warthog9" wrote:
> On Wed, 13 Feb 2008 13:17:46 +0100, Jakub Narebski wrote:
>> 
>> BTW. did you consider using cgit (C/Caching git web interface) instead
>> or in addition to gitweb? Freedesktop.org uses it side by side with
>> gitweb. I wonder how it would perform on kernel.org...
> 
> When I branched and did the initial work for gitweb-caching CGit had
> only barely made verion 0.01.  So putting something *that* new into
> production on Kernel.org didn't even remotely make sense.

If I remember correctly cgit was _created_ in response (or at least
around) to discussion on git mailing list that kerne.org needs caching
for gitweb.

BTW. I have CC-ed CGit author, Lars Hjemli.

> Since than 
> the caching modifications (along with a few other fixes and such) have
> proven to be quite stable and have withstood the onslaught of users
> fairly well.  I have toyed with the idea of giving up on gitweb-caching
> (since I either need to redo it to bring it closer to mainline gitweb,
> and probably give up on breaking it up into multiple files or switch to
> something new)

By the way, why did you split into so many modules? I would think
that separating into generic modules (like for example commit parsing),
HTML generation modules (specifing to gitweb) and caching module;
perhaps for easier integration only main gitweb (core version)
and caching module would be enough.

I was thinking about adding caching, using code from your fork,
to git.git gitweb, somewhere along the line... I guess I can move
it earlier in the TODO list, somewhere along CSS cleanup and log-like
views generation cleanup, and using feed links depending on page.

> but the current question that I, and no one else on the 
> kernel.org admin staff has had time to investigate is does cgit use the
> same url paths.  If so it would be a simple drop-in replacement and that
> would appeal to us.  If it doesn't we can't use cgit and will have to
> stick with gitweb or a direct derivative there-of.

Unfortunately cgit is not designed to be gitweb compatibile; it is
simplier (which might be considered better), doesn't support the
multitude of gitweb views, and unfortunately doesn't understand
gitweb URLs.

On the other side having gitweb and cgit coexist together on the same
set of repositories should be quite easy, as shown by FreeDesktop folks:
http://gitweb.freedesktop.org and http://cgit.freedesktop.org
 
>> (Almost) every optimization should begin with profiling. Could you tell
>> us which gitweb pages are most called and perhaps which pages generate
>> most load for kernel.org?
> 
> That would be correct, though when I did up gitweb-caching the profiling
> was blatantly obvious, with every single page request git was being
> called, git was hammering the disk and it was becoming increasingly
> obvious that going and running git for every page load was completely
> impractical.

[bringing back old quote]
>> On Wed, 13 Feb 2008, J.H. "Warthog9" wrote:
>>
>>>  There is currently something like 20G of disk being used on one
>>> of kernel.org's machines providing the cache (this does get flushed on
>>> occasion - I think) but that is providing caching for everything that
>>> kernel.org has in it's git trees (or 255188 unique urls currently).

What I meant here that one should balance between not having cache
at all (and spending all the CPU), to caching everything under the
sun (and spending all the HDD space). To that one should know which
pages are most requested, so they would be cached by having static
page to serve; which generate most load / are less requested, so
perhaps git commands output would be cached; and which are rare enough
that caching is waste of disk space, and hints to caching proxies
should be enough.

[...]
> As for the most often hit pages - the front page is by far hit the most,
> which should be no surprise to everyone, and it is by far the most
> abusive since it has to query *every* project have.  After that things
> taper off as people find the project they want and go looking for the
> data they are interested in.

But what of those pages are most requested and generate most load?
'summary' page? 'rss' or 'atom' feeds? 'tree' view? README 'blob'?
snapshot (if enabled)?
 
>>  How new projects are added (old projects
>> deleted)?
> 
> By and large - left up to the users - if they don't want their tree
> anymore they delete it (though I don't know of anyone who has) if they
> need another one - they create it.

Bummer. If projects were created by some script (like I think is
the case for git hosting facilities, like repo.or.cz, GitHub,
Gitorious or TucFamily) we could update projects listing file
(so gitweb doesn't need to scan directories), and perhaps even
add some gitweb-specific hooks (add multiplexer + hooks).

>>  Do you control (can add to or can add multiplexing) to update
>> or post-receive hooks?
> 
> No.  We do not want to, at all, control in any way the tree's that
> people put up on Kernel.org.  We just don't have the bandwidth to deal
> with that for every single tree on kernel.org.  Anything that would
> require us to go changing or forcing a user to change something in their
> git tree means we've already lost.  Taking the caching layer and making
> it 100% transparent to the git tree's owners and generally speaking to
> the end user makes things very simple for us to deal with.

That's bad, because update / post-recive hook could be used for example
to invalidate 'summary', 'rss' and 'atom' views cache, and perhaps
regenerate projects list page. First request would generate cache, which
would be then used till it was deleted by the hook script.
 
>> 
>> Without this data we could concentrate on things which are of no
>> importance. BTW. I wonder if slitting projects_list page would help...
> 
> That would be bad - I know for a fact there are people who will go to
> git.kernel.org and then search on the page for the things they want - so
> changing this would probably cause a lot of confusion for minor gain at
> this point.

I was thinking about first page being page of categories, perhaps with
"search projects" box. The page with so many projects is a bit unwieldy.

P.S. Do you make use of alternates, or do you left it to users to setup.?
-- 
Jakub Narebski
Poland
