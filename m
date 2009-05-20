From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 17:23:17 +0200
Message-ID: <96BC1064-EEEF-48BC-B79A-9D15C517CF47@wincent.com>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home> <20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home> <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com> <alpine.LFD.2.00.0905200853010.3906@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 20 17:23:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6ne6-0001yI-CR
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 17:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbZETPXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 11:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbZETPXp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 11:23:45 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:35580 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbZETPXp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 11:23:45 -0400
Received: from cuzco.lan (156.pool85-53-12.dynamic.orange.es [85.53.12.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n4KFNH9U005077
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 20 May 2009 11:23:19 -0400
In-Reply-To: <alpine.LFD.2.00.0905200853010.3906@xanadu.home>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119616>

El 20/5/2009, a las 14:53, Nicolas Pitre escribi=F3:

> On Wed, 20 May 2009, Wincent Colaiuta wrote:
>
>> El 20/5/2009, a las 5:35, Nicolas Pitre escribi=F3:
>>
>>> Having a "trash" reflog would solve this unambiguously.  That =20
>>> could also
>>> include your index example above.  However, in the index case, I'd
>>> record a reflog entry only if you're about to discard a previously =
=20
>>> non
>>> committed entry.  If you do:
>>>
>>> 	$ git add foo
>>> 	$ git add bar
>>> 	$ git commit
>>> 	$ hack hack hack
>>> 	$ git add foo
>>>
>>> then in this case there is nothing to be lost hence no additional =20
>>> entry
>>> in the "trash" reflog.
>>
>> That's true in the example you provide, but it doesn't really =20
>> handle Jeff's
>> initial example ("git add" twice on the same file), where it is =20
>> possible to
>> throw away intermediate state (by overwriting).
>
> Did I disagree with Jeff's original example?

No, but I may have misinterpreted you; I understood that you said you =20
wouldn't store intermediate index state after successive "git add" =20
executions.

Cheers,
Wincent
