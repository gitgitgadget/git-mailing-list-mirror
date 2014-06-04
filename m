From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 04 Jun 2014 16:55:46 +0200
Message-ID: <538F3372.5070400@gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, 
 Thomas Braun <thomas.braun@virtuell-zuhause.de>,
 msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com, Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBB4XGXSOAKGQEHD5Q72Q@googlegroups.com Wed Jun 04 16:55:47 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB4XGXSOAKGQEHD5Q72Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB4XGXSOAKGQEHD5Q72Q@googlegroups.com>)
	id 1WsCbS-0005nz-Uf
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 16:55:46 +0200
Received: by mail-lb0-f192.google.com with SMTP id p9sf763192lbv.19
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=KEKneIZLQPven7P1uTA4vA8xlFVPJTTkhDdSwO7yk9M=;
        b=lYiseTqO17ZrkWMWwdSY2liR+OpzKey51cxAFdTzicdogFTKkugZBhu1Y/BmyFw9uR
         Jylqn5T3/GflEKwxoDMPe6lhjD3Jen1h3yp/xBwV1VZlzlnKKA9BV+Hpqio6IgnNq1DN
         OR3kDM/MVLmXmFG7G2NN90DID3JIVCTmfTlBl8qqPBEj6LKxGCimZMkzEtjfGGkGb5k0
         psSqiMBONR8Rrf65NMfvdf1bTlWNb4Bzgf3HUSBLVnnHwyx5nr1NsLLDcNYVM5x0auly
         /2zZvf5XFBMSVFHp3wD8WB4zGciAfis6hkgzVI5dCt2of1nEMka4uN7uXWMT+e6pel5D
         iH8Q==
X-Received: by 10.152.20.194 with SMTP id p2mr13769lae.24.1401893746782;
        Wed, 04 Jun 2014 07:55:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.120.2 with SMTP id ky2ls482245lab.96.gmail; Wed, 04 Jun
 2014 07:55:45 -0700 (PDT)
X-Received: by 10.112.19.103 with SMTP id d7mr2335613lbe.2.1401893745735;
        Wed, 04 Jun 2014 07:55:45 -0700 (PDT)
Received: from mail-wi0-x234.google.com (mail-wi0-x234.google.com [2a00:1450:400c:c05::234])
        by gmr-mx.google.com with ESMTPS id x7si585708wiw.1.2014.06.04.07.55.45
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 07:55:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::234 as permitted sender) client-ip=2a00:1450:400c:c05::234;
Received: by mail-wi0-x234.google.com with SMTP id hi2so1644176wib.13
        for <msysgit@googlegroups.com>; Wed, 04 Jun 2014 07:55:45 -0700 (PDT)
X-Received: by 10.15.61.5 with SMTP id h5mr2037535eex.40.1401893745562;
        Wed, 04 Jun 2014 07:55:45 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 8sm6339909eea.10.2014.06.04.07.55.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 07:55:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::234
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250734>

Am 04.06.2014 16:05, schrieb Erik Faye-Lund:
> On Wed, Jun 4, 2014 at 3:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Jun 4, 2014 at 6:47 PM, Stepan Kasal <kasal@ucw.cz> wrote:
>>> @@ -133,7 +133,7 @@ char *git_path(const char *fmt, ...)
>>>  void home_config_paths(char **global, char **xdg, char *file)
>>>  {
>>>         char *xdg_home =3D getenv("XDG_CONFIG_HOME");
>>> -       char *home =3D getenv("HOME");
>>> +       const char *home =3D get_home_directory();
>>>         char *to_free =3D NULL;
>>>
>>>         if (!home) {
>>
>> Just checking. Instead of replace the call sites, can we check and
>> setenv("HOME") if it's missing instead? MinGW port already replaces
>> main(). Extra initialization should not be a problem. I feel
>> "getenv("HOME")" a tiny bit more familiar than get_home_directory(),
>> but that's really weak argument as the number of call sites has not
>> increased in 4 years.
>=20

Setting the variable instead of wrapping getenv has the additional benefit =
that it also affects child processes (read: scripted commands).

> Yeah. But we already set %HOME% to %HOMEDRIVE%%HOMEPATH% in
> /etc/profile, git-cmd.bat, gitk.cmd *and* git-wrapper... Do we really
> need one more place?
>=20

...all of these also do the string concatenation correctly (i.e. not "C:/\U=
sers\MyName" as this patch does), fall back to %USERPROFILE% if %HOMEPATH% =
is not set, and most (except git-wrapper) even check that the directory exi=
sts. So IMO this patch has been superseded by more robust solutions and sho=
uld be dropped.


--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
