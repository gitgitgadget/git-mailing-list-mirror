From: =?UTF-8?B?IkFuZHLDqXMgRy4gQXJhZ29uZXNlcyI=?= <knocte@gmail.com>
Subject: Re: [PATCHv3] transport: Catch non positive --depth option value
Date: Tue, 26 Nov 2013 00:34:43 +0100
Message-ID: <5293DE93.3020008@gmail.com>
References: <5283A380.9030308@gmail.com> <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com> <528A9877.4060802@gmail.com> <xmqq61ro9utf.fsf@gitster.dls.corp.google.com> <528E2660.6020107@gmail.com> <xmqq1u294ih3.fsf@gitster.dls.corp.google.com> <CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 00:34:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl5g8-0003VS-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 00:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab3KYXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 18:34:53 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:39513 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab3KYXew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 18:34:52 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so4820958wib.2
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 15:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gb5Ute9meXO5ATpNJCkUm5Ro0kT+jSC8N7+gTlJRyNM=;
        b=s6jer3LtOtE+/c89E5TlqCVRvOQCr0nhzDGq5GIetVWTV63YlYO9MhsMjpaoMr+dJ3
         14LGA/YFeftOV7LzpY+05erZatJhfkmlxuCnnEUHOTAnV0zJlaNaXXL30tkIJ4HyeRDC
         nHTAXIz0LO+iLyVgTy+ryBfX1pR+BJqPsSngekCWscAKYibWAITNBuDO+As+8g3sJROk
         01o1I/H21bF84pI3ytNJYLAhubTMipxqbPJR2apX9D3dGxTQhKIUD3+/H3gXcol81Sjr
         4dDqG1NJZyP4rgxUaigq7NVkHj0WiWUNM5CCJyIIKxxk9Oq5cx1kY3ZUYI1Bd3wCgZNf
         Qf/Q==
X-Received: by 10.180.198.170 with SMTP id jd10mr15631540wic.65.1385422491257;
        Mon, 25 Nov 2013 15:34:51 -0800 (PST)
Received: from [192.168.0.157] (7.Red-88-19-107.staticIP.rima-tde.net. [88.19.107.7])
        by mx.google.com with ESMTPSA id qc10sm54924795wic.9.2013.11.25.15.34.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 15:34:50 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238364>

On 22/11/13 02:18, Duy Nguyen wrote:
> On Fri, Nov 22, 2013 at 3:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Have you run the tests with this patch?  It seems that it breaks
>> quite a lot of them, including t5500, t5503, t5510, among others.
> 
> I guess it's caused by builtin/fetch.c:backfill_tags(). And the call
> could be replaced with
> 
> transport_set_option(transport, TRANS_OPT_DEPTH, NULL);
> 

Not sure what you mean,
https://github.com/git/git/blob/master/t/t5550-http-fetch.sh doesn't
call backfill_tags. What do you mean?

Thanks
