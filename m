X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [StGIT PATCH] Bash snippet to show branch and patch in bash prompt
Date: Mon, 30 Oct 2006 11:32:44 +0100
Message-ID: <200610301132.45086.robin.rosenberg@dewire.com>
References: <20061029233745.24899.1470.stgit@lathund.dewire.com> <4545CC6F.90001@tromer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 30 Oct 2006 10:33:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <4545CC6F.90001@tromer.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30493>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeUQb-0005NY-7Q for gcvg-git@gmane.org; Mon, 30 Oct
 2006 11:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161216AbWJ3Kbe convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006 05:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbWJ3Kbe
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 05:31:34 -0500
Received: from [83.140.172.130] ([83.140.172.130]:28461 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1161216AbWJ3Kbd convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006
 05:31:33 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id AC0DB8030A5; Mon, 30 Oct 2006 11:28:15 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 29172-08; Mon, 30 Oct
 2006 11:28:15 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5]) by torino.dewire.com (Postfix)
 with ESMTP id 652648030A1; Mon, 30 Oct 2006 11:28:13 +0100 (CET)
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org

m=C3=A5ndag 30 oktober 2006 10:57 skrev Eran Tromer:
> That's an annoying 430ms delay at every prompt, on my box. Does StGIT=
 do
> something expensive on every invocation?

I don't type fast enough to notice really and my machine seems faster, =
~300 ms=20
per prompt.

>
> Ben Clifford'd solution is pretty much instantaneous, and the followi=
ng
> extends it to StGIT (in a less clean but much faster way):
>
> ----------------------------------------------
> __prompt_githead() {
>     __PS_GIT=3D"$(git-symbolic-ref HEAD 2>/dev/null)" || exit
>     __PS_GIT=3D"$(basename $__PS_GIT)"
>     echo -n " $__PS_GIT"
>     __PS_GIT=3D$(cat "${GIT_DIR:-.git}/patches/$__PS_GIT/current" \
>                2>/dev/null) || exit
>     echo -n ":$__PS_GIT"
> }
> PS1=3D'[\u@\h \W$(__prompt_githead)]\$ '
> ----------------------------------------------

This doesn't work if the branch have a / in the name or if you are in a=
=20
subdirectory, not the top level. Probably not hard to fix though.

