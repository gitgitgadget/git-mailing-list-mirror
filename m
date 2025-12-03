Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA6200C2
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722843; cv=none; b=drhfz5Wa4YOX6Rizjpu1b4Lrl7V3FWC3inIZd8sXcTRnmU3lYD28myZknNATGU1pZSZcdossOMyQWq6jdVD7AwptN2exmiz2il2EI7V2FmJQsoBScmZvYQZF9yV4y/waYnd+Kp1dnD55NaFfGFpU8sZGaTeLvr3alNm1VUYuwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722843; c=relaxed/simple;
	bh=D83y6+GwQYv3PnWlCaOIOsnajJNPk7Ly9k/1k9GHbDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCdZHk2ICFREENvgCtZLPKKBrDFbKnIhvjHQHm+d1MY9qOwHtvp5FNyStHMjrWcYcqfbpMoYA/Mfn9kQUTIP1ohH/pbD54SNeWwekQ7qQeYCc0mjf8GFILQg6EIZzp/4tjeJ1moyNEZdAwC0oqaCoFUXgt7VCGkNuWsq0CPRfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=k7dU0Ljn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k7dU0Ljn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764722840;
	bh=D83y6+GwQYv3PnWlCaOIOsnajJNPk7Ly9k/1k9GHbDY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=k7dU0LjnvqEUhw9LNCIdImapxUy8j5UB+cXr2DCYGahIfU0ziMje0T8s6HWHBJjz9
	 cg/m+oWPK478SDVFzx0keipZThfnBpiTE+M//1wuzuA0KKcYbs5aLY+Ul26PCbIuLd
	 3Yzna+9aN6QmQ8eoH35c/cbSjeUp2QuObAcYQdiJetrs5cNJkzUNOqWvG8JlVRu9Ob
	 U9y+Ac0jnLJ23LWyKxl3vsQXa4NqjwKrsAabfTwqyE5zfj/K7VketmD9EzLdFzA+Mb
	 jpzDTWQY2SXcSc/XoWF15LvJse/wzYb+vhoC8qOpv9wwyIYHrYKGeRzFbu+e+j2k7c
	 YilgDD9tAhqiXdRg3omZcWVlasm9nV2XYmKNjiG1dm37W20bjo45GtyyUJHULEyGKk
	 FXPMt9wQ6A+SIbpE+GvuNJg6AkHcEZ9ygxdi9JgMvcrF+4YiqxCk/M84zpJ4SQ92Dt
	 dYrK+ZMtIcZmcpmgtv6WyKzKSGKSVXNGxrvmsHoobEIl+GzmQu+
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ec58:fb7:4d4e:5078])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0B8522003B;
	Wed,  3 Dec 2025 00:47:20 +0000 (UTC)
Date: Wed, 3 Dec 2025 00:47:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
Message-ID: <aS-D5lD2Kk6BHNIl@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <Z4bqMYKRP7Gva5St@tapette.crustytoothpaste.net>
 <xmqqwmevtfye.fsf@gitster.g>
 <f4a0cf5a-fe35-e038-a78e-e87caef03780@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fp3myG8fs9o9LfQV"
Content-Disposition: inline
In-Reply-To: <f4a0cf5a-fe35-e038-a78e-e87caef03780@gmx.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Fp3myG8fs9o9LfQV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-02 at 14:11:54, Johannes Schindelin wrote:
> So you haven't come across `OSC P 1 0 ; ? ST` (see e.g.
> https://www.xfree86.org/current/ctlseqs.html#:~:text=3DOSC%20P%20s%20;%20=
P%20t%20ST
> for this control sequence, as well as others that elicit responses from
> terminal emulators, from current cursor position to terminal
> capabilities)? I use this Escape sequence myself in my `tmux` sessions to
> toggle the colors between bright-on-dark and dark-on-bright.

So let's talk about this class of escape sequences with your patches for
a moment.  I compiled the patches in this series on my system and
changed the default PATH to use that client-side git binary (the
server-side is unchanged).  I have not changed any configuration related
to your patches, so the behaviour is the patch default.

I have a server called castro (after the San Francisco neighbourhood)
and I added the following script called `~/bin/fake-git-upload-pack`,
which should let us simulate a malicious server:

----
#!/bin/sh

printf '\033]10;rgb:ffff/ffff/ffff\007Hello, world!\n' >&2

exec git-upload-pack "$@"
----

This basically uses this class of escape sequences to change the
foreground colour to bright white.

I then ran a clone command, like so:

----
% git clone -u fake-git-upload-pack castro:~/git/css.git
Cloning into 'css'...
Hello, world!
remote: Enumerating objects: 663, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 663 (delta 0), reused 0 (delta 0), pack-reused 659 (from 1)
Receiving objects: 100% (663/663), 114.83 KiB | 38.28 MiB/s, done.
Resolving deltas: 100% (329/329), done.
----

Despite my patched Git binary, the escape sequence was executed and my
foreground colour was changed.  So I don't think these patches are
sufficient to actually fix the issue and I somewhat doubt that it's even
possible at all to defend against a malicious SSH server which would
like to send arbitrary escape sequences in general.

I don't think we can just close stderr or not wire it up to the TTY
because OpenSSH needs the TTY to prompt and doing so also breaks things
on Windows.[0]  There are also cases where the remote side sends
messages over the Banner portion of the protocol that are required for
auth ($DAYJOB sends a unique URL for 2FA, for instance) and redirecting
stderr to `/dev/null` would mean that people couldn't log into those
machines.

If it's the case that we effectively can't fix this for SSH, I don't see
the advantage to trying to patch this for HTTPS, since it would give a
false sense of security and many people use both in their daily work (I
certainly do).

> It is true that many terminal emulators started disabling support for such
> Escape sequences. But that's not because the terminal emulators' features
> were buggy. That's because some console programs are buggy, allowing
> payload originating from outside the user's trust boundary to be passed
> through to the terminal without proper sanitizing. That's what the entire
> CWE-150 weakness class (https://cwe.mitre.org/data/definitions/150.html)
> is all about.

It is in general very difficult to eliminate all sources of untrusted
input in the terminal because people run `cat` and a variety of other
tools on untrusted files all the time.  It would certainly be convenient
if we did not need to deal with that case, but we do nonetheless.
That's why we've tended to patch terminal emulators when escape
sequences execute code.

> That check, whether the output is even sent to a terminal emulator or not,
> is notably something that cannot ever be done by those `pre-receive` hooks
> that were held up as examples to block this here patch series: They have
> no way of knowing whether or not their output goes to a terminal, but they
> send the control sequences anyway. Because YOLO, I guess. In that
> respect, I think that even you two would agree that those `pre-receive`
> hooks are broken by design.

I don't agree.  Lots of systems that are not terminals interpret
at least some terminal escape sequences, such as GitHub Actions.  And I
can tell you that there are a substantial number of organizations that do
indeed have actual pre-receive hooks in production that use terminal
escape sequences without actually knowing that the other side supports
them because I have had to troubleshoot those pre-receive hooks.

Even if we were to agree that it might not be desirable to send terminal
escape sequences without knowing if there's a terminal, people do it,
and even Vim does it (try `TERM=3Ddumb vim -e`, whereupon it will send
escape sequences, much to my annoyance).  I don't think we can say that
everybody thinks this kind of thing is unreasonable and clearly some
people very much want to do it and make reasonably good use of it, so
it's a use case we should consider.

> Also, it is relatively easy if you fail to protect your terminal emulator
> to have your entire session messed up to a point where not even a `reset`
> restores it. And corrupting the terminal session is still much better than
> getting pranked by having all of Git's output be overwritten with a
> picture of a snake (download the raw version of
> https://github.com/csdvrx/sixel-testsuite/blob/master/snake.six -- after!
> verifying that it is just a regular text file containing only a few
> harmless escape sequences~ -- and then `cat` it to your terminal). That
> could have been goatse, too, though. Or for that matter (as
> https://github.com/mpv-player/mpv demonstrates, which allows you to render
> entire Youtube videos in your current terminal window) you could be
> Rick-rolled. And all of those are still pranks more than anything. Much
> worse can be done with those terminal emulator capabilities.

As I mentioned, sending Sixel images can be legitimately useful to send
things like QR codes to build outputs or for things like authentication.
Certainly there are less savoury things one can do as well.

> For the record, I was almost successfully gas-lit into believing that this
> here issue is not even a vulnerability, as was claimed by some (but not
> all) involved in the discussion on the Git security list. Fortunately I am
> in a wonderful position that I have access to outstanding security
> researchers, and I asked two of them, independently, to tell me whether or
> not this is a vulnerability that needs to be fixed. Independently, both
> agreed that my assessment "High" was too high, and it should have been
> "Moderate" instead. At the same time, they also both agreed that it is a
> vulnerability that should be fixed in Git.

I don't think "gas-lit" is an accurate characterization of the
discussion.  I disagreed with you that this was a Git-specific problem
and some others wanted more discussion about the matter.  I don't think
anyone else had intentions of misleading or deceiving you, or making you
doubt your memory or perceptions of reality, and I certainly did not.
Instead, we simply disagreed on a technical matter.  Linus and I have
clearly disagreed strongly on some matters on this list in the past and
I don't think that "gaslighting" would be an accurate characterization
there, either.

I will state that while I do disagree with you on this matter and it's
clear that we don't always see eye to eye or necessarily get along
famously, I do appreciate the work that you do for this project and Git
for Windows and I do respect you and your contributions.

[0] I remember this from Git LFS: https://github.com/git-lfs/git-lfs/issues=
/1843
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Fp3myG8fs9o9LfQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaS+IkwAKCRB8DEliiIei
gW9IAPwO3kgUseBrwpVsreTU2fW7R8gAc4a/l6YYcMPCAnSRVQEA/J5oaXWl7ePV
lc+Bim2Tla4Hl6Adkx137O9mS68tFgk=
=IBMb
-----END PGP SIGNATURE-----

--Fp3myG8fs9o9LfQV--
