X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Mon, 4 Dec 2006 22:13:16 +0000
Message-ID: <b0943d9e0612041413p4f303176x3d0fa95afd1c4a1@mail.gmail.com>
References: <20061111121625.8988.45195.stgit@localhost>
	 <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com>
	 <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com>
	 <20061204153705.GA8644@diana.vm.bytemark.co.uk>
	 <e5bfff550612041034g727a1bebg464f7c523c0fac7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 22:13:43 +0000 (UTC)
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VQwJnCIkLuIFaCEwbGBhmkj3oPxZaVbhErYbiZQa0AUaVapjzNnbGOATNhKJ11HcrKCw1WWxopiVUlKrhQLf6pxwleeGFAdtEGZcYEOSgw+BKTpbw+YeFmeVa1oGWG0atm1lxJJ7BHRCkkJD2hLShEI6Y+h4GS9NVagjbTLAOLs=
In-Reply-To: <e5bfff550612041034g727a1bebg464f7c523c0fac7f@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33261>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrM47-0008VW-2t for gcvg-git@gmane.org; Mon, 04 Dec
 2006 23:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759628AbWLDWNS convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 17:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759732AbWLDWNS
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 17:13:18 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:39750 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1758411AbWLDWNR convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 17:13:17 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1971318nze for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 14:13:17 -0800 (PST)
Received: by 10.65.236.14 with SMTP id n14mr13001786qbr.1165270396894; Mon,
 04 Dec 2006 14:13:16 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Mon, 4 Dec 2006 14:13:16 -0800 (PST)
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

On 04/12/06, Marco Costalba <mcostalba@gmail.com> wrote:
> On 12/4/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > I introduced this since I wanted to divert the output to a file, an=
d
> > the progress message had no business being written to that file. Bu=
t a
> > command line option to suppress progress messages would work just a=
s
> > well if that's what git does.
>
> If you don't mind I would prefer a command line option to _enable_
> progress messages, something like -v or --verbose so to keep back
> compatibility with current versions of tools that do not expect stder=
r
> messages.

I'll first move the message back to stdout. Does qgit rely on the
StGIT output to have a certain format/information? Does the progress
message affect it in any way?

I consider many of the other messages to be progress messages (like
"pushing... done") and I haven't differentiated between them until
Karl's patch. For commands like diff or status, you expect the command
to check the working copy anyway and it doesn't output this specific
message.

The best would probably be to add a "verbose" config option to enable
this message (and maybe a command line option later but this means
modifying all the commands to accept this option). I'll try to push
this change tomorrow (together with moving from stgitrc to gitconfig).

--=20
