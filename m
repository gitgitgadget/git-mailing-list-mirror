From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/2] cat-file: teach cat-file a '--literally' option
Date: Tue, 17 Mar 2015 19:29:40 +0530
Message-ID: <7BBE9C66-3654-4E6A-96FB-1EF16FC28E35@gmail.com>
References: <5507B7EE.1070403@gmail.com> <1426569400-8204-1-git-send-email-karthik.188@gmail.com> <CAPig+cSJVGy_L6mThFCU1Bw0ZrZEv=pZ8=W8gTZd=A5y2fcR7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 15:00:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXs2C-0006jl-RL
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 14:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbbCQN7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 09:59:48 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36612 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbbCQN7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 09:59:47 -0400
Received: by padcy3 with SMTP id cy3so10603375pad.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=vP13ZVODwGrZrL5RBwjLlcmyGHEAN7NYiYOr2irWIkA=;
        b=v/v5gLsFJ8biYmRkvWRssN9G5VaWTNYO1N/4aJ09LZQL9+/EWCGNVKQLgmiY6jA5KO
         /qzESr/p6kTv/ISU2jwGpgdkS7HthgWvF7FMkek2eZebvDA3JaxpshBWQ+TtyZdDZh3Q
         rznmMOHaI5GY1lWU8lC4bW/nC+sYgMhPhl/nPP51+0o19nBSXGiyOdBySUfjdG5XtvnF
         QnoHjMhrx5y550KZMbp7dh1tRu1ETDOAwG9rcTJRDcy1urkvibS/iJpHlTASq2G/5ogd
         kA7DoGaqHk+ruMvQ1tYtvEIqCV6f3LbE3MfBFq/Qj62dwIc9c5HZPNVtHaSw4QAr0S9u
         OEHw==
X-Received: by 10.66.97.37 with SMTP id dx5mr102342827pab.69.1426600787019;
        Tue, 17 Mar 2015 06:59:47 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.99.94])
        by mx.google.com with ESMTPSA id x4sm22709937pas.40.2015.03.17.06.59.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Mar 2015 06:59:45 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPig+cSJVGy_L6mThFCU1Bw0ZrZEv=pZ8=W8gTZd=A5y2fcR7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265629>



On March 17, 2015 12:21:33 PM GMT+05:30, Eric Sunshine <sunshine@sunshineco.com> wrote:
>On Tue, Mar 17, 2015 at 1:16 AM, Karthik Nayak <karthik.188@gmail.com>
>wrote:
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index df99df4..1625246 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -323,8 +338,8 @@ static int batch_objects(struct batch_options
>*opt)
>>  }
>
>I don't presently have time for a proper read-through, however, this
>popped out while quickly running my eyes over the changes.
>
>>  static const char * const cat_file_usage[] = {
>> -       N_("git cat-file (-t | -s | -e | -p | <type> | --textconv)
><object>"),
>> -       N_("git cat-file (--batch | --batch-check) <
><list-of-objects>"),
>> +       N_("git cat-file (-t [--literally]|-s
>[--literally]|-e|-p|<type>|--textconv) <object>"),
>> +       N_("git cat-file (--batch | --batch-check)
><list-of-objects>"),
>
>The '<' in the second line before <list-of-objects> is intentional. It
>means that <list-of-objects> is provided via stdin. Therefore, it is
>incorrect to remove it.
I see. It seemed out of place. Makes sense, probably should have asked. 

Thanks.
>
>>         NULL
>>  };
>>

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
