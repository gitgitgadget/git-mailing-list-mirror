From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 10/16] engine.pl: delete the captured stderr
 file if empty
Date: Mon, 20 Jul 2015 07:16:24 +0100
Organization: OPDS
Message-ID: <FDE2D068444A4350B0C2F25275CBC41D@PhilipOakley>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org><1437336497-4072-11-git-send-email-philipoakley@iee.org> <CAPig+cSDGUNZfc3cV=P2WUDUR+MBBjoHFxTBFaizf0NH-LmFTw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"MsysGit List" <msysgit@googlegroups.com>,
	"Yue Lin Ho" <b8732003@student.nsysu.edu.tw>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: msysgit+bncBDSOTWHYX4PBBIVEWKWQKGQE2VG5CGA@googlegroups.com Mon Jul 20 08:16:04 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBIVEWKWQKGQE2VG5CGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBIVEWKWQKGQE2VG5CGA@googlegroups.com>)
	id 1ZH4Mt-0007qT-TM
	for gcvm-msysgit@m.gmane.org; Mon, 20 Jul 2015 08:16:03 +0200
Received: by lagw2 with SMTP id w2sf53329072lag.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=BLRRb7lbHHKD8QX5bhA2Q9Pv/S3bcvN1VdjQ1yHoQJg=;
        b=q+ylOcEB2jDpxHJOg41Qx+hJTRhHhrfJ/XnBY2wkpQNx6hvM4VQrKa2O4yrLL7UpKa
         ZN3LPq7BixQGZcZO0RWCQrMP2LkcOR5sUAVKZGVU8ZWaz00VE+C3O/OZrWohGfJK3X19
         4AxONN8tmvA4huUHtVLHa7EYeVKQ12HslAMNk2R4gD2UPwoekmACOqbCzuhx8ZwoZ3Yv
         wyD9T7agEHLx7IKrtduFFuMziNJ/PZD7JVYYeE0Qg/iUwEUZHHPvqvKEp/6TifcWMMxC
         kAmeIurPXiFXpM+CzrQMdKqsabRiq4Rt5rmJ5etz/hKSwI2+gxGp+fpGb6blPoiciJSt
         sJ0w==
X-Received: by 10.152.5.100 with SMTP id r4mr377276lar.13.1437372963575;
        Sun, 19 Jul 2015 23:16:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.206.76 with SMTP id lm12ls119802lac.109.gmail; Sun, 19 Jul
 2015 23:16:02 -0700 (PDT)
X-Received: by 10.152.37.101 with SMTP id x5mr14144496laj.5.1437372962332;
        Sun, 19 Jul 2015 23:16:02 -0700 (PDT)
Received: from out1.ip04ir2.opaltelecom.net (out1.ip04ir2.opaltelecom.net. [62.24.128.240])
        by gmr-mx.google.com with ESMTP id v8si324198wiw.1.2015.07.19.23.16.02
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 23:16:02 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.240 as permitted sender) client-ip=62.24.128.240;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DLFQA6kaxVPHMBFlxcgxNUaYMje4IzbbYghXUEBAKBIU0BAQEBAQEHAQEBAUEkG4QeBQEBAQECAQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBhMIAgECAwGIFQyue4ZXjxeBIokogQKFBoJvL4EUBZRSAYEKg2SJO5Z+gQmBW4E/PTGCSwEBAQ
X-IPAS-Result: A2DLFQA6kaxVPHMBFlxcgxNUaYMje4IzbbYghXUEBAKBIU0BAQEBAQEHAQEBAUEkG4QeBQEBAQECAQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBhMIAgECAwGIFQyue4ZXjxeBIokogQKFBoJvL4EUBZRSAYEKg2SJO5Z+gQmBW4E/PTGCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,507,1432594800"; 
   d="scan'208";a="547851411"
Received: from host-92-22-1-115.as13285.net (HELO PhilipOakley) ([92.22.1.115])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 20 Jul 2015 07:16:01 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.240 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274315>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Sun, Jul 19, 2015 at 4:08 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> Keep the build clean of extraneous files if it is indeed clean.
>> Otherwise leave the msvc-build-makedryerrors.txt file both as
>> a flag for any CI system or for manual debugging.
>>
>> Note that the file will contain the new values of the GIT_VERSION
>> and GITGUI_VERSION if they were generated by the make file. They
>> are omitted if the release is tagged and indentically defined in
>> their respective GIT_VERSION_GEN file DEF_VER variables.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> diff --git a/contrib/buildsystems/engine.pl 
>> b/contrib/buildsystems/engine.pl
>> index a6999b6..020776e 100755
>> --- a/contrib/buildsystems/engine.pl
>> +++ b/contrib/buildsystems/engine.pl
>> @@ -77,6 +77,8 @@ EOM
>>
>>  my $ErrsFile = "msvc-build-makedryerrors.txt";
>>  @makedry = `cd $git_dir && make -n MSVC=1 V=1 2>$ErrsFile` if 
>> !@makedry;
>> +# test for an empty Errors file and remove it
>> +for ($ErrsFile) {unlink $_ if (-f $_) && (!-s $_);}
>
> Why the 'for' loop?
>
> Also, if you're using the 'for' loop for the $_ side-effect, then why
> not the simpler:

It was cargo cult programming, with some Google searching to select 
between invocations. Most examples were looping through lists in 
scripts, hence the down select.

>
>    for ($ErrsFile) { unlink if -f && !-s; }

A lot better. Will fix.

>
> ?
>
>>
>>  # Parse the make output into usable info
>>  parseMakeOutput();
>> --
>> 2.4.2.windows.1.5.gd32afb6
>

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
