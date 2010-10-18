From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Mon, 18 Oct 2010 16:15:22 -0500
Message-ID: <20101018211522.GA7655@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 23:19:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7x6v-0007P6-D0
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 23:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136Ab0JRVTG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 17:19:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48291 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab0JRVTE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 17:19:04 -0400
Received: by iwn35 with SMTP id 35so534105iwn.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fuo9VEXFt7jate3xXXQjYhqJJdLZYtzqZZlexM62+/E=;
        b=X46M5QYU+FFxkVqxqSUJpwOX05xWHoBDWGPmADf9x2qGnalOatYTS37ljMvwo6ePhO
         kNcp9kOPV0Yr2/sGnkv89qhAB+OHjZrNu+875C2vNgCDgYAKNPT4F5Kc/PXZxip5sA+O
         UOmQyLfU/e2i7f4gcjzjru58LphucvZ7IqcGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=T0Y8+QCWivBtlu+wrnqXgL7Q0Gqb3AqZ1kIq9v3U4MIPJoP5jdu2ZSzffW0ejxdWy7
         CqgMB9EwUi+RLIYaEo/dXdfcJi0KiNMcl5Un1XLLjohCM1wBbPG5H/ipo9qt8mJ/viF4
         5ESrLcZnzahuLnOzQnKLhYEs89SB6jsFkQMDU=
Received: by 10.231.157.195 with SMTP id c3mr3903690ibx.155.1287436742458;
        Mon, 18 Oct 2010 14:19:02 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j21sm2889924vcr.34.2010.10.18.14.18.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 14:19:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159288>

Hi Thore,

Thore Husfeldt wrote:

>     what an annoying learning experience.=20
>=20
> I promised myself to try to remember what made it all so hard, and to
> write it down in a comprehensive and possibly even constructive
> fashion.

Thanks for doing this work!

> There probably is a radical case to be made for abandoning the word
> =E2=80=9Ctracking=E2=80=9D entirely. First, because tracking branches=
 don=E2=80=99t track, and
> second because =E2=80=9Ctracking=E2=80=9D already means something els=
e in Git (see
> below).

I think you are overthinking this "tracking like a Basset hound" thing.

When a person keeps a diary to track their appointments, is it always
up to date?  No, it is only as up to date as the person is diligent.
Similarly, git provides a namespace for branches that a person can
use to track remote branches, which is only as up to date as one
keeps it.

So what would be a better term?

>                In the ideal world, origin/master would be something
> like =E2=80=9Cthe fetching branch=E2=80=9D for the origin=E2=80=99s m=
aster, or the =E2=80=9Csnapshot
> branch=E2=80=9D or the =E2=80=9Cfetched branch=E2=80=9D.

=46amiliarity might be leaving me blind, but these all sound even more
confusing to me.  In fact, origin/master is not only updated by
fetching but by pushing (at least if I remember correctly).  It is
meant to be git's local memory of remote content.

Using the term "remote-tracking" consistently would certainly be an
improvement and would make it easier to do a search-and-destroy (erm,
-and-replace) if another term comes up that seems to fit the concept
better.

> The wonderful and central concept of staging area exists under at
> least three names in Git terminology. And that=E2=80=99s really, real=
ly
> annoying. The index, the cache, and the staging area are all the same=
,
> which is a huge revelation to a newcomer.

Heh.  Personally I tend to think in terms of "the index".

e.g., "git add" registers changes for use in the next commit.
Information about the commit in preparation is stored in the
index.

Why?  Because "staging area" has this misleading feeling of
not-jargon.  It is jargon and when misused can be very confusing
(to me, at least).

> 2. Introduce the alias `git unstage` for `git reset HEAD` in the
> standard distribution.

Doesn't "git reset" ('reset the staged content to match...') fit the
same metaphor?

> 3. Duplicate various occurences of `cached` flags as `staged` (and
> change the documentation and man pages accordingly), so as to have,
> e.g., `git diff --staged`.

Already exists (though in practice it tends to be easier to teach
--cached since that is the option that documents all over the web
use).

> Clean? What=E2=80=99s this now? Clean and dirty are Git slang, and no=
t what I
> want to meet as a new user. The message should inform me that the
> untracked files in the working directory are equal to their previous
> commit.

Huh?

Anyway, improvements welcome (in the form of a simple mockup, or even
better, patches).

>     changed but not updated:
>=20
> I=E2=80=99m still not sure what =E2=80=9Cupdate=E2=80=9D was ever sup=
posed to mean in this
> sentence.

It's historical residue.  (What is now done with "git add" used to be
done with "git update-index").

>     Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>
> should be
>
>     Untracked files:
>     (use "git track <file>" to track)

Is this "git track" a synonym for "git add -N"?

>                                      The opposite of staging is `git
> reset HEAD <file>` and the opposite of tracking is -- well, I=E2=80=99=
m not
> sure, actually.

Ah, this is a kind of obnoxious thing!  For a newly added file,

	git reset -- <path>

ought to un-add it, but it doesn't.

=46or a file that has been around for a while, removal is imho just
adding a different kind of change.  It would be nice if

	git add -- <path>

pointed to "git rm --cached" to help the operator to do that.

> The entire quoted paragraph in the tutorial can be removed: there=E2=80=
=99s
> simply no reason to tell the reader that git behaves differently from
> other version control systems

How will a person used to e.g. cvs ever adjust if they don't even
realize git is different?

Hope that helps,
Jonathan
