From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Re: [PATCH 7/7] t0000: verify that real_path() removes
 extra slashes
Date: Fri, 7 Sep 2012 08:18:39 +0700
Message-ID: <CACsJy8AqMGo5+jPS9RHEjSwA-VrmO+WCM3Y2hPN9U8FRie4U-A@mail.gmail.com>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu> <7v1uihbqhf.fsf@alter.siamese.dyndns.org>
 <CACsJy8DAbp1uDsNFFk1g9tuEV1qMnM2DZtxOwp5H9_VE7VwO1g@mail.gmail.com>
 <7v1uif7s1d.fsf@alter.siamese.dyndns.org> <20120906054407.GA25981@duynguyen-vnpc.dek-tpc.internal>
 <7vharb3vib.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: mhagger@alum.mit.edu, Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, 
	Orgad and Raizel Shaneh <orgads@gmail.com>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncCLWW9eeFGBCOl6WCBRoEzD9rOQ@googlegroups.com Fri Sep 07 03:19:15 2012
Return-path: <msysgit+bncCLWW9eeFGBCOl6WCBRoEzD9rOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f58.google.com ([209.85.216.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLWW9eeFGBCOl6WCBRoEzD9rOQ@googlegroups.com>)
	id 1T9nE2-0004DY-Ac
	for gcvm-msysgit@m.gmane.org; Fri, 07 Sep 2012 03:19:14 +0200
Received: by qaec1 with SMTP id c1sf1908596qae.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 06 Sep 2012 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:from
         :date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=jRAnU94/vRAlLsRmISPFBb1qD877Z2WCW8XljW0qqWk=;
        b=IjG0UtgkQnPe4BzhgVUHUYdfxW6u6/m5rI6PTAILfM8WxSKZayCxmAJlXy0fSb+7wK
         eAxGTSb8k96HvkK20ZoFl+lZLlGcjwG14bjXSL/Yex3vXwubTz14p8jF4sIyXez37RLP
         4y9ulN48ZnkaFClmkj9EgyB+rqw/kE4pJX0UPuIO2Q1sLsk9OvCC0iVH1xlZQ/tZQ2rx
         yghB6tPU0X2CSTWIuOeei+hQNyG5I94CnAwM2xTIvfnyPRePEN2XXauZ3ivnE+z+rYwp
         00fPhxdkfkD1CLOOtkm+lJPhDtcf6OFedoHRasBxCEBTXgQldcmray5i6h15ra1yQatI
         FMVw==
Received: by 10.50.196.131 with SMTP id im3mr2317000igc.6.1346980750611;
        Thu, 06 Sep 2012 18:19:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.37.197 with SMTP id a5ls117372igk.4.gmail; Thu, 06 Sep 2012
 18:19:09 -0700 (PDT)
Received: by 10.42.90.4 with SMTP id i4mr1905762icm.19.1346980749911;
        Thu, 06 Sep 2012 18:19:09 -0700 (PDT)
Received: by 10.42.90.4 with SMTP id i4mr1905761icm.19.1346980749901;
        Thu, 06 Sep 2012 18:19:09 -0700 (PDT)
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com [209.85.223.177])
        by gmr-mx.google.com with ESMTPS id u5si1379960igw.3.2012.09.06.18.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 18:19:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 209.85.223.177 as permitted sender) client-ip=209.85.223.177;
Received: by ieje10 with SMTP id e10so5400444iej.22
        for <msysgit@googlegroups.com>; Thu, 06 Sep 2012 18:19:09 -0700 (PDT)
Received: by 10.50.193.201 with SMTP id hq9mr5644119igc.48.1346980749782; Thu,
 06 Sep 2012 18:19:09 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Thu, 6 Sep 2012 18:18:39 -0700 (PDT)
In-Reply-To: <7vharb3vib.fsf@alter.siamese.dyndns.org>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pclouds@gmail.com designates 209.85.223.177 as permitted sender)
 smtp.mail=pclouds@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204942>

On Fri, Sep 7, 2012 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Modulo that I suspect you could get rid of offset_1st_component()
> altogether and has_dos_drive_prefix() return the length of the "d:"
> or "//d" part (which needs to be copied literally regardless of the
> "normalization"), what you suggest feels like the right approach.
> Why do you need the "keep_root" parameter and do things differently
> depending on the setting by the way?

That's how offset_1st_component() originally works, root slash if
present is counted.

> Wouldn't "skip the root level
> when computing the offset of the first path component" something the
> caller can easily decide to do or not to do, and wouldn't it make
> the semantics of the function cleaner and simpler by making it do
> only one thing and one thing well?

Yeah. I'll have a closer look later and see if we can simplify the function.
-- 
Duy

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
