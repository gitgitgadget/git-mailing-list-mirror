From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/2] prefer xwrite instead of write
Date: Fri, 17 Jan 2014 20:08:51 +0100
Message-ID: <CABPQNSYQhctwvJgW4N-=56Oiiop6MyyYNyLKQF6WYps7dpC5Ug@mail.gmail.com>
References: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
 <20140117182148.GY18964@google.com> <xmqq4n52xw95.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRB3P74WLAKGQE3OCRKNQ@googlegroups.com Fri Jan 17 20:09:35 2014
Return-path: <msysgit+bncBDR53PPJ7YHRB3P74WLAKGQE3OCRKNQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f189.google.com ([209.85.220.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB3P74WLAKGQE3OCRKNQ@googlegroups.com>)
	id 1W4EnO-0002N0-Sf
	for gcvm-msysgit@m.gmane.org; Fri, 17 Jan 2014 20:09:35 +0100
Received: by mail-vc0-f189.google.com with SMTP id ij19sf859897vcb.26
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Jan 2014 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=jZjOSVKiOITeaONvqzoI03UjRz1wcPez98rgJ0/yz1s=;
        b=U5bIfcfgYKNmx7CsDwtwszo0GI1UOWjNRf+2zfSZOjOqASIdy4qdVGIuM+CaBd9Dvo
         7C/HtRTC0n0mYPScxtxyVIH2ykgeHFgdW/YRDfVE8Tx11Zi7Ntd8hNRlAlYWJxpsjxKh
         bvEDL/As54DhHhDA4dk8CDTzgSaaIkEkPRTlTuRIMurJBaIMVYux2uv6O0TTHN8KsuRz
         HuLcctyz6d3lpc4AOeLnXvhTzUgoM5lnIeZCph9WiMiBgEc4n44AVpJzMbMLfb0J6IJj
         pgYLciML+JuMyREYR557JN2byh9J29GE9XALcpfXLJFX74TkcetEyuVOnQWDLmBsjIP0
         xAUg==
X-Received: by 10.50.29.41 with SMTP id g9mr116164igh.4.1389985774064;
        Fri, 17 Jan 2014 11:09:34 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.45.105 with SMTP id l9ls591733igm.27.canary; Fri, 17 Jan
 2014 11:09:33 -0800 (PST)
X-Received: by 10.66.231.132 with SMTP id tg4mr1324804pac.31.1389985773151;
        Fri, 17 Jan 2014 11:09:33 -0800 (PST)
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com [2607:f8b0:4001:c03::234])
        by gmr-mx.google.com with ESMTPS id 48si3881556yhf.7.2014.01.17.11.09.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 11:09:33 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::234 as permitted sender) client-ip=2607:f8b0:4001:c03::234;
Received: by mail-ie0-f180.google.com with SMTP id at1so2905692iec.39
        for <msysgit@googlegroups.com>; Fri, 17 Jan 2014 11:09:32 -0800 (PST)
X-Received: by 10.50.29.114 with SMTP id j18mr4424244igh.24.1389985772689;
 Fri, 17 Jan 2014 11:09:32 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Fri, 17 Jan 2014 11:08:51 -0800 (PST)
In-Reply-To: <xmqq4n52xw95.fsf@gitster.dls.corp.google.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::234
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240610>

On Fri, Jan 17, 2014 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Hi,
>>
>> Erik Faye-Lund wrote:
>>
>>> --- a/builtin/merge.c
>>> +++ b/builtin/merge.c
>>> @@ -367,7 +367,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
>>>                      sha1_to_hex(commit->object.sha1));
>>>              pretty_print_commit(&ctx, commit, &out);
>>>      }
>>> -    if (write(fd, out.buf, out.len) < 0)
>>> +    if (xwrite(fd, out.buf, out.len) < 0)
>>>              die_errno(_("Writing SQUASH_MSG"));
>>
>> Shouldn't this use write_in_full() to avoid a silently truncated result? (*)
>
> Meaning this?  If so, I think it makes sense.
>

Yeah, I think that's better. Thanks, both!

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
