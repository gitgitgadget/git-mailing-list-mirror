From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/16] engine.pl: delete the captured stderr
 file if empty
Date: Mon, 20 Jul 2015 14:10:52 -0400
Message-ID: <CAPig+cQxCc=HQ5-=KF5HwEQyJD88Lyw6z5R4-Jn3kwabatK_-w@mail.gmail.com>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
	<1437336497-4072-11-git-send-email-philipoakley@iee.org>
	<CAPig+cSDGUNZfc3cV=P2WUDUR+MBBjoHFxTBFaizf0NH-LmFTw@mail.gmail.com>
	<FDE2D068444A4350B0C2F25275CBC41D@PhilipOakley>
	<CAPig+cRZgjnxrYRVYCLuzomE=qQtF9N_SE6t5kLcXbdiheNeTg@mail.gmail.com>
	<3CB33892F653436E8DCF521B61A2D48E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	MsysGit List <msysgit@googlegroups.com>, Yue Lin Ho <b8732003@student.nsysu.edu.tw>, 
	dscho <notifications@github.com>, Johannes Sixt <j6t@kdbg.org>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBD2JJCMYYEGBBLHTWSWQKGQEU4JPOZA@googlegroups.com Mon Jul 20 20:10:54 2015
Return-path: <msysgit+bncBD2JJCMYYEGBBLHTWSWQKGQEU4JPOZA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vn0-f62.google.com ([209.85.216.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD2JJCMYYEGBBLHTWSWQKGQEU4JPOZA@googlegroups.com>)
	id 1ZHFWf-0006ww-Nj
	for gcvm-msysgit@m.gmane.org; Mon, 20 Jul 2015 20:10:53 +0200
Received: by vnav141 with SMTP id v141sf23103718vna.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 20 Jul 2015 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=TZK2kota5X9gNvQqI81CNhdiTiNm17Ux+Hfq6onIyWA=;
        b=EnR3Llz4Zzx3mZIMXkHBEZbhWCqn+w9zgO+3nhJ4LNtm1yI8ahGZoE7ogjQuhW/3gs
         ClJ6FnBAEOTvjIi+suB6LxBge8iFNSSc1H+steUX11IdTk17FU5W65zrvlrC4qHe8Eaw
         /nGHKu0pQbmkNG7MXLsAXMKW6z19H99RVs18K84oAO6dNPboYjJKzdXRHgM7FlY9wPnL
         1cJoVcheVVFRJ2tLSieD5DQ3CAWxQ2pJzNaHstzA7FGYV31RpJrFTspEs60GS/HXAqvH
         ZSDqkpRn5V+C2TlHsiiua0DKqS/dK/C4Wmt5IdFS+h8YzfgtlD4wEcyCFfkoSPHY8T+M
         g0iQ==
X-Received: by 10.50.61.161 with SMTP id q1mr185504igr.10.1437415853065;
        Mon, 20 Jul 2015 11:10:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.102.3 with SMTP id fk3ls1383769igb.34.gmail; Mon, 20 Jul
 2015 11:10:52 -0700 (PDT)
X-Received: by 10.66.249.233 with SMTP id yx9mr34281626pac.3.1437415852545;
        Mon, 20 Jul 2015 11:10:52 -0700 (PDT)
Received: from mail-yk0-x236.google.com (mail-yk0-x236.google.com. [2607:f8b0:4002:c07::236])
        by gmr-mx.google.com with ESMTPS id s127si1923537ywc.6.2015.07.20.11.10.52
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 11:10:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::236 as permitted sender) client-ip=2607:f8b0:4002:c07::236;
Received: by mail-yk0-x236.google.com with SMTP id x123so145640911yka.1
        for <msysgit@googlegroups.com>; Mon, 20 Jul 2015 11:10:52 -0700 (PDT)
X-Received: by 10.129.76.140 with SMTP id z134mr30543342ywa.17.1437415852431;
 Mon, 20 Jul 2015 11:10:52 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 11:10:52 -0700 (PDT)
In-Reply-To: <3CB33892F653436E8DCF521B61A2D48E@PhilipOakley>
X-Original-Sender: sunshine@sunshineco.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::236
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274338>

On Mon, Jul 20, 2015 at 7:55 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Sunshine" <sunshine@sunshineco.com>
>> Although that works, I'm not sure that it's really all that desirable
>> due to the unnecessary and potentially confusing 'for' loop. I'd
>> probably just write it as:
>>
>>    unlink $ErrsFile if -f $ErrsFile && !-s _;
>>
>> The lone '_' is magical[1] in that it re-uses the stat() information
>> from the -f rather than stat'ing $ErrsFile again. I'd also probably
>> replace !-s ("not non-zero size") with -z ("zero size"):
>>
>>    unlink $ErrsFile if -f $ErrsFile && -z _;
>>
>> And, if you're using Perl 5.10 or later,
>
> The Msysgit (@1.9.5) uses perl v5.8.8, while the newer G4W SDK uses perl
> 5, version 20, subversion 2 (v5.20.2), so there is a decision to be made
> about whether to leave the Msysgit version behind.
>
> While it would be nice to use the newest version, I'm minded that we
> should keep a little backward compatibility with Msysgit, at least until
> the new G4w has had a few 'proper' releases, so not use the magic
> suggestion below.
>
>>     you could use a little
>> syntactic sugar[1] and stack the file test operators up against one
>> another:
>>
>>    unlink $ErrsFile if -f -z $ErrsFile;

Since msysgit is only at Perl 5.8.8, it makes plenty of sense to just
stick with:

    unlink $ErrsFile if -f $ErrsFile && -z _;

since it's only a tiny bit more verbose than:

    unlink $ErrsFile if -f -z $ErrsFile;

and then you don't have to worry about needing a more modern Perl version.

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
