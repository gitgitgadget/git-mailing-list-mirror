Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB481531F0
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975200; cv=none; b=R0zqD5BxV1VgyYiUQgNKvH6D6BZKJeoj6zRY5UzPTDUdyn9FP5clWf7bKyu6rWMADo9it+am5MJqDu6G125i8rDAfgCF4C8BnuY2M6eer8IujXoPYqYbx86LXda+Y63hUJP96ywEtMyX3TyHS0u1A1Y+j3bse8aa6SgMpZNh+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975200; c=relaxed/simple;
	bh=ntSuYLVv6t8ORQ6tQPgbJVYl0Lo1KdJlYnS1MxjZ4d8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OgR2NSdoBayUsNJqXA45QIE55bwvBWrajH2YuilhnJjKJcarp/7+texgGC/5H1I5j2EGTzP6KiO7xIXLS2PaANWOWhDyeQt5ep7GQOnrCy+7u8l9Am/KGzuzYcXRg7H86eXvIe2kwMjQRMhlRiumxa9AA6qY7dir14uDicXgbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=O+ycWydM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="O+ycWydM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742975190; x=1743579990;
	i=johannes.schindelin@gmx.de;
	bh=ZJW9ivBgFUMTB94Ypjfln9bar/r97faFN4ZfYofE8No=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O+ycWydMw0c4z/KQSka5emV2qEh0AVubuioKc+7+jJlP8hGbbYhJvsbzUHM7iX2W
	 h5iwL+o+rdGGpAlL/SCOD3hk4BrH5VgXJBbPT+Kdv56qwAgi6D/tBVFaQxJLvpPlp
	 dX0vIzzAE2UkGTjfnbW97TKQuzG6hB/jyDphqxMZdwTzaJ6kUVCEmUPNGpkzwNn6r
	 m5ZEw1T30ks4+Z8EI7/cmDjgwiMjqGwuMlq6XpQkanrGjfKraUeM+FPkpFLdGLCMU
	 yp9T1CUNid/GFmZSj740gfOjZinzgLne1yz+cH6/mPDtvnUZBCjEWshCeNYsAbf63
	 HlhYVE7vn1YX9+cPqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1tBgxM3VYr-00zhh9; Wed, 26
 Mar 2025 08:46:30 +0100
Date: Wed, 26 Mar 2025 08:46:29 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 07/10] wildmatch: explicitly mark intentional use of
 the comma operator
In-Reply-To: <Z-OWpEDwHtaq3r2J@pks.im>
Message-ID: <721cfcca-b702-cb44-c847-f438b2495bda@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com> <Z-OWpEDwHtaq3r2J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xIn302m9McVc6gr4fI+PPjYhgjU0KLI0XzJeKazsnMHzcasKOJs
 Pbub1gOnuQA//bJfzvM6GzwHsKZMFkY/csmGA6xhDh4DEAcP+lUiSpe8D6PlIRfsGK788Kk
 j0x/gaRxhg8nsux3cw8P4RnuxZ8ZkLsL2PRYUnJBx0c3Hbu2KbKFfFpmQLqnvGmnbY8l6a6
 Jo12Y91V2qUhC4xv4RoAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fZAy9JHbCyw=;hL/qC0oOPDSsIoJpRrVwz8hV4W0
 Un5+TWSyfCHQ0m6ijcHK1bV74R6ADzVR9YOfBV+8BXHcu3/gqEiwp3tGWYcmfm18q059gH8G4
 osaiIJYZ+ngSe6z2YuRwNPL9I61uftWtqV5bFMby/5466Pkyma+DHWhAUT042p5xrBSpbQOkK
 Bgfx+8PUfZh7oeRSoeBb3iQ+8tAxv6vlTLJhtjwnkgfRpmy/sZL1ZM4hZJq0OUtD8pT5EaAsF
 K282pho88zIR+HS8OV0VR4wPYsFihe14px65EU9BIU4vMEq/jJL+JK5etGQmz7u52rbHqEV4i
 cLd89KAXyMb2hKv1V1/HilcRZTHm/T6b5AAEXvwOo+bVWF6tRbznSvlVBT14wxxcjqtgNI0Of
 FDlM0pk8COxThKFhY6K3R1v2YFiWcRN/Z0v6w4TM9zinErkNZAVJzabjj9mhistR9448C+zMr
 lvy1erwS0n8OtIrW1hMGQt1BcieXQhjLnGkYCz9opzeGIpXC3dV54B3WggYv1UCLAJ/NWneh8
 LhDrVZfvd3flANQ4NaOQeJzDqeTNbnu2G0WOGr+mmjjUZOYifaggn1EPXICCM2+faykmsDevV
 Y9nynh8oB+r5yF5f7Aar/dh3IBduO6Nm1xGk2MsVHcwGZPbeVOzqukAoQfQOe5Ys+IcorLXbZ
 JmuINf76mrkin7R0m2F0+oo4DtrHhKkQVm3DoQfqGJaTuCoarc6IuDk0KyFXifOjxwwMEnwRh
 fI8Z5tNJiWX1dbeDn+InVYZ4FFhpQ+wojoRFfzaZAgObggEfeM8d/j/x+jpNd40La0+w7cmjn
 gSZfYhFRj/NLP2wEC8/YkW6Hhclez87zljXtXYEQWoe3nHzE/JcjGzMrQ66qkKu0hY+n2d410
 3E2RzbK3VP3Fh73t1nr8NzGk6xL/sEZectvuoofJiRaFj6iAPIz94XWCF9WDCF2CtAqmk2NBK
 mI3BpB1i8mVPS+aiBkqjaWSw7Ssx+my19niIq3JfCIqdZcUXbNNPi74z51G96bElZZKAk6PzF
 5jDh1rtSgnhgz2nxNofFUnE3AELJgUi0mV3ZHvFnmU2qJRbfcK7+QWLxt6bY18vVBBfE7i0SM
 m6WBoDHEJk267bM8pe8stkpSVKIvcvqPU62wSBteb53UhhDyKNK/rKzMXJzz1TEc2KS/rCmfS
 JxkbyYdKPR5t12QBo5eCgF++TBzW2bsGZUDnlVeXZNDP9tfrGvfW9K8ZETd4KmF01TftQU0Tl
 YmBo2Ygom30JIqgHSKA1jf8o54kR3++DAEb6K710FQJiOqw8F3C7j0d1daZHExcnbONugppv8
 KLx6J0WzTA8eN6d7zsdPiixFH7CIaQ7XvRlSxYZ4LYfxixrW6Dhwq3/ybfOHSXyFaiMkfD8mI
 aNJOsqTFQPKluGakFz0qxauWcSQdfNoeU/x9KJyVbZ+vhtRzQGP/W1R6TC87sFweUASLZdgKi
 xN5uytPWXWXowzbDsLtCB6Hu55k0NJRV3KI/Bajrrr9rC/4Rx
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 26 Mar 2025, Patrick Steinhardt wrote:

> On Tue, Mar 25, 2025 at 11:32:11PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/wildmatch.c b/wildmatch.c
> > index 8ea29141bd7..ce8108a6d57 100644
> > --- a/wildmatch.c
> > +++ b/wildmatch.c
> > @@ -268,7 +268,7 @@ static int dowild(const uchar *p, const uchar *tex=
t, unsigned int flags)
> >  					p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
> >  				} else if (t_ch =3D=3D p_ch)
> >  					matched =3D 1;
> > -			} while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
> > +			} while ((void)(prev_ch =3D p_ch), (p_ch =3D *++p) !=3D ']');
> >  			if (matched =3D=3D negated ||
> >  			    ((flags & WM_PATHNAME) && t_ch =3D=3D '/'))
> >  				return WM_NOMATCH;
>
> In this case I agree that it makes sense to not introduce curly braces
> for brevity.

I should probably have mentioned that this patch took the longest to write
of the entire patch series, by far. Not because of the changed code, that
was easy. No, when I wrote the commit message and spotted the `continue`,
I did not want to leave it at that because the code around that `continue`
looks... well, let's just say that it could be rewritten for clarity.

In fact, when I looked at the following part, I was immediately
_convinced_ that it is incorrect, and had to work very hard to understand
why it works correctly, even going so far as to single-step through a
couple of examples, e.g. `test-tool wildmatch wildmatch 'b' '[[:a-z]'`:

				} else if (p_ch =3D=3D '[' && p[1] =3D=3D ':') {
					const uchar *s;
					int i;
					for (s =3D p +=3D 2; (p_ch =3D *p) && p_ch !=3D ']'; p++) {} /*SHARED=
 ITERATOR*/
					if (!p_ch)
						return WM_ABORT_ALL;
					i =3D p - s - 1;
					if (i < 0 || p[-1] !=3D ':') {
						/* Didn't find ":]", so treat like a normal set. */
						p =3D s - 2;
						p_ch =3D '[';
						if (t_ch =3D=3D p_ch)
							matched =3D 1;
						continue;
					}

For context, here is a link:
https://gitlab.com/gitlab-org/git/-/blob/v2.49.0/wildmatch.c?ref_type=3Dta=
gs#L213-227.
At this point, `t_ch` is the current character in the text to match;
`p_ch` (and `*p`) is the current character in the _pattern_, and it is
_inside_ a `[...]` character range, and it wants to match a character
class of the form `[:alnum:]` but also allow for a regular character range
that starts by including the colon. And that latter scenario, where it is
_not_ a special character class, is what this `continue` is all about.

What threw me was that `t_ch =3D=3D p_ch` condition _directly_ after assig=
ning
`p_ch =3D '['`. It is still a pattern I would always immediately suspect t=
o
be a bug: Why not compare `t_ch =3D=3D '['` instead, which would be much m=
ore
obvious?

You will also note that the value of `i` is only used in the condition,
and it is basically used to determine whether the the colon was
immediately followed by the closing bracket or not, which could be
rewritten to be a lot more obvious.

So what does the `continue` do here? It skips back to the outer loop,
continuing with the `:` as next pattern character in the character range,
and for that it is crucial that the `p_ch` be set to the opening bracket
and `p` is rewound _just_ so that the assignments in the loop condition
can set things up for the next loop iteration (still within that `case
'['`) not to be thrown by that `[:`.

I probably did a terrible job explaining why the code works as intended,
but I'll just chalk it up to the contortions my brain had to exercise to
understand that code.

But all that's safely outside the scope of the question whether to use a
comma operator or not ;-)

Ciao,
Johannes
