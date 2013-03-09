From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] connect.c: Tell *PLink to always use ssh protocol
Date: Sat, 09 Mar 2013 15:08:30 +0100
Message-ID: <513B425E.1020208@tu-clausthal.de>
References: <5112D219.3020604@tu-clausthal.de> <20130206232214.GN27507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBDS5J3OFVYGBBXEE5WEQKGQESNAMLNQ@googlegroups.com Sat Mar 09 15:08:57 2013
Return-path: <msysgit+bncBDS5J3OFVYGBBXEE5WEQKGQESNAMLNQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDS5J3OFVYGBBXEE5WEQKGQESNAMLNQ@googlegroups.com>)
	id 1UEKSB-0001n3-Lk
	for gcvm-msysgit@m.gmane.org; Sat, 09 Mar 2013 15:08:51 +0100
Received: by mail-wg0-f62.google.com with SMTP id dr1sf1185353wgb.27
        for <gcvm-msysgit@m.gmane.org>; Sat, 09 Mar 2013 06:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:x-virus-scanned:x-spam-level:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=OeyZGfgE9QexUD2RxN+Fiq1j5cyDrVJSUvqYa8NK/Oo=;
        b=wCBD6gBVL678cWwFIw1ttYIZ4rgsdvNYaQPVCVJUKEX7wIlig9KB/lmhuaXDlNqpHU
         jwORxuQOc22+0I8BgPyym0QHjr5/Zv0tbtJfmQWv47WB6cBHso53GrJlHX7bl34XhImF
         KRz6sDS2wEY+afe7tx/d3wlF8AZ3kKd/jTi/qn0G2FsmAb/i27wqGf7m1Lppxwg9FURi
         NuKla91ePAgtQtiGkqe5hEHfP0ZfHmPDvmTDpqoOlLu7QTO1QW2CMvo6b/CYE8Y0JxX3
         pvcn 
X-Received: by 10.180.100.102 with SMTP id ex6mr286544wib.7.1362838109816;
        Sat, 09 Mar 2013 06:08:29 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.73.2 with SMTP id h2ls177223wiv.20.canary; Sat, 09 Mar
 2013 06:08:28 -0800 (PST)
X-Received: by 10.15.44.2 with SMTP id y2mr6885336eev.2.1362838108306;
        Sat, 09 Mar 2013 06:08:28 -0800 (PST)
Received: from mailrelay1.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de. [139.174.2.42])
        by gmr-mx.google.com with ESMTP id 47si2935746eeh.1.2013.03.09.06.08.27;
        Sat, 09 Mar 2013 06:08:27 -0800 (PST)
Received-SPF: pass (google.com: domain of sven.strickroth@tu-clausthal.de designates 139.174.2.42 as permitted sender) client-ip=139.174.2.42;
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 9C48E42E353;
	Sat,  9 Mar 2013 15:08:27 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 76244422079;
	Sat,  9 Mar 2013 15:08:27 +0100 (CET)
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 0D030422078;
	Sat,  9 Mar 2013 15:08:27 +0100 (CET)
Received: from [79.193.86.162] (account sstri@tu-clausthal.de HELO [192.168.0.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 45308776; Sat, 09 Mar 2013 15:08:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130206232214.GN27507@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_800_899 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FORWARDED_MSG 0, __HAS_FROM 0, __HAS_MSGID 0, __IN_REP_TO 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
X-Original-Sender: sven.strickroth@tu-clausthal.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sven.strickroth@tu-clausthal.de designates
 139.174.2.42 as permitted sender) smtp.mail=sven.strickroth@tu-clausthal.de;
       dkim=pass header.i=@tu-clausthal.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217726>

Am 07.02.2013 00:22 schrieb Jeff King:
> On Wed, Feb 06, 2013 at 10:58:49PM +0100, Sven Strickroth wrote:
> 
>> Default values for *plink can be set using PuTTY. If a user makes
>> telnet the default in PuTTY this breaks ssh clones in git.
>>
>> Since git clones of the type user@host:path use ssh, tell *plink
>> to use ssh and override PuTTY defaults for the protocol to use.
>>
>> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> 
> Makes sense to me, though I'd expect to see this cc'd to the msysgit
> list (which I'm doing on this response) for comment from people who
> might be more familiar with the area.

The msysgit people have a git-wrapper which already enables this (see
https://github.com/msysgit/msysgit/blob/master/src/git-wrapper/git-wrapper.c#L62).

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server

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
