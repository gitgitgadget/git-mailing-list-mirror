From: Miles Bader <miles@gnu.org>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 09 May 2011 13:36:16 +0900
Message-ID: <buozkmw5w3j.fsf@dhlpc061.dev.necel.com>
References: <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com> <4DB82D90.6060200@op5.se>
 <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net>
 <7vwrif5q93.fsf@alter.siamese.dyndns.org> <20110427220748.GA19578@elie>
 <7vsjt35l84.fsf@alter.siamese.dyndns.org> <20110427234224.GA26854@elie>
 <7viptz5j82.fsf@alter.siamese.dyndns.org>
 <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
 <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
 <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
 <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com> <4DB9329E.7000703@op5.se>
 <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 06:36:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJICw-0004ft-Jh
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 06:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab1EIEgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 00:36:19 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:62110 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1EIEgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 00:36:18 -0400
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LKW00LMAVGGCPC0@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Mon, 09 May 2011 13:36:17 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LKW00J6IVGG6X00@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Mon, 09 May 2011 13:36:16 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id AB91848087; Mon, 09 May 2011 13:36:16 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id A66AD4807B; Mon,
 09 May 2011 13:36:16 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id PAH15736; Mon,
 09 May 2011 13:36:16 +0900
X-IronPort-AV: E=Sophos;i="4.64,338,1301842800";   d="scan'208";a="25562724"
Received: from unknown (HELO relay11.aps.necel.com) ([10.29.19.46])
 by relmlii1.idc.renesas.com with ESMTP; Mon, 09 May 2011 13:36:16 +0900
Received: from relay11.aps.necel.com ([10.29.19.46] [10.29.19.46])
 by relay11.aps.necel.com with ESMTP; Mon, 09 May 2011 13:36:16 +0900
Received: from dhlpc061 ([10.114.97.64] [10.114.97.64])
 by relay11.aps.necel.com with ESMTP; Mon, 09 May 2011 13:36:16 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 52FA552E1DE; Mon,
 09 May 2011 13:36:16 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7vhb986chl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173192>

Junio C Hamano <gitster@pobox.com> writes:
> Do you or do you not run "apt-get install git-superadd"?
>
> One possible answer may be to run "apt-get install git-superadd", and then
> the users who want "git add" to behave in a new way to opt-in to use the
> "plug-in".  I think that is what Jon is getting at.

If aliases could override built-in command names, it'd be easy enough
("alias add=superadd") ... [with some feature to allow suppressing the
alias to prevent recursion, e.g. an environment variable or something.]

-Miles

-- 
Justice, n. A commodity which in a more or less adulterated condition the
State sells to the citizen as a reward for his allegiance, taxes and personal
service.
