From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Collocate strings to simplify translation
Date: Thu, 24 May 2012 14:20:39 +0200
Message-ID: <4FBE2797.80505@viscovery.net>
References: <1337845288-7656-1-git-send-email-vfr@lyx.org> <4FBDF21F.1010807@in.waw.pl> <4FBE0593.7070205@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Thu May 24 14:21:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXX2P-0002nE-66
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 14:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab2EXMU7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 08:20:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:45609 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab2EXMU6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 08:20:58 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SXX2q-0004Rj-8q; Thu, 24 May 2012 14:21:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 803891660F;
	Thu, 24 May 2012 14:20:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FBE0593.7070205@lyx.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198369>

Am 5/24/2012 11:55, schrieb Vincent van Ravesteijn:
> Op 24-5-2012 10:32, Zbigniew J=C4=99drzejewski-Szmek schreef:
>> On 05/24/2012 09:41 AM, Vincent van Ravesteijn wrote:
>>> -    status_printf_ln(s, c, _("%s files:"), what);
>>> +    status_printf_ln(s, c, _("%s:"), what);
>> How can "%s:" be translated? _() should be removed here.
>=20
> Some languages might use a character different from ':'. For example,
> Chinese uses a full-width character ':' (unicode 0xFF1A) instead of a
> half-width character. Maybe this is taken care of by the system/shell=
 or
> whatever, maybe not. Other examples are languages that read from righ=
t to
> left. I guess it should then be translated by ":%s".
>=20
> This will probably be a matter of convention.

Shouldn't you then move the colon with the "files"? That is, here we ha=
ve:

-	status_printf_ln(s, c, _("%s files:"), what);
+	status_printf_ln(s, c, "%s", what);

and elsewhere we use _("Untracked files:") and _("Ignored files:").

-- Hannes
