Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18936D9E0
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550025; cv=pass; b=Ww6EbdO6QrOeUhGSU0qEpo/KMKHWYoiW3UwJXGGPKotCQphrZDr55mWjQo6SayoMuOQrVAq8Jmg1lpOxqg+Ba9ypdWsqiXTCsfqFHsl+GqsirAOd3B9jARoJSZoGJweYOt9Vdf3Vb0bmVKKUOnGOT24e3ns+7CLR1iJ0ph35jm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550025; c=relaxed/simple;
	bh=hQap+anGzbCsLYMbcVUX8e3uhmt1iSOlFkDOlAGlB80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KL+oC2+TXSnhq5XabZF4+ZMQRkwgnrWhhDSQiLYbCQ9YrR/Azezb69XE/lAZOtdkum1HvOlmjLPaneAp9RSgxFYapV4Hr5lyN/Akr7KQ6rB7qOHvC8QfZlz3FkbEWoOynl7Zxret0XDtg+u2zM9AKmOT4l6PNi7b1/n6HttCoXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks4E8A1o; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks4E8A1o"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c95395230so11171691fa.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786550021; cv=none;
        d=google.com; s=arc-20260327;
        b=Fv6C8jYeJbdgyYW9wxQztteY2R8Pb3l4aDlydrx5cMZ+sI8UmeiqzOoc38UPCrsjur
         UaV90bTG5kEsaJnOfulIu1CxEP7hyv5wwIDSNDYEqbYVwnvYvvF5YlaxLifHHqVwlPjT
         77TwcdEx0BSukWJW611NQcQJRR34jdVCBDYNXoRClezQeN6c7SPsz1KsyM29nh5QiulE
         z8X6WC+cOXgpHm94sH3+vgAZmTcoVH34FEw7Tjhb4lhU3Y0GHqLp1wAIENTwnLd2ZkqN
         pHo6kWzZy0bhBypcrXJyNYlUPcicmjazqczhXtmRUg+DsE6sOwodLtUUDTNWI7Dqj3pk
         JEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8l1963d642Myj9wuNM19HT6paRwBloUlcVZSW9sB/eE=;
        fh=d1rV2MROs4/FzRznGkflpbFAAMgTL4i3bMQQIlWLUO4=;
        b=clDEWLZgxFnDE5zyvVFCXFakIsi3vZBNWqIIlsbG/Z2V5Uu33AEneHM4HqnG4OGFM8
         Tx/yVZCPMrPFC9Nqffj6VAOLYHljKHQ/fQpV4w0Sxhr8XOHIX8Lb51Nk4ukKvRmz/El2
         OhuTiLqPnLisqxoH6iqSb+jCGkSfEgf+RDTJYbv70f/qV0uNRqgGaxYB2wGmj2SDXf9V
         aEyVSgVDh+5Tw2Ys0CUlvRBWfRC5kFzTUPI79TC6x+oGgGqu7B6m+AcarwsnXypHf0Md
         5TYtuC7UdJi0SzbJrZxa6i9DxtWBuTrs3hK3Wb/cB4NoE7I855C/WS8Gj45ka79uY0Wp
         wcOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786550021; x=1787154821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8l1963d642Myj9wuNM19HT6paRwBloUlcVZSW9sB/eE=;
        b=Ks4E8A1oC7kULX7eOz0ukojC42JhRsTzzzI/8ATdo79AzjJR/yQz5j5f9VIHLKnU/g
         MAJQN4GThu07Iu9y/Czh91lnzXGUx32hGKHIyh4lZ9RJavNXST6gDMOUSaZb9fZUjKOt
         dLtXxF+L0ZCCZ+YfdTpLe9BD2L8z+ZZXvkW2HDHgy+y1R+tRgxLWZMUZAGV/aJi5jm6o
         IwSwplGOYunl8HVZlD/DC/7IaDF+Xjl4xPwJB3ehL96HfCNQS9va0cco3jSkhuuK6PHM
         WVse8252juCpBT+//0OMEbn40YbdhRsndsSv2Pf74PCkfsIo3AnwrWcvNiIhW4ibQW9c
         pfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550021; x=1787154821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8l1963d642Myj9wuNM19HT6paRwBloUlcVZSW9sB/eE=;
        b=bEAF4Ah0B53gIJTt+yAckoHrDXsej1+3folkGiMswI/Lc7aI2cAe8BiC1ZQ23HgeDz
         unVtrBT+6VDVH8JJMl8TpVT3X5J2zR9/R7FLo5+F0hiBDafBjOJa1iRUsYC8QKxatxIZ
         mW/7GNc/D+Cu/2LfUaeLt64eF1LXyelI7We9/A2b5/aY3yU3oFOgJlpKN6bBcJjiS3Mt
         wDTFZRPLaDsHN0Qr+JUI2uBSWNO0Pe07b4uFLcYD1ZbHKZaW0HFaUHZ4S4aAG5lRnBn+
         8XnpUhjgMoJ5uGtH6xAP/p+7Fs9ytqd+H2k9ojYShvK9DFeT4hK0JSDryLVtxXmcn9Pr
         /5uw==
X-Gm-Message-State: AOJu0YwLsZ2FMZiAiJ3BQSCI/mEnsHS+vIwvrNklyPEsdQvtfPpQJdwA
	sX0pPXx8XjjXHbwAiUnYxnWkX7p7xXbSFJla9Vt/bWkocY6o4XzfcQ2Kv12KqDuxlZe9fqj6dFK
	LyfSm+adS7nCtQNdWCht6CbFs+VF1fXE=
X-Gm-Gg: AR+sD10KxG1UyO3IAlW6i4FvijdN1uee6JKqN6uYzrn6UiZ6iItPoLxgNqW0gaUGKQa
	fc8EN95x/YkXlcuBbfcB2yrfcwRZbYa8haxRLC1/W9L9i8oBM9pLtmTkm3SrurlacJ5BpG5pUWr
	b+rqjmKs0z9zUJh+aAppL0bsLV9KRbNSIrG+MtAC5CvyXmEmKEvFPvFt73m1CHj1ncjPWGAOLgC
	v3IL2R4LbOSBPTFZT41wM/Jj89jkr/xYWwFMujbZkgPYjtnabKWWLPhmsvNGv7ImTX9PUjhFzjx
	TozKhQm1fyYodobTtfgt/m7ueKxwm0QgyQ+gVMFukJoM1sOXjC3ja/AwjbrRuOv4X3JJkb6fEpQ
	xPDg=
X-Received: by 2002:a2e:b8c3:0:b0:393:8ba5:3d01 with SMTP id
 38308e7fff4ca-3a10d5ad7d2mr6938611fa.22.1786550021125; Wed, 12 Aug 2026
 08:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811170200.43097-1-ggordon@gitlab.com> <20260811204407.52471-1-ggordon@gitlab.com>
 <anwR3Inkf-9nLmYm@pks.im>
In-Reply-To: <anwR3Inkf-9nLmYm@pks.im>
From: Grayson Gordon <graysongordon1@gmail.com>
Date: Wed, 12 Aug 2026 11:53:29 -0400
X-Gm-Features: AUfX_myBrbuifdugoB_8287_XR5K70N_F3tf565ciHrs5Owc6s4JcDHdPr6mqLw
Message-ID: <CALgUfNhoSdp191e=r6593GQHAC6DQsfh=g7hB+SwnRRGEzAGDw@mail.gmail.com>
Subject: Re: [PATCH v2] http: add http.sslVerifyStatus to check stapled OCSP responses
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick,

Thank you for reviewing my submission!

I understand the "nit" you're describing: software can't exactly be
called the same thing if it is built against different libraries,
which in turn creates an opportunity for different behaviors. I agree
with your follow-up that we should aim to maintain consistency despite
those library choices. The benefits of the Principle of Least
Astonishment are well established, and I would argue that users
reasonably expect Git to behave consistently regardless of the
underlying TLS library.

I can provide additional context to motivate this change. Like you, I
currently work for GitLab, but as part of the Professional Services
organization, which works directly with customers deploying the
software in their environments for production use. I am supporting a
government customer whose servers use OCSP stapling. There are many
such government and government-adjacent customers that utilize
certificates issued by US Department of Defense PKI CAs, which have
published policies that explicitly outline support for OCSP:
https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/pdf/Unclass-DoD_X.509_C=
ertificate_Policy_v10.7_Jun_3_21.pdf.
Many DoD PKI CAs serve certificates with stapled OCSP responses today
and can reasonably be expected to continue to do so until there is a
DoD-wide policy change.

A related bug in GnuTLS has affected my customer in their current
production environment, preventing them from being able to push-mirror
to repositories on remotes whose servers use OCSP stapling. The
push-mirror failure is what prompted my initial investigation into
this issue.

Original GnuTLS issue:
https://gitlab.com/gnutls/gnutls/-/work_items/1372, resolved in GnuTLS
3.8.8.

GitLab issue on the Cloud Native GitLab build that resolves this
behavior in GitLab's default Helm chart base image:
https://gitlab.com/gitlab-org/build/CNG/-/work_items/2374#note_3653072099

GitLab ships its Helm charts with two primary "flavors": one based on
Debian and the other on UBI. On Debian, the default SSL backend is
GnuTLS, and the aforementioned issues resolve the problem. On UBI, the
default backend is OpenSSL, and this issue surfaces. For my government
customers who need FIPS, switching to the UBI-based image is the
long-term path forward:
https://gitlab.com/graysongordon-gl/gitaly-tls-experiments/-/blob/main/docs=
/FIPS-AND-THE-TLS-BACKEND.md?ref_type=3Dheads.

To be more explicit, OpenSSL-linked Git binaries are the default case
for many government customers, and those customers frequently
interface with Git servers that use this type of certificate
revocation mechanism.

In summary, there are many instances of Git servers serving a large
base of developers working on government-related software that are
impacted by this issue and need this functionality. These users have
experienced the pain and confusion of this behavior being broken
firsthand in downstream applications and have brought the issue to me.
These customers care that their Git clients respect certificate
revocation when it occurs, whether from their development machines or
through service-to-service communications over Git on platforms like
GitLab. They interface with these kinds of certificates frequently and
will continue to do so, which warrants the inclusion of this flag. The
benefit they would receive is correct validation of a remote's
certificate.

As it stands today, users leveraging OpenSSL-linked Git binaries can
receive a response indicating that the certificate is valid even when
the stapled OCSP response indicates that the certificate has been
revoked. I think there is a reasonable case that this could qualify as
a low-to-medium severity CVE.

The threat model is:

An attacker steals the private key of a Git server whose certificate
is accompanied by an OCSP-stapled response.
The breach is detected, and the certificate authority revokes the certifica=
te.
Despite the revocation, Git clients continue to accept the certificate
and push/pull code from a malicious Git server impersonating the
legitimate server.
A malicious actor could leverage this to facilitate the exfiltration
of an organization's Git data.

Similar CVEs against libcurl include:
https://curl.se/mail/lib-2026-04/0036.html,
https://curl.se/docs/CVE-2024-0853.html

In addition, the attacker would need a mechanism for intercepting or
redirecting the victim's connection to the Git server, hence this not
being a higher-severity issue. However, I think that in the context of
DoD systems, this is sufficiently dangerous to warrant remediation,
and this patch provides that capability.

On the GitLab side, we already have mechanisms for per-remote
configuration values to be passed, and integrating this would not be a
monumental lift.

Thank you,
Grayson


On Wed, Aug 12, 2026 at 2:25=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Aug 11, 2026 at 04:44:07PM -0400, graysongordon-gl wrote:
> > From: Grayson Gordon <graysongordon1@gmail.com>
> >
> > git asks libcurl to verify the peer certificate and the hostname, but i=
t
> > never sets CURLOPT_SSL_VERIFYSTATUS, so the "Certificate Status Request=
"
> > TLS extension is never requested and any stapled OCSP response the serv=
er
> > does send is ignored.
> >
> > On an OpenSSL-linked build this is silent. OpenSSL hands the stapled
> > response to the application and takes no view on it:
> > SSL_CTX_set_tlsext_status_cb(3) says the callback "should determine
> > whether the returned OCSP response(s) are acceptable or not", and libcu=
rl
> > only installs that callback when CURLOPT_SSL_VERIFYSTATUS is set. So gi=
t
> > will fetch from a server whose own staple says its certificate has been
> > revoked.
> >
> > A GnuTLS-linked build behaves differently, and the difference does not
> > come from curl. GnuTLS consults a stapled response inside
> > gnutls_certificate_verify_peers(), so the failure surfaces through the
> > verifypeer branch of curl's GnuTLS backend (lib/vtls/gtls.c) whether or
> > not CURLOPT_SSL_VERIFYSTATUS was ever set. The same git, against the sa=
me
>
> Nit: this is arguably not the same git, as it links against different
> libraries. It is not exactly unexpected that using different
> dependencies may cause different behaviour, even though we should of
> course try to minimize the differences.
>
> > server, therefore enforces revocation or not depending only on how its
> > libcurl was built. That difference is documented here rather than paper=
ed
> > over: this option turns the check on where the backend needs asking, an=
d
> > setting it to false does not turn the check off on GnuTLS.
> >
> > Add an http.sslVerifyStatus boolean that sets CURLOPT_SSL_VERIFYSTATUS.
> > Because http_options() is the collect_fn of a urlmatch config, the
> > per-URL form works with no further changes:
> >
> >     git config http.https://example.com/.sslVerifyStatus true
> >
> > It defaults to false, and has to. The option is fail-closed: libcurl fa=
ils
> > verification when the server staples nothing at all, so turning this on
> > globally would break every remote that does not staple.
> >
> > Leaving the default to libcurl is not an option either. The same
> > complaint was raised there in https://github.com/curl/curl/issues/15483
> > and closed as intentional ("Marked as enhancement since this was done o=
n
> > purpose"), with the observation that stapling is expected to see less u=
se
> > as Let's Encrypt drops OCSP support. If the check is to be reachable at
> > all, the lever has to come from the application.
>
> Okay. One could make the argument that we shouldn't add support for OCSP
> either if it's being phased out now. But I assume there's still going to
> be enough servers out there that do use it.
>
> The big question to me is why we want to have this change in the first
> place. It doesn't help to address the behaviour difference between
> GnuTLS and OpenSSL: if set to "false" OpenSSL would continue to ignore
> OCSP, whereas GnuTLS would still honor it. If set to "true", OpenSSL
> would fail closed, whereas GnuTLS would still behave the same as before.
> So nothing really changes here, unless I misunderstand something.
>
> We don't really gain security, either, because the setting is disabled
> by default and can only be enabled host-by-host. I doubt anybody out
> there is really going to do that though, and consequently we haven't
> really made the world a more secure place :/
>
> So is there any specific use case that you're after? Who exactly is this
> new feature for?
>
> Thanks!
>
> Patrick
