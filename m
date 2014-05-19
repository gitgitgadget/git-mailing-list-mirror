From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH/RFC] send-pack.c: Allow to disable side-band-64k
Date: Mon, 19 May 2014 22:29:59 +0200
Message-ID: <CABPQNSb7B6D_XthOOCfadXA8agLUhoSYy5=20OL2fh598evR1g@mail.gmail.com>
References: <1400526434-3132-1-git-send-email-thomas.braun@byte-physics.de>
 <20140519193340.GP12314@google.com> <CABPQNSbYVZP4CcatWLuv5m-RFWWgOuKOJJcceBkcEzyJQQ+BqA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Braun <thomas.braun@byte-physics.de>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRB4GT5GNQKGQEBPRY27Q@googlegroups.com Mon May 19 22:30:41 2014
Return-path: <msysgit+bncBDR53PPJ7YHRB4GT5GNQKGQEBPRY27Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f190.google.com ([209.85.216.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB4GT5GNQKGQEBPRY27Q@googlegroups.com>)
	id 1WmUCn-0006bP-9V
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 22:30:41 +0200
Received: by mail-qc0-f190.google.com with SMTP id i17sf1861753qcy.27
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=VQqDd9LPgRw9FyfGflokZNOl5kHodlI7I1xJkGZ9OH0=;
        b=HQrwmnXDBIcGwdMl6hXOAzVWPYOprOhbyxw6NB0Gc8GQlfKOFWyZdegdD31KufS3sX
         E0Xmq5uIt/l4Ig0BNjGKEXoV5C8HhBZ3n3hihVZrULF3NzIz7DnL+iLRILAc+o9/WiIG
         1hYyQ1Oi5U2sz8hxD5SG7LNiEfGP9VXR47HRH7MLaQcLBAnkbveEqFXk8+CchmjS3t4M
         dwoVgHULWk9u7F8njy93etZsfRCIuAl0QRo88p2ZPTFIbMVclvnmq8WpmIlXwFg4wZWc
         mTmRVjWBrBm+UUNBc/V/1U2+PUhJ1W50HbXB4FvmDFbn87Aki9tylvjvM5enulD5czjK
         lSNw==
X-Received: by 10.140.97.119 with SMTP id l110mr52039qge.21.1400531440415;
        Mon, 19 May 2014 13:30:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.24.42 with SMTP id 39ls1845970qgq.26.gmail; Mon, 19 May
 2014 13:30:39 -0700 (PDT)
X-Received: by 10.58.178.232 with SMTP id db8mr10285289vec.21.1400531439884;
        Mon, 19 May 2014 13:30:39 -0700 (PDT)
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com [2607:f8b0:4001:c05::22d])
        by gmr-mx.google.com with ESMTPS id 6si752486igs.1.2014.05.19.13.30.39
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 13:30:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22d as permitted sender) client-ip=2607:f8b0:4001:c05::22d;
Received: by mail-ig0-x22d.google.com with SMTP id hn18so4003691igb.0
        for <msysgit@googlegroups.com>; Mon, 19 May 2014 13:30:39 -0700 (PDT)
X-Received: by 10.50.153.11 with SMTP id vc11mr1054067igb.24.1400531439697;
 Mon, 19 May 2014 13:30:39 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 19 May 2014 13:29:59 -0700 (PDT)
In-Reply-To: <CABPQNSbYVZP4CcatWLuv5m-RFWWgOuKOJJcceBkcEzyJQQ+BqA@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22d
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249619>

On Mon, May 19, 2014 at 10:00 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Mon, May 19, 2014 at 9:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi,
>>
>> Thomas Braun wrote:
>>
>>> pushing over the dump git protocol with a windows git client.
>>
>> I've never heard of the dump git protocol.  Do you mean the git
>> protocol that's used with git:// URLs?
>>
>> [...]
>>> Alternative approaches considered but deemed too invasive:
>>> - Rewrite read/write wrappers in mingw.c in order to distinguish between
>>>   a file descriptor which has a socket behind and a file descriptor
>>>   which has a file behind.
>>
>> I assume here "too invasive" means "too much engineering effort"?
>>
>> It sounds like a clean fix, not too invasive at all.  But I can
>> understand wanting a stopgap in the meantime.
>>
>
> Yeah, now that the problem seems to be understood, I don't think that
> would be too bad. I recently killed off our previous write()-wrapper
> in c9df6f4, but I see no reason why we can't add a new one.
>
> Would we need to wrap both ends, shouldn't wrapping only reading be
> good enough to prevent deadlocking?
>
> compat/poll/poll.c already contains a function called IsSocketHandle
> that is able to tell if a HANDLE points to a socket or not.

This very quick attempt did not work out :(

diff --git a/compat/mingw.c b/compat/mingw.c
index 0335958..ec1d81f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -370,6 +370,65 @@ int mingw_open (const char *filename, int oflags, ...)
     return fd;
 }

+#define is_console_handle(h) (((long) (h) & 3) == 3)
+
+static int is_socket_handle(HANDLE h)
+{
+    WSANETWORKEVENTS ev;
+
+    if (is_console_handle(h))
+        return 0;
+
+    /*
+     * Under Wine, it seems that getsockopt returns 0 for pipes too.
+     * WSAEnumNetworkEvents instead distinguishes the two correctly.
+     */
+    ev.lNetworkEvents = 0xDEADBEEF;
+    WSAEnumNetworkEvents((SOCKET) h, NULL, &ev);
+    return ev.lNetworkEvents != 0xDEADBEEF;
+}
+
+#undef read
+ssize_t mingw_read(int fd, void *buf, size_t count)
+{
+    int ret;
+    HANDLE fh = (HANDLE)_get_osfhandle(fd);
+
+    if (fh == INVALID_HANDLE_VALUE) {
+        errno = EBADF;
+        return -1;
+    }
+
+    if (!is_socket_handle(fh))
+        return read(fd, buf, count);
+
+    ret = recv((SOCKET)fh, buf, count, 0);
+    if (ret < 0)
+        errno = WSAGetLastError();
+    return ret;
+}
+
+#undef write
+ssize_t mingw_write(int fd, const void *buf, size_t count)
+{
+    int ret;
+    HANDLE fh = (HANDLE)_get_osfhandle(fd);
+
+    if (fh == INVALID_HANDLE_VALUE) {
+        errno = EBADF;
+        return -1;
+    }
+
+    if (!is_socket_handle(fh))
+        return write(fd, buf, count);
+
+    return send((SOCKET)fh, buf, count, 0);
+    if (ret < 0)
+        errno = WSAGetLastError();
+    return ret;
+}
+
+
 static BOOL WINAPI ctrl_ignore(DWORD type)
 {
     return TRUE;
diff --git a/compat/mingw.h b/compat/mingw.h
index 08b83fe..1690098 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -177,6 +177,12 @@ int mingw_rmdir(const char *path);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open

+ssize_t mingw_read(int fd, void *buf, size_t count);
+#define read mingw_read
+
+ssize_t mingw_write(int fd, const void *buf, size_t count);
+#define write mingw_write
+
 int mingw_fgetc(FILE *stream);
 #define fgetc mingw_fgetc

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
