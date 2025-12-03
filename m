Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7E296BDA
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764749107; cv=none; b=bOzkMMGRQR9V6vdiDxg+faiEm0U+1KKkAnOwngkjsM2NCH+p3tLSU3RCLwdZ6qm4v3t29on34YShNjGINCnJCT234pV7BsQk+B6m0WwFMSvEyc32Mdyqx4eh4sJL0r+G1yVa6cjHEZ3dkLudCu5zdrgzQ8trsKw0K6dsN7eucFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764749107; c=relaxed/simple;
	bh=UqcNbjj25ilIy0uWmxaJ29VXq4sCM6r8XW5EE7VKGL0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NeX7pVfVnZ5mh9XCJ3Usc4ay6lgJ7SEFtAFklk1tu2Ed391hVMOzlX0/qqRYi8QkcF1FcZGhGohxeZn6dyQTWJ0NvFpTsTrPUx4TyQST2aqr2O/LgZoh37fgNyQGRiLz08grDMfLGFC/6MRsFFdYWqHXidssRnfU/Nm2IWR2yRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=psRTA/eb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="psRTA/eb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764749095; x=1765353895;
	i=johannes.schindelin@gmx.de;
	bh=nhyhdqMtSCRc/t9rLjh1g8qsH60wp+jvHOKPqLm8Dpo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=psRTA/ebWD5p88ezazIH0teLjIAv5SZ1BlWIsZUvncyT+bHILIhXUjicqhiPH6K3
	 9zEHU6dB6ZzbVKKXsRdYTd5T7/ZouSxDMAxHxf7QJ5QYhUE0I6U7rUol4zHjsUnaR
	 L0tnj3MFc79LqM5wb1eeuEui3NKSQdvgGhD9jwhpU4tsRDOhGT1CQGeFNXKJzr5vB
	 bBpgvmfYc68N9WZ6MAt3aou4PHN3XJNxr7flrZVQ6bnb74QA1T78sVyaIq90Yq7py
	 RxVJP83f1IbznTsZ0IpimTcjw6EpXKzWrg84bI5NBxnPpo7J/CyXjng6CsjWR4EDJ
	 79NP5KNo/QLIo0Ehyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.54]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1wAfjb2iHw-00xSQc; Wed, 03
 Dec 2025 09:04:55 +0100
Date: Wed, 3 Dec 2025 09:04:53 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
cc: Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
In-Reply-To: <aS-D5lD2Kk6BHNIl@fruit.crustytoothpaste.net>
Message-ID: <416327f5-0c12-350a-ad8f-67b402a303d6@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <Z4bqMYKRP7Gva5St@tapette.crustytoothpaste.net> <xmqqwmevtfye.fsf@gitster.g> <f4a0cf5a-fe35-e038-a78e-e87caef03780@gmx.de> <aS-D5lD2Kk6BHNIl@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-464513714-1764749095=:9097"
X-Provags-ID: V03:K1:hoW/3x3+ilEzcHiE4/fbxa93+aLcpjC1077LOUfmZDndv5XGBgb
 8plMG82GliQIfoYUMtYkrjc6Cae11oqZk+pP5VI4tmRoQ0d4vC8W5F71rDM+17ycWp/YgbL
 XaajDulzSx6hnAYqqTbcwiwOgw+f3lno3zB71rgNNe7Qt4pLmg2yIxm+AE08vq8cgaWu5Ky
 F54niumLwULqu3kAw3WrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gkBmYz5SF6E=;9uZbZPfuiT6Ax7cr1yvWKxfG8b7
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-464513714-1764749095=:9097
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi brian,

On Wed, 3 Dec 2025, brian m. carlson wrote:

> On 2025-12-02 at 14:11:54, Johannes Schindelin wrote:
> > So you haven't come across `OSC P 1 0 ; ? ST` (see e.g.
> > https://www.xfree86.org/current/ctlseqs.html#:~:text=3DOSC%20P%20s%20;=
%20P%20t%20ST
> > for this control sequence, as well as others that elicit responses fro=
m
> > terminal emulators, from current cursor position to terminal
> > capabilities)? I use this Escape sequence myself in my `tmux` sessions=
 to
> > toggle the colors between bright-on-dark and dark-on-bright.
>=20
> So let's talk about this class of escape sequences with your patches for
> a moment.  I compiled the patches in this series on my system and
> changed the default PATH to use that client-side git binary (the
> server-side is unchanged).  I have not changed any configuration related
> to your patches, so the behaviour is the patch default.

Thank you for testing this patch series; I'm really happy that we can
cross this long-standing item off the list. It opens the door for us to
work together, and I am eager to keep the momentum going.

> I have a server called castro (after the San Francisco neighbourhood)
> and I added the following script called `~/bin/fake-git-upload-pack`,
> which should let us simulate a malicious server:
>=20
> ----
> #!/bin/sh
>=20
> printf '\033]10;rgb:ffff/ffff/ffff\007Hello, world!\n' >&2
>=20
> exec git-upload-pack "$@"
> ----
>=20
> This basically uses this class of escape sequences to change the
> foreground colour to bright white.
>=20
> I then ran a clone command, like so:
>=20
> ----
> % git clone -u fake-git-upload-pack castro:~/git/css.git
> Cloning into 'css'...
> Hello, world!
> remote: Enumerating objects: 663, done.
> remote: Counting objects: 100% (4/4), done.
> remote: Compressing objects: 100% (3/3), done.
> remote: Total 663 (delta 0), reused 0 (delta 0), pack-reused 659 (from 1=
)
> Receiving objects: 100% (663/663), 114.83 KiB | 38.28 MiB/s, done.
> Resolving deltas: 100% (329/329), done.
> ----
>=20
> Despite my patched Git binary, the escape sequence was executed and my
> foreground colour was changed.  So I don't think these patches are
> sufficient to actually fix the issue and I somewhat doubt that it's even
> possible at all to defend against a malicious SSH server which would
> like to send arbitrary escape sequences in general.
>=20
> I don't think we can just close stderr or not wire it up to the TTY
> because OpenSSH needs the TTY to prompt and doing so also breaks things
> on Windows.[0]  There are also cases where the remote side sends
> messages over the Banner portion of the protocol that are required for
> auth ($DAYJOB sends a unique URL for 2FA, for instance) and redirecting
> stderr to `/dev/null` would mean that people couldn't log into those
> machines.

Just to clarify: the patches here are specifically about the sideband
behavior in HTTPS, where the attack scenario that I am trying to defend
against involves a malicious server posing as a trusted one, e.g. via a
domain that looks highly similar to "github.com". In that context, SSH
isn=E2=80=99t really applicable, victims would be immediately suspicious i=
f asked
for SSH credentials.

So while your SSH tests are interesting, they=E2=80=99re outside the scope=
 of this
patch series. If you=E2=80=99d like to explore equivalent fixes on the SSH=
 side,
that would be a great complementary effort, but the focus here is ensuring
sideband over HTTPS is handled securely.

> If it's the case that we effectively can't fix this for SSH, I don't see
> the advantage to trying to patch this for HTTPS, since it would give a
> false sense of security and many people use both in their daily work (I
> certainly do).

Thanks for sharing your opinion.

I would frame it a bit differently, though: security is rarely
all=E2=80=91or=E2=80=91nothing, it=E2=80=99s a game of layers.

Even if SSH-based Git operations have weaknesses that seem to be unlikely
to be fully fixable right now, that doesn=E2=80=99t mean we should leave
HTTPS-based operations exposed when we can strengthen them. Each
improvement reduces the attack surface, and together they add up to
meaningful protection. So rather than a false sense of security, I see
this patch series as one necessary step in a layered approach. If
complementary work on SSH becomes possible, that would be great, but in
the meantime it seems rational to secure what we can.

> > It is true that many terminal emulators started disabling support for =
such
> > Escape sequences. But that's not because the terminal emulators' featu=
res
> > were buggy. That's because some console programs are buggy, allowing
> > payload originating from outside the user's trust boundary to be passe=
d
> > through to the terminal without proper sanitizing. That's what the ent=
ire
> > CWE-150 weakness class (https://cwe.mitre.org/data/definitions/150.htm=
l)
> > is all about.
>=20
> It is in general very difficult to eliminate all sources of untrusted
> input in the terminal because people run `cat` and a variety of other
> tools on untrusted files all the time.  It would certainly be convenient
> if we did not need to deal with that case, but we do nonetheless.
> That's why we've tended to patch terminal emulators when escape
> sequences execute code.

You=E2=80=99re right that users sometimes do things that are hard or impos=
sible to
protect against. There is nothing we can do in Git's source code to
prevent a user from `cat`ing a malicous file, for example.

But what we _can_ do is to ensure that Git, at least, is as secure by
default as we can make it. In this context: to sanitize control sequences
originating from outside Git's (or the Git user's) control. That=E2=80=99s=
 exactly
why CWE=E2=80=91150 exists: the responsibility lies with programs to sanit=
ize what
they pass through, rather than expecting terminal emulators to defend
against every possible misuse.

Patching terminal emulators is a last=E2=80=91resort mitigation, and given=
 the
number of terminal emulators, it's once again far from an "all-or-nothing"
situation. In line with your earlier argument, one terminal emulator's
maintainer could claim that _another_ terminal emulator is still
unpatched, so why should _they_ be required to patch theirs? You see where
that leads, to finger pointing instead of security, and we all lose. I'd
rather see all terminal emulator projects doing what is in their power to
add layers of security, just as I am trying to do what is in my power
regarding Git's security in this here mail thread.

Concretely, even if we cannot eliminate all sources of untrusted input in
the terminal, in general, we should at least do our best to prevent Git
from passing through untrusted input to the terminal.

> > That check, whether the output is even sent to a terminal emulator or =
not,
> > is notably something that cannot ever be done by those `pre-receive` h=
ooks
> > that were held up as examples to block this here patch series: They ha=
ve
> > no way of knowing whether or not their output goes to a terminal, but =
they
> > send the control sequences anyway. Because YOLO, I guess. In that
> > respect, I think that even you two would agree that those `pre-receive=
`
> > hooks are broken by design.
>=20
> I don't agree.  Lots of systems that are not terminals interpret
> at least some terminal escape sequences, such as GitHub Actions.  And I
> can tell you that there are a substantial number of organizations that d=
o
> indeed have actual pre-receive hooks in production that use terminal
> escape sequences without actually knowing that the other side supports
> them because I have had to troubleshoot those pre-receive hooks.

Oh, I can imagine how cumbersome troubleshooting such `pre-receive` hooks
can be. I can imagine how insistent the inventors of such hooks are on
doing a legitimate thing. And because they are paying customers... they
are right.

And far be I from noticing that many systems that are not terminals
interpret some Escape sequences. In the extensive research I conducted in
October and November last year in the course of developing this here patch
series, I even stumbled across successful exploits targeting users of
web-based log viewers that interpret such Escape sequences, a scenario in
which I myself would have easily fallen prey to such an attack, as I would
have been totally unprepared to even suspect that the log viewer shows me
anything but plain text.

Having said all that, it is incorrect in general to assume that all
consumers of the output of Git commands _can_ interpret Escape sequences,
even if there should be a surprising number of consumers that do.

> Even if we were to agree that it might not be desirable to send terminal
> escape sequences without knowing if there's a terminal, people do it,
> and even Vim does it (try `TERM=3Ddumb vim -e`, whereupon it will send
> escape sequences, much to my annoyance).  I don't think we can say that
> everybody thinks this kind of thing is unreasonable and clearly some
> people very much want to do it and make reasonably good use of it, so
> it's a use case we should consider.

I am puzzled. Do you really want to maintain that it is rational to send
Escape sequences without checking whether the receiver can interpret them
as desired? By this rationale, we could simplify the logic in `color.c`
rather dramatically, and always send Escape sequences. If you think this
through, I am sure you will want to stop this train of thought.

> > Also, it is relatively easy if you fail to protect your terminal emula=
tor
> > to have your entire session messed up to a point where not even a `res=
et`
> > restores it. And corrupting the terminal session is still much better =
than
> > getting pranked by having all of Git's output be overwritten with a
> > picture of a snake (download the raw version of
> > https://github.com/csdvrx/sixel-testsuite/blob/master/snake.six -- aft=
er!
> > verifying that it is just a regular text file containing only a few
> > harmless escape sequences~ -- and then `cat` it to your terminal). Tha=
t
> > could have been goatse, too, though. Or for that matter (as
> > https://github.com/mpv-player/mpv demonstrates, which allows you to re=
nder
> > entire Youtube videos in your current terminal window) you could be
> > Rick-rolled. And all of those are still pranks more than anything. Muc=
h
> > worse can be done with those terminal emulator capabilities.
>=20
> As I mentioned, sending Sixel images can be legitimately useful to send
> things like QR codes to build outputs or for things like authentication.
> Certainly there are less savoury things one can do as well.

Right. But the presence of legitimate use-cases does not legitimize
holding up bug fixes. For a humorous take on this, see https://xkcd.com/11=
72/.

By definition, every security bug fix is a breaking change. Just like the
user of the space bar heater in that xkcd comic, the `pre-receive` hooks
you cited rely on a bug that needs to be fixed.

And a bug in Git it is, it's a weakness, matching CWE-150, giving rise to
vulnerabilities I have illustrated on the git-security mailing list (which
I will make public once I am reasonably certain that most Git users have
had a chance to upgrade to versions that no longer have those
vulnerabilities).

Ciao,
Johannes

> > For the record, I was almost successfully gas-lit into believing that =
this
> > here issue is not even a vulnerability, as was claimed by some (but no=
t
> > all) involved in the discussion on the Git security list. Fortunately =
I am
> > in a wonderful position that I have access to outstanding security
> > researchers, and I asked two of them, independently, to tell me whethe=
r or
> > not this is a vulnerability that needs to be fixed. Independently, bot=
h
> > agreed that my assessment "High" was too high, and it should have been
> > "Moderate" instead. At the same time, they also both agreed that it is=
 a
> > vulnerability that should be fixed in Git.
>=20
> I don't think "gas-lit" is an accurate characterization of the
> discussion.  I disagreed with you that this was a Git-specific problem
> and some others wanted more discussion about the matter.  I don't think
> anyone else had intentions of misleading or deceiving you, or making you
> doubt your memory or perceptions of reality, and I certainly did not.
> Instead, we simply disagreed on a technical matter.  Linus and I have
> clearly disagreed strongly on some matters on this list in the past and
> I don't think that "gaslighting" would be an accurate characterization
> there, either.
>=20
> I will state that while I do disagree with you on this matter and it's
> clear that we don't always see eye to eye or necessarily get along
> famously, I do appreciate the work that you do for this project and Git
> for Windows and I do respect you and your contributions.
>=20
> [0] I remember this from Git LFS: https://github.com/git-lfs/git-lfs/iss=
ues/1843
> --=20
> brian m. carlson (they/them)
> Toronto, Ontario, CA
>=20

--8323328-464513714-1764749095=:9097--
