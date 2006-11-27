X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
Subject: Re: git: how to produce context diffs?
Date: Mon, 27 Nov 2006 19:33:46 +0100
Message-ID: <20061127183346.30010@gmx.net>
References: <200611271516.30425.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 27 Nov 2006 18:35:07 +0000 (UTC)
Cc: git@vger.kernel.org, junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611271516.30425.bruno@clisp.org>
X-Authenticated: #20307258
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32436>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GolIf-0001Ef-Qy for gcvg-git@gmane.org; Mon, 27 Nov
 2006 19:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932934AbWK0Sdt convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006 13:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933049AbWK0Sdt
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 13:33:49 -0500
Received: from mail.gmx.de ([213.165.64.20]:47050 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S932934AbWK0Sds (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 13:33:48 -0500
Received: (qmail 27307 invoked by uid 0); 27 Nov 2006 18:33:46 -0000
Received: from 141.130.250.71 by www069.gmx.net with HTTP; Mon, 27 Nov 2006
 19:33:46 +0100 (CET)
To: Bruno Haible <bruno@clisp.org>
Sender: git-owner@vger.kernel.org

Hello,

I'm using the following script 'external-diff.sh':

--
# path old-file old-hex old-mode new-file new-hex new-mode
# $1   $2       $3      $4       $5       $6      $7

old_hex=3D$3
new_hex=3D`git-hash-object $5`

if [ "$old_hex" =3D "$new_hex" ]
then
	exit 0
fi

echo "diff --git a/$1 b/$1"
echo "index ${old_hex:0:7}..${new_hex:0:7} $4"

diff -L a/$1 -L b/$1 -pc $2 $5

exit 0
--

which can be called by:

export GIT_EXTERNAL_DIFF=3Dexternal-diff.sh
git-diff-index master -p > my.patch



Bye,
Thomas Kolejka

--=20
"Ein Herz f=FCr Kinder" - Ihre Spende hilft! Aktion: www.deutschlandseg=
elt.de
Unser Dankesch=F6n: Ihr Name auf dem Segel der 1. deutschen America's C=
