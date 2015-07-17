From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix detection of uname failure
Date: Fri, 17 Jul 2015 14:39:56 -0700
Message-ID: <xmqq7fpy1n0z.fsf@gitster.dls.corp.google.com>
References: <ef7d56584c3b5d6431f895df1d94eba8@www.dscho.org>
	<1437152981-28855-1-git-send-email-charles@hashpling.org>
	<7cf6757e8e81c2f9e102db24efbedb2a@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:40:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGDMR-0001fx-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 23:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbbGQVj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 17:39:59 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36653 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbGQVj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 17:39:58 -0400
Received: by pachj5 with SMTP id hj5so67013441pac.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/8LMJakBMBTJ8nCqvWW9zMA0VyKY3TIPF3sUV9JHl7w=;
        b=ZaeSVFHHi25vRbVePtOAieAKZuVs1fr3kmmQ5EdJf/t4lMDi3Rm1ogB9wNxhqNPN76
         RNTAAOOKHkTObJBYOc9q4PUVJP7/2C+lnXcQaiObFRsFwEQ/JhoiJ3XAprJVTxa+hZs7
         nALg/AG957dnuSjM6p5wZtoQRVOzwraY0t2nvmRxbaMUZgXPRe6lCWyv60DL2qrkZQSO
         Q/pGB0DxC4e1ua78ReD5qwxhDjQEkB3qSLlHRlW+Ckl4FMNu3cy7wmD5ILqT8VOa7X81
         IATGXdA6qhBMz4rR3NpkTygh7iIQyT7o6ZQFA4idwCeuKIpefvZH5mntxo3l4TUvUtep
         WtBQ==
X-Received: by 10.66.66.173 with SMTP id g13mr33907171pat.155.1437169198138;
        Fri, 17 Jul 2015 14:39:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id da2sm12245183pbb.57.2015.07.17.14.39.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 14:39:57 -0700 (PDT)
In-Reply-To: <7cf6757e8e81c2f9e102db24efbedb2a@www.dscho.org> (Johannes
	Schindelin's message of "Fri, 17 Jul 2015 23:07:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274107>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On 2015-07-17 19:09, Charles Bailey wrote:
>> From: Charles Bailey <cbailey32@bloomberg.net>
>> 
>> According to POSIX specification uname must return -1 on failure and a
>> non-negative value on success. Although many implementations do return 0
>> on success it is valid to return any positive value for success.  In
>> particular, Solaris returns 1.
>> 
>> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I'd s/Ack/Review/; as the original is not your code but you are well
qualified (and have my trust) to judge the change to this codepath
;-)

Thanks.
