From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2009 Prospective student
Date: Tue, 24 Feb 2009 16:38:06 +0100
Message-ID: <200902241638.08300.jnareb@gmail.com>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com> <m3y6vxupvf.fsf@localhost.localdomain> <20090223155836.GI22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Rohan Dhruva <rohandhruva@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzNt-0004dH-Ek
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbZBXPiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbZBXPiV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:38:21 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:50676 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbZBXPiU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:38:20 -0500
Received: by fxm11 with SMTP id 11so2878835fxm.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pu5oeLIkSvprcDs/8evneBbpdtIi0HHIFBLlcMavjdg=;
        b=LYnvDCFjAUbSb4uJgVmjNbuTbgtlJfv30sNxbU7cBTqBkSAK2/dnYxUYxyTDc9OyV3
         ZOO5XV5VLR58deFOnXbm68pCbP0kgqq8bQxvpGh+YRhr0bwJ5zGQfY7VEpJ9aNmW87s3
         h1Mk/wc2l5UU+Y0x5JfMIK/+Ep6Ky/l3Cfw60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sf3a9vFH3postXsKqRbocthApjqMm1Sj9HjFU2kgqTY6h8o3U/2cdgwZ+2uUFr6iGk
         xFf8G9k4imuzSNquUl42gI89tA92e1ysLsC3Vt14hTirlsdiUM/pCmIctEwOQLYGQGXF
         xfoX6Qk4Irn0rssBA4z9TjmiRpQ8jlQj2PJdE=
Received: by 10.86.83.2 with SMTP id g2mr3818235fgb.1.1235489896351;
        Tue, 24 Feb 2009 07:38:16 -0800 (PST)
Received: from ?192.168.1.15? (abvk114.neoplus.adsl.tpnet.pl [83.8.208.114])
        by mx.google.com with ESMTPS id 3sm1759828fge.42.2009.02.24.07.38.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 07:38:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20090223155836.GI22848@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111297>

On Mon, 23 Feb 2009, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Nicolas Pitre <nico@cam.org> writes:
>>> On Sun, 22 Feb 2009, Miklos Vajna wrote: 
>>>> 
>>>> http://thread.gmane.org/gmane.comp.version-control.git/55254/focus=55298
>>>> 
>>>> Especially Shawn's message, which can be a base for your proposal, if
>>>> you want to work in this.
>>> 
>>> I don't particularly agree with Shawn's proposal.  Reliance on a stable 
>>> sorting on the server side is too fragile, restrictive and cumbersome.
> 
> We already rely on a stable sort in the tree format. [...]

I (and Nicolas) by 'sorting order' mean here ordering of objects and
deltas in the pack file, i.e. whether we get _exactly_ the same (byte
for byte) packfile for the same want/have exchange (your proposal), or
even for the same arguments to git-pack-objects (which is a necessary,
although I think not sufficient condition).

[...]
>> I think it is possible for dumb protocols (using commit walkers) and
>> for (deprecated) rsync.
> 
> Yes, it is possible for the commit walkers to implement a restart,
> as they are actually beginning at the current root and walking back
> in history.  Resuming a large file like a pack is easy to do on HTTP
> if the remote server supports byte range serving.  Its also easy
> to validate on the client that the pack wasn't repacked during the
> idle period (between initial fetch and restart), just validate the
> SHA-1 footer.  If the pack was repacked and came up with the same
> name you'll have a mismatch on the footer.  Discard and try again.

Can we assume that packfiles are named correctly (i.e. name of packfile
match SHA-1 footer)?

>
> And if you want to save bandwidth, always grab the last 20 bytes
> of the file before getting any other parts, save it somewhere,
> and revalidate that last 20 before resuming.  If its changed,
> you should discard what you have and start over from the beginning.

Therefore I think that restartable clone for "dumb" (commit walker)
protocols is easy GSoC project, while restartable clone for "smart"
(generate packfile) protocols is at least of medium difficulty, and
might be harder.

>>> I think restartable clone is a really bad suggestion for SOC students.  
>>> After all we want successful SOC projects, not ones that even core git 
>>> developers did not yet find a good solution for.
>>> 
>>> IMHO of course.
>> 
>> But I agree that within current limits (as far as I know there are no
>> way to ask for SHA-1; you can only ask for refs for security reasons)
>> it would be difficult to very difficult to add restartable clone
>> support to native (smart) protocols.
>> 
>> If not for this limitation it would be, I think, possible to do a kind
>> of fsck, checking which commits in packfile are complete (i.e. have
>> all objects), and based on that ask for subset of objects.  This would
>> require support only from a client... alas, this is not possible.
> 
> I think the current "must want advertised ref" restriction is
> too strict.  If you make the server check the reachability of the
> wanted object, (assuming it can be resolved to a commit) then you
> can pick up in the middle of history.  We already (to some extent)
> support that with the deepen thing in a shallow clone.  Sure, it
> may cause more server load when clients ask for this partial fetch.

Hmmm... I forgot about shallow clone.


Still, we can have the following situation:

  *---*---o---.---.---. ....  .---o---*---*   <-- some ref

      ^                               ^
      |                               |
      a                               b

where '*' means that we have commit and all its object fully in packfile
(i.e. if they are delta, there is base for delta in packfile), 'o' means
incomplete, for example commit with some o blobs missing, and '.' means
missing commit object.

Because git deals with continuous range, we can tell on restart of clone
that we have 'a', and that we want 'b', but without further extensions
to git protocols, where we can tell that we have some objects (to
exclude), but not assume anything about their requirements; something
that if I remember correctly was implemented in some floating 'lazy
clone' patch (well, lazy loading of blobs patch)...

[...]
> So, IMHO, the restriction that a commit must be advertised, and not
> merely reachable, is overly strict and doesn't buy us a whole lot.
>  
>> I think that unless 'restartable clone' is limited to commit wakers
>> (HTP protocol etc.) it should be moved up the diffuculty from "New to
>> Git?" section. I guess that mirror-sync, formerly GitTorrent, could be
>> easier to implement.
> 
> Maybe.  But a simple stable sort on the objects makes it easier,
> perhaps within reach of "new to git".

As Nico said in the presence of threaded packing ordering of _objects_
on _packfile_ might be not deterministic.

> 
> That ideas page is a wiki for a reason.  If folks feel differently
> from me, please edit it to improve things!  :-)

I'll try to add 'pack file cache for git-daemon' proposal to 
GSoC2009Ideas page... but I cannot be mentor (or even co-mentor) for
this idea.
-- 
Jakub Narebski
Poland
