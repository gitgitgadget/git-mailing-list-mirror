From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/17] .gitignore: improve MSVC ignore patterns
Date: Thu, 25 Jun 2015 08:13:39 -0700
Message-ID: <xmqqd20j253w.fsf@gitster.dls.corp.google.com>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
	<1435190633-2208-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GitList <git@vger.kernel.org>,  MsysGitList <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCG77UMM3EJRBJNVWCWAKGQE6LT4DJI@googlegroups.com Thu Jun 25 17:13:43 2015
Return-path: <msysgit+bncBCG77UMM3EJRBJNVWCWAKGQE6LT4DJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f192.google.com ([209.85.223.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBJNVWCWAKGQE6LT4DJI@googlegroups.com>)
	id 1Z88qU-00086G-NT
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 17:13:42 +0200
Received: by ierx19 with SMTP id x19sf19905178ier.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Jun 2015 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=PrT+yexVNK9aYlMWdRtx9uQdrr6rcRD2NtyZSI+20jM=;
        b=nuJY0mZvdQthEYpTZas5rJOzvSD0lQBgKH+RP2LHPlouQsiK5ESXUBPvDPOcexuJgL
         GLHBBJITWqCpof2ddEULPdR51Bsi/W0Q95B4HIUTI/8+aw5vV9uVDd3mZ1V/vBRl+r5o
         4y4YJkOQ3JXcpaiG8eKNmEsCKfkL2KAux3SyPVh2ILpeUEXWc57zRdgs2+uJUHCyXvI6
         bldLzakdKsnK748jm2pxn+mZnIxVozMzf1ji4/cjG8CngIyIMhvdqav9fJTd+fe/XudL
         g/Mo5sFcw6XPyp3ZdWnoOLQ9UNMGyRkqUicQmIYOPRIAq1hgpsmx5nbzQPp08HgYRDPI
         vM9w==
X-Received: by 10.50.50.167 with SMTP id d7mr73281igo.10.1435245222023;
        Thu, 25 Jun 2015 08:13:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.132.18 with SMTP id g18ls708110iod.67.gmail; Thu, 25 Jun
 2015 08:13:41 -0700 (PDT)
X-Received: by 10.42.10.142 with SMTP id q14mr33720385icq.28.1435245221522;
        Thu, 25 Jun 2015 08:13:41 -0700 (PDT)
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com. [2607:f8b0:4001:c05::236])
        by gmr-mx.google.com with ESMTPS id x1si547760igb.2.2015.06.25.08.13.41
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 08:13:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c05::236 as permitted sender) client-ip=2607:f8b0:4001:c05::236;
Received: by mail-ig0-x236.google.com with SMTP id lr2so57475842igb.0
        for <msysgit@googlegroups.com>; Thu, 25 Jun 2015 08:13:41 -0700 (PDT)
X-Received: by 10.107.134.16 with SMTP id i16mr26782152iod.6.1435245221449;
        Thu, 25 Jun 2015 08:13:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id g1sm19737581iog.4.2015.06.25.08.13.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 08:13:40 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <1435190633-2208-2-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Thu, 25 Jun 2015 01:03:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c05::236
 as permitted sender) smtp.mail=jch2355@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272684>

Philip Oakley <philipoakley@iee.org> writes:

> Add the Microsoft .manifest pattern, and correct the generic 'Debug'
> and 'Release' directory patterns which were mechanically adjusted way
> back in c591d5f (gitignore: root most patterns at the top-level directory,
> 2009-10-26) to allow multi-level projects within the Git suite.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  .gitignore | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 422c538..55498c1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -246,5 +246,6 @@
>  *.user
>  *.idb
>  *.pdb
> -/Debug/
> -/Release/
> +*.manifest
> +**/Debug/
> +**/Release/

Why "**/" there?  Wouldn't

*.manifest
Debug/
Release/

suffice?

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
