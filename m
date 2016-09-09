Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62ED1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbcIIOMT (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:12:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:64166 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbcIIOMS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:12:18 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MK17F-1bjjyw04Sj-001PHP; Fri, 09 Sep 2016 16:12:11
 +0200
Date:   Fri, 9 Sep 2016 16:12:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/22] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <d8112b27-8de3-0860-e902-fb271b80a0e7@gmail.com>
Message-ID: <alpine.DEB.2.20.1609091608090.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de> <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com> <alpine.DEB.2.20.1609010836010.129229@virtualbox>
 <d8112b27-8de3-0860-e902-fb271b80a0e7@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1972324869-1473430331=:129229"
X-Provags-ID: V03:K0:vyh8k0OLfKh/h1WI8yaJx82ojcZxdoe4W0pd3K2ks3dqRY7pga5
 JJHW9MCBZqbEJ96D0GEVMR89/kXEM/Qt2xaBrKRNlx8/iTNf9pjvNQ8PBqWXXBxFKp0Ceuy
 WoyFHCOD7UthakBifpDZeswAYYaKvfN249x9Vd6FKGFeK6z6ez8ZxOIPuimNOj6p02avWBx
 Zmvfe1VqpA6yCWLmNI+tQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xwJinv2z/dE=:Bwcvx2BXXYeEQ9C7e1Op8r
 HqzBwVfPN3/RmpuQP01zfZLlD8FI0KxljYGEblP2xRjrm1OHNkYka2po2KG1PqQ+AIvbPLF6G
 1NSBt7kAWZaN60AlfJBQSZs8YLGujErIeCk4R+vKQtTJZQ6f1/mzeIBgcQGmt8XgHzWNvR2J/
 df/u8hb3i7hmIi2DtWa1raDimGYir9J0oD8KAzp8LlLqXGnDFYG8U//Ib5jcyq4UI1HK1GYzj
 lKbp1jiHmidtM4P+KPhnhbg7sHfFDHrgHxeIECQh/E+JH3UfAIlD2sGvJ+TwOa3VUm/ARH/2w
 DvqEoVfFKNFpAFJlgeWb7hl5LgF2yqf+Uij7sFVEBJY4THE2onJnVF3lA/MvuB/cDWVqZEcA1
 hDcIMdMd2waKZbwoOhxlm5TSKcrv7k9AdE0blPzd9ShZTIfdfXkA8vIJSDvaSIPcK8gI/0vm7
 J7xnAsUTaIK/7YPoDIBZxuYRUIka0hTCGBV21nI5KPlLjzjL6yElkYu6rKmmKG9PsHl+exRZt
 tRLoDdm38op5gBt2jC1Ayx1B19uefVScTqVKQQZ3r02AkKI5PksJwwVxP/TCMukxgyQMuDSfg
 UHzpvampP/UHKavGhWJYtL0EOj0h8JFknBUwdH9NQFIgw/oOUlIKTk/ryNrJSohhP2rFOM1Mo
 B0yVGaquSoNFSZPgzaSl+qHC6i6/m+bFc4B5s9IaNLXbiMAtcMnJQBdQu6Fgnb0ihhLHW2YnS
 45O0/WltsJCSZDu6+c1xAtXv3YI/1Us1hpKlo4z9EKh5Y/fVpSbGAJxJnbscdocTGl0GBokct
 Sw9IicB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1972324869-1473430331=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Fri, 2 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 01.09.2016 o 09:49, Johannes Schindelin pisze:
> > On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:=20
>=20
> >> Here todo_list uses growable array implementation of list.  Which is
> >> I guess better on current CPU architecture, with slow memory,
> >> limited-size caches, and adjacency prefetching.
> >=20
> > That is not the reason that an array is used here. The array allows us
> > much more flexibility.
>=20
> It would be nice if this reasoning (behind the change from linked list
> to growable array) was mentioned in appropriate commit message, and
> perhaps also in the cover letter for the series.  It is IMVHO quite
> important information (that you thought obvious).

Amended.

> >>> +struct todo_item *append_todo(struct todo_list *todo_list)
> >>
> >> Errr... I don't quite understand the name of this function.
> >> What are you appending here to the todo_list?
> >=20
> > A new item.
> >=20
> >> Compare string_list_append() and string_list_append_nodup(),
> >> where the second parameter is item to append.
> >=20
> > Yes, that is correct. In the case of a todo_item, things are a lot more
> > complicated, though. Some of the values have to be determined tediously
> > (such as the offset and length of the oneline after the "pick <oid>"
> > command). I just put those values directly into the newly allocated ite=
m,
> > is all.
>=20
> I would expect sth_append command to take a list (or other collection),
> an element, and return [modified] collection with the new element added.
> Such API would require temporary variable in caller and memcopy in the
> sth_append() function.
>=20
> This is not it.  It creates a new element, expanding a list (a collection=
),
> and then expose this element.  Which spares us memcopy... on non-critical
> path.
>=20
> I don't know how to name operation "grow list and return new element".
> But "append" it is not.

I renamed it to append_new_todo().

> >>> -=09end_of_object_name =3D bol + strcspn(bol, " \t\n");
> >>> +=09end_of_object_name =3D (char *) bol + strcspn(bol, " \t\n");
> >>
> >> Why is this cast needed?
> >=20
> > Because bol is a "const char *" and we need to put "NUL" temporarily to
> > *end_of_object_name:
>=20
> Would compiler complain without this const'ness-stripping cast?

Yes. I would not have added it otherwise.

Please note that this is only necessary because I changed the parameter
from "char *" to "const char *" (which was The Right Thing To Do).

> >>>  =09saved =3D *end_of_object_name;
> >>>  =09*end_of_object_name =3D '\0';
> >>>  =09status =3D get_sha1(bol, commit_sha1);
> >>>  =09*end_of_object_name =3D saved;
> >=20
> > Technically, this would have made a fine excuse to teach get_sha1() a
> > mode where it expects a length parameter instead of relying on a
> > NUL-terminated string.
> >=20
> > Practically, such fine excuses cost me months in this rebase--helper
> > project already, and I need to protect my time better.
>=20
> Put it in TODO list (and perhaps add a TODO comment) ;-).

I am also a realist: I won't be able to do anything about this. If you
care enough, please go right to town.

Thanks again,
Dscho
--8323329-1972324869-1473430331=:129229--
