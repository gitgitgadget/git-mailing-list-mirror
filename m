From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Issue: repack semi-frequently fails on Windows
 (msysgit) - suspecting file descriptor issues
Date: Thu, 16 Apr 2015 13:10:36 +0200
Message-ID: <552F98AC.5030603@virtuell-zuhause.de>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>
To: Andreas Mohr <andi@lisas.de>, git@vger.kernel.org
X-From: msysgit+bncBCL7JHHTPAILFMN6VECRUBETJWCUQ@googlegroups.com Thu Apr 16 13:10:43 2015
Return-path: <msysgit+bncBCL7JHHTPAILFMN6VECRUBETJWCUQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAILFMN6VECRUBETJWCUQ@googlegroups.com>)
	id 1Yihgw-0003Z2-Ru
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 13:10:42 +0200
Received: by wivr20 with SMTP id r20sf26146363wiv.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=nYJktQpEWskOFaFLC0aq/bGqqCkfW4VzFZHg8CECu0U=;
        b=za+IWGP4OOdt56gi+CIDslzAUX/f+THH/+rPchH6NXZsQ/CWeUMUxbioPN7S9SKe7B
         G2uSO12WSOZWLEkUDt23U4pfsOB2b9FTbgfNuao5xGs+Cfu16tC4xlr78vx9F5Mv+Kbp
         P+XpP+Mi7iC0xzaozcYrRsoQNJZXoxJPjRJ2Wk9DSOPvnLkw0Um5W8sw2WOZKFU5/luO
         fgfzhy2fzuNVQRPbq/evhcYRyTJaef+1sByFDvY9d4aOkckttW54qogjBH2i2JKq9MXC
         aVqAPpAqDKR14HBgEj5cZ3WSm+dWiyzlJWAD4uBOhyGFE6uUxhx96YX1gfjVVzC4YFXM
         8KKg==
X-Received: by 10.180.109.13 with SMTP id ho13mr34465wib.16.1429182642408;
        Thu, 16 Apr 2015 04:10:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.9.106 with SMTP id y10ls568953wia.18.gmail; Thu, 16 Apr
 2015 04:10:41 -0700 (PDT)
X-Received: by 10.180.73.137 with SMTP id l9mr1544743wiv.5.1429182641771;
        Thu, 16 Apr 2015 04:10:41 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id k2si977880wif.0.2015.04.16.04.10.41
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 Apr 2015 04:10:41 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=80.237.132.163;
Received: from p5ddc1deb.dip0.t-ipconnect.de ([93.220.29.235] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1Yihgu-0001Bh-Tn; Thu, 16 Apr 2015 13:10:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1429182641;65b69da9;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267276>

Am 16.04.2015 um 12:03 schrieb Andreas Mohr:
> Hi all,
> 
> over the years I've had the same phenomenon with various versions of msysgit
> (now at 1.9.5.msysgit.0, on Windows 7 64bit), so I'm now sufficiently
> confident of it being a long-standing, longer-term issue and thus I'm
> reporting it now.

(CC'ing msysgit)

Hi Andreas,

> Since I'm doing development in a sufficiently rebase-heavy manner,
> I seem to aggregate a lot of objects.
> Thus, when fetching content I'm sufficiently frequently greeted with
> a git gc run.
> This, however, does not work fully reliably:
> 
>     Auto packing the repository for optimum performance. You may also
>     run "git gc" manually. See "git help gc" for more information.
>     Counting objects: 206527, done.
>     Delta compression using up to 4 threads.
>     Compressing objects: 100% (27430/27430), done.
>     Writing objects: 100% (206527/206527), done.
>     Total 206527 (delta 178632), reused 206527 (delta 178632)
>     Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb3660cedc264c3c.pack' failed. Should I try again? (y/n) n
>     Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb3660cedc264c3c.idx' failed. Should I try again? (y/n) n
>     Checking connectivity: 206527, done.
> 
> A workable workaround for this recurring issue
> (such a fetch will fail repeatedly,
> thereby hampering my ability to update properly)
> is to manually do a "git gc --auto"
> prior to the fetch (which will then succeed).

I've never had this issue. The error message from unlinking the file
means that someone is still accessing the file and thus it can not be
deleted (due to the implicit file locking on windows).

Can you reproduce the error reliably?

Thomas


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
