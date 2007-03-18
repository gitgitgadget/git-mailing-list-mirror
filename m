From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] More diff possibilities in gitweb
Date: Sun, 18 Mar 2007 22:55:59 +0100
Message-ID: <200703182256.00005.jnareb@gmail.com>
References: <20070317151731.GA32571@auto.tuwien.ac.at> <ethnog$cf6$1@sea.gmane.org> <20070318150216.GB9607@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:56:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3MG-0007xn-P0
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933310AbXCRV4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 17:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933316AbXCRV4H
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:56:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:12855 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933310AbXCRV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 17:56:05 -0400
Received: by nf-out-0910.google.com with SMTP id o25so861488nfa
        for <git@vger.kernel.org>; Sun, 18 Mar 2007 14:56:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KdmrlmdtuE7b2TncrqTrFp8f8prcPJy0IJdK2tdJaIXdWGaTfSoJIhdiG90qIKFa7he99frBmDPM1euS+Aje+wKxs7fSeEM/gcdndj6vvPPHM0JRjLsyk5/viJaTNw8A+KG61jPhWN6aHKWICtBCStC2Qr+Ao6Vth/UWb42X+EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Lj4VzuG4xx4PYYp5PKTBG3StMqwDAhgzQ6nugvyyh9mvjzjPK6yKLVGWwK3mS1OlkVaRtpBNERpcfBA6ZJ9O+PdrQdU1KgMqMCSaeJbJLjYrADF6SnUcj4pRyfH8ACuyOs4zeXtG/zHk2kl2RjTIBZ+Y01mU7E1ORrkrqpw/+R8=
Received: by 10.82.167.5 with SMTP id p5mr8590596bue.1174254963678;
        Sun, 18 Mar 2007 14:56:03 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id i5sm15995543mue.2007.03.18.14.56.01;
        Sun, 18 Mar 2007 14:56:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070318150216.GB9607@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42529>

On Sun, Mar 18, 2007, Martin Koegler wrote:
> On Sat, Mar 17, 2007 at 10:51:51PM +0100, Jakub Narebski wrote:
>> Martin Koegler wrote:
>> 
>>> The whole is implemented in JavaScript on the client side (tested with
>>> IE 6 and Mozilla). On the server side, only the JavaScript file is
>>> included in the output (see below). 
>> 
>> I'd rather not use JavaScript for that, but perhaps add in the history
>> view (shortlog, history) selectbox to select commits (for shortlog, and
>> history of a directory) or versions of a blob/file (history of a file)
>> like in an "info" view e.g. in MoinMoin wiki:
>>   http://git.or.cz/gitwiki/GitSurvey?action=info
>> JavaScript can be used to beautify this like e.g. MediaWiki engine
>> does:
>>   http://en.wikipedia.org/w/index.php?title=Darcs&action=history 
>> (to allow selection of diff only in forward direction).
> 
> Let's focus on the UI first:
> 
> Using a select box, as shown above, exposes only a small part of all
> possible combinations, eg. how to compare commits on different
> branches.

I assume you meant "e.g. it doesn't provide a way to compare commits
on different branches".

We can easily add selectbox not only for shortlog and history views,
but also for heads view (which would allow to compare tips of different
branches) and tags view (which would allow to compare [commits pointed
to by] different tags).

Although there is yet another limitation, namely that shortlog and
history views are divided into pages...

> In my solution, I add to each link to a compareable object (commit,
> tree, blob) two new link, eg: link "commit" becomes "commit (base |
> diff)". "base" stores the ID of the object in a cookie. "diff"
> retrieves the cookie and compares it with it's associated object.

Well, I haven't though of it being a problem, because _I_ can have
always handcraft an URL to get requested diff from gitweb.

But after some thinking I guess that your idea has some merit
_provided_ that "(base | diff)" (by the way, what would happen
if someone would click "diff" without setting "base" first? is
"diff" inactive, or is some "base" default?) is added _only_ when
web browser supports it. It means that it should appear only when
JavaScript is turned on (easy if links are added by JavaScript)
and when cookies are turned on (I'm not sure if you are checking
this).

I guess that we could (under control of gitweb configuration, %feature
hash or something like that) add links which would lead to server
setting a cookie, or adding unused CGI parameters ('hp', 'hpb' and
'fp' are used only by 'diff' views).

> Currently, only few combinations are implemented. Future version could
> integrate tags (as an tag links to one commit). Additionally,
> comparing tags/commits with a tree could be enabled, as a tag/commit
> link to one tree.

Diffs makes sense only between two commit-ish (commit-ish being commit
or a tag; head also denotes a commit) for which we need 'h' and 'hp'
params, between two tree-ish (tree-ish being tree, commit or a tag)
for which we need 'h'/'hb' and 'hp'/'hpb' and usually 'f', sometimes
'fp', and finnally between two blobs, for which we need 'h'/'hb' and
'hp'/'hpb' and usually 'f', sometimes 'fp'.

There makes no sense to compare tree-ish with blob, for example.

By the way, I'm not that sure if gitweb handle correctly request for
diff of two _different_ tree-ish, or two arbitrary different files.

[...]
> 1) introduce git_treediff

NOTE: git_treediff is in some parts very similar (I think) to
git_commitdiff with the exception of not being there commit message,
nor links to parents, and I'd like very much to avoid code repetition
(duplication) betweem git_treediff and git_commitdiff if possible.
On the other hand git_treediff is similar to git_blob in handling
its parameters ('h', 'hp' but also 'hb', 'hpb' and 'f', 'fp').

[...]
> If depending on cookies is a problem for some out there, the base
> object can be passed in the URLs as fallback. It would require, that
> the select base object is included in every link, which gitweb
> generates.

Not much of a problem. Generation of links is consolidated in href()
subroutine, and it would be fairly easy to add passing through base
parameters, if they are needed or not. It means that if 'shortlog' view
was passed 'hp' parameter then "diff" links (or "diff <sha1>" links,
or "diff sel"/"diff selected" links) would lead to diff with given base.


P.S. I find it strange that you don't send patches from git. If you want
to test gitweb, you should have git installed. Why not fetch git.git
repository, and send patches from it?

-- 
Jakub Narebski
Poland
