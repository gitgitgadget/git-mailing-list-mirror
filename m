From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/WIP v3 1/4] for-each-ref: extract helper functions out
 of grab_single_ref()
Date: Fri, 29 May 2015 02:03:01 +0530
Message-ID: <55677B7D.3060209@gmail.com>
References: <5567527A.6090607@gmail.com>	<1432835025-13291-1-git-send-email-karthik.188@gmail.com> <vpqr3q0o3yr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 22:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4UK-00070G-AI
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbbE1UdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:33:08 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36418 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbbE1UdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:33:06 -0400
Received: by pdfh10 with SMTP id h10so49497572pdf.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PLyvwUwrmtZy7AACnj7PhpMdRHX3MS9aeWB3EEoDjN8=;
        b=ncDl6cYjX0GTpByUoVHrCSzhbc/KkxTqSso0hWXwomoic7ShHYsBqnshFvRS9Erv3u
         3yg4rgo2ff5+0zYmCox4iolD/wRuUM8QAwWiwCF2s4Ph84u+PoiL7/iscp9Djvi39Ydi
         kE7wG7iWUhi0s8EI5MuPZ7cdN6K2fV6Gvd2DsrQWjEL9x/WSFP+gvc8TRsTnqGEoXsMk
         QfHYq/YDZ/US0SSh0BHO4cDxYaYYbLXAC+1Yu2+suCWAK2zV79TIGqGV1ZRBFFhM8plB
         Yq0dgqfjYyduvwzcGZhxoAJyPXZzf2mVCLpzOnOM0QxEYggZs/7iC1LdK5XKnAJ521Yg
         wDww==
X-Received: by 10.70.93.69 with SMTP id cs5mr8697064pdb.165.1432845186204;
        Thu, 28 May 2015 13:33:06 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id qz7sm3282955pbc.11.2015.05.28.13.33.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 13:33:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqr3q0o3yr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270191>

On 05/29/2015 01:43 AM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is a preperatory patch for restructuring 'for-each-ref' and
>> evntually moving most of it to 'ref-filter' to provide the
>
> s/evntually/eventually/

Noted.


>
> The patch looks much nicer now.
>
>> -	int cnt;
>> [...]
>> +	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
>> +	cb->grab_array[cb->grab_cnt++] = ref;
>>
>> -	cnt = cb->grab_cnt;
>> -	REALLOC_ARRAY(cb->grab_array, cnt + 1);
>> -	cb->grab_array[cnt++] = ref;
>> -	cb->grab_cnt = cnt;
>
> This hunk is not advertized in the commit message, and I had to fight a
> bit to understand what it does with "we're extracting helper functions"
> in mind. It would have been much easier to review in a separate patch
> entitled "for-each-ref: simplify code" for example.
>
> But I agree that your version is simpler indeed.
>

Will put it in a separate patch. Thanks for the review.

-- 
Regards,
Karthik
