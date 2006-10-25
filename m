X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] xdiff: Do not consider lines starting by # hunkworthy
Date: Wed, 25 Oct 2006 02:17:20 +0200
Organization: At home
Message-ID: <ehmadg$rkj$1@sea.gmane.org>
References: <20061025000708.2753.74523.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 00:17:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30019>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcWSP-0006Rt-KM for gcvg-git@gmane.org; Wed, 25 Oct
 2006 02:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422853AbWJYARS convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 20:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422856AbWJYARS
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 20:17:18 -0400
Received: from main.gmane.org ([80.91.229.2]:939 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1422853AbWJYARS (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 20:17:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GcWS7-0006OB-Qj for git@vger.kernel.org; Wed, 25 Oct 2006 02:17:04 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 02:17:03 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 25 Oct 2006
 02:17:03 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:

> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 *rec =3D=3D '(=
' ||=A0=A0=A0=A0=A0/* lisp defun? */
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 *rec =3D=3D '#=
')) {=A0=A0=A0=A0/* #define? */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 *rec =3D=3D '(=
')) {=A0=A0=A0=A0/* #define? */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (len > sz)

Shouldn't it be:

+                    *rec =3D=3D '(')) {    /* lisp defun? */
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

