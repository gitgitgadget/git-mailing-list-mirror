From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-log --cherry-pick gives different results when using tag
 or tag^{}
Date: Wed, 15 Jan 2014 10:59:53 +0100
Message-ID: <52D65C19.2000209@gmail.com>
References: <52CFF27C.1090108@gmail.com> <20140115094945.GD14335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 10:59:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3NFd-0003uP-OE
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 10:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbaAOJ7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 04:59:04 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:37832 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaAOJ7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 04:59:00 -0500
Received: by mail-wg0-f50.google.com with SMTP id l18so1497562wgh.17
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 01:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=aDi4XY7RYtfjp2JFfaTYa47MsFV2sp+45tAe0JADOAw=;
        b=GM8dl/aZN+yQwNgBmXn+9t8HF02xfzPc7Wl8qOLfKGrV7tO2EBeacvbpUeIZtN4xI2
         jgP1JdZJ9jK8glORdFcmFgKXEvp6JUIHu8nIr+ykV3M1HZYAaaiyKGEkPDwuhX92nadN
         EBlgH/mSvNX5qIM/d5Twuvhx0mw0u6YOzT60rKB/hcyIWMQQprNM4KAc+4lSYuuVzzag
         p56X9vmUn8Rcpwdf/jJdfxsPwDboQbCuesUFHMcygbWlHzlWBx3cFzGqblOhdPUxmbGl
         kWIMTgiVBtu5NVz3576UKHiBb1kBKCJAt+AmRSMWnaRY9rnOjqeEdXq7ybPG2uAS3X/b
         R+Tw==
X-Received: by 10.180.211.141 with SMTP id nc13mr1205416wic.47.1389779939049;
        Wed, 15 Jan 2014 01:58:59 -0800 (PST)
Received: from [192.168.7.30] (au213-1-82-235-205-153.fbx.proxad.net. [82.235.205.153])
        by mx.google.com with ESMTPSA id ot9sm2793384wjc.0.2014.01.15.01.58.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 01:58:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140115094945.GD14335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240448>

On 01/15/2014 10:49 AM, Jeff King wrote:
> [+cc Junio, as the bug blames to him]
> 
> On Fri, Jan 10, 2014 at 02:15:40PM +0100, Francis Moreau wrote:
> 
>> In mykernel repository, I'm having 2 different behaviours with git-log
>> but I don't understand why:
>>
>> Doing:
>>
>>     $ git log --oneline --cherry-pick --left-right v3.4.71-1^{}...next
>>
>> and
>>
>>     $ git log --oneline --cherry-pick --left-right v3.4.71-1...next
>>
>> give something different (where v3.4.71-1 is a tag).
>>
>> The command using ^{} looks the one that gives correct result I think.
> 
> Yeah, this looks like a bug. Here's a simple reproduction recipe:

Thanks a lot Jeff for your good analyze.
