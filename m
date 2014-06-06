From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 5/5] Win32: Thread-safe windows console output
Date: Sat, 07 Jun 2014 00:03:52 +0200
Message-ID: <53923AC8.2030309@gmail.com>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz> <1402062173-9602-6-git-send-email-kasal@ucw.cz> <alpine.DEB.2.00.1406062224530.17391@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>,
 Karsten Blees <blees@dcon.de>
To: Peter Krefting <peter@softwolves.pp.se>, Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBRPVZCOAKGQEFKWRZKI@googlegroups.com Sat Jun 07 00:03:55 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBRPVZCOAKGQEFKWRZKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f184.google.com ([74.125.82.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBRPVZCOAKGQEFKWRZKI@googlegroups.com>)
	id 1Wt2Eo-0006C4-9u
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 00:03:50 +0200
Received: by mail-we0-f184.google.com with SMTP id u56sf208045wes.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=TKSrEzuI1RchQkdsDGLzU19zR6A1d+HYcswYN99OtWM=;
        b=hTI0rd+Wh6zmwZZhoNazAEdwJih9AUXg0jl1r/idk6DUDf6CI9A6m+alEpmCj+Lkjk
         qF4shMrT/+HkTEcqwLvfW90ZpVmYanheI054VbLH5LKY70+q8gV7BanRCOnfrWlAuN9J
         GBWTDA2dTobgiN7ANJ6RT60lnnvNvackJU+vJBSSdodaUsGQOAON0AZDHMTxz9iJ+Dzq
         9/SLlKR0Mm147KSve0OCDo/dBKiVUDW3RldLn3IlmFgrNkcreOO+MXT05/REjng3dHyf
         CM0z8e4Bp69irG3ckoEw4NRpO+5vtM65fe6luIwJN0/EFoxTa4keBfH8oolstm2kWLJZ
         S1/A==
X-Received: by 10.152.87.2 with SMTP id t2mr82laz.40.1402092229944;
        Fri, 06 Jun 2014 15:03:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.130 with SMTP id e2ls154625lam.16.gmail; Fri, 06 Jun
 2014 15:03:48 -0700 (PDT)
X-Received: by 10.112.204.201 with SMTP id la9mr2226280lbc.3.1402092228899;
        Fri, 06 Jun 2014 15:03:48 -0700 (PDT)
Received: from mail-we0-x235.google.com (mail-we0-x235.google.com [2a00:1450:400c:c03::235])
        by gmr-mx.google.com with ESMTPS id xk11si1441146wib.0.2014.06.06.15.03.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 15:03:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::235 as permitted sender) client-ip=2a00:1450:400c:c03::235;
Received: by mail-we0-f181.google.com with SMTP id w61so3412342wes.40
        for <msysgit@googlegroups.com>; Fri, 06 Jun 2014 15:03:48 -0700 (PDT)
X-Received: by 10.14.113.136 with SMTP id a8mr1820324eeh.0.1402092228792;
        Fri, 06 Jun 2014 15:03:48 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w6sm25647496eej.7.2014.06.06.15.03.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 15:03:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <alpine.DEB.2.00.1406062224530.17391@ds9.cixit.se>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::235
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250972>

Am 06.06.2014 23:29, schrieb Peter Krefting:
> Stepan Kasal:
>=20
>> +    /* only called from console_thread, so a static buffer will do */
>> +    static wchar_t wbuf[2 * BUFFER_SIZE + 1];
>=20
> Wouldn't BUFFER_SIZE + 1 (or even BUFFER_SIZE) do here? If you convert fr=
om up to BUFFER_SIZE octets of UTF-8 input, you should never get back more =
than BUFFER_SIZE code units of UTF-16 output. Worst case would be ASCII, wh=
ich is one UTF-16 code unit per UTF-8 octet, everything else is less (non-B=
MP is four UTF-8 octets mapping to two UTF-16 code units).
>=20

You're right for MultiByteToWideChar. However, the next patch series will i=
ntroduce another conversion function that converts invalid UTF-8 to hex cod=
e, i.e. two wide chars per invalid UTF-8 char, +1 for L'\0' (see [1] mingw.=
h:365ff for space requirement rationale). And yet another patch will replac=
e this patch's MultiByteToWideChar for consistentcy [2].

[1] https://github.com/msysgit/git/commit/018c94a8
[2] https://github.com/msysgit/git/commit/45e28a4d

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
