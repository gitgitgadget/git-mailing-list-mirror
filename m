From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] t0000: verify that real_path() removes
 extra slashes
Date: Wed, 05 Sep 2012 20:23:58 -0700
Message-ID: <7v1uif7s1d.fsf@alter.siamese.dyndns.org>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu>
 <7v1uihbqhf.fsf@alter.siamese.dyndns.org>
 <CACsJy8DAbp1uDsNFFk1g9tuEV1qMnM2DZtxOwp5H9_VE7VwO1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: mhagger@alum.mit.edu,  Johannes Sixt <j6t@kdbg.org>, 
 git@vger.kernel.org,  Orgad and Raizel Shaneh <orgads@gmail.com>,  msysGit
 <msysgit@googlegroups.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: msysgit+bncCI3_0YzZExDRrqCCBRoEz3aALw@googlegroups.com Thu Sep 06 05:24:05 2012
Return-path: <msysgit+bncCI3_0YzZExDRrqCCBRoEz3aALw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCI3_0YzZExDRrqCCBRoEz3aALw@googlegroups.com>)
	id 1T9ShJ-0008BQ-7d
	for gcvm-msysgit@m.gmane.org; Thu, 06 Sep 2012 05:24:05 +0200
Received: by ghbf18 with SMTP id f18sf1031971ghb.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Sep 2012 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=kOe0PXv56kpYfOJgodiA7yBLegz0EADKo4raL3IbASg=;
        b=Dl/v6vFrg1vusUGwqVy3J85Z6YsP2pIrtuhbIKRaIJp0TwE03hkrl4R03rBwRXoVWI
         9Rg8ij5vQPrcf2J6QLZytXZNsUCL8rlTpbraoc0NFoP2gv8AYFL3oDyyuakd5GUIeTgK
         dyJy4FUOVezzEufZQQhp4/Jx/DZ4ol1V91GL91hfdTsnuPBPEdJZN0SYP86oJWZlT3VZ
         rQF7MA4Yf0mqEm8M+6ExTGbX9O0dV7hlevY1DSQOi6o1FK1KCFvYEqW5XUmMFVR1e2Da
         u1H4qOOJFg5USu+v1OfuWjJWZOrjlbQBkIWt1Aqk48SQvHqGuUfFNfvLvn57RV7bbdx 
Received: by 10.52.34.115 with SMTP id y19mr48550vdi.1.1346901841744;
        Wed, 05 Sep 2012 20:24:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.155.6 with SMTP id q6ls182356vcw.3.gmail; Wed, 05 Sep 2012
 20:24:01 -0700 (PDT)
Received: by 10.52.67.175 with SMTP id o15mr242015vdt.4.1346901841055;
        Wed, 05 Sep 2012 20:24:01 -0700 (PDT)
Received: by 10.52.67.175 with SMTP id o15mr242014vdt.4.1346901841046;
        Wed, 05 Sep 2012 20:24:01 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id cf2si108071vdb.0.2012.09.05.20.24.00;
        Wed, 05 Sep 2012 20:24:01 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 734B48EA7;
	Wed,  5 Sep 2012 23:24:00 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5766E8EA3;
	Wed,  5 Sep 2012 23:24:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C458E8EA1; Wed,  5 Sep 2012
 23:23:59 -0400 (EDT)
In-Reply-To: <CACsJy8DAbp1uDsNFFk1g9tuEV1qMnM2DZtxOwp5H9_VE7VwO1g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 5 Sep 2012 17:52:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C993032-F7D2-11E1-9458-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204855>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> diff --git a/path.c b/path.c
> index 66acd24..ad2881c 100644
> --- a/path.c
> +++ b/path.c
> @@ -503,6 +503,10 @@ int normalize_path_copy(char *dst, const char *src)
>                 *dst++ = *src++;
>                 *dst++ = *src++;
>         }
> +#ifdef WIN32
> +       else if (src[0] == '/' && src[1] == '/')
> +               *dst++ = *src++;
> +#endif

The two-byte copy we see above the context is conditional on a nice
abstraction "has_dos_drive_prefix()" so that we do not have to
suffer from these ugly ifdefs.  Could we do something similar?

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
