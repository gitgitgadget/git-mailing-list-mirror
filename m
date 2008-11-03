From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH 4/4] Add support for 'namespace' history simplification
Date: Mon, 3 Nov 2008 23:34:19 +0100
Message-ID: <adf1fd3d0811031434w5a74c978q5fbf573288bd9c5a@mail.gmail.com>
References: <200811031439.12111.brian.foster@innova-card.com>
	 <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811031133590.3419@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811031135410.3419@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org>
	 <adf1fd3d0811031345j4582e109jaf95aede0f33eff7@mail.gmail.com>
	 <alpine.LFD.2.00.0811031358460.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Brian Foster" <brian.foster@innova-card.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:37:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx82P-0007qS-C2
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 23:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbYKCWea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 17:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbYKCWe3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:34:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:57750 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbYKCWeW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 17:34:22 -0500
Received: by ug-out-1314.google.com with SMTP id 39so59700ugf.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 14:34:20 -0800 (PST)
Received: by 10.103.243.9 with SMTP id v9mr317402mur.44.1225751659945;
        Mon, 03 Nov 2008 14:34:19 -0800 (PST)
Received: by 10.103.179.20 with HTTP; Mon, 3 Nov 2008 14:34:19 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811031358460.3419@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100006>

On Mon, Nov 3, 2008 at 11:05 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 3 Nov 2008, Santi B=E9jar wrote:
>>
>> I tried it once, but I had problems simplifying the merges, and it i=
s trivial...
>
> It depends on the new --simplify-merges code which does that.
>
>> Not that it matters a lot, but if you try it on master you get some
>> extra merges without a ref like:
>>
>> 373a273 (Merge git-gui 0.11.0, 2008-08-17)
>
> Umm? Your point is?
>
> That merge itself doesn't have a ref, but it's required becase there =
are
> refs along both legs of the merge - one side has the "gitgui-0.11.0" =
tag,
> while the other has (for example) v16.0-rc3.
>
>> f44bc33 (Sync with 1.5.6.5, 2008-08-06)
>
> Again, the merge doesn't have a ref, but it's needed because there ar=
e
> refs on both parents (v1.5.6.5 vs v1.6.0-rc[01]).
>
> So no, --simplify-namespace in no way guarantees that all resulting
> commits will have refs pointing to them, because it also needs to ret=
urn
> enough of the merges to make it a real and meaningful DAG.

I thought of it as "for each ref rewrite its parents to the
independent set of refs that are ancestors". So in the case of 373a273
(Merge git-gui 0.11.0, 2008-08-17), its parents (gitgui-0.11.0 and
v1.6.0-rc3) would be the parents of ea02eef (GIT 1.6.0, 2008-08-17).

Santi
