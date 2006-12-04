X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Mon, 4 Dec 2006 19:34:59 +0100
Message-ID: <e5bfff550612041034g727a1bebg464f7c523c0fac7f@mail.gmail.com>
References: <20061111121625.8988.45195.stgit@localhost>
	 <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com>
	 <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com>
	 <20061204153705.GA8644@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 18:35:12 +0000 (UTC)
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dp1kf0tzCsNuh3NqvRYhbBvxDNyGmU1DZxED8R09q4+Jf2kk1an5mp1Dh99vR84+GlsN/v8zIZzKojtBaYm1rJ2tINYYvvJX2ApJ/VeAxzSu7xciPBwoFMIFBx67UpCpvR8mUZ5OHAoj45LZ+T5Jp3ofC0QMIgGawvf0WtmMy8M=
In-Reply-To: <20061204153705.GA8644@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33216>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrIeg-0005mq-VO for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937247AbWLDSfD convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 13:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937250AbWLDSfD
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:35:03 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:14514 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937247AbWLDSfA convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 13:35:00 -0500
Received: by py-out-1112.google.com with SMTP id a29so2325998pyi for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 10:34:59 -0800 (PST)
Received: by 10.35.41.14 with SMTP id t14mr15789221pyj.1165257299705; Mon, 04
 Dec 2006 10:34:59 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Mon, 4 Dec 2006 10:34:59 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 12/4/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-12-04 09:17:16 +0000, Catalin Marinas wrote:
>
> > On 02/12/06, Marco Costalba <mcostalba@gmail.com> wrote:
> >
> > > On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > >
> > > > Printing progress messages to stdout causes them to get mixed u=
p
> > > > with the actual output of the program. Using stderr is much
> > > > better, since the user can then redirect the two components
> > > > separately.
> > >
> > > This patch breaks qgit.
> >
> > Since there are other tools relying on a clean stderr, I think I
> > would revert it and add a verbose flag and/or config option. Karl,
> > any thoughts on this (since you sent the patch)?
>
> I introduced this since I wanted to divert the output to a file, and
> the progress message had no business being written to that file. But =
a
> command line option to suppress progress messages would work just as
> well if that's what git does.
>

If you don't mind I would prefer a command line option to _enable_
progress messages, something like -v or --verbose so to keep back
compatibility with current versions of tools that do not expect stderr
messages.

Thanks
