From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] connect.c: Tell *PLink to always use ssh protocol
Date: Thu, 07 Feb 2013 10:40:57 +0100
Message-ID: <511376A9.6030803@tu-clausthal.de>
References: <5112D219.3020604@tu-clausthal.de> <20130206232214.GN27507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBDS5J3OFVYGBBIPNZWEAKGQELLXZXTI@googlegroups.com Thu Feb 07 10:41:09 2013
Return-path: <msysgit+bncBDS5J3OFVYGBBIPNZWEAKGQELLXZXTI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDS5J3OFVYGBBIPNZWEAKGQELLXZXTI@googlegroups.com>)
	id 1U3Nyf-00074n-6m
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2013 10:41:09 +0100
Received: by mail-we0-f192.google.com with SMTP id x10sf710583wey.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2013 01:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:x-virus-scanned
         :x-spam-level:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=QaoT4e7VJ8PktrAUVDMjNlAc/4/9AiTpkXayGd4iL/w=;
        b=j8460kEUWYOKdeG0A4WI97SPkD+7gCt8Utf77CyeE2BPin/Fv6u9BoAsoztFcIxbTM
         dLxjIBd6Ep3GoCvFePK1qpqr9ncoSbm9aqBtOj0q11dbvR5HDJDSMatmBgnINBjn/oj2
         b95jMQTpWaaxAilMdNWQjsDh/TjNGWL4+Jw/mXeprl9ITJFa5946QVdXJAQS+oikhIW4
         q1lF96CCkweFvY63uO9JPth2z+oR4u4hL5xcmLUVVeR5EiPTje0LNtiAQv8Qi 
X-Received: by 10.180.75.82 with SMTP id a18mr33150wiw.16.1360230050513;
        Thu, 07 Feb 2013 01:40:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.13.84 with SMTP id ew20ls49968wid.36.gmail; Thu, 07 Feb
 2013 01:40:49 -0800 (PST)
X-Received: by 10.204.4.217 with SMTP id 25mr78963bks.1.1360230049020;
        Thu, 07 Feb 2013 01:40:49 -0800 (PST)
X-Received: by 10.204.4.217 with SMTP id 25mr78962bks.1.1360230049007;
        Thu, 07 Feb 2013 01:40:49 -0800 (PST)
Received: from mailrelay2.rz.tu-clausthal.de (mailrelay2.rz.tu-clausthal.de. [139.174.2.43])
        by gmr-mx.google.com with ESMTP id 14si1936839bky.0.2013.02.07.01.40.48;
        Thu, 07 Feb 2013 01:40:48 -0800 (PST)
Received-SPF: pass (google.com: domain of sven.strickroth@tu-clausthal.de designates 139.174.2.43 as permitted sender) client-ip=139.174.2.43;
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 93BE6289D2C;
	Thu,  7 Feb 2013 10:40:48 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 77BB729A260;
	Thu,  7 Feb 2013 10:40:48 +0100 (CET)
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 38C0429A25F;
	Thu,  7 Feb 2013 10:40:48 +0100 (CET)
Received: from [139.174.110.83] (account sstri@tu-clausthal.de [139.174.110.83] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43933051; Thu, 07 Feb 2013 10:40:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130206232214.GN27507@sigill.intra.peff.net>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1400_1499 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FORWARDED_MSG 0, __HAS_FROM 0, __HAS_MSGID 0, __IN_REP_TO 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __USER_AGENT 0')
X-Original-Sender: sven.strickroth@tu-clausthal.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sven.strickroth@tu-clausthal.de designates
 139.174.2.43 as permitted sender) smtp.mail=sven.strickroth@tu-clausthal.de;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215685>

Am 07.02.2013 00:22 schrieb Jeff King:
> On Wed, Feb 06, 2013 at 10:58:49PM +0100, Sven Strickroth wrote:
> 
>> Default values for *plink can be set using PuTTY. If a user makes
>> telnet the default in PuTTY this breaks ssh clones in git.
>>
>> Since git clones of the type user@host:path use ssh, tell *plink
>> to use ssh and override PuTTY defaults for the protocol to use.
>> ---
>>  connect.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/connect.c b/connect.c
>> index 49e56ba..d337b6f 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -625,6 +625,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
>>  		if (!ssh) ssh = "ssh";
>>  
>>  		*arg++ = ssh;
>> +		if (putty)
>> +			*arg++ = "-ssh";
>>  		if (putty && !strcasestr(ssh, "tortoiseplink"))
>>  			*arg++ = "-batch";
>>  		if (port) {

Just for the completeness: This might have an unwanted side effect...
Using the -ssh parameter sets the protocol to ssh AND the port number to
22. This might break a setting where a user stores a PuTTY default for
ssh, but with a different port number (e.g. because a user always pushes
to a remote ssh repository which resides on a different port).

PuTTY settings for a named session still work, it only affects the
"Default Settings" session - so users can set up specific sessons in
PuTTY if he wants to change the default port.

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
