From: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
Subject: Re: [PATCH 3/3] git-p4: improve submit performance on new P4 servers
Date: Thu, 21 Jan 2010 18:58:29 -0800
Message-ID: <4B591455.7050409@naughtydog.com>
References: <4B590808.6010206@naughtydog.com> <alpine.LFD.2.00.1001212147480.1726@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9iy-0002pL-Fg
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889Ab0AVC6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2010 21:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755866Ab0AVC6L
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:58:11 -0500
Received: from ironport02a.scea.com ([160.33.44.43]:30712 "EHLO
	ironport02a.scea.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0AVC6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:58:09 -0500
X-IronPort-AV: E=Sophos;i="4.49,322,1262592000"; 
   d="scan'208";a="8055730"
Received: from inbetweener01.scea.com ([160.33.45.195])
  by ironport02a.scea.com with ESMTP; 21 Jan 2010 18:58:00 -0800
Received: from postal1-dog.naughtydog.com (intmail.naughtydog.com [10.15.0.14])
	by inbetweener01.scea.com (Postfix) with ESMTP id D27FDF017A;
	Thu, 21 Jan 2010 18:58:00 -0800 (PST)
Received: from [127.0.0.1] ([150.0.6.116]) by postal1-dog.naughtydog.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Jan 2010 18:58:29 -0800
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LFD.2.00.1001212147480.1726@xanadu.home>
X-OriginalArrivalTime: 22 Jan 2010 02:58:29.0577 (UTC) FILETIME=[C6828390:01CA9B0E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137728>

Nicolas Pitre wrote:
> On Thu, 21 Jan 2010, Pal-Kristian Engstad wrote:
>=20
>> Improve git-p4 submit performance on newer (from 2009.2) Perforce
>> servers by changing "p4 diff -du" to "p4 diff -dub". This change is
>> harmless since the output is only used for display purposes.
>>
>> Signed-off-by: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
>=20
> Why is the b flag impacting performance?

That's a very good question. The release notes say that they've been=20
changing how 'p4 diff -du' works, but the net effect of it all is that
it stats all files in the whole working set. For large projects, this
takes forever. We say pauses of 3 minutes per submit...

> And even if for display purposes, why might you wish not to see=20
> differences in whitespace changes?

That's a good point, but what alternative is there?

PKE
--=20
P=E5l-Kristian Engstad (engstad@naughtydog.com),=20
Lead Graphics & Engine Programmer,
Naughty Dog, Inc., 1601 Cloverfield Blvd, 6000 North,
Santa Monica, CA 90404, USA. Ph.: (310) 633-9112.

"Emacs would be a far better OS if it was shipped with=20
 a halfway-decent text editor." -- Slashdot, Dec 13. 2005.
