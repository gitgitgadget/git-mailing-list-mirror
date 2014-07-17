From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] mingw unicode environment
Date: Thu, 17 Jul 2014 12:18:31 -0700
Message-ID: <xmqq7g3bpzeg.fsf@gitster.dls.corp.google.com>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
	<53C8115D.8040505@gmail.com>
	<xmqqfvhzq22x.fsf@gitster.dls.corp.google.com>
	<20140717190000.GA18960@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBD6DUCPAKGQEE5TMS3Y@googlegroups.com Thu Jul 17 21:18:41 2014
Return-path: <msysgit+bncBCG77UMM3EJRBD6DUCPAKGQEE5TMS3Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBD6DUCPAKGQEE5TMS3Y@googlegroups.com>)
	id 1X7rCS-0006Hd-PY
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 21:18:40 +0200
Received: by mail-we0-f192.google.com with SMTP id x48sf367629wes.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=fuq/DDXyc9GnSyiHlY5h4zZZ41asLasb8qelEs4UiLo=;
        b=Zjpr02bfhBfWIaADjzSyJmcO36fyOJJ2wzj1SuIKNnl+t7Acb1h1p0BbaeCf4b/fGt
         yVp1+TvG/wUOqQSMlHBFeAKMs+eGqpzZDOwDscbpsRSkXy7Mu/F20SmXV1eQ5R9sLuSY
         6Qs9sj+qOdsv+gXzY53GQTL4bqc41+tRtsIBFiXj8TevLeEsO0x58vWERwyqeTNPJhjE
         iWS0wEMDhOBcgZDGOWWqxaxpFxDgMlvDXMQQxBBjMqYokhEnVCH4JHSq9sc/p3Fq34b4
         itEnZckVjj/B5TXcd366gfoFwx+uPnOIW7okEpUueynUAbfOyDw7yUbxZyNWOzUY7gFc
         xD7A==
X-Received: by 10.180.95.35 with SMTP id dh3mr2424wib.12.1405624720548;
        Thu, 17 Jul 2014 12:18:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.95.163 with SMTP id dl3ls474761wib.5.gmail; Thu, 17 Jul
 2014 12:18:38 -0700 (PDT)
X-Received: by 10.180.87.7 with SMTP id t7mr2267237wiz.5.1405624718974;
        Thu, 17 Jul 2014 12:18:38 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id m2si434633qcr.2.2014.07.17.12.18.38
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 12:18:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FB3D29313;
	Thu, 17 Jul 2014 15:18:38 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8517629302;
	Thu, 17 Jul 2014 15:18:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D3388292FE;
	Thu, 17 Jul 2014 15:18:32 -0400 (EDT)
In-Reply-To: <20140717190000.GA18960@ucw.cz> (Stepan Kasal's message of "Thu,
	17 Jul 2014 21:00:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 247D3936-0DE7-11E4-A47A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253772>

Stepan Kasal <kasal@ucw.cz> writes:

> If anyone thinks the resulting ordering is not OK, they can propose
> one re-order patch on top of this series.

I agree that that would be a good way to go.

> Junio wrote:
>> OK, so the series may need further re-polishing of the polishing
>> done by Stepan last-minute before sending them out.  I'll still
>
> No, it was not last minute work.  It was done several weeks ago, after some
> planning, etc.  It's my best.  Corrections welcome, though.

I did not literally mean "minute", and I am sorry if I sounded like
I was saying that you threw junk that are not well-thought-out into
the mix.

The point I wanted to clarify was that the claim to be "time proven
part of msysGit" in the first paragraph of the cover does not apply
to some of the patches in the series, in which case I shouldn't
merge it right to 'master' without waiting for responses.

In that context (I take "time proven" is like "more than 18
months"), weeks vs minutes do not make much of a difference anyway
;-).



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
