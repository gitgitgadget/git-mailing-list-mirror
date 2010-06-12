From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bugreport: Git responds with stderr instead of stdout
Date: Sat, 12 Jun 2010 16:52:34 +0000
Message-ID: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
References: <20100425130607.2c92740f@pennie-farthing>
	<v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
	<y2g51dd1af81004251124zc4da759dka2ceebe1d9735fd7@mail.gmail.com>
	<20100425192207.GA14736@coredump.intra.peff.net>
	<m2h51dd1af81004251232ue621ca42r7168429f45d20461@mail.gmail.com>
	<20100425193258.GA16171@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Jack Desert <jackdesert556@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:52:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTwm-0004z3-T4
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab0FLQwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 12:52:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55854 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab0FLQwf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jun 2010 12:52:35 -0400
Received: by iwn9 with SMTP id 9so1605626iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J+bLENNtPB6xzliWTxiuPEAnh/TfgeSutWHXqgZn4ok=;
        b=HJPDikxHv3urRHmqD4TJOrxIgon4Uk76avMvCxrrVcCeEt5OiBSDFzC2YyCnkLwfVy
         pWQMP/7JXaYHycDRAIiDCcaOKvwHZmt6dkAGlzr/UFP3wyOv8G0gk8tjArbLZNW6VCUM
         oVY4LsGQMq1L5nxhgzwO1GmsV32IXUDHbZlxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=abouHuFVgD8e5PN22oJpHdVTU6GE4eXUJ4r8VWPLMGxcAAGz2+OgkKcCJjfJY/2VoG
         9kxBFFpdEZ8qMOwiG7mgS1XdF8walE7G1/hcsZCFKyLkcHIWEVAxgJkK+20sEFCz2cUA
         ZWAFDndQcl/HAArFySD/1faMM/uGA1m+buc9U=
Received: by 10.231.124.41 with SMTP id s41mr3453406ibr.165.1276361554706; 
	Sat, 12 Jun 2010 09:52:34 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Sat, 12 Jun 2010 09:52:34 -0700 (PDT)
In-Reply-To: <20100425193258.GA16171@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149022>

On Sun, Apr 25, 2010 at 19:32, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 25, 2010 at 07:32:00PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> >> I've had some issues scripting `git fetch` because on error it'll
>> >> print to stdout and not stderr.
>> >
>> > Errors should go to stderr, so I imagine patches would be welcome.=
 Which
>> > messages went to stdout?
>>
>> I can't recall exactly now. Looking at fetch.c I can't see anything
>> obvious, I'll report anything if I spot it in the future.
>
> Thanks. As I mentioned, we've been fixing little things like this as
> time goes on, so it may well have been fixed already.

Actually here's an example with Git 1.7.1:

    # time /etc/github-backup/github-backup
    remote: Counting objects: 76, done.
    remote: Compressing objects: 100% (43/43), done.
    remote: Total 47 (delta 26), reused 18 (delta 4)
    Unpacking objects: 100% (47/47), done.
    From github.com:avar/linode-etc
       75a27cf..09d5ff7  master     -> origin/master
    From github.com:avar/svn-dump-fast-export
     * [new branch]      gh-pages   -> origin/gh-pages
     * [new branch]      git-merge  -> origin/git-merge
     * [new branch]      master     -> origin/master
     * [new branch]      rollout    -> origin/rollout

The script I'm running is github-backup
(http://github.com/avar/github-backup) which just outputs `git fetch`
output as-is.

Looking at the source the problematic code is in builtin/fetch.c's
update_local_ref. That function takes a char *display which it writes
to things that are both errors and just status messages:

Error:

		sprintf(display, "! %-*s %-*s -> %s  (can't fetch in current branch)"=
,
			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
			pretty_ref);

Just a status message (in my case):

		else {
			msg =3D "storing head";
			what =3D "[new branch]";
		}

		r =3D s_update_ref(msg, ref, 0);
		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '*',
			TRANSPORT_SUMMARY_WIDTH, what, REFCOL_WIDTH, remote, pretty_ref,
			r ? "  (unable to update local ref)" : "");

That function is then called as:

		if (ref) {
			rc |=3D update_local_ref(ref, what, note);
			free(ref);
		} else
			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
				TRANSPORT_SUMMARY_WIDTH, *kind ? kind : "branch",
				 REFCOL_WIDTH, *what ? what : "HEAD");
		if (*note) {
			if (verbosity >=3D 0 && !shown_url) {
				fprintf(stderr, "From %.*s\n",
						url_len, url);
				shown_url =3D 1;
			}
			if (verbosity >=3D 0)
				fprintf(stderr, " %s\n", note);
		}

Shouldn't that fprintf() be called as:

    fprintf((rc ? stderr : stdout), ...)

?
