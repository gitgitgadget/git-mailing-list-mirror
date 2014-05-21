From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH v4 2/3] add trace_performance facility to
 debug performance issues
Date: Wed, 21 May 2014 20:34:47 +0200
Message-ID: <537CF1C7.6030408@gmail.com>
References: <537BA806.50600@gmail.com> <537BA8D7.4000007@gmail.com> <20140521165806.GD2040@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBR7D6ONQKGQEO4XPMSI@googlegroups.com Wed May 21 20:34:49 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBR7D6ONQKGQEO4XPMSI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f55.google.com ([74.125.83.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBR7D6ONQKGQEO4XPMSI@googlegroups.com>)
	id 1WnBLk-0003DT-P1
	for gcvm-msysgit@m.gmane.org; Wed, 21 May 2014 20:34:48 +0200
Received: by mail-ee0-f55.google.com with SMTP id t10sf264822eei.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 May 2014 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=xNwBeOV31zSWnXYJ1hYCPJdG1dl+g6vJitQCL67qGDE=;
        b=rGLp4BJQmk0M+/vvtXKLcfFwCHMjiPADvmmW3SPUSgacA6YXG4WCfocUCeXZduwPu7
         W87dmMz9fmaCIUSDQAgXiy11X3Q2gS5a4M+UVPgHADmUDoNCRD7E9KtSIboASqMyJ1tM
         loLdLPRpWLhIeII7WbMlSo76gImQSZwsIckCHnphJgCdjxg3DyIr5L/8VxMoZfhXpyzN
         l/8dyrHtv8gGuueECeRllIfFuUgl6NoZfYESeS4dDNaTFyYxpT8Zfu0bdoqcPxfo+NGu
         0y8kV/cqgl8uQtGyDHUH23hN9z5SWbsuRNi48X/E91B9K4SP/g2VGwwP+SFqiC+r/lM5
         Rcaw==
X-Received: by 10.180.208.50 with SMTP id mb18mr65440wic.9.1400697288368;
        Wed, 21 May 2014 11:34:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.14.42 with SMTP id m10ls146445wic.21.gmail; Wed, 21 May
 2014 11:34:46 -0700 (PDT)
X-Received: by 10.180.14.130 with SMTP id p2mr1210697wic.0.1400697286874;
        Wed, 21 May 2014 11:34:46 -0700 (PDT)
Received: from mail-ee0-x232.google.com (mail-ee0-x232.google.com [2a00:1450:4013:c00::232])
        by gmr-mx.google.com with ESMTPS id g42si2176270eev.1.2014.05.21.11.34.46
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 May 2014 11:34:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::232 as permitted sender) client-ip=2a00:1450:4013:c00::232;
Received: by mail-ee0-x232.google.com with SMTP id e51so1918137eek.9
        for <msysgit@googlegroups.com>; Wed, 21 May 2014 11:34:46 -0700 (PDT)
X-Received: by 10.14.127.9 with SMTP id c9mr5989577eei.93.1400697286801;
        Wed, 21 May 2014 11:34:46 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id h49sm13788327eeg.21.2014.05.21.11.34.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 May 2014 11:34:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140521165806.GD2040@sigill.intra.peff.net>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::232
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249821>

Am 21.05.2014 18:58, schrieb Jeff King:
> On Tue, May 20, 2014 at 09:11:19PM +0200, Karsten Blees wrote:
>=20
>> Add trace_performance and trace_performance_since macros that print file
>> name, line number, time and an optional printf-formatted text to the fil=
e
>> specified in environment variable GIT_TRACE_PERFORMANCE.
>>
>> Unless enabled via GIT_TRACE_PERFORMANCE, these macros have no noticeabl=
e
>> impact on performance, so that test code may be shipped in release build=
s.
>>
>> MSVC: variadic macros (__VA_ARGS__) require VC++ 2005 or newer.
>=20
> I think we still have some Unix compilers that do not do variadic
> macros, either. For a while, people were compiling with antique stuff
> like SUNWspro and MIPSpro. I don't know if they still do, if they use
> gcc on such systems now, or if those systems have finally been
> decomissioned.
>=20
> But either we need to change our stance on variadic macros, or this
> feature needs to be able to be compiled conditionally.
>=20
> -Peff
>=20

Macros are mainly used to supply __FILE__ and __LINE__, so that lazy people=
 don't need to think of a unique message for each use of trace_performance_=
*. Without __FILE__, __LINE__ and message, the output would be pretty usele=
ss (i.e. just the time without any additional info).

If there's platforms that don't support variadic macros, I'd suggest to dro=
p the __FILE__ __LINE__ feature completely and make message mandatory (with=
 the added benefit that manually provided messages don't change if the code=
 is moved, i.e. trace logs would become somewhat comparable across versions=
).

(adding cc: Dscho as IIRC the __FILE__ __LINE__ idea was originally his).

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
