X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring another repository.
Date: Wed, 01 Nov 2006 13:23:33 +0100
Organization: At home
Message-ID: <eia3jk$n2f$1@sea.gmane.org>
References: <20060925044641.GB15757@spearce.org> <20061031174225.3c7c1e77.vsu@altlinux.ru> <7vac3covlf.fsf@assigned-by-dhcp.cox.net> <ei8s19$e04$1@sea.gmane.org> <20061101151859.0e984d3f.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 1 Nov 2006 12:25:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30634>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfF9H-00077a-K7 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 13:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946856AbWKAMYi convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006 07:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946857AbWKAMYh
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 07:24:37 -0500
Received: from main.gmane.org ([80.91.229.2]:52878 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1946856AbWKAMYg (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 07:24:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfF8H-0006sd-Sy for git@vger.kernel.org; Wed, 01 Nov 2006 13:23:49 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 13:23:49 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 01 Nov 2006
 13:23:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sergey Vlasov wrote:

>> Perhaps just don't remove log when branch is deleted. I tend for exa=
mple
>> to be careful when reordering commits on a branch, and use git branc=
h -f
>> instead of deleting and recreating branch to not lose reflog.
>=20
> Keeping the reflog does not help - reflog entries are not refs, and d=
o
> not keep the referenced objects live in the repository. =A0Therefore =
old
> objects will be lost when the repository is repacked and pruned.

Well, now to reorder and choose which commits on branch to save, and
optionally also rebase, I use
$ git branch tmp
$ git branch -f <branch> <upstream>
$ git checkout <branch>
$ git cherry-pick tmp~<n>
=2E..
$ git branch -D tmp

> Also, the reflog really must be deleted together with the ref itself =
-
> otherwise it may cause a file/directory conflict when another ref is
> created. =A0Of course, if the ref is renamed instead of deleting, the
> corresponding reflog may be renamed too.

There is currently no command to rename branch (and rename reflog).
It would be nice if git-branch could also rename branch (and reflog).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

