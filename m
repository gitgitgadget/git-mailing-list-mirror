X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Tue, 5 Dec 2006 07:11:04 +0100
Message-ID: <e5bfff550612042211q4c4e1e79x8e6e08a224209135@mail.gmail.com>
References: <20061111121625.8988.45195.stgit@localhost>
	 <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com>
	 <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com>
	 <20061204153705.GA8644@diana.vm.bytemark.co.uk>
	 <e5bfff550612041034g727a1bebg464f7c523c0fac7f@mail.gmail.com>
	 <b0943d9e0612041413p4f303176x3d0fa95afd1c4a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 5 Dec 2006 06:11:12 +0000 (UTC)
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qVbc9hbFAOL45DEhbx509iLFaA1zEZwuxvX1hPYvKNtxbSO5K6TGQe/RgXwjYTPBjAFNphmErEqzmJY4N6SF7a6efzyXCAW4JnAMPVzS5DrRRcZCAZPeiVoSCwI+BQxzis/ca8bf5W7inRCnfNlDV0ZRoHY5Fr/NjqDG8xQaP5E=
In-Reply-To: <b0943d9e0612041413p4f303176x3d0fa95afd1c4a1@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33307>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrTWJ-0006IV-AP for gcvg-git@gmane.org; Tue, 05 Dec
 2006 07:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967465AbWLEGLI convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006 01:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968039AbWLEGLI
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 01:11:08 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:12822 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S967465AbWLEGLF convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 01:11:05 -0500
Received: by py-out-1112.google.com with SMTP id a29so2412058pyi for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 22:11:04 -0800 (PST)
Received: by 10.35.93.19 with SMTP id v19mr16938993pyl.1165299064440; Mon, 04
 Dec 2006 22:11:04 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Mon, 4 Dec 2006 22:11:04 -0800 (PST)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/4/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 04/12/06, Marco Costalba <mcostalba@gmail.com> wrote:
> > On 12/4/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > > I introduced this since I wanted to divert the output to a file, =
and
> > > the progress message had no business being written to that file. =
But a
> > > command line option to suppress progress messages would work just=
 as
> > > well if that's what git does.
> >
> > If you don't mind I would prefer a command line option to _enable_
> > progress messages, something like -v or --verbose so to keep back
> > compatibility with current versions of tools that do not expect std=
err
> > messages.
>
> I'll first move the message back to stdout. Does qgit rely on the
> StGIT output to have a certain format/information? Does the progress
> message affect it in any way?
>

No. It just checks stderr for empty.

The only commands whose output is used by qgit are stg series/applied/u=
