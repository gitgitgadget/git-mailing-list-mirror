From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 10/16] engine.pl: delete the captured stderr
 file if empty
Date: Mon, 20 Jul 2015 12:55:25 +0100
Organization: OPDS
Message-ID: <3CB33892F653436E8DCF521B61A2D48E@PhilipOakley>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org><1437336497-4072-11-git-send-email-philipoakley@iee.org><CAPig+cSDGUNZfc3cV=P2WUDUR+MBBjoHFxTBFaizf0NH-LmFTw@mail.gmail.com><FDE2D068444A4350B0C2F25275CBC41D@PhilipOakley> <CAPig+cRZgjnxrYRVYCLuzomE=qQtF9N_SE6t5kLcXbdiheNeTg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"MsysGit List" <msysgit@googlegroups.com>,
	"Yue Lin Ho" <b8732003@student.nsysu.edu.tw>,
	"dscho" <notifications@github.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: msysgit+bncBDSOTWHYX4PBBBWDWOWQKGQEPBX744I@googlegroups.com Mon Jul 20 13:54:47 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBBWDWOWQKGQEPBX744I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBBWDWOWQKGQEPBX744I@googlegroups.com>)
	id 1ZH9eh-00018z-JK
	for gcvm-msysgit@m.gmane.org; Mon, 20 Jul 2015 13:54:47 +0200
Received: by wgjf7 with SMTP id f7sf2273916wgj.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 20 Jul 2015 04:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=8rd5uvvYe5d4oVD4dDbepbOVVi02rDD61fLJziAyAtc=;
        b=qcQcOVbpKZSBhiSgHhW+mQHoIVy+ql5Smw7RqOP6fnwjARPV2LXv4dALP38jT8TBWY
         VOy/PgHdl/sNj82NhUXVp6jxXXkRJMYTdcnsD7OOq93YVgCPFCWCfv5NC7ke59faWp3F
         6Ha/bRh2/XWA3aNZYE3Xvax0UX3IcaNySkfhMDEKIZK6ZvdSfCgNprGrQTYtahciODWs
         5ytuwtGKtPtG7hH1rVWZLuKRKZswC7/OovrNmLEx61lG56a6KUbrWNxZQUIXiexak0GW
         r+22N8j0CDGBCmFBv/2mAhN28Ox6csV2dJG680TaHe8iBzWa3yvhv1dC/gemOOoHFzbY
         ZDaQ==
X-Received: by 10.180.187.226 with SMTP id fv2mr34917wic.1.1437393287155;
        Mon, 20 Jul 2015 04:54:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.84.230 with SMTP id c6ls780035wiz.40.gmail; Mon, 20 Jul
 2015 04:54:45 -0700 (PDT)
X-Received: by 10.181.13.202 with SMTP id fa10mr6129126wid.4.1437393285836;
        Mon, 20 Jul 2015 04:54:45 -0700 (PDT)
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net. [62.24.128.242])
        by gmr-mx.google.com with ESMTP id t6si381285wiz.0.2015.07.20.04.54.45
        for <msysgit@googlegroups.com>;
        Mon, 20 Jul 2015 04:54:45 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.242 as permitted sender) client-ip=62.24.128.242;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ACDwC+4KxVPHMBFlxcgxNUaYMje4MgtiqFbQQEAoEpTQEBAQEBAQcBAQEBQAE/hB4FAQEBAQIBCAEBGRUeAQEhBQYCAwUCAQMVAwICBSECAhQBBBoGBwMUBhMIAgECAwGIFQwJr3yGV48dgSKJKIEChQaCby+BFAWUUgGBCoNkiTuWfoEJgVuBPz0xAYJKAQEB
X-IPAS-Result: A2ACDwC+4KxVPHMBFlxcgxNUaYMje4MgtiqFbQQEAoEpTQEBAQEBAQcBAQEBQAE/hB4FAQEBAQIBCAEBGRUeAQEhBQYCAwUCAQMVAwICBSECAhQBBBoGBwMUBhMIAgECAwGIFQwJr3yGV48dgSKJKIEChQaCby+BFAWUUgGBCoNkiTuWfoEJgVuBPz0xAYJKAQEB
X-IronPort-AV: E=Sophos;i="5.15,507,1432594800"; 
   d="scan'208";a="685550330"
Received: from host-92-22-1-115.as13285.net (HELO PhilipOakley) ([92.22.1.115])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 20 Jul 2015 12:54:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.242 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274321>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Mon, Jul 20, 2015 at 2:16 AM, Philip Oakley <philipoakley@iee.org>
> wrote:
>> From: "Eric Sunshine" <sunshine@sunshineco.com>
>>> On Sun, Jul 19, 2015 at 4:08 PM, Philip Oakley
>>> <philipoakley@iee.org>
>>> wrote:
>>>> Keep the build clean of extraneous files if it is indeed clean.
>>>> Otherwise leave the msvc-build-makedryerrors.txt file both as
>>>> a flag for any CI system or for manual debugging.
>>>>
>>>> Note that the file will contain the new values of the GIT_VERSION
>>>> and GITGUI_VERSION if they were generated by the make file. They
>>>> are omitted if the release is tagged and indentically defined in
>>>> their respective GIT_VERSION_GEN file DEF_VER variables.
>>>>
>>>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>>>> ---
>>>> +# test for an empty Errors file and remove it
>>>> +for ($ErrsFile) {unlink $_ if (-f $_) && (!-s $_);}
>>>
>>> Why the 'for' loop?
>>>
>>> Also, if you're using the 'for' loop for the $_ side-effect, then
>>> why
>>> not the simpler:
>>
>> It was cargo cult programming, with some Google searching to select
>> between
>> invocations. Most examples were looping through lists in scripts,
>> hence the
>> down select.
>>
>>>    for ($ErrsFile) { unlink if -f && !-s; }
>>
>> A lot better. Will fix.
>
> Although that works, I'm not sure that it's really all that desirable
> due to the unnecessary and potentially confusing 'for' loop. I'd
> probably just write it as:
>
>    unlink $ErrsFile if -f $ErrsFile && !-s _;
>
> The lone '_' is magical[1] in that it re-uses the stat() information
> from the -f rather than stat'ing $ErrsFile again. I'd also probably
> replace !-s ("not non-zero size") with -z ("zero size"):
>
>    unlink $ErrsFile if -f $ErrsFile && -z _;
>
> And, if you're using Perl 5.10 or later,

The Msysgit (@1.9.5) uses perl v5.8.8, while the newer G4W SDK uses perl
5, version 20, subversion 2 (v5.20.2), so there is a decision to be made
about whether to leave the Msysgit version behind.

While it would be nice to use the newest version, I'm minded that we
should keep a little backward compatibility with Msysgit, at least until
the new G4w has had a few 'proper' releases, so not use the magic
suggestion below.

I've cc'd dscho, Johannes, J6t and Sebastian in case they have any firm
opinions with respect to the Msysgit / G4W split.

>     you could use a little
> syntactic sugar[1] and stack the file test operators up against one
> another:
>
>    unlink $ErrsFile if -f -z $ErrsFile;
>
> which is the equivalent of the above with the sugar removed.
>
> [1]: http://perldoc.perl.org/functions/-X.html
> --

Philip 

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
