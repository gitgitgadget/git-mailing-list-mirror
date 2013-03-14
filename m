From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v3 3/3] git-merge-one-file: revise merge error reporting
Date: Thu, 14 Mar 2013 19:39:28 +0200
Message-ID: <51420B50.2030600@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi> <1363137142-18606-1-git-send-email-kevin@bracey.fi> <1363137142-18606-3-git-send-email-kevin@bracey.fi> <7vehfj2neh.fsf@alter.siamese.dyndns.org> <51416DD5.2030805@bracey.fi> <7vr4jiyqrj.fsf@alter.siamese.dyndns.org> <5142097B.1080105@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"David Aguilar <davvid@gmail.com>l Antoine Pelisse" 
	<apelisse@gmail.com>, Ciaran Jessup <ciaranj@gmail.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 18:40:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGC8N-0000H6-EB
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 18:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079Ab3CNRjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 13:39:40 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:43374 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755257Ab3CNRjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 13:39:40 -0400
Received: from mail406.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 018DADC34F3
	for <git@vger.kernel.org>; Thu, 14 Mar 2013 18:50:50 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 14 Mar 2013 19:40:23 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 14 Mar 2013 19:40:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <5142097B.1080105@bracey.fi>
X-Ovh-Tracer-Id: 830069708018716888
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrgeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrgeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218158>

On 14/03/2013 19:31, Kevin Bracey wrote:
> On 14/03/2013 16:56, Junio C Hamano wrote:
>>
> Well, yes, but I would assume that we would forcibly select normal 
> diff here somehow, if we aren't already. We should be - turning 
> ABCDEFGH vs ABCD into ABCD<EFGH|EFGH=> is silly.

Doh. But anyway, we don't want to waste space with |= markers, and make 
the same "surrounding code is in the base" suggestion. So we should be 
selecting diff.

Kevin
