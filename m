Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BC8F70
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742424; cv=none; b=sZNKF1WZcugkvReIpG+12yRbPELB7PJ9+X0yZvNUnnI+1Wu7LpVZ2zRZsZoqSp15pd2xdNknPJizmaJX9o4PJn13jWl7HdlRiyfRgDDvna7NvvbUC8dui5SISJEhp0y1fnPUHNKUDwAYVYW9t+JAa5tMGOai35FQ4HGUv8ykKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742424; c=relaxed/simple;
	bh=AxG8IGr6llObPasEyN+sgelVxN+j9sTDm2HMB1ygqk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEhc5sEtUQwCjrj/1ph8cOTKOfnnYZKEUgjDXGp05PShtn8/vZXtXdzwK56YK3/UWlHiEaIhUYR1iNLNIdj25m4tKCxY+Ak1drT9lA56Mact7VOihwq/030r/Por+/S8ktni112Jd8zAFdhWu6Hp7nxopX5G46TNEFZeECwqlow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me; spf=pass smtp.mailfrom=dwim.me; dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b=VNeNlAX9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NBzx7C5S; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwim.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b="VNeNlAX9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NBzx7C5S"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ADFD411400F1;
	Tue, 23 Jul 2024 09:47:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Jul 2024 09:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721742420;
	 x=1721828820; bh=Tag8iLAtOOGIV1IcGcfq3jAPTupMvuKvMQlOF42hUd8=; b=
	VNeNlAX9s8yjO9V9Q7h+69JRo2h4oSOZg1qHdZVbvW6sB80lWpRiEOUa11UI4d/U
	xfoKv7VVcowzmI+fDG9bkGIpl+LtDOZ6YceQ81hzQRCp2+ut5sJGEGZGpOKMX5tT
	OSgWwM9TSX4SN/0QrBVEh1h7Qh8lN77+HZIhhExi2m4CPrFQHxuwgk5TA4pmSrIT
	YWjiBP4cEy6h8aEjaTyHsY0mNy6BURdemx+/EAH6ZrDBKu4L0C5DQcEoWdtVmT9+
	T+MkFebkXMKex63ePxyAl1Ln911QKKdlTmxO789Fnl48PEJRdnbPJ1A7mgmiXhfe
	URB/ytLHVA/cYPt+DxtGvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721742420; x=
	1721828820; bh=Tag8iLAtOOGIV1IcGcfq3jAPTupMvuKvMQlOF42hUd8=; b=N
	Bzx7C5SMP46H2qYt7jAPkXbBcVN0V4Y9hUTSADpfCHY40lQvYoJUj0NDGK03GaAy
	Kun6HSs7ANHgiA1U+V1RfDghwVjNkEdMo4/eYjY28Ightz3mgoxLngDCE0qFdXVG
	zP8EGL0OEPZbgX1E5TzEtq5ZX5gn9xtHLGhiGntdQBYsrHdGVSluCQMVa95tCcXo
	l4RgvEAOj00OQ1UsvNH8+YuyjOEMn8YGO4EHnDNkBU0P14d0kqgA+26AwgpIypOj
	+ZNfi6k3Jn6ufqG6jTuYOw5odYFFgfAL60OYWrJ53InYWX7FDHEiw/vXLuChNQUU
	5Ka3MosexXYiYI+2jQIug==
X-ME-Sender: <xms:VLSfZueOsJXd83ePs7CghAWJovH8VJzF92351AhcIp4Yo5w_tfAgVw>
    <xme:VLSfZoN-erNKov3CCMUyFFJcYzLEzacVpHdxlsHfPHTsPM3YjQqau4DqREOy8fsxs
    K0Jwid_VT8wv1Xu8Q>
X-ME-Received: <xmr:VLSfZvjn9arfSrBN6eMncCDCafAnMdu4DyTmjdkJbTyQ4mqCpJAwrwJuCqeXuwcp5_8ZNjjntdzFYl1PnmbT1TGqaFlZyGaiSETV8EK7gBGhw-PRzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvveffjghftgfgfgggsehtqh
    ertddtreejnecuhfhrohhmpeevrghrlhhoshcuofgrrhhtvohnucfpihgvthhouceotghm
    nhesugifihhmrdhmvgeqnecuggftrfgrthhtvghrnhepgfdvieeuiedvjeefvddvkedtue
    euffehveegjeegtdegjeevjedvgedtgfffgfegnecuffhomhgrihhnpehhthhtphgusghu
    fhhfvghrshhtohhomhhutghhfhhorhhushhtohgsvggrsghlvghtohhrvghplhhitggrth
    gvthhhvghsihhtuhgrthhiohhnrdhithdphhhtthhphedttddrshhonecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghmnhesugifihhmrdhmvg
    dpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:VLSfZr8AoOYkXwfRli_0KGFEVYy3ADutgJDQzvgAbasxLpw1Dx8LKQ>
    <xmx:VLSfZquvI4EuXWX1iMAhV5oVrdWQBg2ssdq1osHMJjVhX_SJk-cV5Q>
    <xmx:VLSfZiEKkMhskmQqvo29NPfXc5e8k0H8jnmi8AUIXoZaB32UWodzJQ>
    <xmx:VLSfZpOHdzV7QYf62VbmS_IerNfgKN5J6KZkEZcCo9-r9LunWgfEmA>
    <xmx:VLSfZj7nNiX4zOHnZFEqxDYg2z2XclM-mK-3_Aw0xK1tskfPliPV281i>
Feedback-ID: ifc4b4307:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 09:46:59 -0400 (EDT)
Message-ID: <78867db952e00f22c7f8cc143227b7dac06bffe3.camel@dwim.me>
Subject: Re: [PATCH 0/4] Report rejections over HTTP when the remote rejects
 during the transfer
From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Date: Tue, 23 Jul 2024 15:46:57 +0200
In-Reply-To: <20240613091134.GA796372@coredump.intra.peff.net>
References: <20240612115028.1169183-1-cmn@dwim.me>
	 <20240613091134.GA796372@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 05:11 -0400, Jeff King wrote:
> On Wed, Jun 12, 2024 at 01:50:24PM +0200, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > While investigating a difference between HTTP and SSH when rejecting a =
push due
> > to it being too large, I noticed that rejecting a push without receivin=
g the
> > entire packfile causes git to print out the error message "pack exceeds=
 maximum
> > allowed size" but it also shows "Everything up-to-date" instead of the =
rejection
> > of every ref update like the server has specified.
> >=20
> > This is the result of two issues in git, of which I aim to fix one here=
, namely
> >=20
> > =C2=A0 1) when the server sends the response and closes the connection,=
 remote-curl
> > =C2=A0 sees that as an error and stops processing the send-pack output,=
 combined with
> >=20
> > =C2=A0 2) git does not remember what it asked the remote helper to push=
 so it cannot
> > =C2=A0 distinguish whether an empty report means "I had an error and di=
d nothing" or
> > =C2=A0 "everything was up to date and I didn't have to do anything".
> >=20
> > The latter issue is more complex so here I'm concentrating on the forme=
r, which
> > has a simple solution but a complex test. The solution is to read in to=
 the end
> > of what send-pack is telling us (it's creating the whole packfile that =
we're
> > throwing away anyway) so we can report back to the user.
>=20
> Hmm. I think the second one is much more important, though. If the
> remote helper dies unexpectedly for any reason, shouldn't the parent
> git-push realize this and propagate the error? It sounds like you are
> fixing one _specific_ case where the remote helper dies so that we don't
> run into the problem caused by (2).

I am concentrating on this one bug that seems relatively self-contained
(other than the testing). The (2) bug requires a lot more reworking of
the remote helper mechanism. But fixing it only fixes one aspect which
is the lack of ref report instead of "Everything up-to-date". It still
wouldn't display the message sent back from the server saying why it
was rejected (though as you later argue, it might be correct to ignore
it when we send back the 200).

>=20
> But if we fixed (2), then (1) would not be nearly as important anymore

It's not as confusing regarding the up-to-date message, but (1) would
still hide the error message from the server, so it still wouldn't be
showing that message, just some other generic message about the helper
dying. And for HTTP it would still be different from what we see over
SSH.

> (if at all). But I think there is a little more going on with this
> specific case...
>=20
> > The testing however proved a bit complicated as this bug requires the s=
erver to
> > cut off the connection while git is uploading the packfile. The existin=
g HTTP
> > tests use CGI and as far as I've been able to test, httpd buffers too m=
uch for
> > us to be able to replicate the situation.
>=20
> It is not buffering that gets in your way, but rather that Apache will
> actually drain the remainder of the request (throwing away the extra
> bytes) if the CGI dies. You can see this by running your test against
> apache and strace-ing the apache process. It is in a read/write loop
> streaming the packfile from network to the CGI's stdin, it hits EPIPE on
> the write(), and then it switches to just read().
>=20

Yes, that was bad wording on my side. I think the effect here was that
I did not see the same issues when remote-curl or send-pack manged to
get further into their own data stream that what we see with the 500
from the server that disconnects.

> Which makes sense, because you can't send back the HTTP 200 response
> until you've read the whole request. RFC 7230 does make an exception for
> error responses:
>=20
> =C2=A0 A client sending a message body SHOULD monitor the network connect=
ion
> =C2=A0 for an error response while it is transmitting the request.=C2=A0 =
If the
> =C2=A0 client sees a response that indicates the server does not wish to
> =C2=A0 receive the message body and is closing the connection, the client
> =C2=A0 SHOULD immediately cease transmitting the body and close its side =
of
> =C2=A0 the connection.
>=20
> That's just a "SHOULD" but I think curl does this properly. In the case
> of GitHub's servers, a fatal condition from index-pack seems to trigger
> an HTTP 500. So that is OK by the standard above, but it does mean we
> lose the opportunity to provide any error report at the Git protocol
> level. And so you end up with output like:
>=20
> =C2=A0 error: RPC failed; HTTP 500 curl 22 The requested URL returned err=
or: 500
> =C2=A0 send-pack: unexpected disconnect while reading sideband packet
> =C2=A0 fatal: the remote end hung up unexpectedly
>=20
> whereas the same push over ssh produces[1]:
>=20
> =C2=A0 remote: fatal: non-blob object size limit exceeded (commit ddc6d4e=
7091229184537d078666afb241ea8ef62 is 104857798 bytes)
> =C2=A0 error: remote unpack failed: index-pack failed
> =C2=A0 To github.com:peff/test.git
> =C2=A0=C2=A0 ! [remote rejected] main -> main (failed)
> =C2=A0 error: failed to push some refs to 'github.com:peff/test.git'
>=20
> And even if we teach the remote helper to soak up the whole pack, we're
> still going to see the same useless output. So I would argue that the
> first fix here needs to be at the server level. It should be soaking up
> all of the request bytes if possible so that we can write back an HTTP
> 200 with the appropriate error report.
>=20
> Of course it's kind of lame that we don't cut off the client and let it
> keep sending useless bytes (though really it is not any different than
> fsck errors, which we queue after reading the whole input).

Ideally we would be able to tell the client quickly too, but that
presents some challenges both on the server and client.

>=20
> It might be possible to send an application/x-git-receive-pack-result as
> the body of the 500 response. And then we could teach the client side to
> notice and handle that better. We could possibly even use a different
> code (413 Payload Too Large?), and I suspect existing clients would
> behave sensibly (and new ones could give a better message). We _might_
> even be able to get away with a "200" response here, though even if curl
> is OK with it, I think we are stretching the RFC a bit.

Yes, I had completely missed this before, and I thought it was a curl
behaviour, but we actually just ignore any output from the server if
the status is >=3D 300 in rpc_in. This makes sense as we don't want to
try to parse a generic error message, but if the server manages to set
the content-type, then it can tell git that it does want it to parse
the message, but it's an error. A slight modification to my server
script does make it seem like it does work and this might have been a
significant part of what I was fighting against before.

If git (send-pack here I think) can reliably detect the server sending
an error, then it might be able to stop sending the data early. That
would then work for any protocol.

>=20
> [1] The keen-eyed observer may notice this is failing due to a different
> =C2=A0=C2=A0=C2=A0 reason than "pack exceeds maximum allowed size". I hap=
pen to know
> =C2=A0=C2=A0=C2=A0 that GitHub's version of index-pack will also reject c=
ommits over 100MB
> =C2=A0=C2=A0=C2=A0 in the same unceremonious way, so we can generate the =
same condition
> =C2=A0=C2=A0=C2=A0 without having to spend tons of bandwidth:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # start with one small commit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git init
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git commit --allow-empty -m foo
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # now make a too-big one. Note that it wil=
l compress well with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # zlib!
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git cat-file commit HEAD >commit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perl -e 'print "a" x 79, "\n" for (1..1310=
720)' >>commit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit=3D$(git hash-object -t commit -w co=
mmit)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git update-ref HEAD $commit
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # pushing just the commit above will not g=
enerate the issue,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # because we'll (racily) have sent the res=
t of the pack by
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # the time the server notices the problem.=
 So tack on a bunch of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # big (and uncompressible) irrelevant data=
.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dd if=3D/dev/urandom of=3Dfoo.rand bs=3D1M=
 count=3D90
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git add foo.rand
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git commit -m 'big data'
>=20
> =C2=A0=C2=A0=C2=A0 And now pushing over http will quickly-ish get you to =
the ugly
> =C2=A0=C2=A0=C2=A0 output (but over ssh is OK). But note this only work w=
ith GitHub!
> =C2=A0=C2=A0=C2=A0 Upstream Git does not have the same object-size check.
>=20
> > This is why there's a python Git server in this patch series that doesn=
't rely
> > on CGI but streams the data both ways so it can close the stream as soo=
n as
> > receive-pack exits. There's already some python tooling in the project =
and I'm
> > much more familiar with it than e.g. perl, so I hope that's fine. I tri=
ed to
> > make it as simple as possible while still being able to stream bidirect=
ionally.
>=20
> I admit that I don't love carrying a separate webserver implementation,
> but I doubt we can convince Apache not to do the draining behavior.
> Though based on what I wrote above, I'm not sure that non-draining is a
> behavior we care about testing that much (we _do_ care about getting an
> HTTP 500 and bailing from the helper, but that is much easier to test).

Coming to it from the side where you see this for a large packfile, I'm
partial to git working in such a way that we don't have to eat up the
entire rest of the packfile. It would also be nice if we can return
other errors to the user quickly for their own sake.

>=20
> If we are going to carry some custom server code, python brings some
> complications. We don't currently depend on python at all in the test
> suite, outside of the git-p4 tests. And those are disabled if NO_PYTHON
> is set. We do assume that we have access to perl in the test suite even
> if NO_PERL is set, but we try to limit ourselves to a very vanilla
> subset that would work even on ancient versions of perl (so basically
> treating perl like sed/awk as being in the "it's everywhere" unix
> toolbox).
>=20
> I don't know if we could do the same with python. I suspect there are
> systems without it, even these days. I'm also not sure what portability
> issues we might see on the specific components you're using. E.g., is
> http.server always available?

AFAICT I did not rely on anything that doesn't come with the standard
library, although I did write python 3 which may not be easy to install
everywhere git has even run. It should also be available with python 2,
but I appreciate the extra requirements. I did see a lot of python in
git-p4 but if that's the only thing, that's a different support level
than the core of git.


Cheers,
   cmn
