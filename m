From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/16] engine.pl: delete the captured stderr
 file if empty
Date: Mon, 20 Jul 2015 02:40:54 -0400
Message-ID: <CAPig+cRZgjnxrYRVYCLuzomE=qQtF9N_SE6t5kLcXbdiheNeTg@mail.gmail.com>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
	<1437336497-4072-11-git-send-email-philipoakley@iee.org>
	<CAPig+cSDGUNZfc3cV=P2WUDUR+MBBjoHFxTBFaizf0NH-LmFTw@mail.gmail.com>
	<FDE2D068444A4350B0C2F25275CBC41D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	MsysGit List <msysgit@googlegroups.com>, Yue Lin Ho <b8732003@student.nsysu.edu.tw>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBD2JJCMYYEGBB55PWKWQKGQEQGSSAAA@googlegroups.com Mon Jul 20 08:40:58 2015
Return-path: <msysgit+bncBD2JJCMYYEGBB55PWKWQKGQEQGSSAAA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f61.google.com ([209.85.192.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD2JJCMYYEGBB55PWKWQKGQEQGSSAAA@googlegroups.com>)
	id 1ZH4ky-0000Ma-9A
	for gcvm-msysgit@m.gmane.org; Mon, 20 Jul 2015 08:40:56 +0200
Received: by qgdf45 with SMTP id f45sf30738213qgd.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 23:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=MqLgGF+F2bmkyqLUl2cS+/AYmwDt9E0hsvMTOIM8wms=;
        b=vabWM2Gbxx+/AXX/ZjJK1bCdB9Uo6AsdWmTqmD/MfB5Ooqgr3XB4o9XCeYMXGkQ5Jm
         cVUy8gohJTvf3mrLdkyokBN32vnQmBZTn0T3uKi9nrgqAYpZFGoSkEd5MwI2UaIT9U8t
         HOs01M1Z8nJkr2BwKoWJKuOFCfAuBCCYnnNXeqLTKu5NQ0bZfAMaDX72b2kE8L71gqLt
         RQNIO5jX6mDH1DF3iG0MV2v6bjhU5qCx2ZP3koMRloG/nynjkiaqDBailWthE9xKr1oz
         +7pQkmwokaKpCp8F1hBM58ag5WT1pWv/eQ+qOwArwl5y9FeeZlaSJc9zwisg5GHCmkcr
         FOPw==
X-Received: by 10.50.107.105 with SMTP id hb9mr130106igb.3.1437374455524;
        Sun, 19 Jul 2015 23:40:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.155.9 with SMTP id d9ls2083723ioe.49.gmail; Sun, 19 Jul
 2015 23:40:54 -0700 (PDT)
X-Received: by 10.107.7.220 with SMTP id g89mr22620128ioi.2.1437374454914;
        Sun, 19 Jul 2015 23:40:54 -0700 (PDT)
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com. [2607:f8b0:4002:c07::231])
        by gmr-mx.google.com with ESMTPS id s127si1780404ywc.6.2015.07.19.23.40.54
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2015 23:40:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::231 as permitted sender) client-ip=2607:f8b0:4002:c07::231;
Received: by mail-yk0-x231.google.com with SMTP id x123so132404736yka.1
        for <msysgit@googlegroups.com>; Sun, 19 Jul 2015 23:40:54 -0700 (PDT)
X-Received: by 10.129.91.87 with SMTP id p84mr27512958ywb.95.1437374454772;
 Sun, 19 Jul 2015 23:40:54 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 23:40:54 -0700 (PDT)
In-Reply-To: <FDE2D068444A4350B0C2F25275CBC41D@PhilipOakley>
X-Original-Sender: sunshine@sunshineco.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::231
 as permitted sender) smtp.mail=ericsunshine@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274317>

On Mon, Jul 20, 2015 at 2:16 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Sunshine" <sunshine@sunshineco.com>
>> On Sun, Jul 19, 2015 at 4:08 PM, Philip Oakley <philipoakley@iee.org>
>> wrote:
>>> Keep the build clean of extraneous files if it is indeed clean.
>>> Otherwise leave the msvc-build-makedryerrors.txt file both as
>>> a flag for any CI system or for manual debugging.
>>>
>>> Note that the file will contain the new values of the GIT_VERSION
>>> and GITGUI_VERSION if they were generated by the make file. They
>>> are omitted if the release is tagged and indentically defined in
>>> their respective GIT_VERSION_GEN file DEF_VER variables.
>>>
>>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>>> ---
>>> +# test for an empty Errors file and remove it
>>> +for ($ErrsFile) {unlink $_ if (-f $_) && (!-s $_);}
>>
>> Why the 'for' loop?
>>
>> Also, if you're using the 'for' loop for the $_ side-effect, then why
>> not the simpler:
>
> It was cargo cult programming, with some Google searching to select between
> invocations. Most examples were looping through lists in scripts, hence the
> down select.
>
>>    for ($ErrsFile) { unlink if -f && !-s; }
>
> A lot better. Will fix.

Although that works, I'm not sure that it's really all that desirable
due to the unnecessary and potentially confusing 'for' loop. I'd
probably just write it as:

    unlink $ErrsFile if -f $ErrsFile && !-s _;

The lone '_' is magical[1] in that it re-uses the stat() information
from the -f rather than stat'ing $ErrsFile again. I'd also probably
replace !-s ("not non-zero size") with -z ("zero size"):

    unlink $ErrsFile if -f $ErrsFile && -z _;

And, if you're using Perl 5.10 or later, you could use a little
syntactic sugar[1] and stack the file test operators up against one
another:

    unlink $ErrsFile if -f -z $ErrsFile;

which is the equivalent of the above with the sugar removed.

[1]: http://perldoc.perl.org/functions/-X.html

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
