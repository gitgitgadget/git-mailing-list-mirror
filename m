From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH 4/4] diff: mark any file larger than core.bigfilethreshold
 binary
Date: Mon, 23 Jun 2014 21:21:12 +0200
Message-ID: <53A87E28.8050903@virtuell-zuhause.de>
References: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com> <1401368227-14469-1-git-send-email-pclouds@gmail.com> <1401368227-14469-4-git-send-email-pclouds@gmail.com> <1403180845.10052.16.camel@thomas-debian-x64> <CACsJy8A5StEv4O64rnd39+1jMNWiaAv4oOd0+Yko_JPuk6EYZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Dale R. Worley" <worley@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 21:21:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz9nu-0003KC-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 21:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbaFWTVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 15:21:18 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:55069 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754652AbaFWTVR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2014 15:21:17 -0400
Received: from p5ddc21d8.dip0.t-ipconnect.de ([93.220.33.216] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1Wz9nk-00089a-VR; Mon, 23 Jun 2014 21:21:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8A5StEv4O64rnd39+1jMNWiaAv4oOd0+Yko_JPuk6EYZw@mail.gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1403551277;d88064d9;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252366>

Am 23.06.2014 14:18, schrieb Duy Nguyen:
> On Thu, Jun 19, 2014 at 7:27 PM, Thomas Braun
> <thomas.braun@virtuell-zuhause.de> wrote:
>>> @@ -2721,6 +2721,11 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>>>               }
>>>               if (size_only)
>>>                       return 0;
>>> +             if ((flags & DIFF_POPULATE_IS_BINARY) &&
>>> +                 s->size > big_file_threshold && s->is_binary == -1) {
>>> +                     s->is_binary = 1;
>>> +                     return 0;
>>> +             }
>>
>> Why do you check for s->is_binary == -1 here? I think it does not matter
>> what s_is_binary says here.
> 
> If some .gitattributes to mark one file not-binary, we should respect
> that, I think. Same for below too.

Reading diffcore.h I thought is_binary being -1 means it is not yet
decided if it is binary or text.
Respecting .gitattributes is obviously a good thing :)
