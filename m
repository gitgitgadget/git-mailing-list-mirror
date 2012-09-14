From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 10:30:31 -0700
Message-ID: <7va9ws5x6w.fsf@alter.siamese.dyndns.org>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBOOTZWBAKGQEE466HCA@googlegroups.com Fri Sep 14 19:30:39 2012
Return-path: <msysgit+bncBCG77UMM3EJRBOOTZWBAKGQEE466HCA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBOOTZWBAKGQEE466HCA@googlegroups.com>)
	id 1TCZiw-0007g3-P9
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:30:39 +0200
Received: by ghbf18 with SMTP id f18sf2432102ghb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=C5Au8VR/eNi3McFl4s4O49Ubt01xId+d0YGrzZ6wyfQ=;
        b=ARqxqSsHbAnxbGKVPpQM6v2cYQzYegC8CgArKHOArcuukL5WCBPcQQVmj2HIDcwRE0
         vwmfeTF3fq4S9In43UyeWBwnGAzD31w/WzGqgMT6QOQgpj5/TF70JCavIgMpo5QBiGWW
         4eXOtCXuCZggkVM+5jX4pSSOQtQAJuszjOIu0WGdaxy/34LKmxd2f4q6y6SDJqC+evtQ
         eM5wcLLyNwCHU4PlZaGSp6LNmkYisDwq3JJGuwDzvymJESj0bo1TxSsXEK1KOkeMlpZi
         uESyExMPKwGgGXHU4NDWR4v8U+HmO+8jEabBCLVona2gA29UdZMhDPGrBhHB0CarD8S 
Received: by 10.224.209.133 with SMTP id gg5mr1061893qab.5.1347643834469;
        Fri, 14 Sep 2012 10:30:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.216.6 with SMTP id hg6ls8166016qab.5.gmail; Fri, 14 Sep
 2012 10:30:33 -0700 (PDT)
Received: by 10.224.220.12 with SMTP id hw12mr2449179qab.8.1347643833778;
        Fri, 14 Sep 2012 10:30:33 -0700 (PDT)
Received: by 10.224.220.12 with SMTP id hw12mr2449178qab.8.1347643833767;
        Fri, 14 Sep 2012 10:30:33 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id g28si540275qcq.2.2012.09.14.10.30.33;
        Fri, 14 Sep 2012 10:30:33 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 281BC902B;
	Fri, 14 Sep 2012 13:30:33 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14FE09029;
	Fri, 14 Sep 2012 13:30:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 854359026; Fri, 14 Sep 2012
 13:30:32 -0400 (EDT)
In-Reply-To: <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com> (Erik
 Faye-Lund's message of "Fri, 14 Sep 2012 18:54:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2BC6C80-FE91-11E1-946C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205513>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Fri, Sep 14, 2012 at 6:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 78c4286..7d1b34b 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
>>  # This test checks if command xyzzy does the right thing...
>>  # '
>>  # . ./test-lib.sh
>> +
>> +if ! which tput > /dev/null ; then
>> +       tput () {
>> +               case "$1" in
>> +               bold)
>> +                       echo -ne "\033[1m" ;;
>> +               setaf)
>> +                       echo -ne "\033[0;3$2m" ;;
>> +               sgr0)
>> +                       echo -ne "\033(\033[m" ;;
>
> I should of course have checked this earlier, but I find now that
> "echo -ne" isn't portable.

Neither is which, no?

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
