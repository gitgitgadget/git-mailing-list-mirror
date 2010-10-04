From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 00/16] Add missing &&'s in the testsuite
Date: Sun, 3 Oct 2010 22:44:46 -0500
Message-ID: <20101004034446.GA24884@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <AANLkTi=+N=jm1b3vpiwxR0tFwPGbsaJyEq39q3oAyAn_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:48:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2c29-0008Tc-MX
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab0JDDsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 23:48:06 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40430 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab0JDDsE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 23:48:04 -0400
Received: by qwh6 with SMTP id 6so2847849qwh.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8qawQo/npEF7RawQI1gwtC5qpfLOWLheXc68fOp2/EA=;
        b=qYs5pHlzPfLMv9m6Zn6ClzhADqKTDjgNXHksKlqzqU8bTCPsDT8xORKthS7M7pVKyU
         avCZvgBEwzDrvdmNcKSdOhew/YA+a0qiXYjce0qieVUb9hWIpI54lkhPxu45qtmQ0EYb
         sEOXUaFDyuvuITY0wMe9G+XVuRc63yI7WLEtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sOGFsspt67MTJqm7U/PDz1tkZeXoH7sKZBlRwtLNJ849EJFDDdXvAbFArnqGZ6il9B
         85p4wL3x1fL8amcUAarrhNDJ0TwXcUKjnPPXx0DBUUpJiIG8h25RDGMI6yahIrFxafMT
         HNet2iAEDvc1CjAHeGA9bvyiyi8k2U8j4lGRQ=
Received: by 10.224.71.151 with SMTP id h23mr6195900qaj.219.1286164083857;
        Sun, 03 Oct 2010 20:48:03 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id t24sm4906391qcs.11.2010.10.03.20.48.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 20:48:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=+N=jm1b3vpiwxR0tFwPGbsaJyEq39q3oAyAn_@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157967>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Since Jonathan says all but 7 & 15 are OK (and I looked at those) I
> assume I don't need to hunt down some other discussion and comment on
> that. I.e. unless someone replies here.

If you find time, it would be nice to take a look at
http://thread.gmane.org/gmane.comp.version-control.git/157827/focus=3D1=
57874
(concerning patch 1/16), to consider quoting issues.

Because of all the nested quoting (and funny indentation, too), I
found the test hard to read.  Probably the best long-term solution
would be to use something like the style[1] notmuch=E2=80=99s test suit=
e uses.

I can only see problems coming from this if the path to the test
directory has shell metacharacters (especially '$') in it, which would
seem to me to be a pretty unusual setup.

[1] or as Jeff suggested recently:

test_start 'setup'
cat >expect <<EOF
=2E.. whatever ...
EOF
test_end success

test_start 'description'
git frob >actual &&
test_cmp expect actual
test_end success

http://thread.gmane.org/gmane.comp.version-control.git/155596/focus=3D1=
55681
