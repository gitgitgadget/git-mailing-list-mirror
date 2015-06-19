From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Move unsigned long option parsing out of
 pack-objects.c
Date: Fri, 19 Jun 2015 13:03:25 +0200 (CEST)
Message-ID: <69265919.629073.1434711805415.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org> <1434705059-2793-3-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 13:02:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5u3b-0005s5-Mj
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 13:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbbFSLBz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 07:01:55 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:39408 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750980AbbFSLBz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 07:01:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id CAA0C293C;
	Fri, 19 Jun 2015 13:01:52 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CL80Yd2aRhxv; Fri, 19 Jun 2015 13:01:52 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id AFF562924;
	Fri, 19 Jun 2015 13:01:52 +0200 (CEST)
In-Reply-To: <1434705059-2793-3-git-send-email-charles@hashpling.org>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: Move unsigned long option parsing out of pack-objects.c
Thread-Index: QmyQi2Q23OuBpDh1cRMIKx2cU3l2fQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272127>

Charles Bailey <cbailey32@bloomberg.net> writes:
> test_expect_success 'long options' '
> - test-parse-options --boolean --integer 1729 --boolean --string2=3D3=
21 \
> - --verbose --verbose --no-dry-run --abbrev=3D10 --file fi.le\
> - --obsolete > output 2> output.err &&
> + test-parse-options --boolean --integer 1729 --unsigned-long 16k \
> + --boolean --string2=3D321 --verbose --verbose --no-dry-run \
> + --abbrev=3D10 --file fi.le --obsolete \
> + > output 2> output.err &&
> test_must_be_empty output.err &&
> test_cmp expect output
> '

It's trivial matter but the line:
> + > output 2> output.err &&
should be written:
> + >output 2>output.err &&

It was incorrectly written before but since=20
you are modifying the line, it might be a=20
good thing to change it now.

R=C3=A9mi
