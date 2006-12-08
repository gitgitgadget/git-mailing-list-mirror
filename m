X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git pull and merging.
Date: Fri, 8 Dec 2006 21:09:27 +0100
Message-ID: <8aa486160612081209r91a35f4v4e495357791a934c@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <200612072354.01830.Josef.Weidendorfer@gmx.de>
	 <8aa486160612071756s18f9530cr7ed26e4b7b47d1de@mail.gmail.com>
	 <200612081823.45565.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 20:09:51 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QMaofwYtPCzjmAwv9v1rfo9b+vaFwKyVRLBTCxyUExb5QJ4tx8tyQEQaIl9780h7SjefGU4nTCSeTwqL60iFcXCiocuJxMR5Oxux/JtzaZx4bloDeP88wyYlUvyrtBENmxbkCaavst7bVTqDc8fW0r9T3OZ088VeFTk2LAycNp4=
In-Reply-To: <200612081823.45565.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33735>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsm2I-0006BY-Du for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946146AbWLHUJa convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 15:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946262AbWLHUJa
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:09:30 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:40422 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1946223AbWLHUJ2 convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 15:09:28 -0500
Received: by wx-out-0506.google.com with SMTP id h27so904861wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 12:09:27 -0800 (PST)
Received: by 10.70.50.18 with SMTP id x18mr6528298wxx.1165608567658; Fri, 08
 Dec 2006 12:09:27 -0800 (PST)
Received: by 10.70.45.1 with HTTP; Fri, 8 Dec 2006 12:09:27 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Friday 08 December 2006 02:56, Santi B=E9jar wrote:
> > > [remote "repo"]
> > >   url =3D ...
> > >   fetch =3D branch1
> > >   fetch =3D branch2
> > >
> > > [branch "mybranch1"]
> > >   remote =3D repo
> > >   merge =3D branch1
> > >
> > > actually looks fine, and is the only possible way.
> > > But still, this does not work.
> >
> > It works for me.
> >
> > > You have to specify
> > >
> > >   merge =3D refs/heads/branch1
> >
> > It does not.
> >
> > The merge line must match exactly the remote part of the refspec.
>
> Yes, you are right; I just looked it up in git-parse-remote.
> Sorry about any confusion.
>
> >
> > >
> > > That's confusing (perhaps I can come up with a patch
> > > to allow "branch1" alone).
> > >
> > > So probably the best way is to write some more detailed
> > > explanation into the docu ...
> >
> > Perhaps that the branch.<name>.remote and branch.<name>.merge have =
the
> > equivalent meaning as the parameters of git-pull?
>
> We want to fetch multiple refs from one remote in a row. So what
> are you proposing? That branch.<name>.merge has to exactly
> specify one remote? I do not think this is needed.

I'm not proposing anything. What I wanted to say is that we could
document the ...remote and ...merge configs as the default parameters
of git-pull (this is how it is implemented already).

>
> Actually, I am really for a new branch.<name>.localmerge option,
> and keeping branch.<name>.merge (but not advertising it).

I do not see anything wrong with the current ...remote and ...merge
(see above), but I'm not against the ...localmerge config.

