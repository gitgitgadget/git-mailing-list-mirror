From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 3/7] add a test for semantic errors in config files
Date: Thu, 24 Jul 2014 19:26:07 +0530
Message-ID: <53D11077.10907@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>	<1406140978-9472-4-git-send-email-tanayabh@gmail.com>	<vpq38drvohr.fsf@anie.imag.fr> <xmqq38drd8ue.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 15:56:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAJVK-00060C-Je
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 15:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759004AbaGXN4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 09:56:14 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36230 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758894AbaGXN4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 09:56:13 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so3757521pde.9
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yM7MCiwYNmJ5j8x+Yt1YgeDwwVWljywqB3uCDrLqe6I=;
        b=ViD3X5OWYK1ZcC4FGlRpAiaZYpn4Kzm2R9fVaaMv95eTIbDL7pii2lVA6ZUJGXsrGr
         xiyrNd32GZf3opSF36krdVOZ302zBKK2wO8nb/Hkejd+C/YnQKofoNVs4ughHK29h+nd
         btMJUpP1xvfpKWLzezJTSfrXrmj5XR+X2C6CddY+jxzCuw3vgst0DMkMls0JraQ40d/3
         sQKv/ihuFR/6DxkdNb/4WkPOyyehkJdD2pg0/WCwhEcbUF18PFeNNJz0wijGPb6tOnU0
         raSWwjke/zJYKE02EQGXlrLfI2WL7oz67J9mFTO5W/XNMf/VBFdAZtA7qka0SUwBiIV3
         zOWQ==
X-Received: by 10.68.134.98 with SMTP id pj2mr10597237pbb.98.1406210172800;
        Thu, 24 Jul 2014 06:56:12 -0700 (PDT)
Received: from [127.0.0.1] ([117.96.50.136])
        by mx.google.com with ESMTPSA id xq3sm21079936pab.0.2014.07.24.06.56.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 06:56:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq38drd8ue.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254157>



On 7/24/2014 3:41 AM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> +test_expect_success 'check line errors for malformed values' '
>>> +	cp .git/config .git/config.old &&
> 
> Should this be "mv" not "cp"?  You will be overwriting the file from
> scratch in the later part of this test.
>

Noted.

>>> +	test_when_finished "mv .git/config.old .git/config" &&
>>> +	echo "[alias]\n br" >.git/config &&
> 
> Is the use of \n portable?
> 

Yes, you are right, will replace with printf in the next patch.
