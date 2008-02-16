From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] Correct git-pull documentation
Date: Sat, 16 Feb 2008 05:04:20 -0500
Message-ID: <76718490802160204x348af397i8bda3abb9dd04b0c@mail.gmail.com>
References: <1203137441-52448-1-git-send-email-jaysoffian@gmail.com>
	 <7vodahb63s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 11:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQJuj-0000L3-J4
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 11:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYBPKEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 05:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752803AbYBPKEX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 05:04:23 -0500
Received: from qb-out-0506.google.com ([72.14.204.233]:25406 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbYBPKEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 05:04:22 -0500
Received: by qb-out-0506.google.com with SMTP id e11so434386qbe.15
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 02:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=51Sdd1Vt+G6SqrEe/o24nFD5KvUISzs7yfuLe4b5PxU=;
        b=HHVEwt55s+KRLWWPurOk/WKlyAOGDCcqpK3tL9/6XWAJcSJERN2m6Ix3wHvX8xxTEVMCBpatqMfvhqeTRDD3oOI72pvQDclHMnfDPEx8RYEZz1YTQYrDGxROGmekKX56SHFHUL3RiKzE9M45x3hMcqQPF6XKgWZZXQXP1uuKj94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jmXcJGxXmsriLyI6XalI5UFO5vL1mMJGZUxpHn3E9sLRd8zXKXnrnyyyB3F96QjoSJMLTMexy8N4GUEuX7xrzorO11SzoO2Ztamql/QzzKyb7vGt25e19L2VKOt/axT0Z/5Nur+8oMftt80wjZqTZcNaRPr8ny9GXoVNOsNwBRI=
Received: by 10.114.174.2 with SMTP id w2mr938127wae.17.1203156260993;
        Sat, 16 Feb 2008 02:04:20 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Sat, 16 Feb 2008 02:04:20 -0800 (PST)
In-Reply-To: <7vodahb63s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74036>

On Feb 16, 2008 4:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
> > The --rebase option was documented in the wrong place (under MERGE
> > STRATEGIES instead of OPTIONS). Noted the branch.<name>.rebase
> > option and clarified the use '.' in a few places. Switched
> > "git-<command>" to "git command".
>
> Clarifying that --rebase is not a strategy is a good
> improvement.  Thanks.
>
> > @@ -55,12 +57,13 @@ Often people use `git pull` without giving any parameter.
> >  Traditionally, this has been equivalent to saying `git pull
> >  origin`.  However, when configuration `branch.<name>.remote` is
> >  present while on branch `<name>`, that value is used instead of
> > -`origin`.
> > +`origin`. (`branch.<name>.remote` may be set to `.` to pull from
> > +the local repository by default.)
>
> I am not sure if this special case deserves mentioning here.

Sigh, this is getting a bit frustrating. Yes you can use "fetch + merge" or
"fetch + rebase", but what I'm trying to get at here is that if the user
configures their branch appropriately, they can just use "git pull" and it
will just Do The Right Thing. But for that to work, the user has to know to
set branch.<name>.remote to "." and the git-pull documentation seems like the
right place to mention it.

> > -In order to determine what URL to use to fetch from, the value
> > -of the configuration `remote.<origin>.url` is consulted
> > -and if there is not any such variable, the value on `URL: ` line
> > -in `$GIT_DIR/remotes/<origin>` file is used.
> > +Unless pulling from the local repository, a URL must be determined
> > +for the origin. This is done by first consulting
> > +`remote.<origin>.url`. If there is not any such variable, the value
> > +on `URL: ` line in `$GIT_DIR/remotes/<origin>` file is used.
>
> Likewise.

Likewise what? All I did was clarify the existing paragraph which was wrong in
the case where remote is set to "."

> > @@ -138,6 +141,9 @@ You should refrain from abusing this option to sneak substantial
> >  changes into a merge commit.  Small fixups like bumping
> >  release/version name would be acceptable.
> >
> > +git pull --rebase . master::
> > +     This syntax is equivalent to calling `git rebase master`; see
> > +     linkgit:git-rebase[1] for details.
>
> Likewise.  That is a very roundabout way to say "git rebase
> master".  It happens to work as a logical consequence of two
> facts (1) that you can pull from any remote and (2) that "." is
> a valid remote that names local.  I am personally happy that the
> command works consistently, but I think we should rather teach
> people the more natural way to do their rebase in our
> documentation.
>
> The fact that we earlier talked about "git pull ." does not
> justify this addition.  Even though "git pull ." is also a
> roundabout way, it used to be the only way (we did not have the
> "git merge" callable as the top-level command) and there are
> existing documents that show the "git pull ." form out there on
> the web, and that is the primary reason we mention this ancient
> form, so that people who saw such an ancient notation can find
> out what it is about in our documentation.  Some people still
> prefer it from pure inertia, and we have no reason to deprecate
> it, but I do not think it is something we should advertise as
> the first class interface.

I want to be able to use "git pull" (w/o any options) and have it figure out
based on my configuration what to do with the current branch, be it:

1. merge another local branch.
1. rebase from another local branch.
3. fetch+merge from remote.
4. fetch+rebase from remote.

And in fact, I can. But to do so, I have to know that "." means local, so why
not advertise that fact in git-pull?

j.
