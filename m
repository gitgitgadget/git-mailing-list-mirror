X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Small optimizations to gitweb
Date: Tue, 19 Dec 2006 00:17:03 +0100
Organization: At home
Message-ID: <em77cg$obn$1@sea.gmane.org>
References: <20061218224327.GG16029@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 18 Dec 2006 23:25:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34759>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwRoi-0003gc-3a for gcvg-git@gmane.org; Tue, 19 Dec
 2006 00:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754752AbWLRXWl convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754755AbWLRXWl
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 18:22:41 -0500
Received: from main.gmane.org ([80.91.229.2]:56201 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1754752AbWLRXWk
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 18:22:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GwRjp-00027n-Jw for git@vger.kernel.org; Tue, 19 Dec 2006 00:17:41 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 00:17:41 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 19 Dec 2006
 00:17:41 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Robert Fitzsimons wrote:

> Limit some of the git_cmd's so they only return the number of lines
> that will be processed.=20
[...]
> @@ -2876,8 +2879,8 @@ sub git_summary {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0
> -=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", git_cmd(), "rev-list", "--ma=
x-count=3D17",
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0git_get_head_hash($proj=
ect), "--"
> +=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", git_cmd(), "rev-list", "--ma=
x-count=3D16",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$head, "--"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0or die_error(undef, "=
Open git-rev-list failed");
> =A0=A0=A0=A0=A0=A0=A0=A0my @revlist =3D map { chomp; $_ } <$fd>;
> =A0=A0=A0=A0=A0=A0=A0=A0close $fd;

Actually, that is needed to implement checking if we have more than
the number of commits to show to add '...' at the end only if there
are some commits which we don't show. The same for heads and tags.
(On my short TODO list, but feel free to do it yourself, if you want).

So ack without the last chunk.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

