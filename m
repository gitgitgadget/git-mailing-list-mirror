From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC 3/4] engine.pl: split the .o and .obj processing
Date: Fri, 21 Nov 2014 20:35:47 -0000
Organization: OPDS
Message-ID: <622F65684C63407184D58ED19385AFD4@PhilipOakley>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-4-git-send-email-philipoakley@iee.org> <alpine.DEB.1.00.1411211043050.13845@s15462909.onlinehome-server.info>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"Marius Storm-Olsen" <mstormo@gmail.com>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Michael Wookey" <michaelwookey@gmail.com>,
	"Msysgit" <msysgit@googlegroups.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDSOTWHYX4PBB7WDX2RQKGQE2L5NPGY@googlegroups.com Fri Nov 21 21:35:11 2014
Return-path: <msysgit+bncBDSOTWHYX4PBB7WDX2RQKGQE2L5NPGY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f57.google.com ([74.125.83.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB7WDX2RQKGQE2L5NPGY@googlegroups.com>)
	id 1Xruv9-0003BG-B0
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 21:35:11 +0100
Received: by mail-ee0-f57.google.com with SMTP id e53sf519790eek.12
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=kX61xevQU38IHkm7QmrrtwULH1LfPgsxhfcqzyW+P7M=;
        b=Dk5NyvxUGNAGOG9Rf+UmYEs6E2ibsHriL/tGfNdoosBXuwyHfczzst/AmD8O165tWO
         gnYmXn9s6/4yeHV/+wka57uHWXYYf45l8xDW3xAdryY7PrHdKlw34HXyi5zSV5g0/0YE
         UizmuVKbG+jFrhnmXek9YIrPmb1WRbNd5fEOPBMN1Vb1ZzRM7G9HjXl1vWESES6z7Ybr
         O+wqfs2R5IykiZhHT1RMTKYiFbT4+/inPc/1D1arJoUcIupalpqE/Xz2lS6zu6V/IAUK
         byETATNQOff5WkvwjFtkd9M7vLpjMQFVzN2y86SVmZ/RDfybPtb9agwzlnaZj7rCVwIx
         mk5Q==
X-Received: by 10.180.14.33 with SMTP id m1mr1702wic.20.1416602111117;
        Fri, 21 Nov 2014 12:35:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.8.170 with SMTP id s10ls23360wia.30.gmail; Fri, 21 Nov
 2014 12:35:10 -0800 (PST)
X-Received: by 10.180.219.66 with SMTP id pm2mr50901wic.7.1416602110438;
        Fri, 21 Nov 2014 12:35:10 -0800 (PST)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id ed6si17857wib.3.2014.11.21.12.35.10
        for <msysgit@googlegroups.com>;
        Fri, 21 Nov 2014 12:35:10 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApYQAMKhb1RZ8YpUPGdsb2JhbABcgw5VWYgNw2kdCoZlAQMBAYEGFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEuFggBARwFCwIDBQIBAxUDCSUUAQQYAgYHAxQGCAsIAgECAwEMBIgLAwkNCb1RkBUBCyCOToI9gzaBHwWLaIZ8a4N6iSSZHUgwAYJKAQEB
X-IPAS-Result: ApYQAMKhb1RZ8YpUPGdsb2JhbABcgw5VWYgNw2kdCoZlAQMBAYEGFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEuFggBARwFCwIDBQIBAxUDCSUUAQQYAgYHAxQGCAsIAgECAwEMBIgLAwkNCb1RkBUBCyCOToI9gzaBHwWLaIZ8a4N6iSSZHUgwAYJKAQEB
X-IronPort-AV: E=Sophos;i="5.07,432,1413241200"; 
   d="scan'208";a="16965927"
Received: from host-89-241-138-84.as13285.net (HELO PhilipOakley) ([89.241.138.84])
  by out1.ip02ir2.opaltelecom.net with SMTP; 21 Nov 2014 20:34:48 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Philip,
>
> On Thu, 20 Nov 2014, Philip Oakley wrote:
>
>> Commit 4b623d80f7352 added an .obj file (invalidcontinue.obj) which 
>> was not
>> processed correctly.
>>
>> The generate engine then mistakenly did a s/.o/.c/  to create a 
>> request
>> to compile invalidcontinue.cbj.
>
> This is good. However, this:
>
>> Split the '/\.(o|obj)$' in engine.pl#L353 into:
>>
>>         } elsif ($part =~ /\.o$/) { # was '/\.(o|obj)$'
>>             push(@objfiles, $part);
>>         } elsif ($part =~ /\.obj$/) { # was '/\.(o|obj)$'
>>             # push(@objfiles, $part); # do nothing
>>         } else {
>
> just repeats what the diff says, so it is unnecessary in the commit
> message.
OK.

>
>> diff --git a/contrib/buildsystems/engine.pl 
>> b/contrib/buildsystems/engine.pl
>> index 8e41808..16c3dd5 100755
>> --- a/contrib/buildsystems/engine.pl
>> +++ b/contrib/buildsystems/engine.pl
>> @@ -264,7 +264,9 @@ sub handleCompileLine
>>          } elsif ($part =~ /\.(c|cc|cpp)$/) {
>>              $sourcefile = $part;
>>          } else {
>> -            die "Unhandled compiler option @ line $lineno: $part";
>> +            print "full line: $line\n";
>> +            print "A:-Unhandled compiler option @ line $lineno: 
>> $part\n"; # die (if !DEBUG)
>> +#            die "Unhandled compiler option @ line $lineno: $part";
>
> This needs to be backed out. I agree that it is nice to get going and 
> to
> debug, so I would split it out into its own commit while working on 
> the
> branch, but then drop it before submitting.

I'll probably split this "improvement in error reporting" (by providing 
the full offending line) into a separate patch, on the basis that we 
want (Windows) folks to start helping, so let's make the error messages 
more useful to those who don't know these scripting languages yet.

>
>> @@ -290,14 +292,15 @@ sub handleLibLine
>>[...]
>>      foreach (@objfiles) {
>>          my $sourcefile = $_;
>> -        $sourcefile =~ s/\.o/.c/;
>> +        $sourcefile =~ s/\.o$/.c/;
>
> Ah, I see from the context that my earlier comment about the 
> white-space
> delimiter was wrong: at this stage, we already have split the list. So
> this is groovy.
>
>> @@ -343,8 +346,10 @@ sub handleLinkLine
>>          } elsif ($part =~ /\.(a|lib)$/) {
>>              $part =~ s/\.a$/.lib/;
>>              push(@libs, $part);
>> -        } elsif ($part =~ /\.(o|obj)$/) {
>> +        } elsif ($part =~ /\.o$/) { # was '/\.(o|obj)$'
>>              push(@objfiles, $part);
>> +        } elsif ($part =~ /\.obj$/) { # was '/\.(o|obj)$'
>> +            # push(@objfiles, $part); # do nothing
>
> How about the following instead?
>
> + } elsif ($part eq 'invalidcontinue.obj') {
> + # ignore
>  } elsif ($part =~ /\.(o|obj)$/) {

Looks good, I'll use that (after deciding whether .obj files should be 
expected in a 'make' output anyway)

>
> ? After all, this change is really only about handling the newly
> introduced invalidcontinue.obj correctly.
Did it ever handle .obj's correctly (rhet) - I dunno.

>
> Ciao,
> Johannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
