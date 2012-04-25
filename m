From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 03/10] i18n: mark relative dates for translation
Date: Wed, 25 Apr 2012 13:07:16 +0200
Message-ID: <4F97DAE4.4070706@viscovery.net>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com> <1335184230-8870-4-git-send-email-pclouds@gmail.com> <xmqqd36wgam5.fsf@junio.mtv.corp.google.com> <CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 13:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN04F-0006j4-B6
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 13:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296Ab2DYLHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 07:07:22 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46534 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758172Ab2DYLHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 07:07:22 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SN045-0003RS-IL; Wed, 25 Apr 2012 13:07:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1A2FC1660F;
	Wed, 25 Apr 2012 13:07:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196306>

Am 4/25/2012 12:46, schrieb Nguyen Thai Ngoc Duy:
> 2012/4/25 Junio C Hamano <gitster@pobox.com>:
>>>       /* Give years and months for 5 years or so */
>>>       if (diff < 1825) {
>>> ...
>>>       }
>>>       /* Otherwise, just years. Centuries is probably overkill. */
>>> -     snprintf(timebuf, timebuf_size, "%lu years ago", (diff + 183) / 365);
>>> -     return timebuf;
>>> +     strbuf_addf(timebuf,
>>> +              Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
>>> +              (diff + 183) / 365);
>>>  }
>>
>> This is just a tangent, but could we possibly come here and say "1 year
>> ago"?
> 
> Nice catch. Singular form here is unnecessary. If you plan to revert
> that, please put a comment so nobody will attempt to convert it to
> Q_() again next time while searching for possible candidates.

I am sure that there are languages (Russian? Polish?) where a variation is
needed not only for the singular, but also for plural depending on the
number, so we still want to have this wrapped in Q_().

-- Hannes
