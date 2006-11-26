X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: handling symlinks proposal
Date: Sun, 26 Nov 2006 19:25:31 +0100
Message-ID: <4569DC1B.9080400@lsrfire.ath.cx>
References: <4569C7F8.4030303@pipapo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 26 Nov 2006 18:26:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <4569C7F8.4030303@pipapo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32362>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoOhL-00064G-Ei for gcvg-git@gmane.org; Sun, 26 Nov
 2006 19:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935486AbWKZSZk convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006 13:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935488AbWKZSZk
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 13:25:40 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:54956 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S935486AbWKZSZj (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26
 Nov 2006 13:25:39 -0500
Received: from [10.0.1.4] (p508E5EE3.dip.t-dialin.net [80.142.94.227]) by
 neapel230.server4you.de (Postfix) with ESMTP id 066A527; Sun, 26 Nov 2006
 19:25:37 +0100 (CET)
To: Christian Thaeter <ct@pipapo.org>
Sender: git-owner@vger.kernel.org

Christian Thaeter schrieb:
> Git currently keep symlinks always as symlink, I would like to see so=
me
> optional functionality when handling symlinks.
>=20
> Sometimes it is not intended to store information external to a sourc=
e
> tree in git. Problems are that it might break a checkout, just loosin=
g
> information or even have security implications.
[...]
> how can we handle symlinks:
>  - 'keep' what git currently does, store the symlink as it is
>  - 'file' store it as file (dereference it), information that it was =
a
>     symlink gets lost, checkouts will produce a file.
>  - 'relative' store it as a relative symlink
>  - 'absolute' store it as a absolute symlink
>  - 'error' refuse to checkin and abort commit
>  - 'warn' display a warning
>=20
> How to add this to git?

Why would we want to?  Could you perhaps give examples on how a symlink
in a git repo could break checkouts, cause loss of information or have
security implications?

You're symlink handling methods 'file', 'relative', 'absolute', 'error'=
,
'warn' aren't very useful if you check in files (and symlinks) manually=
,
because if you add the links by hand then you can make sure they point
to the right place (or are no symlinks, but plain files), after all.

So they're mainly intended for initial checkins and merges with externa=
l
repos, right?  But in these cases you have to trust foreign code anyway
(simple example: you need to be sure 'make all' doesn't run a command
like 'rm -rf $HOME'), so you have to take a closer look at that stuff
anyway -- symlinks are just one part of what needs checking.

Thanks,
