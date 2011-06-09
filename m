From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 11:48:34 +0200
Message-ID: <201106091148.35114.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <20110608150537.GC7805@sigill.intra.peff.net> <BANLkTinibF0xmibeuJ6f9FUjaMmxavMJig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Thu Jun 09 11:48:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUbrC-0002lL-Ng
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 11:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab1FIJsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 05:48:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44623 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab1FIJsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 05:48:46 -0400
Received: by bwz15 with SMTP id 15so1155036bwz.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=5lNvh9XgmRqwQ8YpdaCLcdEV2f2gUoNiGXSlUp7V+Bk=;
        b=ls12JZyVViBsDvrbD6R7n4EVInlhp+BONRXsNJulo/KpDjZHHblWz+jeDdjGnh29k9
         5YfWk7BnstTMxBJpbxuU2Jk8iMTOGA2pCsEHEA4REng06wwuMu5H6doDlAhA9SiWiTxw
         6DV3BEl9EahdHhUiMSIwBLiEy5tIv0a3hxxks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kz39chxMaZeESCsyntu4O5quzc8yj+uljY1pnXSJ2kyU6L4IL75fRUJzCMyoRWO5Xv
         Fsel2KSzwxxONQcqysAbZZifdECBS9Ux8RLO7EqLp1yaSg2bvYWHWrUhERvIkC3hjf8u
         CNnp3VONPnijc88E7OYoUXD1o4w+/HyeXWWuM=
Received: by 10.204.136.217 with SMTP id s25mr536858bkt.13.1307612924811;
        Thu, 09 Jun 2011 02:48:44 -0700 (PDT)
Received: from [192.168.1.15] (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id q20sm1386267bka.17.2011.06.09.02.48.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 02:48:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTinibF0xmibeuJ6f9FUjaMmxavMJig@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175512>

On Wed, 8 June 2011, Michael Nahas wrote:
> On Wed, Jun 8, 2011 at 11:05 AM, Jeff King <peff@peff.net> wrote:
>> On Wed, Jun 08, 2011 at 07:39:16AM -0400, Michael Nahas wrote:
>>
>>> On Wed, Jun 8, 2011 at 7:12 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>>> I don't quite think that we need "git diff NEXT WTREE"; the short
>>>> and sweet "git diff" is short for a reason,
>>>
>>> To be clear, I'm not advocating and have never advocated getting ri=
d
>>> of zero-argument "git diff". =A0I've advocated that every (whole
>>> project) diff command should be expressible by a "git diff TREE1
>>> TREE2". =A0I'm fine with defaults if one or zero trees are specifie=
d.
>>
>> I agree with this, but...
>>
>>> So "git diff" would default to "git diff NEXT WTREE".
>>
>> Isn't this going to be behavior change, since your NEXT is not quite=
 the
>> same as the index? How do I now get an n-way combined diff of the
>> unmerged files in the index?
>=20
> The index is a file in .git/ that serves many purposes.  NEXT is an
> image of the whole project.  NEXT can be computed from the index and
> HEAD.
>=20
> During a conflicted merge, stage 0 of the index holds the resolved
> files.

It is simply not true.  During a conflicted merge, for conflicted files
there is _no_ stage 0!!!  Conflicted files have stage 1 =3D=3D base, 2 =
=3D=3D ours
and 3 =3D=3D theirs, where those stages have all conflicts that can be =
resolved
automatically resolved, and places where there is conflict replaced by
merge-base ('base'), current branch into which we merge ('ours') and
merged branch ('theirs').

> WTREE holds all merge files: the resolved and the unresolved=20
> (which have <<<< =3D=3D=3D=3D >>>> blocks in them).

Worktree version has files with conflict merge markers added in place
where there is conflict.


> I propose that during a=20
> conflicted merge, that NEXT be computed as HEAD plus the resolved=20
> files, that is, the files in stage 0 of the index.

Why _HEAD_?
=20
> "git diff HEAD NEXT" would print the resolved changes.
> "git diff NEXT WTREE" would print the unresolved changes
> "git diff HEAD WTREE" would print all changes.
>=20
> I believe that is the same behaviour as "git diff", "git diff
> --cached" and "git diff HEAD" during a conflicted merge.

"git diff NEXT WTREE" would not behave (with your proposal) like
"git diff", but like "git diff --ours".

"git diff HEAD NEXT" would not behave like "git diff --cached"
(which shows only '*Unmerged path foo').

"git diff HEAD WTREE" would be the same as "git diff HEAD" (just
longer to write), only because it doesn't involve index at all.
=20

> I do not know how "n-way" merge works.  I saw somewhere that indicate=
d
> that it was a series of N-1 two-way merges.

Where this "n-way merge" came from?  Peff wrote about "n-way combined
diff", which is something different.

--=20
Jakub Narebski
Poland
