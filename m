From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 20/48] i18n: git-submodule die + eval_gettext messages
Date: Thu, 12 May 2011 10:08:50 +0200
Message-ID: <4DCB9592.2090503@viscovery.net>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com> <1304857280-14773-21-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 10:09:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKQxE-0002gF-8T
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 10:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab1ELII5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2011 04:08:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62811 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751449Ab1ELII4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 04:08:56 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QKQx1-0000H4-D8; Thu, 12 May 2011 10:08:51 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 20C2A1660F;
	Thu, 12 May 2011 10:08:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1304857280-14773-21-git-send-email-avarab@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173446>

Am 5/8/2011 14:20, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> -		say "Submodule '$name' ($url) registered for path '$path'"
> +		say "$(eval_gettext "Submodule '\$name' (\$url) registered for pat=
h '\$path'")"

On Windows, we have a problem with messages like this (and many others)
that reference $path. eval_gettext has to export 'path', but on Windows
environment variables are case-insensitive. In the substitution, this
happens to pick the value of 'PATH' rather than of 'path'... Can you do
something about this?

Of course, the problem is not limited to 'path' at all, but it is a
prominent example discovered by the test suite.

-- Hannes
