X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git pull and merging.
Date: Fri, 8 Dec 2006 18:23:45 +0100
Message-ID: <200612081823.45565.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <200612072354.01830.Josef.Weidendorfer@gmx.de> <8aa486160612071756s18f9530cr7ed26e4b7b47d1de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 17:23:57 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <8aa486160612071756s18f9530cr7ed26e4b7b47d1de@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33710>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsjRx-00088x-Rs for gcvg-git@gmane.org; Fri, 08 Dec
 2006 18:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760778AbWLHRXv convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 12:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760772AbWLHRXu
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 12:23:50 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:62520 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1760778AbWLHRXt convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 12:23:49 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 84C9479C; Fri,  8
 Dec 2006 18:23:48 +0100 (MET)
To: "Santi =?iso-8859-1?q?B=E9jar?=" <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 02:56, Santi B=E9jar wrote:
> > [remote "repo"]
> >   url =3D ...
> >   fetch =3D branch1
> >   fetch =3D branch2
> >
> > [branch "mybranch1"]
> >   remote =3D repo
> >   merge =3D branch1
> >
> > actually looks fine, and is the only possible way.
> > But still, this does not work.
>=20
> It works for me.
>=20
> > You have to specify
> >
> >   merge =3D refs/heads/branch1
>=20
> It does not.
>=20
> The merge line must match exactly the remote part of the refspec.

Yes, you are right; I just looked it up in git-parse-remote.
Sorry about any confusion.

>=20
> >
> > That's confusing (perhaps I can come up with a patch
> > to allow "branch1" alone).
> >
> > So probably the best way is to write some more detailed
> > explanation into the docu ...
>=20
> Perhaps that the branch.<name>.remote and branch.<name>.merge have th=
e
> equivalent meaning as the parameters of git-pull?

We want to fetch multiple refs from one remote in a row. So what
are you proposing? That branch.<name>.merge has to exactly
specify one remote? I do not think this is needed.

Actually, I am really for a new branch.<name>.localmerge option,
and keeping branch.<name>.merge (but not advertising it).

