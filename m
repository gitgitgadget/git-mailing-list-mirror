From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] Windows: Allow using UNC path for git repository
Date: Tue, 20 May 2014 21:21:32 +0200
Organization: <)><
Message-ID: <20140520192132.GA7355@camelia.ucw.cz>
References: <20140519132334.GA1435@camelia.ucw.cz> <xmqqy4xwxop7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        msysGit <msysgit@googlegroups.com>,
        Cezary Zawadka <czawadka@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCU63DXMWULRBPWW52NQKGQEWIYT64Y@googlegroups.com Tue May 20 21:21:35 2014
Return-path: <msysgit+bncBCU63DXMWULRBPWW52NQKGQEWIYT64Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBPWW52NQKGQEWIYT64Y@googlegroups.com>)
	id 1WmpbT-0001Sd-4y
	for gcvm-msysgit@m.gmane.org; Tue, 20 May 2014 21:21:35 +0200
Received: by mail-wg0-f60.google.com with SMTP id b13sf107407wgh.5
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 May 2014 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=hYAnRFAVFf3OrSdCX9gIbdAb20PG26DDUOzy9B/zFmQ=;
        b=h2afZHJ3lPwz6iTiaMZw+XMpdmWIJlwkUWQLABbv6ki+Cvb13kichrLf5iRR4vIUJj
         RL96MgVes5VoOhEWjHN/6F1gx2S8Hfsz/C/b9lN6LNQMpqC1jh6VMke8A5R1JfB2mqx9
         DwMlF2saCslcR7c3ayTDGGEmL1s4P/nj5fmN/odcT2exuVz03SnSNcNuIOj4Bhm7kbzd
         n69q6BPh9F8Oo5bEt8Tcq9aFe5iWQRBYGf3Ocs+RAqLZxzXczoZExK8TJevZ325ZzuC8
         OzfpSrWFfJNa3Xja9N8g7WjTu/j9Jx0M9FMmh6CcnGHNQeSanfCj5XSfXSyByHOWAbPa
         RNsw==
X-Received: by 10.180.87.68 with SMTP id v4mr26632wiz.1.1400613694789;
        Tue, 20 May 2014 12:21:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.86.135 with SMTP id p7ls171290wiz.4.gmail; Tue, 20 May
 2014 12:21:33 -0700 (PDT)
X-Received: by 10.180.211.114 with SMTP id nb18mr597029wic.4.1400613693862;
        Tue, 20 May 2014 12:21:33 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r49si1006971eep.0.2014.05.20.12.21.33
        for <msysgit@googlegroups.com>;
        Tue, 20 May 2014 12:21:33 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 8F0321C0116;
	Tue, 20 May 2014 21:21:33 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4KJLXEH007445;
	Tue, 20 May 2014 21:21:33 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4KJLWNY007444;
	Tue, 20 May 2014 21:21:32 +0200
In-Reply-To: <xmqqy4xwxop7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249734>

Hello,

On Tue, May 20, 2014 at 11:57:56AM -0700, Junio C Hamano wrote:
> It would be nice if somebody in the S-o-b chain can double-check
> that the "combined" version is sane.  [...]

"Combined" was an unfortunate word.  There was a pair of successive
commits in msysgit all the time.  I just decided to submit them
squashed together.  I haven't changed the code, just created a new
commit message.

That said, reviewing the function is always useful, of course.

Stepan

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
