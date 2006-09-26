From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Wed, 27 Sep 2006 00:24:21 +0200
Organization: At home
Message-ID: <efc9af$7ic$1@sea.gmane.org>
References: <efc2no$eti$2@sea.gmane.org> <20060926213236.79160.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 27 00:25:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSLME-0007fu-Qw
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 00:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWIZWYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 18:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWIZWYv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 18:24:51 -0400
Received: from main.gmane.org ([80.91.229.2]:19670 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964856AbWIZWYu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 18:24:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GSLLx-0007bv-3O
	for git@vger.kernel.org; Wed, 27 Sep 2006 00:24:37 +0200
Received: from host-81-190-26-96.torun.mm.pl ([81.190.26.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 00:24:37 +0200
Received: from jnareb by host-81-190-26-96.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 00:24:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-96.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27831>

Luben Tuikov wrote:

> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> This is example of where forefront has it wrong. I'm all for "list" entry
>> to be link to default view, but I'm all against removing clearly marked
>> link to "plain"/"tree" view.
>> 
>> And "invisible links" _especially_ if the link is not convenience only
>> (i.e. it is not provided clearly as link somewhere else) is so called
>> "mystery meat navigation" and is one of the most common mistakes in
>> web development.
>> 
>> And is not as if "blob |" takes much space...
> 
> I think you would agree that gitweb is quite different than what is
> commonly defined as "mystery meat navigation".

If you need to mouseover to discover that a part of webpage is link, it is
mystery meat navigation. Not in it's worst kind (it is quite obvious on
mouseover that that part is link), but still.

> Gitweb is very well thought out interface, and self-contained.
> There isn't much pondering about what and where to click, have newbies
> too.

But some links are hidden. But there is always (or should be always)
visible, i.e. in default link colors (blue for unvisited), and default
decoration (underline not only on mouseover - that's mystery meat
navigation).

> Think about the removal of the redundant "blob" and "tree" as database
> schema normalization if you will.  The redundancy is so well defined that
> even applying a simple algorithm to gitweb.perl will discover it.

Redundancy is not always bad. Especially in interface.

> Either that or you can think of it as "shortening" the line.
> Wlg, suppose that I have a file called "blobname" and a directory
> called "treename":
>     mode blobname    blob | blame | history | raw
>     mode treename    tree | history
> Is equivalent to
>     mode blobname    blame | history | raw
>     mode treename    history
> For any name "blob" and any name "tree".

But then we _must_ (to not have mystery meat navigation) mark "blobname"
and "treename" _clearly_ as links, while using different visual (e.g.
different colors) to clearly distinguish between "blob" entry and "tree"
entry. And no, mode and remaining links (well, "raw") is not enough.
Which is somewhat contradictory. And makes interface somewhat inconsistent
(although removing both "blob" link for blobs and "tree" link for trees is
a step towards consistency).

> Plus the code (gitweb.perl) has less redundancy and overhead.

Redundancy in _interface_ is not always bad. We have a lot of redundancy
(mostly via hidden _convenience_ links) in gitweb interface.

Overhead? What overhead? Creating the page? It's negligible. Size of the
page? It is small enough for current net bandwidths; creation time is
bottleneck (not for "tree" view though), not the bandwidth.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
