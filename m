From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Avoid declaration after statement
Date: Wed, 23 Sep 2009 02:44:02 -0700 (PDT)
Message-ID: <05f2bea5-0f74-4c89-9a84-d908a80bea20@h30g2000vbr.googlegroups.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org, Johannes.Schindelin@gmx.de,  gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com,  snaury@gmail.com
To: msysGit <msysgit@googlegroups.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 23 11:44:18 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f153.google.com ([209.85.212.153])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqOOY-00077L-AP
	for gcvm-msysgit@m.gmane.org; Wed, 23 Sep 2009 11:44:18 +0200
Received: by vws17 with SMTP id 17so582834vws.25
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Sep 2009 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :mime-version:received:date:in-reply-to:x-ip:references:user-agent
         :x-http-useragent:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=/2FkcoagFM3SK+EwMOw4uQUzrOPx8gky00346nOGOqw=;
        b=TIDyVB5lnwcstvTrtNp8lmBAAfUEnc8xpQFvjfHfGCdlciPunXi8ObgBeyGdMB6ZBW
         5nyDmDq1JCbb5sxoj0HxUJL5ndF5CJKLaEuAT+jn6C1zaJEPofMr84qDMh0Fmvva6T0C
         bFCrV4a3zxFpld/NYCVnnEYDW6jBBVKek3BAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:mime-version:date:in-reply-to:x-ip
         :references:user-agent:x-http-useragent:message-id:subject:from:to
         :cc:content-type:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=Y01y0e29ShjyjwRAOnkC42GUFfAzlsFvCnB6l2Xb0Zh9V0/tzPCiiLn+euTDcf6gWu
         7cZawL9xAKhUKmohbi4LeYEKemqfxLm6tYEBRMHTpEDFfE8JIRZqrnzDpK1Lzkra1Xuv
         2lLP4jpYU7Tw4d1/ddMBD81KxxW9CFiY9jdP4=
Received: by 10.220.69.149 with SMTP id z21mr440864vci.29.1253699051335;
        Wed, 23 Sep 2009 02:44:11 -0700 (PDT)
Received: by 10.177.125.36 with SMTP id c36gr7140yqn.0;
	Wed, 23 Sep 2009 02:44:03 -0700 (PDT)
X-Sender: sschuberth@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.150.87.2 with SMTP id k2mr255696ybb.6.1253699042842; Wed, 23  Sep 2009 02:44:02 -0700 (PDT)
In-Reply-To: <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>
X-IP: 91.64.214.160
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.3)  Gecko/20090824 Firefox/3.5.3,gzip(gfe),gzip(gfe)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128977>


> From: Frank Li <lznuaa@gmail.com>
>
> MSVC does not understand this C99 style
>
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>

Indeed, even in recent Visual Studio versions the C compiler only
understands C90, not C99. Would it make sense to just force MSVC to
compile *.c files with the C++ compiler to fix this, rather than
patching files (which might be necessary for future files, too)? See
the "/TP" command line option to "CL".

--
Sebastian
