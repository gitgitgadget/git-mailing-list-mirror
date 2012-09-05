From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] t0000: verify that real_path() removes
 extra slashes
Date: Wed, 5 Sep 2012 18:13:56 +0700
Message-ID: <CACsJy8BmK64FB61LOH6gn-sW1dnq9CV0SoLXAUdcBCY=5z5aGQ@mail.gmail.com>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu> <7v1uihbqhf.fsf@alter.siamese.dyndns.org>
 <CACsJy8DAbp1uDsNFFk1g9tuEV1qMnM2DZtxOwp5H9_VE7VwO1g@mail.gmail.com> <CAGHpTB+LipLt3CgVt5O0s9xj5HHf9Y5z9QWEy+FKYH8s4O7Q2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: msysgit+bncCLWW9eeFGBCT6JyCBRoEJpDHfg@googlegroups.com Wed Sep 05 13:14:32 2012
Return-path: <msysgit+bncCLWW9eeFGBCT6JyCBRoEJpDHfg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f186.google.com ([209.85.223.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLWW9eeFGBCT6JyCBRoEJpDHfg@googlegroups.com>)
	id 1T9DZ1-0006mg-SJ
	for gcvm-msysgit@m.gmane.org; Wed, 05 Sep 2012 13:14:32 +0200
Received: by ieak13 with SMTP id k13sf254858iea.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Sep 2012 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:from
         :date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=EKG6TuecE61J0nJET+ROC7Rcy8l00OrUOZnaFX07A/A=;
        b=KWSzPswP5qroc3PDnJR5aWz2xJ9S/VtOMs6hWrUjXN2ZI8SX0Dj70hLxtfJnfQbiqL
         cPZP+b4o8pcgOWvZFJQWPOPZGTiYoS52GDOCj/UH1MrZQ1YhschqgK8UWHr22+t0eKqY
         dR9bJJe83/l2p0bp7QtZ8DYHo18RS+yceuost1YYRil2YT7ip2cFsgZYSGYPqO2AOkLt
         uAtfYxzJke7AyWSAue1L2vDpC/d98XOb/ck98TiWYBWNl+abhPoq4Bp3UYukx9y1fwEu
         bHgMJbxKCB0rxYC2R7hEHA2Pv/OJysp+nkxm0AVyt3YoVyfPZhRB30WJlOkUALE+FAV6
         cIIw==
Received: by 10.50.46.131 with SMTP id v3mr6655190igm.1.1346843668444;
        Wed, 05 Sep 2012 04:14:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.231.2.13 with SMTP id 13ls570932ibh.1.gmail; Wed, 05 Sep 2012
 04:14:27 -0700 (PDT)
Received: by 10.42.19.199 with SMTP id d7mr11027517icb.11.1346843667558;
        Wed, 05 Sep 2012 04:14:27 -0700 (PDT)
Received: by 10.42.19.199 with SMTP id d7mr11027515icb.11.1346843667548;
        Wed, 05 Sep 2012 04:14:27 -0700 (PDT)
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com [209.85.223.176])
        by gmr-mx.google.com with ESMTPS id ar7si2052666igc.0.2012.09.05.04.14.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 04:14:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 209.85.223.176 as permitted sender) client-ip=209.85.223.176;
Received: by iecs9 with SMTP id s9so243521iec.21
        for <msysgit@googlegroups.com>; Wed, 05 Sep 2012 04:14:27 -0700 (PDT)
Received: by 10.50.193.201 with SMTP id hq9mr17202371igc.48.1346843667387;
 Wed, 05 Sep 2012 04:14:27 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Wed, 5 Sep 2012 04:13:56 -0700 (PDT)
In-Reply-To: <CAGHpTB+LipLt3CgVt5O0s9xj5HHf9Y5z9QWEy+FKYH8s4O7Q2w@mail.gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pclouds@gmail.com designates 209.85.223.176 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204813>

On Wed, Sep 5, 2012 at 6:05 PM, Orgad and Raizel Shaneh
<orgads@gmail.com> wrote:
> This seems to fix it. Just change src[x] == '/' to is_dir_sep(src[x]).

So you are able to test the changes. Would you mind submitting a patch
so other users benefit it as well?
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
