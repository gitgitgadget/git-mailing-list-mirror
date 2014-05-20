From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH/RFC] send-pack.c: Allow to disable side-band-64k
Date: Tue, 20 May 2014 11:01:31 +0200
Message-ID: <CABPQNSaa3gRLY0A73-RLfwSy7K7gXHpS8QwFbxxYSCwVyi82Yg@mail.gmail.com>
References: <1400526434-3132-1-git-send-email-thomas.braun@byte-physics.de>
 <20140519193340.GP12314@google.com> <CABPQNSbYVZP4CcatWLuv5m-RFWWgOuKOJJcceBkcEzyJQQ+BqA@mail.gmail.com>
 <CABPQNSb7B6D_XthOOCfadXA8agLUhoSYy5=20OL2fh598evR1g@mail.gmail.com> <537B164F.3080606@byte-physics.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@byte-physics.de>
X-From: msysgit+bncBDR53PPJ7YHRBFFU5SNQKGQEOWTGUPA@googlegroups.com Tue May 20 11:02:14 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBFFU5SNQKGQEOWTGUPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f184.google.com ([209.85.220.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBFFU5SNQKGQEOWTGUPA@googlegroups.com>)
	id 1Wmfw5-0008Up-BV
	for gcvm-msysgit@m.gmane.org; Tue, 20 May 2014 11:02:13 +0200
Received: by mail-vc0-f184.google.com with SMTP id hq16sf50071vcb.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 May 2014 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=+XxgVkF1hlDOJJxzh3M43NeDwieFygyNpTuDiwuczE4=;
        b=juwjqb3Mg4N/iZoP+yIa3oh4YsZOnvj5k8jz1ZRA8AewEMSwSdl4I/KkRa+DFHvRn0
         7gMeHC5jO2xjZi3ivWX3S5jXgKSJjyCTOqpbJrZTxItaYCg4lKV9zmzORzATYen6q//J
         6bgRsNwFW+eMeKVdzpRtQgonaEwtujN8pWtRIHe+I5v0iBu1A/VZoXDMhUVH4DMoIwMx
         Tfs58BeGkfSCgHb9JSnh5477vhz6O/NAiKfnnuvx1sEtcNaZ3Z9snHQTbTlX/bwRYyx+
         Ptyl7oU9nigGyzPU37nI77M/yP49Bv2QWru79jkHyAVxXwjZ2MaYK65VaE+ksJlpBXR/
         X0vQ==
X-Received: by 10.140.48.101 with SMTP id n92mr34702qga.15.1400576532573;
        Tue, 20 May 2014 02:02:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.80.81 with SMTP id b75ls145668qgd.34.gmail; Tue, 20 May
 2014 02:02:12 -0700 (PDT)
X-Received: by 10.58.198.3 with SMTP id iy3mr5650383vec.39.1400576532016;
        Tue, 20 May 2014 02:02:12 -0700 (PDT)
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com [2607:f8b0:4001:c03::22c])
        by gmr-mx.google.com with ESMTPS id gy6si880698igb.2.2014.05.20.02.02.11
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 02:02:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22c as permitted sender) client-ip=2607:f8b0:4001:c03::22c;
Received: by mail-ie0-x22c.google.com with SMTP id tp5so142863ieb.31
        for <msysgit@googlegroups.com>; Tue, 20 May 2014 02:02:11 -0700 (PDT)
X-Received: by 10.42.162.71 with SMTP id w7mr14343926icx.50.1400576531907;
 Tue, 20 May 2014 02:02:11 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 20 May 2014 02:01:31 -0700 (PDT)
In-Reply-To: <537B164F.3080606@byte-physics.de>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22c
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249657>

On Tue, May 20, 2014 at 10:46 AM, Thomas Braun
<thomas.braun@byte-physics.de> wrote:
> Am 19.05.2014 22:29, schrieb Erik Faye-Lund:
>>>  [...]
>>> Would we need to wrap both ends, shouldn't wrapping only reading be
>>> good enough to prevent deadlocking?
>>>
>>> compat/poll/poll.c already contains a function called IsSocketHandle
>>> that is able to tell if a HANDLE points to a socket or not.
>>
>> This very quick attempt did not work out :(
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 0335958..ec1d81f 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -370,6 +370,65 @@ int mingw_open (const char *filename, int oflags, ...)
>>       return fd;
>>   }
>>
>> +#define is_console_handle(h) (((long) (h) & 3) == 3)
>> +
>> +static int is_socket_handle(HANDLE h)
>> +{
>> +    WSANETWORKEVENTS ev;
>> +
>> +    if (is_console_handle(h))
>> +        return 0;
>> +
>> +    /*
>> +     * Under Wine, it seems that getsockopt returns 0 for pipes too.
>> +     * WSAEnumNetworkEvents instead distinguishes the two correctly.
>> +     */
>> +    ev.lNetworkEvents = 0xDEADBEEF;
>> +    WSAEnumNetworkEvents((SOCKET) h, NULL, &ev);
>> +    return ev.lNetworkEvents != 0xDEADBEEF;
>> +}
>> +
>> +#undef read
>> +ssize_t mingw_read(int fd, void *buf, size_t count)
>> +{
>> +    int ret;
>> +    HANDLE fh = (HANDLE)_get_osfhandle(fd);
>> +
>> +    if (fh == INVALID_HANDLE_VALUE) {
>> +        errno = EBADF;
>> +        return -1;
>> +    }
>> +
>> +    if (!is_socket_handle(fh))
>> +        return read(fd, buf, count);
>> +
>> +    ret = recv((SOCKET)fh, buf, count, 0);
>> +    if (ret < 0)
>> +        errno = WSAGetLastError();
>> +    return ret;
>> +}
>> +
>> +#undef write
>> +ssize_t mingw_write(int fd, const void *buf, size_t count)
>> +{
>> +    int ret;
>> +    HANDLE fh = (HANDLE)_get_osfhandle(fd);
>> +
>> +    if (fh == INVALID_HANDLE_VALUE) {
>> +        errno = EBADF;
>> +        return -1;
>> +    }
>> +
>> +    if (!is_socket_handle(fh))
>> +        return write(fd, buf, count);
>> +
>> +    return send((SOCKET)fh, buf, count, 0);
>> +    if (ret < 0)
>> +        errno = WSAGetLastError();
>> +    return ret;
>> +}
>> +
>> +
>>   static BOOL WINAPI ctrl_ignore(DWORD type)
>>   {
>>       return TRUE;
>> diff --git a/compat/mingw.h b/compat/mingw.h
>> index 08b83fe..1690098 100644
>> --- a/compat/mingw.h
>> +++ b/compat/mingw.h
>> @@ -177,6 +177,12 @@ int mingw_rmdir(const char *path);
>>   int mingw_open (const char *filename, int oflags, ...);
>>   #define open mingw_open
>>
>> +ssize_t mingw_read(int fd, void *buf, size_t count);
>> +#define read mingw_read
>> +
>> +ssize_t mingw_write(int fd, const void *buf, size_t count);
>> +#define write mingw_write
>> +
>>   int mingw_fgetc(FILE *stream);
>>   #define fgetc mingw_fgetc
>
> According to [1] you also have to pass WSA_FLAG_OVERLAPPED to avoid the deadlock.
>
> With that change I don't get a hang anymore but a read error with
> errno 10054 aka WSAECONNRESET.
>
> [1]: https://groups.google.com/forum/#!msg/msysgit/at8D7J-h7mw/PM9w-d41cDYJ
>

Yeah, sorry, I noticed this right after sending and tested with that
as well. My results were the same :/

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
For more options, visit https://groups.google.com/d/optout.
