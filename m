From: tolga ceylan <tolga.ceylan@gmail.com>
Subject: Re: [PATCH] git-p4: format-patch to diff-tree change breaks binary
 patches
Date: Sat, 26 Apr 2014 14:31:33 -0700
Message-ID: <535C25B5.4050506@gmail.com>
References: <20140425044618.GA7058@olive> <20140426124307.GB4767@padd.com> <535C2138.3050400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cdleonard@gmail.com
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 23:31:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeACC-0006jZ-1q
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 23:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbaDZVbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 17:31:35 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:63549 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbaDZVbf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 17:31:35 -0400
Received: by mail-pa0-f51.google.com with SMTP id fb1so3753578pad.38
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 14:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2Z0ngLB3P5Eu18N/GIcKQ+waFQXtVzNGGz7rm+omYII=;
        b=pQ5axl45Bv1jtOSbiiuuK0C6ivkzwP8VOGMwtO/CcmPYmBWfmpscisK8oe3Xhdk5CY
         sqA651VSHcoHEgXPVu8F098pA8WXQ+cBo3YewD3ytXjMs+vKzeN/1j1XfRb65XHtJVy2
         NrgHq2sAGJsqFf24ExDjHZNYqYkNxOHt/XzIHh/+DEJ1KDOUZEy4g5faNTAjSmJp1Gdo
         m5BH6V3HZsmPFrjFa90hdacm3KwPCaQ859cvOK2XuMO9ftmKrfRKiDK6kxHdilN9WZLQ
         wFzMFXJcgwnVsrVzPh60oXDRNkhi1dx773KRu41nyT5Q06LJijmfwiiNpcU+lt8jYpEc
         EdfQ==
X-Received: by 10.68.248.7 with SMTP id yi7mr16289659pbc.31.1398547894805;
        Sat, 26 Apr 2014 14:31:34 -0700 (PDT)
Received: from [192.168.1.100] (c-98-210-144-148.hsd1.ca.comcast.net. [98.210.144.148])
        by mx.google.com with ESMTPSA id cz3sm24678755pbc.9.2014.04.26.14.31.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Apr 2014 14:31:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <535C2138.3050400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247186>



On 04/26/2014 02:12 PM, tolga ceylan wrote:
> Yes, when git-p4 runs git-apply to test the patch, this fails
> due to abbreviated blob object names. I think git-apply requires
> full object names for binary patches.
>
>> This looks like a straightforward change, but can you give a
>> bit more background on why a full index is required?  Do you
>> mean that "git apply" will reject a patch with abbreviated
>> blob object names?
>>
>>         -- Pete
>>

This is the error message git-apply emits in this case:

error: cannot apply binary patch to '<filename>' without full index line
error: <filename>: patch does not apply

Cheers,
Tolga
