From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v15 02/16] path.c: refactor relative_path(), not only
 strip prefix
Date: Thu, 27 Jun 2013 11:31:35 +0800
Message-ID: <CANYiYbHi=TTuV63SN44YK-vx2+0Vy8c+cHB4z874ouSfmeaAng@mail.gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
	<31fc3821962b83e79cd8f59127c8c11ba1551073.1372175282.git.worldhello.net@gmail.com>
	<7v7ghgwyup.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 05:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us2vs-0001fA-R4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 05:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab3F0Dbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 23:31:37 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:38739 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3F0Dbg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 23:31:36 -0400
Received: by mail-we0-f172.google.com with SMTP id q56so153906wes.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vTAeyVybAGsV9eW2QMPTn3L3YJdV9wpW6s18/5uXReI=;
        b=trISchBaquQ3Fm9Z2hmwN7nEEJyed+2cbZ0uIR6iGOhtGsgSyGz35qPHE5EsgT5URW
         esT17LvhfMJiTmGo4LrA6I1zxs4pf50J6vPSMM58dVPGw+WwtFrNLBNPNoZqB+eEs1Y0
         rlkZGwt8H0pRDcYGiDF5wFtSR+m7uejk+bd/zp1d6jgWp0mdV7X6OaRfOUVg8k0jvQji
         5uxGDNwXJniR3YgjcJV0uEVbcGn1XZRzDQ/NnsjOwoqNSUXNrkUV/Thj/XAQF6MSr7US
         OshdA0QoXqqipM9iq8CZ4QT7xzE6PLbruci+FGVXgYNyZ+eUqlOqHM4PNCVk6A8wO26B
         PboQ==
X-Received: by 10.194.133.106 with SMTP id pb10mr4749462wjb.62.1372303895343;
 Wed, 26 Jun 2013 20:31:35 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Wed, 26 Jun 2013 20:31:35 -0700 (PDT)
In-Reply-To: <7v7ghgwyup.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229085>

2013/6/27 Junio C Hamano <gitster@pobox.com>:
>> +             } else {
>> +                     i++;
>> +                     j++;
>> +             }
>> +     }
>> +
>> +     if (
>> +         /* "prefix" seems like prefix of "in" */
>> +         i >= prefix_len &&
>
> So shouldn't this be "i == prefix_len"?
>
>> +         /*
>> +          * but "/foo" is not a prefix of "/foobar"
>> +          * (i.e. prefix not end with '/')
>> +          */
>> +         prefix_off < prefix_len) {
>> +             if (j >= in_len) {
>
> Again, "j == in_len", isn't it?  Or can i and j overrun in_len and
> prefix_len?

Yes, better write as ==. But both will pass the test cases.
Since this commit has been merged to next, so let it be?


-- 
Jiang Xin
