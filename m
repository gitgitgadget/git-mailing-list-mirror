Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7A1AED5C
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878889; cv=none; b=dMltp7GjJjaV4zZ6dGsNd4sIEZFrGD8x3puwG5Ye/tkEZyoAaZOuobUOvkiWZbAKUpLfC8opkI/42kkOMOGvymZGPDa0zaY+mVZ2a24hsbglzutGikKDKViPcvjuALQ4KHxtGolffpVvKCqdS4LHCUQ9sPsoQLB3j5U9wik9F4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878889; c=relaxed/simple;
	bh=ptbY76jvHJkzWBiG8Bl742OpQU3r/pn5GiVbJcf12cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+nKq3UOZ3QzXqb8kmVNQIs5Zjto9spIbhjho2q276+KwrnwbyyGgUFfBnUsSg5031rA/wzDeKjusYGEgJvNJ80HIXsic9Ysoi+bRc01YT+pnmterqe9ixAax/J1oGsc0EoZjCPoPE77rav+IWLnBvXdx2h1dAbpCrTzfLzr1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GivFzq6C; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GivFzq6C"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so3813561a12.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878885; x=1740483685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgbg/uOPt9DJBinXfLPVv7zRBmpW3vnTclVNmoO7XwY=;
        b=GivFzq6CV+uBA06bAYFebvhk7Br9J0t5rG4qqkGstl74n1HGP5gK8L9FUkOYVEALsJ
         Xjty+OECbRrzTUFSiv2+miOKlzZK2Io1BVbO5OTMgx7Zy5V0Zyp66YimqjDhJnzhAXOX
         G4sAYZrOtYu6JqAHjT5hHtoNaZlNMe1v8pRp6210QbshtG+B77KGWZuv+dW+PJrnQAGk
         c2jxOjJhoWBuLoTn0gNA2BZqcjwafZyLwnWE0XH1hakmGOKbPYu9qKROYXyiPh5vfXTc
         z+xkySdK6gnUbmdbos8cRVyAp4GMInvhiPu1hK0UQDFJmNKPDVhD2cmsk1ZZqAeOHH/D
         pPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878885; x=1740483685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mgbg/uOPt9DJBinXfLPVv7zRBmpW3vnTclVNmoO7XwY=;
        b=dqnjr4DTL5S3R6R+mfKNAGbY80IM3kKGch6mNDeD9EAXnqpIQyERP8fFGCcVzzNRaT
         I+MmZAYxmHFwCjcUUL+8Rm4MmQrrP6lxTVCsijDq7tejVj0EHkORMfOLdOk/XcTQwNQ/
         BcO5Kzu7v9Rbh+eI04ftYObONUHwFQuk7uHYgTomEJPaSz67WuUncLcIaFGTEeSvifOI
         9FCJadfhL0PbP2LkaQKY12PhXuBxiAzlQ203EDjW8b8xjAxwcS8BsBPW9nl6vS/hH5d7
         8VzcSWtq87kMVFM14cKrY5NUd2QR2IYgYpcqAOZg7bDyPLo71sRkWEuGyhJ7tOmrMhml
         kQsg==
X-Gm-Message-State: AOJu0YwzAeMjllCwzhxIRubX/nhZfGsWIUJNbXQuqTyqEGRvebL53m0w
	Fr6kmqZUPCa2+TlgxTFYGAhPpH1phSEJDx8+p0Da8huIdp1oakmkrrlvdYBg09ShP08HG2uM2gC
	6E/8JuC/B5AlonVueu89OVQpTlnI=
X-Gm-Gg: ASbGncslkVWJLZEWxSs0zgjzJZe+BVV6cCthHQJPnAScUeyQvvQuzxw0N9ekVoeEXte
	PuFdGojrbsUSLoWAYgonwnIWq9HpnnTVFKU2ueBXs2TEA1+q2VjJhOpvmWcaL5WYzqkrr/of7LR
	M=
X-Google-Smtp-Source: AGHT+IGR0hm70xNdm3a4N+9AnTAQ+nwH5R0NLwl6Rl3X0LCRek0P7qxag04qJfztuonrx7/3g+AA3qPvcdG4wl+QDaM=
X-Received: by 2002:a05:6402:1f13:b0:5d0:b925:a8a with SMTP id
 4fb4d7f45d1cf-5e03613e1d2mr13379051a12.16.1739878885107; Tue, 18 Feb 2025
 03:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com> <20250127151701.2321341-5-christian.couder@gmail.com>
 <Z5tZm2dNCPt6Y37D@pks.im>
In-Reply-To: <Z5tZm2dNCPt6Y37D@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Feb 2025 12:41:12 +0100
X-Gm-Features: AWEUYZnvnrmxL9Po3BvPpbPuknRcKQE0Qw6l8WyrBdljWPnGBnc_kRwQNSEL2Tg
Message-ID: <CAP8UFD07weDzAdsJyaifakp9XuJxhB9xbGdRR5norfWKPkivSg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] Add 'promisor-remote' capability to protocol v2
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 11:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Jan 27, 2025 at 04:16:59PM +0100, Christian Couder wrote:
> > When a server S knows that some objects from a repository are available
> > from a promisor remote X, S might want to suggest to a client C cloning
> > or fetching the repo from S that C may use X directly instead of S for
> > these objects.
>
> A lot of the commit message seems to be duplicated with the technical
> documentation that you add. I wonder whether it would make sense to
> simply refer to that instead of repeating all of it? That would make it
> easier to spot the actually-important bits in the commit message that
> add context to the patch.

I thought that commit messages should be self-contained as much as
possible. I am fine with adding a sentence saying that a design doc to
help with seeing the big picture will follow in one of the next
commits if it helps though.

> One very important bit of context that I was lacking is what exactly we
> wire up and where we do so. I have been searching for longer than I want
> to admit where the client ends up using the promisor remotes, until I
> eventually figured out that the client-side isn't wired up at all. It
> makes sense in retrospect, but it would've been nice if the reader was
> guided a bit.

The protocol side is implemented on both the client and the server
side in this patch. The rest already works on the client side because
using promisor remotes already works on the client side. We are just
making sure client and server agree on using a promisor remote before
the server allows it by passing "--missing=3Dallow-promisor" to `git
pack-objects`, see below . The tests show that this single change is
enough to make things work.

> > diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotoc=
ol-v2.txt
> > index 1652fef3ae..f25a9a6ad8 100644
> > --- a/Documentation/gitprotocol-v2.txt
> > +++ b/Documentation/gitprotocol-v2.txt
> > @@ -781,6 +781,60 @@ retrieving the header from a bundle at the indicat=
ed URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >
> > +promisor-remote=3D<pr-infos>
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The server may advertise some promisor remotes it is using or knows
> > +about to a client which may want to use them as its promisor remotes,
> > +instead of this repository. In this case <pr-infos> should be of the
> > +form:
> > +
> > +     pr-infos =3D pr-info | pr-infos ";" pr-info
> > +
> > +     pr-info =3D "name=3D" pr-name | "name=3D" pr-name "," "url=3D" pr=
-url
> > +
> > +where `pr-name` is the urlencoded name of a promisor remote, and
> > +`pr-url` the urlencoded URL of that promisor remote.
> > +
> > +In this case, if the client decides to use one or more promisor
> > +remotes the server advertised, it can reply with
> > +"promisor-remote=3D<pr-names>" where <pr-names> should be of the form:
> > +
> > +     pr-names =3D pr-name | pr-names ";" pr-name
> > +
> > +where `pr-name` is the urlencoded name of a promisor remote the server
> > +advertised and the client accepts.
> > +
> > +Note that, everywhere in this document, `pr-name` MUST be a valid
> > +remote name, and the ';' and ',' characters MUST be encoded if they
> > +appear in `pr-name` or `pr-url`.
> > +
> > +If the server doesn't know any promisor remote that could be good for
> > +a client to use, or prefers a client not to use any promisor remote it
> > +uses or knows about, it shouldn't advertise the "promisor-remote"
> > +capability at all.
> > +
> > +In this case, or if the client doesn't want to use any promisor remote
> > +the server advertised, the client shouldn't advertise the
> > +"promisor-remote" capability at all in its reply.
> > +
> > +The "promisor.advertise" and "promisor.acceptFromServer" configuration
> > +options can be used on the server and client side respectively to
>
> s/respectively//, as you already say that in the next line.

I have removed it in the next version.

> > +control what they advertise or accept respectively. See the
> > +documentation of these configuration options for more information.
> > +
> > +Note that in the future it would be nice if the "promisor-remote"
> > +protocol capability could be used by the server, when responding to
> > +`git fetch` or `git clone`, to advertise better-connected remotes that
> > +the client can use as promisor remotes, instead of this repository, so
> > +that the client can lazily fetch objects from these other
> > +better-connected remotes. This would require the server to omit in its
> > +response the objects available on the better-connected remotes that
> > +the client has accepted. This hasn't been implemented yet though. So
> > +for now this "promisor-remote" capability is useful only when the
> > +server advertises some promisor remotes it already uses to borrow
> > +objects from.
>
> I'd leave away this bit as it doesn't really add a lot to the document.
> It's a possibility for the future, but without it being implemented
> anywhere it's not that helpful from my point of view.

In previous iterations, Junio talked about this as an interesting
possibility to implement in the future, so I thought it could be
interesting to mention it in some places. I would be Ok to remove it
if no one cares though.

> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index c714f4f007..5ac282ed27 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -292,3 +306,185 @@ void promisor_remote_get_direct(struct repository=
 *repo,
> >       if (to_free)
> >               free(remaining_oids);
> >  }
> > +
> > +static int allow_unsanitized(char ch)
> > +{
> > +     if (ch =3D=3D ',' || ch =3D=3D ';' || ch =3D=3D '%')
> > +             return 0;
> > +     return ch > 32 && ch < 127;
> > +}
>
> Isn't this too lenient? It would allow also allow e.g. '=3D' and all kind=
s
> of other characters. This does make sense for URLs, but it doesn't make
> sense for remote names as they aren't supposed to contain punctuation in
> the first place. So for these remote names I'd think we should be way
> stricter and return an error in case they contain non-alphanumeric data.

This is used only to determine which characters are URL-encoded, not
which characters we pass or not to the other side. See below.

> > +static void promisor_info_vecs(struct repository *repo,
> > +                            struct strvec *names,
> > +                            struct strvec *urls)
>
> I wonder whether it would make more sense to track these as a strmap
> instead of two arrays which are expected to have related entries in the
> same place.

In the future we might have more generic code with perhaps a
configuration option (maybe "promisor.advertiseFields") that lists the
remote fields, like "name, url, token, filter, id", that should be
advertised by the server. If that happens, then it will make a lot of
sense to use a strmap indeed. For now we just don't know how that code
will evolve, so I think it's not worth risking overengineering this.

> > +{
> > +     struct promisor_remote *r;
> > +
> > +     promisor_remote_init(repo);
> > +
> > +     for (r =3D repo->promisor_remote_config->promisors; r; r =3D r->n=
ext) {
> > +             char *url;
> > +             char *url_key =3D xstrfmt("remote.%s.url", r->name);
> > +
> > +             strvec_push(names, r->name);
> > +             strvec_push(urls, git_config_get_string(url_key, &url) ? =
NULL : url);
> > +
> > +             free(url);
> > +             free(url_key);
> > +     }
> > +}
> > +
> > +char *promisor_remote_info(struct repository *repo)
> > +{
> > +     struct strbuf sb =3D STRBUF_INIT;
> > +     int advertise_promisors =3D 0;
> > +     struct strvec names =3D STRVEC_INIT;
> > +     struct strvec urls =3D STRVEC_INIT;
> > +
> > +     git_config_get_bool("promisor.advertise", &advertise_promisors);
> > +
> > +     if (!advertise_promisors)
> > +             return NULL;
> > +
> > +     promisor_info_vecs(repo, &names, &urls);
> > +
> > +     if (!names.nr)
> > +             return NULL;
> > +
> > +     for (size_t i =3D 0; i < names.nr; i++) {
> > +             if (i)
> > +                     strbuf_addch(&sb, ';');
> > +             strbuf_addstr(&sb, "name=3D");
> > +             strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitize=
d);
> > +             if (urls.v[i]) {
> > +                     strbuf_addstr(&sb, ",url=3D");
> > +                     strbuf_addstr_urlencode(&sb, urls.v[i], allow_uns=
anitized);
> > +             }
> > +     }
> > +
> > +     redact_non_printables(&sb);
>
> So here we replace non-printable characters with dots as far as I
> understand. But didn't we just URL-encode the strings? So is there ever
> a possibility for non-printable characters here?

Yeah, right. I am removing this call in the next version then. This is
nice because it allows us to remove the first 3 patches in this series
and not depend on Usman's "extend agent capability to include OS name"
series (https://lore.kernel.org/git/20250215155130.1756934-1-usmanakinyemi2=
02@gmail.com/).

> > +     strvec_clear(&names);
> > +     strvec_clear(&urls);
> > +
> > +     return strbuf_detach(&sb, NULL);
> > +}

[...]

> > +static void filter_promisor_remote(struct strvec *accepted, const char=
 *info)
> > +{
> > +     struct strbuf **remotes;
> > +     const char *accept_str;
> > +     enum accept_promisor accept =3D ACCEPT_NONE;
> > +
> > +     if (!git_config_get_string_tmp("promisor.acceptfromserver", &acce=
pt_str)) {
> > +             if (!accept_str || !*accept_str || !strcasecmp("None", ac=
cept_str))
> > +                     accept =3D ACCEPT_NONE;
> > +             else if (!strcasecmp("All", accept_str))
> > +                     accept =3D ACCEPT_ALL;
> > +             else
> > +                     warning(_("unknown '%s' value for '%s' config opt=
ion"),
> > +                             accept_str, "promisor.acceptfromserver");
> > +     }
> > +
> > +     if (accept =3D=3D ACCEPT_NONE)
> > +             return;
> > +
> > +     /* Parse remote info received */
> > +
> > +     remotes =3D strbuf_split_str(info, ';', 0);
> > +
> > +     for (size_t i =3D 0; remotes[i]; i++) {
> > +             struct strbuf **elems;
> > +             const char *remote_name =3D NULL;
> > +             const char *remote_url =3D NULL;
> > +             char *decoded_name =3D NULL;
> > +             char *decoded_url =3D NULL;
> > +
> > +             strbuf_strip_suffix(remotes[i], ";");
> > +             elems =3D strbuf_split(remotes[i], ',');
> > +
> > +             for (size_t j =3D 0; elems[j]; j++) {
> > +                     int res;
> > +                     strbuf_strip_suffix(elems[j], ",");
> > +                     res =3D skip_prefix(elems[j]->buf, "name=3D", &re=
mote_name) ||
> > +                             skip_prefix(elems[j]->buf, "url=3D", &rem=
ote_url);
> > +                     if (!res)
> > +                             warning(_("unknown element '%s' from remo=
te info"),
> > +                                     elems[j]->buf);
> > +             }
> > +
> > +             if (remote_name)
> > +                     decoded_name =3D url_percent_decode(remote_name);
> > +             if (remote_url)
> > +                     decoded_url =3D url_percent_decode(remote_url);
>
> This is data we have received from a potentially-untrusted remote, so we
> should double-check that the data we have received doesn't contain any
> weird characters:
>
>   - For the remote name we should verify that it consists only of
>     alphanumeric characters.
>
>   - For the remote URL we need to verify that it's a proper URL without
>     any newlines, non-printable characters or anything else.
>
> We'll eventually end up storing that data in the configuration, so these
> verifications are quite important so that an adversarial server cannot
> perform config-injection and thus cause remote code execution.

We currently don't store that data in the configuration. We just use
it to compare it with what is already configured on the client side. I
agree that if we ever make changes in a future series to store that
data, we should be careful to double-check it.

> > +void mark_promisor_remotes_as_accepted(struct repository *r, const cha=
r *remotes)
> > +{
> > +     struct strbuf **accepted_remotes =3D strbuf_split_str(remotes, ';=
', 0);
> > +
> > +     for (size_t i =3D 0; accepted_remotes[i]; i++) {
> > +             struct promisor_remote *p;
> > +             char *decoded_remote;
> > +
> > +             strbuf_strip_suffix(accepted_remotes[i], ";");
> > +             decoded_remote =3D url_percent_decode(accepted_remotes[i]=
->buf);
> > +
> > +             p =3D repo_promisor_remote_find(r, decoded_remote);
> > +             if (p)
> > +                     p->accepted =3D 1;
> > +             else
> > +                     warning(_("accepted promisor remote '%s' not foun=
d"),
> > +                             decoded_remote);
>
> My initial understanding of this code was that it is about the
> client-side accepting a remote, but this is about the server-side and
> tracks whether a promisor remote has been accepted by the client. It
> feels a bit weird to modify semi-global state for this, as I'd have
> rather expected that we pass around a vector of accepted remotes
> instead.
>
> But I guess ultimately this isn't too bad. It would be nice though if
> it was more obvious whether we're on the server- or client-side.

I have changed the description of the function like this in "promisor-remot=
e.h":

/*
 * Set the 'accepted' flag for some promisor remotes. Useful on the
 * server side when some promisor remotes have been accepted by the
 * client.
 */
void mark_promisor_remotes_as_accepted(struct repository *repo, const
char *remotes);

> > diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-r=
emote-capability.sh
> > new file mode 100755
> > index 0000000000..0390c1dbad
> > --- /dev/null
> > +++ b/t/t5710-promisor-remote-capability.sh
> > @@ -0,0 +1,244 @@
> [snip]
> > +initialize_server () {
> > +     count=3D"$1"
> > +     missing_oids=3D"$2"
> > +
> > +     # Repack everything first
> > +     git -C server -c repack.writebitmaps=3Dfalse repack -a -d &&
> > +
> > +     # Remove promisor file in case they exist, useful when reinitiali=
zing
> > +     rm -rf server/objects/pack/*.promisor &&
> > +
> > +     # Repack without the largest object and create a promisor pack on=
 server
> > +     git -C server -c repack.writebitmaps=3Dfalse repack -a -d \
> > +         --filter=3Dblob:limit=3D5k --filter-to=3D"$(pwd)/pack" &&
> > +     promisor_file=3D$(ls server/objects/pack/*.pack | sed "s/\.pack/.=
promisor/") &&
> > +     >"$promisor_file" &&
> > +
> > +     # Check objects missing on the server
> > +     check_missing_objects server "$count" "$missing_oids"
> > +}
> > +
> > +copy_to_server2 () {
>
> Nit: `server2` could be renamed to `promisor` to make the relation
> between the two servers more obvious.

I think "promisor" might be confusing as that is already used in parts
of some config variable names. For example we would have to set
"remote.promisor.promisor" to "true" several times. I have renamed it
to "lop" instead.

> > diff --git a/upload-pack.c b/upload-pack.c
> > index 728b2477fc..7498b45e2e 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -319,6 +320,8 @@ static void create_pack_file(struct upload_pack_dat=
a *pack_data,
> >               strvec_push(&pack_objects.args, "--delta-base-offset");
> >       if (pack_data->use_include_tag)
> >               strvec_push(&pack_objects.args, "--include-tag");
> > +     if (repo_has_accepted_promisor_remote(the_repository))
> > +             strvec_push(&pack_objects.args, "--missing=3Dallow-promis=
or");
>
> This is nice and simple, I like it.

Yeah, this is really the only change that is needed for a client to be
able to lazy fetch from promisor remotes at clone time.

Thanks.
