Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A781F454
	for <e@80x24.org>; Wed,  6 Nov 2019 11:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfKFLdU (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 06:33:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:35499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfKFLdU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 06:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573039994;
        bh=vpNCfldBNrEw4sgoW2FiJlk3ZERz97wvUBcIS6y+HfA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ef4FVBXamMpMWGAkC1sViS1oPnNqCFDhCzrvL8/CZVe+FCRtrV60mS+lsP0cLkN/d
         P0p2A0mcx/880CKReQUV+1WnYlooRbtzMGA6UUmdn+xzNmJZqZhjVYrWUHVhcQmBt4
         AFucqRQ1dv1DPFC8dH4SBsj7hLgcO6CEk6ExZ0WY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUjC-1hath23AmI-00rXgO; Wed, 06
 Nov 2019 12:33:14 +0100
Date:   Wed, 6 Nov 2019 12:32:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 30/32] ident.c: fix LGTM warning on the possible abuse
 of the '=' operator
In-Reply-To: <xmqqbltpwxyd.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911061231420.46@tvgsbejvaqbjf.bet>
References: <20191104095923.116086-1-gitter.spiros@gmail.com> <xmqqbltpwxyd.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:doLTkSGIoNIhkQMgFpFHbEP511LtFN/LxQ9FtANK23erW4ijYj/
 fnEvOjBXZJJimHXU28kTKA6r24jhiunq60+R9dyWt/inqVlRsaU+GNRD25gpggVgR7bvmKx
 sG4h1nKpafZaofXVYlvuEcC4bB6YwwETWq6jHrQy+MKM9mW5pNcAsfLY0CT/DnnlbY74Wew
 B3VhLLHXMAY1AcIY0R+8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wqHdJl2fm08=:UJPlW8f91n7dkOKytdkk+K
 Jj9v2hLnOggqU43puPlIxyN4DL5OIXaSTVj4TIVwp9ncNy+8BgOqm4uVIOSSSc5pL3V6MaO6L
 IBuTcP/gQ9xiixZouT/SN/QNg8a/n3z/dqCtxWKTNPu+unSgGRVwE3JgC9JkAl4YP96Q/a7eU
 gC/1RBfEdOe3oaP2Nbzu6dXoLvjuWvy1FtCT3zB6VOsjIPWs+V5daY/c90Ts80gEtmJAjVJBf
 voRupSicb4W8pl/BMRwgylVNotL9oQe5YuZbiZJGeX2h/waIonipX1LfbuTUVg9BEBTJ+mD58
 kbQZoPK9B2IpFdT/Ra/J4Bc8KSBIGR+/Pua6l6SzmB7JVgE6T7uF/bfYePFPXqssZVcIRVp2n
 Luwtp3gHYmtxmAE2ylmGeuo1ei4lYBmaCFQarScSYcngGQsFNO91icXTvnGcxTzSIu7bkerx3
 VXvDJ6vb7SqxBuXwAPSi+QeTHSeZbt6IgYN1Myg7AXlAk0IE8xe6rxMutzJeCZ3lwhdVpv177
 f+X0NRE9NqTByEtWywudwLnr5obHqr8sAKKJhjyLOmDiZCJsFQoHKHeZGbphuBlGHrCfOXJ1W
 j+y813B7aEJ/omGjDOLw8DTea1O9Xnt6ldb7eVylc3BhFQW82diqzs/zttRpYBLbZ0vGNEnzt
 Aa+28FtsxxdCBFrcCFLj1JvonpkjlOe1hQeTBlLC4yUcwTZsEFSo9YDxHDkJhmwLa0LZ7nbUV
 uo5y6xEn0ef5oH1IkbloLrGVK+FRm1D/rrRy5fw1HRC1qGjrQSXk75saE0N/eWVM2WPfMiw6b
 DCWcPL569BO6nz+V5B4bEGph0zY7KYWj6qmfcIf0iyjHVKf4gELv6pDhNHukCT04pynMwy4jH
 b7ONz1NMYfwHaJl9cYYo9PfICNxhzKeWHj5Qw91tr0ztLi4E3tpyLkpHHl4wfQ2Bac68SYZea
 ayoIBPG235m2ki/GtazrRhGXRTlNBGIy/vSCSB0fj9qt5uWg4r595QCchqg0XpRIP/CnScNtA
 0sVkFr4hGpYTCZoHcr+zDDWgcMwVz1SeBzY4zfIF9NW7iMEHHBXrXm6deNj8Hu7I3kYEJGOne
 hBdH159+f0BFx585uJMyUX5LReJNVW+lD0/SnFoWFkFczyg9hY/q625CZVlrYCHasKWLghaYg
 XwpZ+Vh4+MjsK8/iBUl/Accqk8teN3dMbNkTGBzoN+4D50SttKajLkLLwceLfHE/ZMc0z4uMv
 3ILnuH/0MMk+alnlI8t8zvzhKI98twLcT1N5uq33xQrjM1AOxnUDHM7VIuGA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 6 Nov 2019, Junio C Hamano wrote:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
> Did I miss the first 29 patches (with what I see in this patch, I
> do not know if I want to see them immediately, though ;-))?
>
> > Fix the LGTM warning of the rule that finds uses of the assignment
> > operator =3D in places where the equality operator =3D=3D would
> > make more sense.
>
> I know you did not mean that existing
>
> 	} else if ((email =3D query_user_email()) && email[0]) {
>
> better reads if it were written like so:
>
> 	} else if ((email =3D=3D query_user_email()) && email[0]) {
>
> but that is the only way how that sentence can be read (at least to
> me) without looking at what the patch actually does.
>
> As "email" has already been assigned to at this point in the
> codeflow, I agree that, to an eye that does not (and is not willing
> to spend cycles to) understand what the code is doing, the latter do
> look more natural: "If the value of the variable is the same as the
> return value of the query_user_email() function, and ...".  And if
> "email" were a simpler arithmetic type it would have been even more
> (iow, it is clear "email" is a character string from "&& email[0]",
> so it is unlikely that "email =3D=3D que()" is what the user intended).
>
> So I am somewhat sympathetic to the "warnings" here, but not all
> that much, especially if squelching makes the codeflow harder to
> follow by introducing otherwise unnecessary nesting levels (like
> this patch did).  I suspect that it might be possible to futher
> restructure the code in such a way that we do not have to do an
> assignment in a conditional without making the code deeply nested,
> and that may perhaps be worth doing.
>
> But the thing is, assignment in a cascading conditional is so useful
> in avoiding pointless nesting of the code (imagine a reverse patch
> of this one---which is easy to sell as cleaning-up and streamlining
> the code).
>
> So, I dunno.

For what it's worth, my reaction was exactly the same: I understand
how some developers might deem the assignment inside an `if ()`
condition undesirable, in Git's context I do strongly prefer the current
code over the version proposed in this patch.

Thanks,
Johannes

>
> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> > ---
> >  ident.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/ident.c b/ident.c
> > index e666ee4e59..07f2f03b0a 100644
> > --- a/ident.c
> > +++ b/ident.c
> > @@ -172,12 +172,15 @@ const char *ident_default_email(void)
> >  			strbuf_addstr(&git_default_email, email);
> >  			committer_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
> >  			author_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
> > -		} else if ((email =3D query_user_email()) && email[0]) {
> > -			strbuf_addstr(&git_default_email, email);
> > -			free((char *)email);
> > -		} else
> > -			copy_email(xgetpwuid_self(&default_email_is_bogus),
> > +		} else {
> > +			email =3D query_user_email();
> > +			if (email && email[0]) {
> > +				strbuf_addstr(&git_default_email, email);
> > +				free((char *)email);
> > +			} else
> > +				copy_email(xgetpwuid_self(&default_email_is_bogus),
> >  				   &git_default_email, &default_email_is_bogus);
> > +		}
> >  		strbuf_trim(&git_default_email);
> >  	}
> >  	return git_default_email.buf;
>
