From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: `format:%>` padding and `git log --graph`
Date: Tue, 22 Dec 2015 18:33:09 +0700
Message-ID: <20151222113309.GA8804@lanh>
References: <CAPZ477ObN53VffNVvHVuqT0MQ2Csu70i0+himmmjvPj1wfXjUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elliott Cable <me@ell.io>
X-From: git-owner@vger.kernel.org Tue Dec 22 12:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBLBq-0004cq-BK
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 12:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbbLVLdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2015 06:33:10 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33956 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbLVLdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 06:33:08 -0500
Received: by mail-pa0-f42.google.com with SMTP id uo6so11298254pac.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 03:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z35rPY1iVpyWFsGri0iQTZqfDJnG/spEJ4vlaG+2GKg=;
        b=OloZkieaFI/Ka6eSqFBYaZo4pb4I27dP2ugHGvfiqwkHHDegMR8e/KE/yT0VEH3YwT
         +ThtyQBk+P5nx/7U7gow/ip5At1oXVJBuBQfHW7TXgeiDKvAZndu1NHaBm1LvQgUWK3m
         +glmZX9U0ojFSvUwLIftpzAvca3OjCdZ2TrNuEiPwiu103E/vVay/FfD9WDebeyvEYD2
         lrpCdSMSo6zwILfR6uojBmVLEXiQ1yj0uPGfhIygp8IQABumhSPzySdWzxysqWcuBBE5
         5wxKcEnvk4VWDwJ2Win58RYec8w7VU1ewNwyN14v3fr70dofVZt+CD0tpzy2iF+uVZ0d
         2W6Q==
X-Received: by 10.66.141.12 with SMTP id rk12mr34924604pab.32.1450783988320;
        Tue, 22 Dec 2015 03:33:08 -0800 (PST)
Received: from lanh ([171.233.236.127])
        by smtp.gmail.com with ESMTPSA id m1sm40797651pfi.27.2015.12.22.03.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 03:33:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 22 Dec 2015 18:33:09 +0700
Content-Disposition: inline
In-Reply-To: <CAPZ477ObN53VffNVvHVuqT0MQ2Csu70i0+himmmjvPj1wfXjUQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282841>

On Sun, Dec 20, 2015 at 10:41:44AM -0600, Elliott Cable wrote:
> I'm not sure what version the `%>` / `<|` / etc padding showed up in,
> but they're truly excellent for building beautiful one-line `git log`
> output.

Somebody found my code useful!! :-D

> This may be a long-shot, but, unfortunately, these new formats sort o=
f
> fall flat in the presence of `git log --graph`: The =E2=80=98pad unti=
l column=E2=80=99
> feature, which when reading the manpage, I desperately hoped
> *specifically exists* to replace the normal =E2=80=98pad with spaces=E2=
=80=99 in
> situations where `--graph` adds an un-known number of characters to t=
he
> start of the line ... unfortunately doesn't seem to work that way.
>=20
> For instance, here's some truncated output from a basic `--graph`:
>=20
>     $ git log --graph --abbrev=3D8 --pretty=3D"tformat:%h %s"
>     ...
>     * | a4402023 + basic boilerplate for Liability / LiabilityFamily
>     * |   32ed6de8 Merge branch 'queueless' into queueless+
>     |\ \
>     | * \   1e53ea10 (merge misc) Bring in some `bats` fixes, and re-=
sty
>     | |\ \
>     | | |/
>     | | * c8c270ff (!! new doc) Add rationale for basically *all* of =
the
>=20
> Here's what `%>|(16)%h` gives me:
>=20
>     $ git log --graph --abbrev=3D8 --pretty=3D"tformat:%>|(16)%h %s"
>     ...
>     * |         a4402023 + basic boilerplate for Liability / Liabilit=
yFa
>     * |           32ed6de8 Merge branch 'queueless' into queueless+
>     |\ \
>     | * \           1e53ea10 (merge misc) Bring in some `bats` fixes,=
 an
>     | |\ \
>     | | |/
>     | | *         c8c270ff (!! new doc) Add rationale for basically *=
all
>=20
> Here's something like what I'd *like* to have seen:
>=20
>     $ git log --graph --abbrev=3D8 --pretty=3D"tformat:%>|(16)%h %s"
>     ...
>     * |     a4402023 + basic boilerplate for Liability / LiabilityFam=
ily
>     * |     32ed6de8 Merge branch 'queueless' into queueless+
>     |\ \
>     | * \   1e53ea10 (merge misc) Bring in some `bats` fixes, and re-=
sty
>     | * \   1e53ea10 (merge misc) Bring in some `bats` fixes, and re-=
sty
>     | |\ \
>     | | |/
>     | | *   c8c270ff (!! new doc) Add rationale for basically *all* o=
f t
>=20
> So: Is this nigh-unimplementable? I once [dove into the git-log
> source][patch], and I recall the `--graph` code being terrifying; so =
if
> this is difficult to support, I can see why it would be left out.

Yeah graph drawing code does not fit well with other format
specifiers. But it does not look that hard to achieve what you want,
assuming that you specify the fixed width of the first column because
calculating it dynamically can be very expensive and the first column
could fill the entire screen (in merge forests like git.git).

A starting point is something like this, which gives me something like
your output. If you can add a new option to specify the graph width,
then it may be an acceptable solution, I think.

diff --git a/graph.c b/graph.c
index c25a09a..8815984 100644
--- a/graph.c
+++ b/graph.c
@@ -430,6 +430,8 @@ static void graph_update_width(struct git_graph *gr=
aph,
 	 * Each column takes up 2 spaces
 	 */
 	graph->width =3D max_cols * 2;
+	if (graph->width < 20)
+		graph->width =3D 20;
 }
=20
 static void graph_update_columns(struct git_graph *graph)

> If I'm off, though, and this is just an oversight, it'd be really nea=
t
> to see somebody implement it! (=3D

Nope. Your itch. Your patch ;)
--
Duy
