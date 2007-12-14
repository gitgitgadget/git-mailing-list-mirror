From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Don't use the pager when running "git diff --check"
Date: Fri, 14 Dec 2007 08:47:44 +0100
Message-ID: <26AEA0A9-9F15-4245-9D27-61050DA57E6F@wincent.com>
References: <1197552751-53480-2-git-send-email-win@wincent.com> <1197575138-58070-1-git-send-email-win@wincent.com> <20071214045127.GC10169@sigill.intra.peff.net> <7vmysdx3la.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J35HR-00045D-8N
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbXLNHrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 02:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbXLNHrz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:47:55 -0500
Received: from wincent.com ([72.3.236.74]:49783 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbXLNHry convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 02:47:54 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBE7ljQI012897;
	Fri, 14 Dec 2007 01:47:46 -0600
In-Reply-To: <7vmysdx3la.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68257>

El 14/12/2007, a las 6:11, Junio C Hamano escribi=F3:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Dec 13, 2007 at 08:45:38PM +0100, Wincent Colaiuta wrote:
>>
>>> In 89d07f75 "git diff" learnt to not run the pager if the user =20
>>> passes
>>> the --exit-code switch. This commit does the same for the --check
>>> switch for the same reason: we want the user to get the exit status
>>> from "git diff", not the pager.
>>
>> But --check is also producing useful output, which might need =20
>> paged. So
>> you are sacrificing existing interactive use of --check for =20
>> scriptable
>> exit-code uses. If you really want the exit code, why not "git diff
>> --check --exit-code"?
>>
>> OTOH, I am not too sad to lose the paging behavior; it would take =20
>> quite
>> a few whitespace errors to scroll off the screen.
>
> You are right.  While I do not personally miss paging output, it is a
> regression not to page --check output by default.

I thought this was ok because "git diff --exit-code" also produces =20
useful output and also turns off the pager.

> By the way, there is no reason to make --check and --exit-code =20
> mutually
> exclusive either.  You could say with --exit-code the command will =20
> exit
> with status 01 or'ed in if trees are not identical, and with --check =
=20
> the
> command will exit with status 02 or'ed in.

Yes, this sounds fine to me.

Cheers,
Wincent
