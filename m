Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793061243;
	b=Q19MJvqPIcOy4AlETiqxJ541kKhrW/9uqqjXAzagESua2Avw35+q+eB/jaBWIR+PI/XT
	 KTnAEWJNUyJ5kpqx8RdFbiMIAfXq+sgAp5S3sd+a70CEuYncmD2ZYF6LhIifs43YCNaN9
	 MEQRoSZWkyDi9hHIN/NJoVjGhHk3K4muKRGw/crkuab/JeZ5ixRPaX/6kwkKci4IpQUQA
	 aE6/RI9ItxKTTAAP2X1RSCa/VAo62MbvjDArriQo5+mcKoCYbRXajplgQDqOBlqGwVX8X
	 lMQYvQq7DcqlXGpHsG2r02iSj0noqWCCYfcbUP6LI1ns59EZJ5Kqft7HU/815uP6OzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793061243;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dwuLx4gh/jrQhqla8MGnrofKrNxibpqyyOosdOyGPoI=;
	b=rNTRk7znlRNwi8cfO94AH266xM0CATZzuMA8uWvnsW1qogzUTKEuSq8Ll76bkD6meyXK
	 Si6dopGQuXqn8f9hCaLKRbtVeDeeflG/+Cla4q7L83lOhxQTFqf/CJv3pFfr53HvIFPY5
	 d8cCfEjszLx9DrrT4s+udAY5/168fnrPJ9rLBkCrTOXzmozgVY34BMZIIAjwmlGBi/Km+
	 ppx+tVrstXuNO0mozMIr7tMGwaFm4pppMV4rRma+kF4qyRaRNrJpZMJhQ1UDBN2EMiHIW
	 VCCxV9cVdn8fPqLHBQgywRmRBnLYHxPlRBHn5upHrL5t/GwPBOplRnq9vR2xiGGk2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Bcgz5VWR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="yYtE/44f";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA3606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 00:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6EA3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Bcgz5VWR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yYtE/44f
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A62F14009F2
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:34:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 26 Oct 2026 20:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793061242; x=1793147642; bh=dwuLx4gh/j
	rQhqla8MGnrofKrNxibpqyyOosdOyGPoI=; b=Bcgz5VWRv+LlNWXbVMkpjV9iqU
	Zx9+yQHkMIoJIR4K8tMYJk8F9YKBD0BYWeVSEVZlZWTtzTj7ZPwBebW8QVzIurDL
	T1SIO7/nhbIVYKQKeD0aYObs3vFDzVkfzcGw/eNrT2m+L6v9qKK73V3Ic+VCFnxW
	E3XfAPnYwt4W2f3USmvAIA/n1dBR4VJWLgC1zJDyNvBGdGhyzwm5Kr1Ja9K5mhYA
	9MEyKLbZErjhe+hx47LaQ6+Rt/O5cDhU8eGHtjBzdlhtx3yhWTjgUAAaIsuL1+AY
	6fdR8z+G5/g0k23Vma9Iy4chvF1T4QJK5s6qfWKZyqKLP7zPIwNVVZap23Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793061242; x=1793147642; bh=dwuLx4gh/jrQhqla8MGnrofKrNxibpqyyOo
	sdOyGPoI=; b=yYtE/44f/saRCgKvWQUYd0UeITeWu2JpeZM4BEvvUo1N4ookIHe
	zrA8K2C0ItBIXzQj+PHOfytIb/hdmMRCmpRoh4Kl02SCvzFGhrQhwAwMCmI1uYvP
	8ho5ENm4/9qk93GG8EcX+yKE7PhxIrd4X7otNcctpu4wCPZjvTcMB1HJxF6LmNvl
	GNDWF+YroBd2f3peH4U7e3FXixXjhQeGoOm6n/b40jrJoyHExK/NL/MFrwy3aW/e
	GNyYFPrGo9JUYthxrVfyQ/IJLSYIakyf3dLSBvT6F5QsNR+GI1IBoYVZPXG8BWNL
	a0SSIS7eg+m5Fd0guFxB1/6LscdO6ioQw+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793061242; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ICEhskr8TaLZ5I3N033ZWWuj0KSa+8ysX3/J5diLbK4r4mX
	k4cukZbnBmG2dE+AoN8AwAabgmd8y73AIl2aGoARUWJvC2opuQMYd889mzglPqKR
	GOWxLoWrxdXuddoBlTauhAinmXc46Mj16DDHuu2pjXVgrWFMKjia98/Mc/1qj+Y4
	dTm1rbQHsNwpKQF8Oz851LJXXCUEmpJmTOIn8E0SwpeKDC2dHusgerEHTmyeuGCw
	TX7PF4JG0KdnwLI0VQ4Jzq+lRiWp32ZjQxbkhSwRpNYX44BwABXxRZ06nef8Bfiu
	oD+G/eM6aUJOxOT1zQ+HUWibNb040hXRYrozbmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:12SrR0z2j68L3ATzoWxDjyGKYnEgrc8GCUKGVVeUJnY=:oPlL/DvXaY5bBYsf6OtFXniXHarUIRDSIQeBOIjtxmk=;
X-ME-Sender: <xms:efHfaqAX-A5Ew3Su2YFyDDes7PYKTN4sVIArxQyDBbC6rFDILoydNw>
    <xme:efHfar_GLX5DfjuMU5XvGT4xRISNZvlPswzWMPRQsx8AjESwMLw8h70ahmM30X5Ny
    bEd3dHelpvFkgToVBlVqlTHDJYk7tXFH7s2eA9iEykPBztprYAlF_4>
X-ME-Received: <xmr:efHfaq9Bn-heRJJurjH9ckxEMdnpy8y__T4IAoKWmBYe8WbCP5ANsvKUprBHxT3nkaO32wf3RCYG0-ujYBvXFsIn0AC1k9ePs5pK>
X-ME-Proxy-Cause: dmFkZTEcP6cfAr4kvH0NJRZokH3QNQ1RgVMluICCROgPFBjJ+MOw8BH/AwiTBh3JmFnidT
    XKxIfk4m1heMIwTbMYk4Sqgmu8RVEFMrEBzzzV8K0bYX4eBd2eT7a5FlUQbh0Qsx3TYmYa
    LWUKSdV7LIvUVfACly/TCFltvgOp+a0BUUVDEaEc+p+HUtJMaJGU/6SId+L1vlyJFti+uA
    6GujH4KrqAewFY67sXwAYap7GQ1OcQgxHdaGz82/CYgnh83f1No/OOKMDeCTwDpkRT5yoS
    k6wV7MTwDSWrpnHCUco+kSyQ5mCH9d+nqirQM0FCfh7qwY4Pn+6uBDdV590PHQkQQk69sv
    48NudqLCKwZNCL5oHINSfpGzuzvjyo/PGxCwW4NyovSvwDUwVOR6QO0uMlcewA6ojShA8Q
    2CtbVZc8kR0DMb2Y2voSQ6/7sdF3wYqC9XP/16WUhCfoYidLLOmcvoN0Qwm4zgjt7tCSZJ
    TKJCevqDCkbVDgL6hDthMnotZEE8DuOs1OPvHX123Da88v9+6SpHhHBF0r+psJCWR8jwbg
    EN6gYkfL9RSYKF2nBYgVwhv6Ytmuv6ZFLnBHBtpc4D0kxIWTCnxYQYPzpZgxjidBnneymk
    1d8B8trZOfhTWOjuU6WZ33VdYvdSD5czhyoxScWxpOZES83/5LQqqL/8NlBw
X-ME-Proxy: <xmx:efHfaie18FhtqAXD55jvVP-aFlARi5lOQr_2AAhfzrEAEQgdzBganA>
    <xmx:efHfajGnk12BqhspoI1GZ7-zEkqexXlSh3NVWCUoefD2NeThcNSsuA>
    <xmx:efHfage30Snhy-1aMn6HsBFqrGAFPrpbupKobNx7-A-l1weGDoklvA>
    <xmx:efHfatFBAnO06iXKSZIYk7e-CsGXYPe6l1fRjaPcEGsdpv99OZVkFQ>
    <xmx:evHfar-1sIyfz5WcMmnfJeXSS-5VdyTM9s3-YRb0H9OkrE6z98UYUfAV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 20:34:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: document two-pass promisor remote fetch order
In-Reply-To: <20261026211210.1941-1-edsonwasswa54@gmail.com> (Edson's message
	of "Tue, 27 Oct 2026 00:12:10 +0300")
References: <20261026211210.1941-1-edsonwasswa54@gmail.com>
Date: Mon, 26 Oct 2026 17:34:00 -0700
Message-ID: <xmqq8q3knfrb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Edson <edsonwasswa54@gmail.com> writes:

> ...
> The implementation uses a two-pass approach: first try accepted remotes
> (those advertised by the server and accepted by the client), then try
> all configured promisor remotes. Document this behavior to make the
> technical design notes complete.
> ...
>  Documentation/technical/partial-clone.adoc | 4 ++++
>  1 file changed, 4 insertions(+)

The log message may accurately describe the motivation and the
behavior being documented, but the patch itself appears to be
malformed or based on an unpublished tree.

> diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
> index a1104930fb..f80346729b 100644
> --- a/Documentation/technical/partial-clone.adoc
> +++ b/Documentation/technical/partial-clone.adoc
> @@ -199,6 +199,10 @@ until all the objects have been fetched.
>  When a server advertises promisor remotes via the protocol v2
>  "promisor-remote" capability and the client accepts them (see
>  linkgit:gitprotocol-v2[5]), those accepted remotes are tried first.
> +Note that clients only accept server-advertised promisor remotes when
> +explicitly configured to do so via the `promisor.acceptFromServer` or
> +`promisor.acceptFromServerUrl` options (see linkgit:git-config[1]),
> +which prevents arbitrary injection of untrusted remotes by servers.
>  After trying the accepted remotes, Git then tries the other configured
>  promisor remotes as described below.

Specifically, the commit message states: "The implementation uses a
two-pass approach ... Document this behavior to make the technical
design notes complete."  But the patch text provides the documentation
of the two-pass approach as context lines (without '+'), and only adds
the security model paragraph:

When sending a new topic that is not anywhere in my tree, please
make sure it applies to either (1) the last published feature
release (currently, Git 2.56.0), or (2) a recent tip of 'master'
branch.  The former is preferred for a topic to fix a bug in the
released version, while the latter is more appropriate for a new
feature and behavior.  A patch that does not apply to either should
be accompanied by a note that explains on what tree it is designed
to be applied (see [*] for an example of how it is communicated).

Thanks.


[Reference]

 * In https://lore.kernel.org/git/20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im/
   the author explains the base of the topic as:

      The series is built on top of c51408889c (The 6th batch, 2026-10-16)
      with the following dependencies merged into it:

      - ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
        `read_alternates` callback, 2026-10-08) merged into it.

      - ps/setup-enforce-repo-passed-to-create-repository-has-no-state
        (phew, what a mouthful) at 0ba59c8453 (odb/source: drop
        `read_alternates` callback, 2026-10-08).

 * The resulting topic, applying the patches on a synthetic base the
   above instruction describes, looks like this:

   $ git log --first-parent --oneline master..901d6767e6
   901d6767e6 builtin/submodule: propagate "--object-storage-format="
   ed8e104fe6 builtin/clone: introduce "--object-storage-format="
   3545b04fde builtin/init: introduce handling of object storage format
   590e753455 builtin: expose the object storage format
   074bf8b219 setup: allow overriding object storage format via environment
   0538b7b345 setup: introduce object storage extension
   27dfe6b692 loose: drop unused `repo_write_loose_object_map()`
   1cdc1db14b Merge branch 'ps/setup-enforce-repo-passed-to-create-repository-has-no-state' into ps/odb-object-storage-extension
   7464b1a063 Merge branch 'ps/odb-files-alternates' into ps/odb-object-storage-extension
