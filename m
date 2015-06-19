From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory
 configuration
Date: Fri, 19 Jun 2015 13:34:14 +0200 (CEST)
Message-ID: <1537731273.629800.1434713654223.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 13:32:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5uXQ-0000NE-8e
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 13:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbbFSLco convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 07:32:44 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:32919 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751311AbbFSLcn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 07:32:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 770113730;
	Fri, 19 Jun 2015 13:32:41 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3KVRj-flaXX; Fri, 19 Jun 2015 13:32:41 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 61266371D;
	Fri, 19 Jun 2015 13:32:41 +0200 (CEST)
In-Reply-To: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: format-patch: introduce format.outputDirectory configuration
Thread-Index: ss/tOJTlBSWzyzpdHYevqq5swLefhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272130>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:
> +test_expect_success "format-patch format.outputDirectory option" '
> + git config format.outputDirectory "patches/" &&
> + git format-patch master..side &&
> + cnt=3D$(ls | wc -l) &&
> + echo $cnt &&
> + test $cnt =3D 3 &&
> + git config --unset format.outputDirectory
> +'

You should probably do:
> + test_config format.outputDirectory "patches/" &&

instead of:
> + git config format.outputDirectory "patches/" &&
> [...]
> + git config --unset format.outputDirectory

This way there shouldn't be any problem with the=20
tests following yours if your test fails in the middle.

R=C3=A9mi
