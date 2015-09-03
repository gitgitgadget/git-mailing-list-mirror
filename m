From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 2/4] git-p4: add gitConfigInt reader
Date: Thu, 03 Sep 2015 21:20:55 +0100
Message-ID: <55E8ABA7.7080207@diamand.org>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-3-git-send-email-larsxschneider@gmail.com> <55E8A647.90903@diamand.org> <FFEA6EC7-5663-4AE1-9E59-6AF89E731DB7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:20:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXb0E-0002bM-2E
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbbICUUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 16:20:54 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33050 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbbICUUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 16:20:53 -0400
Received: by wiclk2 with SMTP id lk2so2202836wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VGJye3E7GL6QQ7xIF1H6ReLUbjruzd2iypGIR/pr9u0=;
        b=B25zqTPhOzPSSPOIZa3MkFdkaq02gSDkAl46c+hiJhwPvp7xSvRN+F5ueGoe6yJcU3
         jVmQbif2YO0JaFUL18naqE4LTcH8FLjfjaDH07fJfpfiIToS2+6tt2mr61QiaaH0EFS/
         qTPdos/o87+OrTBnCVMko5c8wMaET+Jn6uTH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VGJye3E7GL6QQ7xIF1H6ReLUbjruzd2iypGIR/pr9u0=;
        b=CgZ0PZ6IzayC/QtDECB2hkii3uD8s7gWXk4pZBoMUtJxhkITD2hg5h0cC0ZRXYiQLe
         fWOf9GGf8SWc5k4PBx8JxiRhlLF1rZeCJVt7iEhOqNPSlctu7QmUDbvD6mG6AeC8QwQ5
         Ag6rQwzfih5WJkjgv1mnn+7yJJAI6/lH6WNeugg2wkQ7t5q4N1uJdxe+IhXKmOOiE3ac
         Q6KO+6fhdnx1ilotJOA9AIOEh7p8wRMoiFvwi3NO6r26F5ZIVwmsbH+gxHnWxVoAz10T
         PQNtiz/24/eMJgaS6xpeP140vq2IpdN0Xwx9iApD6i93VqbCOiJCdEieoagxxWjj39Nm
         4CGw==
X-Gm-Message-State: ALoCoQkOpz54TV/dWcqZrZS2kmG+aEPd/UOi3ue0JjOy0beR4B/GA503vdNaJMjCcm80yLrOt5B6
X-Received: by 10.180.39.136 with SMTP id p8mr1738563wik.92.1441311652500;
        Thu, 03 Sep 2015 13:20:52 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id en5sm38239wib.18.2015.09.03.13.20.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2015 13:20:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <FFEA6EC7-5663-4AE1-9E59-6AF89E731DB7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277255>

On 03/09/15 21:17, Lars Schneider wrote:
>
> On 03 Sep 2015, at 21:57, Luke Diamand <luke@diamand.org> wrote:
>
>> On 03/09/15 17:35, larsxschneider@gmail.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>
>> Explanation?
> Add a git config reader for integer variables. Please note that the git config implementation automatically supports k, m, and g suffixes.

Sorry, I should have been clearer. The commit needs a comment to say 
both what it's doing ("adding a git config int reader") and why.

c.f. Documentation/SubmittingChanges.

Luke
