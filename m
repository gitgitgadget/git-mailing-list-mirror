From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv2] mingw_rmdir: do not prompt for retry when non-empty
Date: Mon, 10 Dec 2012 17:50:21 +0100
Message-ID: <CABPQNSZL-edn4izfMuss1-3KbLBSrGm8J08wn0TbETtsn2nn+A@mail.gmail.com>
References: <1355150547-8212-1-git-send-email-kusmabite@gmail.com> <7vr4mxc1rd.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRB5NFTCDAKGQETU56JIQ@googlegroups.com Mon Dec 10 17:51:17 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB5NFTCDAKGQETU56JIQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB5NFTCDAKGQETU56JIQ@googlegroups.com>)
	id 1Ti6ZX-0000M4-VN
	for gcvm-msysgit@m.gmane.org; Mon, 10 Dec 2012 17:51:16 +0100
Received: by mail-gh0-f186.google.com with SMTP id f11sf2314545ghb.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 10 Dec 2012 08:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=xLQCAvrn64Q4sxRBtAbwkDiysXDvE2qYR6RSGD2FOiQ=;
        b=GdFYiR8IqtlgoeWi8yNEtRPHnZjiOelhey0RhI/K12NNXXW4RxsMjsO67KHukocJpn
         RNbSeZWmSWc1/qKPV5idpIIz6BsVxt1ZobodfQb+/hx51LD56jc6z+cTzwtjI6i01Sbb
         cW2huUVZP8sVzcdv7r7Ys2wtF3weqoc5CRqH3xkmdb7I6qcc0nLYxny8KuUUv3ll3wUL
         OFusgNULSvZ3JFnLrbTMa9Ux5Wj68VjClbSfe+FwchJJ1knzjLODACPM16mxPuzH/9tY
         L7Ha9XKym4YygLTZD654/WLOeEdx7amf2EHWq7xf7Y0H6Aii6x9vAfcw+6+BTy7sqPNa
         kFKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=xLQCAvrn64Q4sxRBtAbwkDiysXDvE2qYR6RSGD2FOiQ=;
        b=buISmQQasxnDC2fSDY6MzR1AiIstHAlKALBAHjUSY31I6saA/CMqNQKnylAUwhDRQ/
         EuydlFN+YY39R2zKL2pDvR21eVUFGqwk747AL4HuK3Rc0MYa1dwHxfvjy78SYsFdwYuL
         1Er51U4DYt5G1bQ92AsfC8zhKH/Opy5tRweckLqEWLFeQB/F6A4GNxtvVfo0c3rwLDa7
         +kNrKBhVWKIAt9Q78HKjGL9Rn0yBh0iHstbaRpwfTKHJ8af+gUG0V/Eb44f2mM/72mHv
         w2xFPjfgwotTnISwV1KeQ3R8lmSn2THOBlLtYeWrBhrEn3M+lL5NYse7YwqPJ4xm+edX
         ubCw==
Received: by 10.49.58.238 with SMTP id u14mr3353072qeq.13.1355158262993;
        Mon, 10 Dec 2012 08:51:02 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.106.164 with SMTP id gv4ls4128098qeb.35.gmail; Mon, 10 Dec
 2012 08:51:01 -0800 (PST)
Received: by 10.236.130.205 with SMTP id k53mr10560650yhi.38.1355158261483;
        Mon, 10 Dec 2012 08:51:01 -0800 (PST)
Received: by 10.236.130.205 with SMTP id k53mr10560649yhi.38.1355158261448;
        Mon, 10 Dec 2012 08:51:01 -0800 (PST)
Received: from mail-vb0-f52.google.com (mail-vb0-f52.google.com [209.85.212.52])
        by gmr-mx.google.com with ESMTPS id j11si947351ank.2.2012.12.10.08.51.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Dec 2012 08:51:01 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.52 as permitted sender) client-ip=209.85.212.52;
Received: by mail-vb0-f52.google.com with SMTP id ez10so3786592vbb.39
        for <msysgit@googlegroups.com>; Mon, 10 Dec 2012 08:51:01 -0800 (PST)
Received: by 10.52.97.104 with SMTP id dz8mr8275371vdb.21.1355158261239; Mon,
 10 Dec 2012 08:51:01 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Mon, 10 Dec 2012 08:50:21 -0800 (PST)
In-Reply-To: <7vr4mxc1rd.fsf@alter.siamese.dyndns.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.52 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211259>

On Mon, Dec 10, 2012 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"),
>> a check was added to prevent us from retrying to delete a directory
>> that is both in use and non-empty.
>>
>> However, this logic was slightly flawed; since we didn't return
>> immediately, we end up falling out of the retry-loop, but right into
>> the prompting-loop.
>>
>> Fix this by setting errno, and guarding the prompting-loop with an
>> errno-check.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> Here's the second version of this patch, sorry for the slight delay.
>
> Is this meant for me, or is it to be applied to msysgit and later
> somehow fed to me in different form?
>
> I can s/_wrmdir/rmdir/;s/wpathname/pathname/ if that is what you
> want me to do, but otherwise this patch does not apply.
>

Ugh, you are right. I intended for you to apply it, but I didn't
realize that my patch was based on the msysGit-master, where Karsten's
UTF-8 patches has been applied.

I'm not entirely sure what the best approach would be. The issue is
present in both branches, but we only build installers from the
msysGit-branch. But I think there are other people who builds Git from
the upstream source code, so it would be slightly less annoying for
them if the patch was fixed up and applied. But on the other hand,
that causes some annoyance when (if?) Karsten's UTF-8 patches gets
upstreamed.

Thoughts?

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
