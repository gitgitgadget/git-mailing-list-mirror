From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Mon, 13 May 2013 17:26:14 +0300
Message-ID: <5190F806.6040207@bracey.fi>
References: <cover.1368274689.git.john@keeping.me.uk> <518FB8DE.7070004@bracey.fi> <20130512162823.GK2299@serenity.lan> <20130512163317.GL2299@serenity.lan> <518FCDDE.9040707@bracey.fi> <7vwqr3u9c5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:26:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubtht-00049B-6m
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab3EMO0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:26:25 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:56080 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752065Ab3EMO0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:26:24 -0400
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id D0E92FFA9F9
	for <git@vger.kernel.org>; Mon, 13 May 2013 16:26:20 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 13 May 2013 16:26:38 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 13 May 2013 16:26:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
In-Reply-To: <7vwqr3u9c5.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 17878164622200115416
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224152>

On 13/05/2013 01:22, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>>     git log --ancestry-path --left-right E...F --not $(git merge-base
>> --all E F)
>>
>> which looks like we're having to repeat ourselves because it's not
>> paying attention...
> You are half wrong; "--left-right" is about "do we show the </>/=
> marker in the output?", so it is true that it does not make sense
> without "...", but the reverse is not true: A...B does not and
> should not imply --left-right.
>
The repetition I meant is that by the definition of ancestry-path, the 
above would seem to be equivalent to

   git log --ancestry-path --left-right E F --not $(git merge-base --all E F) $(git merge-base --all E F)

Anyway, revised separated-out version of the patch follows.

Kevin
