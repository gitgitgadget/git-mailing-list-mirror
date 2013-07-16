From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v5 4/5] config: improve support for http.<url>.* settings
Date: Tue, 16 Jul 2013 02:53:38 -0700
Message-ID: <4D163C69-2228-4895-AE47-377A5A71FD5E@gmail.com>
References: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79> <dcbaa11c8595f48814aa39a75ad18ea@f74d39fa044aa309eaea14b9f57fe79> <CAPig+cQTNXgPyD4qiQPyQeSHWY0Y=_Qnd2i9LfVqQDA1DJNDxg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 11:53:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz1x5-0004Ag-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 11:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab3GPJxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 05:53:44 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33705 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab3GPJxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 05:53:43 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so504024pdd.6
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=V66iFDHttKe1t8nUBkBQ+LMQDapRcvGbR/KL2hUC4k4=;
        b=XPVmct92rKpGXXptT2zLLh4mrCiubIrVF3TVYSJn3Gi3VGffV0iHQ5ChT2+mo0TF8X
         rFrB8oB2VGASU5KPybhVGXbWTgenE+7ByUdwnlqVyxdup29UGDDddXsf2SkPvRo+7hv3
         jF0FWfko3wNnW55nM1iLnNRoiChIlIkKXNbdjSWCuWKhWfSHfReONbR2gD+N6JXFBLx3
         GEO34DvBfunyS35OKzJGJ7yJlPw3hL0sU5p54hCskCYdwCWd0C9EDkkqKhVmrhGpRGoi
         lWwQmqOUq6PrXEg/Mgo60mtrC24M8O3r910Lgs9Mm5UirLraSvU2n9+ALzLoGnYvw3HU
         GmDw==
X-Received: by 10.68.170.37 with SMTP id aj5mr736728pbc.79.1373968422673;
        Tue, 16 Jul 2013 02:53:42 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id zv11sm3421170pab.3.2013.07.16.02.53.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 02:53:41 -0700 (PDT)
In-Reply-To: <CAPig+cQTNXgPyD4qiQPyQeSHWY0Y=_Qnd2i9LfVqQDA1DJNDxg@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230558>

On Jul 15, 2013, at 16:12, Eric Sunshine wrote:
> On Mon, Jul 15, 2013 at 5:51 AM, Kyle J. McKay <mackyle@gmail.com>  
> wrote:
>> +static int append_normalized_escapes(struct strbuf *buf,
>> +                                    const char *from,
>> +                                    size_t from_len,
>> +                                    const char *esc_extra,
>> +                                    const char *esc_ok)
>> +{
>> +       /*
>> +        * Append to strbuf buf characters from string from with  
>> length from_len
>
> s/from string from/from string/

Hmmm.  Actually it's meant to say "from string <parameter with name  
from>".

Do quotes make it read better:

   from string `from'

Or do you think it needs to be:

   from string parameter `from'
