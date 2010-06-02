From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC v3 0/7] Add internationalization support to Git
Date: Wed, 02 Jun 2010 08:32:56 +0200
Message-ID: <4C05FB18.7010200@viscovery.net>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>	<1275435597-4017-1-git-send-email-avarab@gmail.com> <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 08:33:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJhVf-0001H4-Ue
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 08:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649Ab0FBGc6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 02:32:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29632 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753533Ab0FBGc5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 02:32:57 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OJhVY-0005KZ-Ol; Wed, 02 Jun 2010 08:32:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 85BD51660F;
	Wed,  2 Jun 2010 08:32:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148221>

Am 6/2/2010 2:11, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>     +export GIT_TEXTDOMAINDIR=3D`pwd`/../share/locale

This works only in some shells for two reasons:

- 'export foo=3Dbar' syntax is not understood everywhere;

- if it is understood, then some shells still split the expansion in
'export foo=3D`pwd`' at white-space.

Use 'foo=3Dbar; export foo', like you did elsewhere.

>      test_expect_success 'sanity: $TEXTDOMAINDIR exists' '
>     -	test -d $TEXTDOMAINDIR
>     +	test -d $TEXTDOMAINDIR &&
>     +	test $TEXTDOMAINDIR =3D $GIT_TEXTDOMAINDIR

Double-quotes, double-quotes!

-- Hannes
