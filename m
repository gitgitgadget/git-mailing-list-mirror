From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 11:03:47 -0700
Message-ID: <7vpq5o4h30.fsf@alter.siamese.dyndns.org>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
 <7va9ws5x6w.fsf@alter.siamese.dyndns.org>
 <CABPQNSb=j=TtZVm4tzR6HE+Fhh=Aa6GSnmaysLNBQTbtSie4Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBBXDZWBAKGQEY2GFPAA@googlegroups.com Fri Sep 14 20:03:57 2012
Return-path: <msysgit+bncBCG77UMM3EJRBBXDZWBAKGQEY2GFPAA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBBXDZWBAKGQEY2GFPAA@googlegroups.com>)
	id 1TCaF9-0003Z8-3x
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 20:03:55 +0200
Received: by ghbf18 with SMTP id f18sf2451824ghb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=U6WKRIKmJPlkZMDz0Iu+XVs7/J0nF/b0Xo9+HpyUgDg=;
        b=GSYGAWE9F/FwHlfnf/HWG06hqznHIs7R3ffIYXAz04KnCJ4TGBoslsKKVwbt3aN8ul
         Foz3eKxWcxBK3QJyAr8m+9QqWvi2iHvlFnW9f/AEEsBNlPR5TxD3payayIW6w8y26t4w
         DeBikg6BN5Bor8kqrOK/VB8na9LdoC8hJjCSq6o2hnWjq72R5NxnbNYFZCXLHIQD2qyl
         YVRyoEZasrwNvlZz0DrDoU0xNMEeVvuB+MnhTn34z9bn60kdO9huMS0pCky6qNWAgT5k
         8WwmfkBjDsig98AJs3mcW+WZ0iVx+zxIJpZkslYY24MJofqrDtaF11Jjc+KltCJNWSY 
Received: by 10.229.114.217 with SMTP id f25mr151211qcq.19.1347645830702;
        Fri, 14 Sep 2012 11:03:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.214.132 with SMTP id ha4ls8226797qab.1.gmail; Fri, 14 Sep
 2012 11:03:50 -0700 (PDT)
Received: by 10.224.182.74 with SMTP id cb10mr2533415qab.0.1347645829983;
        Fri, 14 Sep 2012 11:03:49 -0700 (PDT)
Received: by 10.224.182.74 with SMTP id cb10mr2533414qab.0.1347645829974;
        Fri, 14 Sep 2012 11:03:49 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id t29si577514qcz.1.2012.09.14.11.03.49;
        Fri, 14 Sep 2012 11:03:49 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72AB89C08;
	Fri, 14 Sep 2012 14:03:49 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613D59C07;
	Fri, 14 Sep 2012 14:03:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D23159C06; Fri, 14 Sep 2012
 14:03:48 -0400 (EDT)
In-Reply-To: <CABPQNSb=j=TtZVm4tzR6HE+Fhh=Aa6GSnmaysLNBQTbtSie4Mg@mail.gmail.com> (Erik
 Faye-Lund's message of "Fri, 14 Sep 2012 19:42:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88A22686-FE96-11E1-8F0B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205521>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> Neither is which, no?
>
> Oooh, right. Thanks for noticing. So I guess I should try to run it
> instead. From the  POSIX spec,...

If you assume POSIX.1, there is "type".

    $ type frotz ; echo $?
    frotz is /usr/games/frotz
    0
    $ type frobnitz ; echo $?
    bash: type: frobnitz: not found
    1

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
