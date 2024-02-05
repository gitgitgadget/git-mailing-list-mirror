Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net [188.165.52.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0468F44
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.52.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102790; cv=none; b=T3wHEKs8Mw1AO0eQXhMChcebi2nB4HLvoO/ksynMqniZ51dDJxLkOuS1KK4b5FJpQIgB+1Rs75BepWq5plGccmLdnf2ePuBHChiwVDMe5/tmKV7AXc/7p2+fN5TcAApAq6DlnLlOfrFIvxL+eqV/MixWEe5JOms7jQtIhkOs/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102790; c=relaxed/simple;
	bh=nwKPCBZr/13lZrLWwIC+wPMF7nA1pir7+NjOjc45F3k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=gBCnxOZAH++7aAhPFXlupaioVcUrXSXUdLLGJZ2DejceuAwL3eb2OhHkbMbM+iElwDBhCrqEfYehTMY6HK5v7ibip++jXEgzhBhum6aRcdpZ1Ajllx5Kw9LVYVaqJNbEUCDEyyrL4ogFiAO0sYgoarNS8aXnzoREeZZ5K5Mc+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org; spf=pass smtp.mailfrom=devyard.org; arc=none smtp.client-ip=188.165.52.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devyard.org
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.17.88])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id F01AD2DC52
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 03:12:57 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-m7cnl (unknown [10.110.168.40])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B15D11FE51;
	Mon,  5 Feb 2024 03:12:57 +0000 (UTC)
Received: from devyard.org ([37.59.142.110])
	by ghost-submission-6684bf9d7b-m7cnl with ESMTPSA
	id IEgvJDlSwGVtBB8AP3h0BA
	(envelope-from <ypsah@devyard.org>); Mon, 05 Feb 2024 03:12:57 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S004a7515535-c439-4ab5-b412-7071ee659105,
                    2E889AE26219FFD1BF1F9309EC37D53C5121073E) smtp.auth=ashpy@devyard.org
X-OVh-ClientIp:213.10.167.74
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 04:12:56 +0100
Message-Id: <CYWTFH7Z8IY4.313MNLG552V8M@devyard.org>
Subject: Re: [PATCH 2/2] http: prevent redirect from dropping credentials
 during reauth
From: "Quentin Bouget" <ypsah@devyard.org>
To: <rsbecker@nexbridge.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240204185427.39664-1-ypsah@devyard.org>
 <20240204185427.39664-3-ypsah@devyard.org>
 <017a01da57be$28748aa0$795d9fe0$@nexbridge.com>
In-Reply-To: <017a01da57be$28748aa0$795d9fe0$@nexbridge.com>
X-Ovh-Tracer-Id: 5924766785704146427
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfsfhuvghnthhinhcuuehouhhgvghtfdcuoeihphhsrghhseguvghvhigrrhgurdhorhhgqeenucggtffrrghtthgvrhhnpeevhfejudeugedvieeiteejfeetveegiedvkeekveffveeuvdejvdeggedtveeuleenucffohhmrghinheptghurhhlrdhsvgenucfkphepuddvjedrtddrtddruddpvddufedruddtrdduieejrdejgedpfeejrdehledrudegvddruddutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoeihphhsrghhseguvghvhigrrhgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth

On Mon Feb 5, 2024 at 12:01 AM CET,  wrote:
> On Sunday, February 4, 2024 1:54 PM, Quentin Bouget wrote:
> > During a re-authentication (second attempt at authenticating with a rem=
ote, e.g.
> > after a failed GSSAPI attempt), git allows the remote to provide creden=
tial overrides
> > in the redirect URL and unconditionnaly drops the current HTTP credenti=
als in favors
> > of those, even when there aren't any.
> >
> > This commit makes it so HTTP credentials are only overridden when the r=
edirect URL
> > actually contains credentials itself.
> >
> > Signed-off-by: Quentin Bouget <ypsah@devyard.org>
> > ---
> > http.c | 18 ++++++++++++++++++
> > 1 file changed, 18 insertions(+)
> >
> > diff --git a/http.c b/http.c
> > index ccea19ac47..caba9cac1e 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -2160,7 +2160,25 @@ static int http_request_reauth(const char *url,
> >  	if (options && options->effective_url && options->base_url) {
> >  		if (update_url_from_redirect(options->base_url,
> >  					     url, options->effective_url)) {
> > +			char *username =3D NULL, *password =3D NULL;
> > +
> > +			if (http_auth.username)
> > +				username =3D xstrdup(http_auth.username);
> > +			if (http_auth.password)
> > +				password =3D xstrdup(http_auth.password);
> > +
> >  			credential_from_url(&http_auth, options->base_url->buf);
> > +
> > +			if (http_auth.username)
> > +				free(username);
> > +			else if (username)
> > +				http_auth.username =3D username;
> > +
> > +			if (http_auth.password)
> > +				free(password);
> > +			else if (password)
> > +				http_auth.password =3D password;
> > +
> >  			url =3D options->effective_url->buf;
> >  		}
> >  	}
>
> I am wondering whether this is a good idea. Having credentials in a redir=
ect
> seems like it might be a vector for going somewhere other than what you w=
ant
> to do, with credentials you do not necessarily want. Others might no bett=
er
> than I on this, but would potentially lead to a CVE? I would prefer to se=
e
> credentials in a redirect rejected rather than used.

I guess this can be controlled by setting http.followRedirects to false.

I am not sure there is generally more danger in following a redirect URL
with or without the provided credentials. Note that this is also how git
currently behaves and while I am not aware of any concrete use case
myself, I am also not confident there isn't any.

That being said, Brian M. Carlson pointed out that reusing credentials
from the initial URL for the redirect URL is quite dangerous.
In my reply, I have suggested to switch to implementing the same
behaviour as libcurl when it comes to reusing credentials: if the
hostname of the redirect is the same as the original URL, reuse the
credentials, otherwise drop them. [1]
I would still retain the (seemingly strange) current behaviour of
favoring credentials in the redirect URL over anything else.

Thanks,
Quentin

[1] https://curl.se/libcurl/c/CURLOPT_UNRESTRICTED_AUTH.html
