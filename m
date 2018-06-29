Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C861F516
	for <e@80x24.org>; Fri, 29 Jun 2018 02:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030464AbeF2CLE (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 22:11:04 -0400
Received: from mail-ot0-f201.google.com ([74.125.82.201]:36227 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030327AbeF2CK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 22:10:59 -0400
Received: by mail-ot0-f201.google.com with SMTP id z25-v6so4808523otk.3
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 19:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=hrYkPu9WllCqHyNhS63MkQDGqLsRvaArDBJPqM2p/mc=;
        b=oQ3AFIl4P6L/NfqSU802ITl0HdABkhG+sDCNI3OREkfiDMO7HoAWsgqcfLfoHUspVn
         pxtPkfQpsTHLBahFgA4LOZpnA6DtSKLSJ0gKp/RodiY4kUwXCX6bViS9WjVbl4C9vzIx
         xw4x1ZVZ9e+ku3uWKHyekydPiPXq7n7vtJ9bE5ugg2VbQEn/fL/Q6N6FjYPaNUI68/21
         VshrZcauR5niUMeDoZAS5BVYSCC4xetBt5+cdbiiCidDAZ34u7+0gqWZHiCZHX9WfyJp
         gu0AxoT15sKqRc8yd99pn+0cN9mbvh9gY7uluu8J7KxwDMhweq7wbqyimnIUw2Mpen/b
         rafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=hrYkPu9WllCqHyNhS63MkQDGqLsRvaArDBJPqM2p/mc=;
        b=oO0Dq9b98IRbg1abdxU/HbPLO5HgwPrxMEhgdrUvMLP0qTbfuTTo6wagzz+OUVNAiV
         oQQEvapnwIwcOit70XCpmrcctGSZID4e6hcwNYdg3xibNVngoYiO6sHTTTmmWWfbn7HF
         ObX9jMsOArPivb2EKPaEQQhKnFaooK+pGwxp9mCOe56+BripBWMP37u1QjyhArJJIQDJ
         WHeqXfrwG89rT+s82JHbhBbvTq6DG1w54WBbrpjFvfVO7alR7V79s3qFc/ddWcpha/N/
         OxA4ZYxPJc3m7H9Kmv5x1ED8w0Eft7xBzrIDqOJDo0n8YBvZP9d3829UcHtyv2beeen9
         5+HQ==
X-Gm-Message-State: APt69E1d+KyNlSNg1ieA6vcrkUaJAhl3BJK1atj29gBmL8mW6fHOTEXW
        KG7ouu6TIcrv8hHZUIW2eybsxN87gJ/XPf56/A+rIuShDw++nmoGCTI/yC8i/VRwFC98/GwsxJj
        WcytrFq6EVeQ2iPLzJNnGJf8QUgbUCKpV/8TXmuNk5xAmbMEwcJYKYwhStQkk
X-Google-Smtp-Source: AAOMgpefBpO60jlJ408eVqC6LJO8isNYhx+rBzx9YNBe9jiF8br3E3CINRSMBJy36WoYj2r316m5jAcxvu7r
X-Received: by 2002:a9d:7101:: with SMTP id n1-v6mr3033591otj.94.1530238258517;
 Thu, 28 Jun 2018 19:10:58 -0700 (PDT)
Date:   Thu, 28 Jun 2018 19:10:50 -0700
In-Reply-To: <20180629021050.187887-1-sbeller@google.com>
Message-Id: <20180629021050.187887-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180629021050.187887-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH 3/3] .mailmap: map names with multiple emails to the same
 author identity
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are multiple author idents who have different email addresses, but
the same name; assume they are the same person, as the world of open source
is actually rather small.

Sift through the history via:

    git shortlog -sne origin/pu |awk '{ NF--; $1=3D""; print }' |sort |uniq=
 -d |cut -c 2-  >names
    while read name; do
        current_name=3D$(git log --author "$name" --format=3D"%an <%ae>" -1=
)
        git log --author "$name" --format=3D"%an <%ae>" |sort |uniq >all_na=
mes

        while read one_name; do
            if [ "$one_name" !=3D "$current_name" ]
            then
                echo $current_name $one_name >> out
            fi
        done <all_names
    done <names

and add all of them to the .mailmap file by appending and resorting the
file.

Care must be given to the comment on top of the file as well as the
comment regarding the two anonymous authors, who claim to be different
persons.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .mailmap | 185 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 134 insertions(+), 51 deletions(-)

diff --git a/.mailmap b/.mailmap
index ff96ef7401f..2607846582a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -5,54 +5,86 @@
 # same person appearing not to be so.
 #
=20
-<nico@fluxnic.net> <nico@cam.org>
+Adam Simpkins <simpkins@facebook.com> Adam Simpkins <adam@adamsimpkins.net=
>
 Alejandro R. Sede=C3=B1o <asedeno@MIT.EDU> <asedeno@mit.edu>
+Alexander Gavrilov <angavrilov@gmail.com>
+Alexander Kuleshov <kuleshovmail@gmail.com>
+Alex Benn=C3=A9e <alex.bennee@linaro.org> Alex Benn=C3=A9e <kernel-hacker@=
bennee.com>
 Alex Benn=C3=A9e <kernel-hacker@bennee.com>
+Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff@gmail.com>
+Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
+Alex Riesen <alexander.riesen@cetitec.com> Alex Riesen <fork0@t-online.de>
+Alex Riesen <alexander.riesen@cetitec.com> Alex Riesen <raa@limbo.localdom=
ain>
+Alex Riesen <alexander.riesen@cetitec.com> Alex Riesen <raa.lkml@gmail.com=
>
+Alex Riesen <alexander.riesen@cetitec.com> Alex Riesen <raa@steel.home>
 Alex Riesen <raa.lkml@gmail.com> <fork0@t-online.de>
 Alex Riesen <raa.lkml@gmail.com> <raa@limbo.localdomain>
 Alex Riesen <raa.lkml@gmail.com> <raa@steel.home>
 Alex Vandiver <alex@chmrr.net> <alexmv@MIT.EDU>
-Alexander Gavrilov <angavrilov@gmail.com>
-Alexander Kuleshov <kuleshovmail@gmail.com>
-Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
-Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff@gmail.com>
+Alex Vandiver <alexmv@dropbox.com> Alex Vandiver <alex@chmrr.net>
+Alex Vandiver <alexmv@dropbox.com> Alex Vandiver <alexmv@MIT.EDU>
+Amos Waterland <apw@debian.org> <apw@rossby.metr.ou.edu>
+Amos Waterland <apw@debian.org> <apw@us.ibm.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
+Andreas Ericsson <ae@op5.se> Andreas Ericsson <exon@op5.se>
+Andreas Schwab <schwab@suse.de> Andreas Schwab <schwab@linux-m68k.org>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
-Amos Waterland <apw@debian.org> <apw@rossby.metr.ou.edu>
-Amos Waterland <apw@debian.org> <apw@us.ibm.com>
-Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
+# the two anonymous contributors are different persons:
+anonymous <linux@horizon.com>
+anonymous <linux@horizon.net>
+Antonio Ospite <ao2@ao2.it> Antonio Ospite <ospite@studenti.unina.it>
+Avery Pennarun <apenwarr@gmail.com> Avery Pennarun <apenwarr@versabanq.com=
>
+Beat Bolli <dev+git@drbeat.li> Beat Bolli <bbolli@ewanet.ch>
+Benoit Person <benoit.person@gmail.com> Benoit Person <benoit.person@ensim=
ag.fr>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
+Ben Peart <Ben.Peart@microsoft.com> Ben Peart <benpeart@microsoft.com>
+Ben Peart <Ben.Peart@microsoft.com> Ben Peart <peartben@gmail.com>
+Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
+Brian Gernhardt <brian@gernhardtsoftware.com> Brian Gernhardt <benji@silve=
rinsanity.com>
+Brian Gernhardt <brian@gernhardtsoftware.com> Brian Gernhardt <brian@silve=
rinsanity.com>
 brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@=
crustytoothpaste.ath.cx>
 brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.=
ath.cx>
 Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
 Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
+Carlos Mart=C3=ADn Nieto <cmn@dwim.me> Carlos Mart=C3=ADn Nieto <cmn@elego=
.de>
+Charles Bailey <cbailey32@bloomberg.net> Charles Bailey <charles@hashpling=
.org>
 Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
-Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
-Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
 Christian Couder <chriscool@tuxfamily.org> <christian.couder@gmail.com>
+Christian Ludwig <chrissicool@gmail.com> Christian Ludwig <chrissicool@goo=
glemail.com>
 Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
 Christopher D=C3=ADaz Riveros <chrisadr@gentoo.org> Christopher Diaz River=
os
+Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
+Clemens Buchacher <drizzd@gmx.net> Clemens Buchacher <clemens.buchacher@in=
tel.com>
+Clemens Buchacher <drizzd@gmx.net> Clemens Buchacher <drizzd@aon.at>
+Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
-Dan Johnson <computerdruid@gmail.com>
-Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How
+Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Daniel Barkalow <barkalow@iabervon.org>
+Daniel Knittl-Frank <knittl89+git@googlemail.com> Daniel Knittl-Frank <kni=
ttl89@googlemail.com>
 Daniel Knittl-Frank <knittl89@googlemail.com> knittl
 Daniel Trstenjak <daniel.trstenjak@gmail.com> <daniel.trstenjak@online.de>
 Daniel Trstenjak <daniel.trstenjak@gmail.com> <trsten@science-computing.de=
>
+Dan Johnson <computerdruid@gmail.com>
+David Barr <davidbarr@google.com> David Barr <david.barr@cordelta.com>
 David Brown <git@davidb.org> <davidb@quicinc.com>
 David D. Kilzer <ddkilzer@kilzer.net>
 David K=C3=A5gedal <davidk@lysator.liu.se>
 David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
 David S. Miller <davem@davemloft.net>
+David Turner <dturner@twopensource.com> David Turner <dturner@twitter.com>
+David Turner <dturner@twopensource.com> David Turner <dturner@twosigma.com=
>
+David Turner <dturner@twopensource.com> David Turner <novalis@novalis.org>
 David Turner <novalis@novalis.org> <dturner@twopensource.com>
 David Turner <novalis@novalis.org> <dturner@twosigma.com>
 Deskin Miller <deskinm@umich.edu>
 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
+Dotan Barak <dotanba@gmail.com> Dotan Barak <dotanb@dev.mellanox.co.il>
+Edward Thomson <ethomson@edwardthomson.com> Edward Thomson <ethomson@micro=
soft.com>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
 Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
 Eric S. Raymond <esr@thyrsus.com>
@@ -64,28 +96,33 @@ Florian Achleitner <florian.achleitner.2.6.31@gmail.com=
> <florian.achleitner2.6.
 Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
 Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
 Frank Lichtenheld <frank@lichtenheld.de> <flichtenheld@astaro.com>
-Fredrik Kuivinen <frekui@gmail.com> <freku045@student.liu.se>
 Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com>
+Fredrik Kuivinen <frekui@gmail.com> <freku045@student.liu.se>
 Garry Dolley <gdolley@ucla.edu> <gdolley@arpnetworks.com>
-Greg Price <price@mit.edu> <price@MIT.EDU>
+Gr=C3=A9goire Paris <gregoire.paris.greg0ire@gmail.com> Gr=C3=A9goire Pari=
s <postmaster@greg0ire.fr>
 Greg Price <price@mit.edu> <price@ksplice.com>
+Greg Price <price@mit.edu> <price@MIT.EDU>
+Han-Wen Nienhuys <hanwen@google.com> Han-Wen Nienhuys <hanwen@xs4all.nl>
+Hartmut Henkel <henkel@vh-s.de> Hartmut Henkel <hartmut_henkel@gmx.de>
 Heiko Voigt <hvoigt@hvoigt.net> <git-list@hvoigt.net>
 H. Merijn Brand <h.m.brand@xs4all.nl> H.Merijn Brand <h.m.brand@xs4all.nl>
+Horst H. von Brand <vonbrand@inf.utfsm.cl>
 H. Peter Anvin <hpa@zytor.com> <hpa@bonde.sc.orionmulti.com>
 H. Peter Anvin <hpa@zytor.com> <hpa@smyrno.hos.anvin.org>
 H. Peter Anvin <hpa@zytor.com> <hpa@tazenda.sc.orionmulti.com>
 H. Peter Anvin <hpa@zytor.com> <hpa@trantor.hos.anvin.org>
-Han-Wen Nienhuys <hanwen@google.com> Han-Wen Nienhuys <hanwen@xs4all.nl>
-Horst H. von Brand <vonbrand@inf.utfsm.cl>
-J. Bruce Fields <bfields@citi.umich.edu> <bfields@fieldses.org>
-J. Bruce Fields <bfields@citi.umich.edu> <bfields@pig.linuxdev.us.dell.com=
>
-J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
+=C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
+Jacob Keller <jacob.keller@gmail.com> Jacob Keller <jacob.e.keller@intel.c=
om>
 Jakub Nar=C4=99bski <jnareb@gmail.com>
 James Y Knight <jknight@itasoftware.com> <foom@fuhm.net>
 Jason McMullan <jason.mcmullan@timesys.com> Jason McMullan <mcmullan@netap=
p.com>
-Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
+Jason McMullan <mcmullan@netapp.com> Jason McMullan <jason.mcmullan@timesy=
s.com>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
+Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
+J. Bruce Fields <bfields@citi.umich.edu> <bfields@fieldses.org>
+J. Bruce Fields <bfields@citi.umich.edu> <bfields@pig.linuxdev.us.dell.com=
>
+J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
 Jean-No=C3=ABl Avila <jn.avila@free.fr> Jean-Noel Avila
 Jean-No=C3=ABl Avila <jn.avila@free.fr> Jean-No=C3=ABl AVILA
 Jeff King <peff@peff.net> <peff@github.com>
@@ -93,18 +130,22 @@ Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm=
.net>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
 Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jens Lindstr=C3=B6m <jl@opera.com> Jens Lindstrom <jl@opera.com>
+Jiang Xin <worldhello.net@gmail.com> Jiang Xin <xin.jiang@huawei.com>
 Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
+Joachim Jablon <joachim.jablon@people-doc.com> Joachim Jablon <ewjoachim@g=
mail.com>
+Joey Hess <joeyh@joeyh.name> Joey Hess <joey@kitenet.net>
 Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@gmx.=
de>
+Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
 Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
 Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
-Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
 John 'Warthog9' Hawley <warthog9@kernel.org> <warthog9@eaglescrag.net>
+Jonathan del Strother <jon.delStrother@bestbefore.tv> <maillist@steelskies=
.com>
+Jonathan Nieder <jrnieder@gmail.com> <jrnieder@uchicago.edu>
+Jonathon Mah <me@jonathonmah.com> Jonathon Mah <me@JonathonMah.com>
 Jon Loeliger <jdl@jdl.com> <jdl@freescale.com>
 Jon Loeliger <jdl@jdl.com> <jdl@freescale.org>
 Jon Seymour <jon.seymour@gmail.com> <jon@blackcubes.dyndns.org>
-Jonathan Nieder <jrnieder@gmail.com> <jrnieder@uchicago.edu>
-Jonathan del Strother <jon.delStrother@bestbefore.tv> <maillist@steelskies=
.com>
 Josh Triplett <josh@joshtriplett.org> <josh@freedesktop.org>
 Josh Triplett <josh@joshtriplett.org> <josht@us.ibm.com>
 Julian Phillips <julian@quantumfyre.co.uk> <jp3@quantumfyre.co.uk>
@@ -116,73 +157,107 @@ Junio C Hamano <gitster@pobox.com> <junio@twinsun.co=
m>
 Junio C Hamano <gitster@pobox.com> <junkio@cox.net>
 Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com> <kaarticsivaraam91196@gmail.=
com>
+Kacper Kornet <draenog@pld-linux.org> Kacper Kornet <kornet@camk.edu.pl>
 Karl Wiberg <kha@treskal.com> Karl  Hasselstr=C3=B6m
 Karl Wiberg <kha@treskal.com> <kha@yoghurt.hemma.treskal.com>
 Karsten Blees <blees@dcon.de> <karsten.blees@dcon.de>
 Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
-Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
 Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
+Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
 Kazuki Saitoh <ksaitoh560@gmail.com> kazuki saitoh <ksaitoh560@gmail.com>
 Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
 Kent Engstrom <kent@lysator.liu.se>
 Kevin Leung <kevinlsk@gmail.com>
+Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Kirill A. Shutemov <k=
irill@shutemov.name>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
+Kirill Smelkov <kirr@nexedi.com> Kirill Smelkov <kirr@landau.phys.spbu.ru>
+Kirill Smelkov <kirr@nexedi.com> Kirill Smelkov <kirr@mns.spb.ru>
+Kirill Smelkov <kirr@nexedi.com> Kirill Smelkov <kirr@navytux.spb.ru>
 Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
+Kristian H=C3=B8gsberg <krh@redhat.com> Kristian H=C3=B8gsberg <hoegsberg@=
gmail.com>
 Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
 Lars Noschinski <lars@public.noschinski.de> <lars.noschinski@rwth-aachen.d=
e>
+Lars Schneider <larsxschneider@gmail.com> Lars Schneider <lars.schneider@a=
utodesk.com>
 Li Hong <leehong@pku.edu.cn>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@evo.osdl.org>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@g5.osdl.org>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@osdl.org>
-Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.org.(=
none)>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.org>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.org.(=
none)>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@woody.linux-found=
ation.org>
+Lukas Fleischer <lfleischer@lfos.de> Lukas Fleischer <git@cryptocrack.de>
 Lukas Sandstr=C3=B6m <luksan@gmail.com> <lukass@etek.chalmers.se>
-Marc Khouzam <marc.khouzam@ericsson.com> <marc.khouzam@gmail.com>
 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
+Marc Khouzam <marc.khouzam@ericsson.com> <marc.khouzam@gmail.com>
 Marco Costalba <mcostalba@gmail.com> <mcostalba@yahoo.it>
+Marius Storm-Olsen <marius@storm-olsen.com> Marius Storm-Olsen <git@storm-=
olsen.com>
+Marius Storm-Olsen <marius@storm-olsen.com> Marius Storm-Olsen <marius.sto=
rm-olsen@nokia.com>
+Marius Storm-Olsen <marius@storm-olsen.com> Marius Storm-Olsen <marius@tro=
lltech.com>
+Marius Storm-Olsen <marius@storm-olsen.com> Marius Storm-Olsen <mstormo_gi=
t@storm-olsen.com>
+Marius Storm-Olsen <marius@storm-olsen.com> Marius Storm-Olsen <mstormo@gm=
ail.com>
 Mark Levedahl <mdl123@verizon.net> <mlevedahl@gmail.com>
 Mark Rada <marada@uwaterloo.ca>
+Martin Koegler <martin.koegler@chello.at> Martin Koegler <mkoegler@auto.tu=
wien.ac.at>
 Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
+Martin Langhoff <martin@laptop.org> Martin Langhoff <martin@catalyst.net.n=
z>
+Martin Langhoff <martin@laptop.org> Martin Langhoff <martin@ng.eduforge.or=
g>
 Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gmail.=
com>
 Matt Draisey <matt@draisey.ca> <mattdraisey@sympatico.ca>
-Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
-Matt McCutchen <matt@mattmccutchen.net> <hashproduct@gmail.com>
 Matthias Kestenholz <matthias@spinlock.ch> <mk@spinlock.ch>
 Matthias R=C3=BCster <matthias.ruester@gmail.com> Matthias Ruester
 Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
 Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
+Matthieu Moy <git@matthieu-moy.fr> Matthieu Moy <Matthieu.Moy@imag.fr>
+Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
+Matt McCutchen <matt@mattmccutchen.net> <hashproduct@gmail.com>
+Michael Coleman <michael.karl.coleman@gmail.com> Michael Coleman <tutufan@=
gmail.com>
 Michael Coleman <tutufan@gmail.com>
-Michael J Gruber <git@grubix.eu> <michaeljgruber+gmane@fastmail.fm>
 Michael J Gruber <git@grubix.eu> <git@drmicha.warpmail.net>
-Michael S. Tsirkin <mst@kernel.org> <mst@redhat.com>
-Michael S. Tsirkin <mst@kernel.org> <mst@mellanox.co.il>
+Michael J Gruber <git@grubix.eu> <michaeljgruber+gmane@fastmail.fm>
 Michael S. Tsirkin <mst@kernel.org> <mst@dev.mellanox.co.il>
-Michael W. Olson <mwolson@gnu.org>
-Michael Witten <mfwitten@gmail.com> <mfwitten@MIT.EDU>
+Michael S. Tsirkin <mst@kernel.org> <mst@mellanox.co.il>
+Michael S. Tsirkin <mst@kernel.org> <mst@redhat.com>
 Michael Witten <mfwitten@gmail.com> <mfwitten@mit.edu>
+Michael Witten <mfwitten@gmail.com> <mfwitten@MIT.EDU>
+Michael W. Olson <mwolson@gnu.org>
 Michal Rokos <michal.rokos@nextsoft.cz> <rokos@nextsoft.cz>
 Michele Ballabio <barra_cuda@katamail.com>
+Mike Ralphson <mike.ralphson@gmail.com> Mike Ralphson <mike@abacus.co.uk>
 Miklos Vajna <vmiklos@frugalware.org> <vmiklos@suse.cz>
-Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
 Namhyung Kim <namhyung@gmail.com> <namhyung@kernel.org>
-Nanako Shiraishi <nanako3@lavabit.com> <nanako3@bluebottle.com>
+Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
 Nanako Shiraishi <nanako3@lavabit.com>
-Nelson Elhage <nelhage@mit.edu> <nelhage@MIT.EDU>
+Nanako Shiraishi <nanako3@lavabit.com> <nanako3@bluebottle.com>
 Nelson Elhage <nelhage@mit.edu> <nelhage@ksplice.com>
+Nelson Elhage <nelhage@mit.edu> <nelhage@MIT.EDU>
 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
+Nick Alcock <nick.alcock@oracle.com> Nick Alcock <nix@esperi.org.uk>
 Nick Stokoe <nick@noodlefactory.co.uk> Nick Woolley <nick@noodlefactory.co=
.uk>
 Nick Stokoe <nick@noodlefactory.co.uk> Nick Woolley <nickwoolley@yahoo.co.=
uk>
+<nico@fluxnic.net> <nico@cam.org>
 Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nicolas.mor=
ey@free.fr>
 Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nmorey@kalr=
ay.eu>
+Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> Nicolas Morey-Cha=
isemartin <devel-git@morey-chaisemartin.com>
+Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> Nicolas Morey-Cha=
isemartin <nicolas@morey-chaisemartin.com>
+Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> Nicolas Morey-Cha=
isemartin <nicolas.morey@free.fr>
+Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> Nicolas Morey-Cha=
isemartin <NMoreyChaisemartin@suse.com>
+Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> Nicolas Morey-Cha=
isemartin <nmorey@kalray.eu>
 Nicolas Sebrecht <nicolas.s.dev@gmx.fr> <ni.s@laposte.net>
+Olaf Hering <olaf@aepfle.de> Olaf Hering <olh@suse.de>
+Orgad Shaneh <orgads@gmail.com> Orgad Shaneh <orgad.shaneh@audiocodes.com>
 Paolo Bonzini <bonzini@gnu.org> <paolo.bonzini@lu.unisi.ch>
+Paolo Bonzini <pbonzini@redhat.com> Paolo Bonzini <bonzini@gnu.org>
+Paolo Bonzini <pbonzini@redhat.com> Paolo Bonzini <paolo.bonzini@lu.unisi.=
ch>
 Pascal Obry <pascal@obry.net> <pascal.obry@gmail.com>
 Pascal Obry <pascal@obry.net> <pascal.obry@wanadoo.fr>
 Pat Notz <patnotz@gmail.com> <pknotz@sandia.gov>
 Patrick Steinhardt <ps@pks.im> <patrick.steinhardt@elego.de>
+Patrick Welche <prlw1@cam.ac.uk> Patrick Welche <prlw1@newn.cam.ac.uk>
+Paul Mackerras <paulus@ozlabs.org> Paul Mackerras <paulus@dorrigo.(none)>
+Paul Mackerras <paulus@ozlabs.org> Paul Mackerras <paulus@pogo.(none)>
+Paul Mackerras <paulus@ozlabs.org> Paul Mackerras <paulus@samba.org>
 Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
 Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
 Peter Baumann <waste.manager@gmx.de> <Peter.B.Baumann@stud.informatik.uni-=
erlangen.de>
@@ -196,19 +271,24 @@ Philip J=C3=A4genstedt <philip@foolip.org> <philip.ja=
genstedt@gmail.com>
 Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
 Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
+Raman Gupta <rocketraman@gmail.com> Raman Gupta <raman@rocketraman.com>
 Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
-Ren=C3=A9 Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
+Randall S. Becker <rsbecker@nexbridge.com> Randall S. Becker <randall.beck=
er@nexbridge.ca>
+Ray Chen <oldsharp@gmail.com> Ray Chen <rchen@cs.umd.edu>
 Ren=C3=A9 Scharfe <l.s.r@web.de> Rene Scharfe
+Ren=C3=A9 Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
 Richard Hansen <rhansen@rhansen.org> <hansenr@google.com>
 Richard Hansen <rhansen@rhansen.org> <rhansen@bbn.com>
 Robert Fitzsimons <robfitz@273k.net>
+Roberto Tyley <roberto.tyley@gmail.com> Roberto Tyley <roberto.tyley@guard=
ian.co.uk>
 Robert Shearman <robertshearman@gmail.com> <rob@codeweavers.com>
 Robert Zeh <robert.a.zeh@gmail.com>
 Robin Rosenberg <robin.rosenberg@dewire.com> <robin.rosenberg.lists@dewire=
.com>
-Rutger Nijlunsing <rutger.nijlunsing@gmail.com> <rutger@nospam.com>
 Rutger Nijlunsing <rutger.nijlunsing@gmail.com> <git@tux.tmfweb.nl>
+Rutger Nijlunsing <rutger.nijlunsing@gmail.com> <rutger@nospam.com>
 Ryan Anderson <ryan@michonline.com> <rda@google.com>
 Salikh Zakirov <salikh.zakirov@gmail.com> <Salikh.Zakirov@Intel.com>
+Sam Hocevar <sam@hocevar.net> Sam Hocevar <sam@zoy.org>
 Sam Vilain <sam@vilain.net> <sam.vilain@catalyst.net.nz>
 Sam Vilain <sam@vilain.net> sam@vilain.net
 Santi B=C3=A9jar <santi@agolina.net> <sbejar@gmail.com>
@@ -216,34 +296,37 @@ Sean Estabrooks <seanlkml@sympatico.ca>
 Sebastian Schuberth <sschuberth@gmail.com> <sschuberth@visageimaging.com>
 Seth Falcon <seth@userprimary.net> <sfalcon@fhcrc.org>
 Shawn O. Pearce <spearce@spearce.org>
-Wei Shuyu <wsy@dogben.com> Shuyu Wei
 Sidhant Sharma <tigerkid001@gmail.com> Sidhant Sharma [:tk]
-Simon Hausmann <hausmann@kde.org> <simon@lst.de>
 Simon Hausmann <hausmann@kde.org> <shausman@trolltech.com>
-Stefan Beller <stefanbeller@gmail.com> <stefanbeller@googlemail.com>
+Simon Hausmann <hausmann@kde.org> <simon@lst.de>
 Stefan Beller <stefanbeller@gmail.com> <sbeller@google.com>
+Stefan Beller <stefanbeller@gmail.com> <stefanbeller@googlemail.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@atlas-elektronik.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@googlemail.com>
 Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
 =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> <stepan.nemec@gmail.c=
om>
 Stephen Boyd <bebarino@gmail.com> <sboyd@codeaurora.org>
 Steven Drake <sdrake@xnet.co.nz> <sdrake@ihug.co.nz>
-Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
 Steven Grimm <koreth@midwinter.com> koreth@midwinter.com
+Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.com>
-Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.be>
+Sven Strickroth <email@cs-ware.de> Sven Strickroth <sven@cs-ware.de>
+Sven Strickroth <email@cs-ware.de> Sven Strickroth <sven.strickroth@tu-cla=
usthal.de>
 Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
+Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.be>
 SZEDER G=C3=A1bor <szeder.dev@gmail.com> <szeder@ira.uka.de>
 Tay Ray Chuan <rctay89@gmail.com>
 Ted Percival <ted@midg3t.net> <ted.percival@quest.com>
 Theodore Ts'o <tytso@mit.edu>
 Thomas Ackermann <th.acker@arcor.de> <th.acker66@arcor.de>
-Thomas Rast <tr@thomasrast.ch> <trast@student.ethz.ch>
-Thomas Rast <tr@thomasrast.ch> <trast@inf.ethz.ch>
 Thomas Rast <tr@thomasrast.ch> <trast@google.com>
+Thomas Rast <tr@thomasrast.ch> <trast@inf.ethz.ch>
+Thomas Rast <tr@thomasrast.ch> <trast@student.ethz.ch>
+Thorsten Glaser <tg@debian.org> Thorsten Glaser <t.glaser@tarent.de>
 Timo Hirvonen <tihirvon@gmail.com> <tihirvon@ee.oulu.fi>
 Toby Allsopp <Toby.Allsopp@navman.co.nz> <toby.allsopp@navman.co.nz>
+Tom G. Christensen <tgc@jupiterrise.com> Tom G. Christensen <tgc@statsbibl=
ioteket.dk>
 Tom Grennan <tmgrennan@gmail.com> <tgrennan@redback.com>
 Tommi Virtanen <tv@debian.org> <tv@eagain.net>
 Tommi Virtanen <tv@debian.org> <tv@inoi.fi>
@@ -253,19 +336,19 @@ Tor Arne Vestb=C3=B8 <torarnv@gmail.com> <tavestbo@tr=
olltech.com>
 Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com> Tran Ngoc Quan <=
vnwildman@gmail.com>
 Trent Piepho <tpiepho@gmail.com> <tpiepho@freescale.com>
 Trent Piepho <tpiepho@gmail.com> <xyzzy@speakeasy.org>
-Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <Uwe.Kleine-Koenig@=
digi.com>
 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <ukleinek@informati=
k.uni-freiburg.de>
+Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <Uwe.Kleine-Koenig@=
digi.com>
 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <uzeisberger@io.fsf=
orth.de>
 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <zeisberg@informati=
k.uni-freiburg.de>
 Ville Skytt=C3=A4 <ville.skytta@iki.fi> <scop@xemacs.org>
 Vitaly "_Vi" Shukela <vi0oss@gmail.com> <public_vi@tut.by>
 Vitaly "_Vi" Shukela <vi0oss@gmail.com> Vitaly _Vi Shukela
-W. Trevor King <wking@tremily.us> <wking@drexel.edu>
+Wei Shuyu <wsy@dogben.com> Shuyu Wei
+William Duclot <william.duclot@gmail.com> William Duclot <william.duclot@e=
nsimag.grenoble-inp.fr>
 William Pursell <bill.pursell@gmail.com>
+W. Trevor King <wking@tremily.us> <wking@drexel.edu>
+Yasushi SHOJI <yasushi.shoji@gmail.com> Yasushi SHOJI <yashi@atmark-techno=
.com>
 YONETANI Tomokazu <y0n3t4n1@gmail.com> <qhwt+git@les.ath.cx>
 YONETANI Tomokazu <y0n3t4n1@gmail.com> <y0netan1@dragonflybsd.org>
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
-# the two anonymous contributors are different persons:
-anonymous <linux@horizon.com>
-anonymous <linux@horizon.net>
-=C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
+=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 <git-dpa@aegee.org> =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=
=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 <dilyan.palauzov@aegee.org>
--=20
2.18.0.399.gad0ab374a1-goog

