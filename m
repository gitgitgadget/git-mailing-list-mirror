From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: Re: [PATCH v4] git-send-pack: fix --all option when used with
 directory
Date: Fri, 1 Apr 2016 13:44:41 +0300
Message-ID: <56FE5119.5000502@assembla.com>
References: <1459432509-12934-1-git-send-email-stanislav@assembla.com>
 <xmqq1t6qmlxk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, dborowitz@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 12:44:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alwZN-00045K-5f
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbcDAKop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:44:45 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38577 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbcDAKoo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:44:44 -0400
Received: by mail-wm0-f49.google.com with SMTP id 20so17812223wmh.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xF8IDzNgPHPjF7fWcjeMe9zHxCcJK5U2TEGLw+JfnsM=;
        b=LnsfK+oURYelRSiiX0TIr8ru/r67Dpa+BHRmuRVeKVMSfwV0dXYUesMEPsTiFT+V1C
         vX6OGPDigxGlW6v4nMThfy0D02DQopKjt8L/m9iX3RWV/Dj1sAT44gH8RfzNzKGs8BAh
         +nLaOT4JfVRk7DtWVpwNOB1NyWSg6wV3irrY1udIX2kInP368G+0N99FUk8eJlr4YtRd
         /pS6qO2i5BLW0p/xi/SH+FcPDnxFBu8/g9wsoosM7VF+CqLu2aJhyp5ADCDVREY65uzI
         PTW3JkHTcALaDIMpAl8UKJKepmaaPRk/+BN4q31dilzoIO915s47q6SjoWCmsGzGRMEd
         HdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xF8IDzNgPHPjF7fWcjeMe9zHxCcJK5U2TEGLw+JfnsM=;
        b=PXfoYIOA8XBFj8R1L3mjpihJJTURaRFwPyz5AFpd9ANWE2ORz/Abafn8mm3zoILlPL
         kRaMOzKgUqnhbCT2JiVIgxsK6vex7sGVwm8+I1pxkzTDBYdKECk2bmLWk6VlXJAMPs+Y
         5wUfShH7tQ6tX1GdrA/2/YuY6wGAhYBJL4+24hJcB2XKCrsAD82zv3ZhFD2Vx9b60Ozs
         Qq7QBY7V68xKyXt4yLVSEhJI3ebQ/mwMpu8alObG6FljvdQr3v3uSjCWbJ1GclXrPbJZ
         HZCMc6p9MAAObpE46TCx6uWfyYlkHYtmdZrH9PdGe21mRE6YOt469Ol4eDHBoqtr3ceA
         22Iw==
X-Gm-Message-State: AD7BkJIN820nm2bX8AOs1UFrXWTyPKovT8HcrclhppcoOFZHuN/cx21VNM9Ky7aT/3qlcw==
X-Received: by 10.194.216.40 with SMTP id on8mr4505750wjc.40.1459507483426;
        Fri, 01 Apr 2016 03:44:43 -0700 (PDT)
Received: from [192.168.88.127] ([217.26.172.139])
        by smtp.googlemail.com with ESMTPSA id u145sm1344234wmu.17.2016.04.01.03.44.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2016 03:44:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqq1t6qmlxk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290519>

On 31/03/16 23:28, Junio C Hamano wrote:
> Thanks, will queue. 

Thanks a lot!

--
Regards,
Stanislav
