From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: format-patch problem when using relative
Date: Thu, 27 Nov 2008 10:42:58 +0100
Message-ID: <20081127094258.GA12018@atjola.homenet>
References: <17081052-4480-4971-9F38-BD5C48087379@gmail.com> <20081126180154.GA7584@coredump.intra.peff.net> <06D676E3-6C24-4ACC-9874-8B19549BC3A1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nikola =?utf-8?B?S25lxb5ldmnEhw==?= <laladelausanne@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 10:44:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5dQB-0006AV-9Y
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 10:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbYK0JnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2008 04:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYK0JnE
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 04:43:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:53426 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750947AbYK0JnC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 04:43:02 -0500
Received: (qmail invoked by alias); 27 Nov 2008 09:43:00 -0000
Received: from i577B9FBC.versanet.de (EHLO atjola.local) [87.123.159.188]
  by mail.gmx.net (mp030) with SMTP; 27 Nov 2008 10:43:00 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/2unkm07L2CsKbIcFPdNdW9XRdsFKAbZhMbUTjxG
	lznGb8f4sghnLy
Content-Disposition: inline
In-Reply-To: <06D676E3-6C24-4ACC-9874-8B19549BC3A1@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101803>

On 2008.11.26 19:58:34 +0100, Nikola Kne=C5=BEevi=C4=87 wrote:
> On 26 Nov 2008, at 19:01 , Jeff King wrote:
>
>> So I think what you really want is:
>>
>>  git format-patch --relative=3Dclick click/master myclick -- click
>>
>> to limit the path pruning to the 'click' directory.
>
> Yes, that did the trick. Also, when I think about it, it makes sense =
- =20
> do checks relative to a path, but prune using path.

Ah, now that makes sense to me, too. You just didn't use the actual
command I told you on IRC ;-)

<doener> git format-patch --relative=3Dclick/ click/master click

That already had the path limiting "click" in it, I really meant "click=
"
there, not "myclick" ;-) I guess the confusion was caused by how
format-patch takes the range it's supposed to work on. If you only give
it a single committish, that is interpreted as "since". So the above is
equal to

git format-patch --relative=3Dclick/ click/master..HEAD click

Bj=C3=B6rn
