From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 05/14] mingw: use real pid
Date: Sun, 10 Oct 2010 17:56:25 -0400
Message-ID: <4CB23689.7020100@sunshineco.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-6-git-send-email-kusmabite@gmail.com> <4CB219D3.8000801@sunshineco.com> <AANLkTinmpzo2-eyPrnx0u=tGBOcMBz03LuFUjZO87dG5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: kusmabite@gmail.com
X-From: msysgit+bncCPSUiZjBDBCP7cjlBBoEKt4I7Q@googlegroups.com Sun Oct 10 23:56:59 2010
Return-path: <msysgit+bncCPSUiZjBDBCP7cjlBBoEKt4I7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-px0-f186.google.com ([209.85.212.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCPSUiZjBDBCP7cjlBBoEKt4I7Q@googlegroups.com>)
	id 1P53t2-0001gA-R7
	for gcvm-msysgit@m.gmane.org; Sun, 10 Oct 2010 23:56:57 +0200
Received: by pxi18 with SMTP id 18sf2769469pxi.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 10 Oct 2010 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:sender:message-id
         :date:from:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=G9vQKc6391c9JByfXdcPRqt+RPzYTtjHAUxUfE3t/Js=;
        b=ZDprrkCZHT5OcB6UlD9agHSuTC/ud3kYSFD88Ixlw9iF8PwFJuau/p5d98JS+ORBK4
         nbCd7neAxWZ4x3uD/4sPmJfmrMLfyeRjht6zHRtL6Tu5tevAQr8gFxrkxRMUm0F+fIBf
         OLoRiVDdnoOfGk7MRr7QKVreOrYoHfcjhPw5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:sender:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:list-subscribe:list-unsubscribe
         :content-type:content-transfer-encoding;
        b=K9VNqZiydoyXzzjLnYoDjiKvkgo1I0HJYY9bV7w6Uv74DPj2eiGubNukGs5X5ZmX1q
         78ViGLwk2WzDaqCCSwdPDLYXQY07QKKeG0JNi6cG2D89Le4f5oy5SCvC/Z/gotAPVDEU
         aupreE9N+mrEUf3YK+gTXEixplBt0ouUEI0ns=
Received: by 10.142.2.25 with SMTP id 25mr170893wfb.25.1286747791892;
        Sun, 10 Oct 2010 14:56:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.142.194.14 with SMTP id r14ls2598600wff.2.p; Sun, 10 Oct 2010
 14:56:31 -0700 (PDT)
Received: by 10.142.147.7 with SMTP id u7mr445113wfd.59.1286747791151;
        Sun, 10 Oct 2010 14:56:31 -0700 (PDT)
Received: by 10.142.147.7 with SMTP id u7mr445112wfd.59.1286747791125;
        Sun, 10 Oct 2010 14:56:31 -0700 (PDT)
Received: from mail-pw0-f46.google.com (mail-pw0-f46.google.com [209.85.160.46])
        by gmr-mx.google.com with ESMTP id w30si5919137wfd.7.2010.10.10.14.56.30;
        Sun, 10 Oct 2010 14:56:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of ericsunshine@gmail.com designates 209.85.160.46 as permitted sender) client-ip=209.85.160.46;
Received: by pwj4 with SMTP id 4so728634pwj.19
        for <msysgit@googlegroups.com>; Sun, 10 Oct 2010 14:56:30 -0700 (PDT)
Received: by 10.114.26.6 with SMTP id 6mr6171283waz.82.1286747789934;
        Sun, 10 Oct 2010 14:56:29 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id f20sm8763733waj.8.2010.10.10.14.56.27
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 14:56:29 -0700 (PDT)
Sender: msysgit@googlegroups.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTinmpzo2-eyPrnx0u=tGBOcMBz03LuFUjZO87dG5@mail.gmail.com>
X-Original-Sender: ericsunshine@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of ericsunshine@gmail.com designates 209.85.160.46 as permitted
 sender) smtp.mail=ericsunshine@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158721>

On 10/10/2010 4:52 PM, Erik Faye-Lund wrote:
> On Sun, Oct 10, 2010 at 9:53 PM, Eric Sunshine<sunshine@sunshineco.com>  wrote:
>> On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>>>
>>> The Windows port so far used process handles as PID. However,
>>> this does not work consistently with getpid.
>>
>> Perhaps this could be elaborated a bit to explain the interaction with
>> getpid() and how it is causing problems for daemon mode. For the casual
>> reader, it is not immediately obvious what is failing or why this patch is
>> needed.
>>
>
> Good point. How about something like this?

Thanks. This sort of explanation could indeed be helpful as part of the 
commit message.

> "The Windows port so far used process handles as PID. However, this is
> not consistent with what getpid returns.
>
> PIDs are system-global identifiers, but process handles are local to a
> process. Using PIDs instead of process handles allows for instance a
> user to kill a hung process with the Task Manager, something that
> would have been impossible with process handles."

Minor nit: Add commas around 'for instance': "...handles allows, for 
instance, a user..."

These also could be combined into a single paragraph.

-- ES
