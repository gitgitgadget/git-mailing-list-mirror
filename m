From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/3] Windows: a test_cmp that is agnostic to
 random LF <> CRLF conversions
Date: Sat, 02 Nov 2013 21:40:18 +0100
Message-ID: <52756332.50404@kdbg.org>
References: <cover.1382814437.git.j6t@kdbg.org> <e64878fec3f026802e8d3958a1e6213428cab778.1382814437.git.j6t@kdbg.org> <52756198.2070900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
X-From: msysgit+bncBCJYV6HBKQILHRWVSMCRUBEFBY6IW@googlegroups.com Sat Nov 02 21:40:21 2013
Return-path: <msysgit+bncBCJYV6HBKQILHRWVSMCRUBEFBY6IW@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f185.google.com ([74.125.82.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQILHRWVSMCRUBEFBY6IW@googlegroups.com>)
	id 1VchzY-00018V-Sr
	for gcvm-msysgit@m.gmane.org; Sat, 02 Nov 2013 21:40:20 +0100
Received: by mail-we0-f185.google.com with SMTP id x55sf98193wes.12
        for <gcvm-msysgit@m.gmane.org>; Sat, 02 Nov 2013 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=p70V8gaRLO8QwJ9CYlN7AxJEa11tD8L1wpU+Qw+iFFw=;
        b=GW2ea8dv8PD7ihvKSBeGAG1uwa4js4kOcI37O/PFgbOftpscA6RhE/itQf1Z0DJnTn
         3KtE/Z1hbR+i5HFJwtmLcV8BasEvsSe8xrxPjF6Ap9pdzWpB7aevMb4xBsJaIU6eFg73
         xIOJe34hYyYj+X/HqLSGxzVsTdkZiByh3eYK4IICuadG09WKVwMZ0z1Ly9+VK2QRHk2j
         z+KZK9vKm6NeoBUXYsdGQfJwRSzbNjvqNRvDmrK0AiVSC9dpuKC4wkhmNwyuy+zNe1TE
         ik5ZctNgjRdA9PPNSPi1NrlVPzrEYJL9j3ekuFTm82EUejklLA3SGp494PRfGVHfIQyQ
         yMLw==
X-Received: by 10.180.97.137 with SMTP id ea9mr79823wib.4.1383424820624;
        Sat, 02 Nov 2013 13:40:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.11.198 with SMTP id ek6ls302095wid.6.gmail; Sat, 02 Nov
 2013 13:40:19 -0700 (PDT)
X-Received: by 10.180.187.212 with SMTP id fu20mr3400392wic.6.1383424819705;
        Sat, 02 Nov 2013 13:40:19 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTPS id z4si1453099eel.0.2013.11.02.13.40.19
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 02 Nov 2013 13:40:19 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0053DA7EB3;
	Sat,  2 Nov 2013 21:40:18 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3CF8519F31A;
	Sat,  2 Nov 2013 21:40:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <52756198.2070900@gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 195.3.86.187 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237251>

Am 02.11.2013 21:33, schrieb Sebastian Schuberth:
> On 26.10.2013 21:17, Johannes Sixt wrote:
> 
>> In a number of tests, output that was produced by a shell script is
>> compared to expected output using test_cmp. Unfortunately, the MSYS
>> bash--
>> when invoked via git, such as in hooks--converts LF to CRLF on output
>> (as produced by echo and printf), which leads to many false positives.
> 
> As you correctly point out the LF vs. CRLF issues are caused by MSYS
> bash. Then why are the functions called mingw_* instead of msys_*? I'd
> prefer to make very clear that not MinGW but MSYS is the culprit
> concerning the LF vs. CRLF issues (and also the path mangling issues).

It's a historical accident. We already have the prerequisite MINGW to
work around various annoyances, most of which are caused by MSYS bash. I
didn't want to invent a new prefix.

-- Hannes

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
