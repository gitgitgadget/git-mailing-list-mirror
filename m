From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCHv2] Do not autosquash in case of an implied interactive
 rebase
Date: Mon, 28 May 2012 11:17:03 +0200
Message-ID: <4FC3428F.4060202@lyx.org>
References: <1337867575-7212-1-git-send-email-vfr@lyx.org> <1337867846-5336-1-git-send-email-vfr@lyx.org> <7vehq8tajh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 28 11:17:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYw4o-0002YG-Ho
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 11:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab2E1JRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 05:17:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53166 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab2E1JRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 05:17:07 -0400
Received: by eaak11 with SMTP id k11so633496eaa.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 02:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=K2qZMZCSFUY/wpBGDA90i5hLcJebLj3XYuFMNC2e0NE=;
        b=eTOrw83ARrpGOodmVJICu42ifeOG2V0a40FeHK5RUzXgYKM2kqVD3MZvfeP7lqxru4
         ESONnimBiojFOoCbmUGQAbh+bRAJkuA1lh010I3vcMArPJL3UiKWZa6xK+enpe28Zg4A
         mQH/g/2N20xmxiEfmHol960rUq2ufMlZgmU9T3rMxswOHx3Tv1vG0uZydPkmHE0+VKVy
         F6ifJXAnbkbYFo6s5vJnZauLYPRfyEB6RvTGSnxdlpw5crS18nGzYyQSOa0z+3tbPL9Z
         ubs8lYLkTG+JukQHYyYJ5Ca6YoNiY/Aeo8Y0eZlhV3O+z2HoZDr9LVdNbQO2QTIuBP9e
         C+PQ==
Received: by 10.14.22.16 with SMTP id s16mr1606479ees.184.1338196625561;
        Mon, 28 May 2012 02:17:05 -0700 (PDT)
Received: from [145.94.170.237] (wlan-145-94-170-237.wlan.tudelft.nl. [145.94.170.237])
        by mx.google.com with ESMTPS id z5sm34979641eem.3.2012.05.28.02.17.04
        (version=SSLv3 cipher=OTHER);
        Mon, 28 May 2012 02:17:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vehq8tajh.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQncH6sJA/EppIqAjWHZ9KP2KAvBd606eEOo6xkLaOPRCu/0L7jOFFCj83m+NlT7pvZZ40p4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198637>

Op 25-5-2012 19:50, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>> The option to autosquash is only used in case of an interactive rebase.
>> When merges are preserved, rebase uses an interactive rebase internally,
>> but in this case autosquash should still be disabled.
>>
>> Signed-off-by: Vincent van Ravesteijn<vfr@lyx.org>
> Hrm, what if the end user said "git rebase --autosquash -p" explicitly
> from the command line?

The option "--autosquash" is designed to have no effect whenever 
"--interactive" is not supplied.

This is what you also argue in another thread 
(http://permalink.gmane.org/gmane.comp.version-control.git/198579):

\"And that "I want rebase with --autosquash but I am not going to do any 
other editing" is where my suggestion to use "--no-edit" comes from.\"

Or did you mean that you want to imply "--interactive" when 
"--autosquash" is explicitly given ?

Vincent
