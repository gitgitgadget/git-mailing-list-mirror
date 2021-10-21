Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22CC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25954611CE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhJUL5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:57:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:42025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhJUL5k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817323;
        bh=iFDkyA2VzuVknMqs+QcR+pVgSqbx4lg0sm1LFsucxGI=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=EFO5YY0p+DeUlpnzM60mb8nUBYa3lF0BTyBj5VDtdyKGsbJ9ZzKlrub2pw7j9H4hJ
         o19O2vW7ydUHATFB0tXMz/DUsMdiL1batUqLqa2TVzYLlfkJOZac0VrhdaeTIzwIKR
         LOGNErEMj5VKqm8TzpbtulUcq8Y9gxlehWR3EOZM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1mXFGC0WB1-00BxDL for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:55:23 +0200
Date:   Thu, 21 Oct 2021 13:55:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Crazy (and not so crazy) ideas
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1667452590-1634813789=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211355150.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:9EkRWRVlbMd1y4Uus2lWabqUgumRDUcA1oYPbaRd61ud9wo0vWB
 yhTPgcOxZqUjgveRFQqLmxX0kXHi8UOnhtZXKKSv4ynwp2s+apT9gFDXz+UPa7RtcUSPa4u
 1AVXwa1YrEoqM5r0Zpq4HvCaVYLLGFRpxI6gcp+sGGx/t0xzwSX9FdSDTB5B4fKEprFFUbn
 EccL39H7rsiEzuwmI+CpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:236aLDagg4M=:0cmr/ZTzNfKcvD6tRYgca8
 BDI1HK31Dn6W+cvFpyoelI6WrI83XQo0iC2Jg9SYnhuXc/lHmFC/Q4rphn0FUIcQdDlqJNWsf
 dCJmRHT1aVY77NunpDQLTjy38Izb/vp2XfcW1f2FM4ruUIfNmPwbPJHYf8WDkv7sZH6EyjBkc
 JbuyKiqYV6EpqZhN4K5JDWlIClPpPrtCi7+Qug/dZCr3QyhN8BM2gRIOQruFqUcgPmv4UExIf
 k0tucCMgsUVquSl1GTW33qIewzJTHkNkjmGDGrb/J16W+WtBdqZ9xBsI9xdfljRt9VpFtuzPv
 5XHzBaitY/S2hh+rqqtVazaOizlErZgUGvvjLHHZz61KUAZeGyAgsmkFbxeyWU/FNabgHN9J9
 lDsTLytCepxb8EiNXGYpxmVL/uYDj1+RQyfVJ+imw8+3CF8QCNQB2ouq3rml3224JxfzXOs+/
 fQXTr0d252NJS9l+GPjlbKljBgz2blm1itd8Iy75WQdqHf2frUYBWI8MxOyHa2wvZqullvbqK
 ThW7OzwEdvRD9NDkthaPGoEk7vekkep6/iF2RhhhMYM5YFkCSToa502nP6um4qSWA3hNb0oAA
 aGd1RsaGOPFGBzKA3MNcTsUnsF89zReEkOO7V/LCzJuxVNRafUgKYOE0IZow+y8hjwimoAKlA
 sEHyfcNBMixtv8+EdZUUfiIv5JsMbz6wA4skZIOSQTj3Ircy+g0GbIURB5H3aIQBclFqVoWDP
 yRYjHGIgZzG845uYjWSkyfQsr4+EsNvYJ32dl4Jv+grnE5GjC0Xr+krJr20tpN9PzC3hRMuRF
 oRkSeSOWhFyDIRFrezKO4/9KSqUgWRXXnO01rpHcvbcwLbt+s9j+mZ1GzrIEILVfK7GAw4HUv
 mg9+pQn+QKD5RjP9wAAwy6x06Cn6Vdcs7Ykvp4z1zqXzeF+PQwgSRZ+rJGdMOzwpRX9BdS7mT
 rZn1VQrgdgleSPjmw6e+G4j1bUGumd3uBS0aay2uX8dXxnk5ebTIMIab4uDGIW30hWOfcP4Qn
 8qSEmNHZD9koKpXbT7BfxYWeTeWHPoqIay/g083c2GYWjmHC+SAbUkbyB+IN/cLXSyPf+DS3c
 7yqAb+JNxsMqww=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1667452590-1634813789=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211355151.56@tvgsbejvaqbjf.bet>

This session was led by Elijah Newren. Supporting cast: Johannes "Dscho"
Schindelin, Jonathan Tan, Jonathan "jrnieder" Nieder, brian m. carlson,
Jeff "Peff" King, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Emily Shaffer, C=
B Bailey,
Taylor Blau, and Philip Oakley.

Notes:

* sent my idea for rebase merges on-list

* Test suite is slow. Shell scripts and process forking.

   * What if we had a special shell that interpreted the commands in a
     single process?

   * Even Git commands like rev-parse and hash-object, as long as that=E2=
=80=99s
     not the command you=E2=80=99re trying to test

   * Dscho wants to slip in a C-based solution

   * Jonathan tan commented: going back to your custom shell for tests
     idea, one thing we could do is have a custom command that generates
     the repo commits that we want (and that saves process spawns and
     might make the tests simpler too)

      * We could replace several =E2=80=9Csetup repo=E2=80=9D steps with =
=E2=80=9Cgit fast-import=E2=80=9D
        instead.

   * Dscho measured: 0.5 sec - 30 sec in setup steps. Can use fast-import,
     or can make a new format that helps us set up the test scenario

   * Elijah: test-lib-functions helpers could be built ins

* Biggest idea: there are a lot of people who version control things via
  tarballs or .zip files per version. This prevents history from
  compressing well. Some people check in those compressed files into Git
  for purposes of history.

   * In particular, .jar files or npm packages. Initial testing showed
     that you can expand .jar files in a way that creates source-like
     files.

   * Jonathan Nieder points out that =E2=80=9Cpristine-tar=E2=80=9D exists=
 to do similar
     ideas: https://joeyh.name/code/pristine-tar/

   * Others use =E2=80=9Cgit archive=E2=80=9D for this purpose to mixed su=
ccess.

   * jars and npm packages compress better if you store them in expanded
     form instead of compressed form

   * So many tools are used to using the end-archive, so while it=E2=80=99=
s
     tempting to have the build system be responsible for this, being able
     to =E2=80=9Cgit add=E2=80=9D the archive and have the right thing hap=
pen behind the
     scenes would be nice for ease of use

   * Goal here isn=E2=80=99t bit-for-bit reproducibility, just semantic
     reproducibility

   * What about other file formats that use zips, such as LibreOffice?

   * Git Merge 2018: Designers Git-It; A unified design system workflow
     did something similar, except made the tool understand the =E2=80=9Ce=
xploded=E2=80=9D
     file view.

   * Jonathan Tan mentions that smudge/clean filters can help, except this
     is about tree<->blob instead of blob<->blob

   * brian m. carlson mentions =E2=80=9Cgit archive=E2=80=9D output isn=E2=
=80=99t stable across
     Git versions. Should we have a canonical tar format that provides
     reproducibility?

   * Peff: tree<->blob filters can get confusing in the
     tree<->index<->worktree mapping. Possible, but requires careful
     thought about the details about when each spot

   * Old suggestion of a =E2=80=9Cblob-tree=E2=80=9D type that allows stor=
ing a single
     index entry that corresponds to multiple trees and blobs in the
     background, possibly.

   * One long-term dream (inspired by Avery Pennarun=E2=80=99s =E2=80=9Cbu=
p=E2=80=9D tool) is to
     store large binary files in a tree-structured way that can store
     common regions as deltas, improve random access, parallelized
     hashing. Involves a consistent way to split the file into stable
     pieces, like --rsyncable uses (based on a rolling hash being zero).

   * Peff: you can do that at the object model layer or at the storage
     layer. The latter is less invasive.

   * jrnieder: The benefits of blobtree are greater at the object model
     layer --- e.g. not having to transmit chunks over the wire that you
     already have. I think the main obstacle has been that the benefits
     haven=E2=80=99t been enough to be worth the complexity. If that chang=
es, we
     can imagine bundling it with some other object format changes, e.g.
     putting blob sizes in tree objects, and rolling it out as a new
     object-format.

   * =C3=86var: can we do this in a simpler manner, without deep technical
     changes? (Context: was thinking about this in the context of some
     $id$ questions.) Clean/smudge filters have some significant UX
     drawbacks. Has experience helping users trying to commit .jar files.
     Some simple advice saying =E2=80=9Cmaybe you don=E2=80=99t want to co=
mmit this file
     type, here are some ways to expand it to a committable format=E2=80=
=A6=E2=80=9D based
     on patterns such as .gitignore or .gitattributes. We don=E2=80=99t ha=
ve ways
     to indicate =E2=80=9Cthis repo uses Git LFS, but you don=E2=80=99t ha=
ve the plugin.=E2=80=9D

* Emily: If I could rewrite the commit object format, I would change some
  things

   * Allow multiple authors

   * Add a layer of indirection to author name

      * brian has thought about this too: replace name with email address
        + some ssh key or something and use something mailmap-like to map
        it. Could be a backward-compatible approach

   * CB has been thinking about these problems in the background. Could
     randomly generate an identifier when you commit your first patch, an
     @example.com address to avoid conflicting with any real address.
     Mailmap can be a blob maintained by the project

      * In the process can get first-class multiple authors

      * If I have this id representing this particular pair of authors,
        can update what the id points to

      * Cool stuff but gets complicated

   * Just getting mailmap applied to trailers in =E2=80=9Cgit log=E2=80=9D=
 would be huge

      * CB: main reason I don=E2=80=99t put myself in mailmap is that it=
=E2=80=99s not
        worth bothering without that feature

      * =C3=86var: =E2=80=9Cgit log --author=E2=80=9D would want the mappi=
ng, too. (and =E2=80=98git
        shortlog --group=E2=80=99) Do we do this only at the presentation =
layer or
        if we do it at a lower layer do we get such things for free?

      * If anyone=E2=80=99s interested, I might know where the dragons are=
 hiding,
        happy to give advice

      * Peff: =E2=80=9Cgit shortlog=E2=80=9D already knows how to parse it=
 out so this
        seems very possible

      * Taylor:
        https://lore.kernel.org/git/YW8A5FznqLYs7MqH@coredump.intra.peff.n=
et/T/

   * Generation number was discussed ~2011(?)

   * =C3=86var: does this really need a format change? Two =E2=80=9Cauthor=
=E2=80=9D fields
     would break things, but could have =E2=80=9Cauthor=E2=80=9D and =E2=
=80=9Cx-author=E2=80=9D header

   * General principle when changing formats: teasing apart where it=E2=80=
=99s
     possible to achieve what you want backward compatibility

* Philip Oakley would like a commit id referring to an unborn branch as a
  proper id

   * brian: empty tree works for what you=E2=80=99re talking about when yo=
u want a
     diff

   * Philip: motivating example was =E2=80=9Cfirst parent is going nowhere=
, but
     you have a second parent=E2=80=9D

   * jrnieder: I see, you want the --first-parent history of your
     published branch to match the reflog. As a workaround, you=E2=80=99re=
 able to
     use an empty initial commit and use --no-ff merges whenever you pull
     things in, but you=E2=80=99re referring to wishing you didn=E2=80=99t=
 have to make
     that empty initial commit

   * =C3=86var: reminds me of the discussion in
     https://www.fossil-scm.org/home/doc/trunk/www/fossil-v-git.wiki of
     commit/branch relationships

--8323328-1667452590-1634813789=:56--
