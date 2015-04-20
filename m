From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v4] git-p4: Use -m when running p4 changes
Date: Mon, 20 Apr 2015 20:17:21 +0100
Message-ID: <553550C1.2030807@diamand.org>
References: <CALM2SnY4GZDSYOjLmDqdq9SgGGywRO2A3XU3639E_0JAh-2P5A@mail.gmail.com>	<1429542020-11121-1-git-send-email-lex@lexspoon.org>	<CAE5ih79BLm1LbZersZeOxShq=W4X5xaPHE1cDwctA5cJOSLRJA@mail.gmail.com> <CALM2Snaih=r_CAACVodbgZiLqSUvJr_yPXsipEdR2WZs+utaZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:17:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkHCc-0006l8-7W
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 21:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbDTTRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 15:17:50 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34891 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbDTTRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 15:17:49 -0400
Received: by widdi4 with SMTP id di4so111980956wid.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dry1yZy2808LUrhN5ZvUqUjp3TnjqwNLT6ydF4oR/IY=;
        b=EjQYpyKphgb6cL2yK8Uang66wbZHTrq2/155ov5pziJlPazMMi/ugTtfz7P8EcVLlC
         /1NBSoTUzqH9TSva8KpY4+ikDHaC5LsNwHprDB27x2sd+Ac1M4Sj1wW9N80u1QaX/3vo
         q3SsXiNvv71HkrhS6nD988krWiAgTilgJE6OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dry1yZy2808LUrhN5ZvUqUjp3TnjqwNLT6ydF4oR/IY=;
        b=CmAWBoE0KKUox3uq6GJlw5oxIFEqJT7ETYa42cdv8qp+0VIFZrXMvQjbEUraOF1BBv
         c++lyP3jawAqrbqMhlXCrEKxiSU3q6/E+to8S+fkq9mv2UWEJiA/mS3gRpF/uV2gD4cA
         VbEIVnpr9LzeQ40TbiFVjzgHVqwvkMqBvOlrnMK0ssJH3a/MvE8HpKbCKRKGGJ0Yptln
         6ry0RKfOwsP8sJMzOV4MQIwSRxxBAkSitnOy4d3JBq3GGxVGD3mgSmCcqnw96AmP0+7P
         K6SteiZ01DwZKyunXDNnakxf7/Oa+25g9RUHC2w/5h57RATa7D5mj2SJiFiri66LO9OI
         PN7w==
X-Gm-Message-State: ALoCoQnkvu+6uxQrUNU4NOcrsWSe5YnWoLrqx6rGt6HWv623MRh3+jAivRAPsUUCdaAlLRTDOy4Y
X-Received: by 10.194.47.231 with SMTP id g7mr33194505wjn.140.1429557465811;
        Mon, 20 Apr 2015 12:17:45 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id ew10sm16489878wic.22.2015.04.20.12.17.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 12:17:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <CALM2Snaih=r_CAACVodbgZiLqSUvJr_yPXsipEdR2WZs+utaZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267489>

On 20/04/15 16:25, Lex Spoon wrote:
> On Mon, Apr 20, 2015 at 11:15 AM, Luke Diamand <luke@diamand.org> wrote:
>> Sorry - could you resubmit your patch (PATCHv4 it will be) with this
>> change squashed in please? It will make life much easier, especially
>> for Junio!
>
> The message you just responded is already the squashed version. It's a
> single patch that includes all changes so far discussed. The subject
> line says "PATCH v4", although since it's in the same thread, not all
> email clients will show the subject change.

Not sure how I missed that! It looks good, now, Ack!

Thanks!
Luke
