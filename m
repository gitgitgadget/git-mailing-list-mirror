From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [RFC] git cat-file "literally" option
Date: Wed, 18 Feb 2015 18:20:30 +0530
Message-ID: <54E48A96.8010301@gmail.com>
References: <54E45DD7.205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 13:50:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO45S-0002gr-GA
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 13:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbbBRMug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 07:50:36 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:44230 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbBRMuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 07:50:35 -0500
Received: by padet14 with SMTP id et14so955023pad.11
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=i289rSqpIm1wCAjRG/E/cY+PmVq+LRutDbOPczrFXQc=;
        b=MdSN3h7QAW0zE0SXFfWrmamnDxaxoI9GM1XwIFIZyhQ+IbzxdktXA5JwJVldb+maN+
         Gk0nN0DxMc5pENCziq2CXU4Zi5bD4GKEV91UPN6RAiQZDzrxmNm33QJxVEfEvGBozmxt
         WGrni5Wfa2vaAgcnoRqpeNx0QOiHYAN1VEt4LseHjXtzzmBTB6c75CjsFs7/GzTBb0hZ
         sfsfiTX8juqHkVA5T6jN1TJrFfi2R61eOuVhvyYtKFFvQmF0MCQS1HyGaH3lXzShnACl
         8mhSk4icCk4RWRedCtRZ3cIWGcC45Xur9Vuk+yT1N9gESC1sUtpSxFxugZQV/MOyNFhc
         M9oA==
X-Received: by 10.66.62.137 with SMTP id y9mr58055873par.87.1424263834922;
        Wed, 18 Feb 2015 04:50:34 -0800 (PST)
Received: from [172.16.2.128] ([182.48.234.2])
        by mx.google.com with ESMTPSA id hr3sm20623183pbb.13.2015.02.18.04.50.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Feb 2015 04:50:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54E45DD7.205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264014>


On 02/18/2015 03:09 PM, karthik nayak wrote:
> Hey,
> After reading 
> http://thread.gmane.org/gmane.comp.version-control.git/256878
> I have started working on the git cat file --literally option.
>
> I'm wondering if I should implement it as an add on to the existing 
> options,
> wherein we could say "git cat-file (t | -s | -e | -p | <type> | 
> --texconv) --literally <object>"
> so that it would be able to print the required data literally or 
> should I implement it such that
> we could say "git cat-file (-t | -s | -e | -p | <type> | --texconv | 
> --literally) <object>"
> so it would just give all information about the given object. (Maybe 
> like the -p option?)
>
> For example :
> if  I create a bogus object like
>
> git hash-object -t bogus --literally -w --stdin </dev/null
>
> Should I implement
> git cat-file -t --literally 49993fe130c4b3bf24857a15d7969c396b7bc187
> or should I implement
> git cat-file --literally 49993fe130c4b3bf24857a15d7969c396b7bc187
> To get information pertaining to the object "bogus:.
>
>
> What do you people think?
> Thanks
> -Karthik
Also,
Is there any way I can get the type of object made via git hash-object 
--literally. The problem I'm facing is "sha1_object_info()" returns a 
object_type enum, so objects not specified there are considered as errors.
