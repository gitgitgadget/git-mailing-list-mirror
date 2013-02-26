From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] improve-wincred-compatibility
Date: Tue, 26 Feb 2013 09:29:14 -0800
Message-ID: <7vfw0jm1at.fsf@alter.siamese.dyndns.org>
References: <50E73B80.4070105@gmail.com>
 <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
 <50EC473A.6060203@gmail.com>
 <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
 <50EEAF9A.6020302@gmail.com>
 <CABPQNSaUizZPVOeeuEyb=o-Qmm4mYCRxV27qkmp62cSpFkinqA@mail.gmail.com>
 <7vsj4k3nbu.fsf@alter.siamese.dyndns.org> <512BF61B.4020708@dcon.de>
 <7vip5gne96.fsf@alter.siamese.dyndns.org>
 <CABPQNSZSv71_W6Y5rxo0nSBAemiiuTOyB=1Ag6txLy56BEbMFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,  git@vger.kernel.org, 
 msysgit@googlegroups.com,  Jeff King <peff@peff.net>,  patthoyts@gmail.com, 
 Johannes.Schindelin@gmx.de
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRB3PBWOEQKGQEHVOE2TY@googlegroups.com Tue Feb 26 18:29:40 2013
Return-path: <msysgit+bncBCG77UMM3EJRB3PBWOEQKGQEHVOE2TY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f55.google.com ([209.85.212.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB3PBWOEQKGQEHVOE2TY@googlegroups.com>)
	id 1UAOLU-0007mv-8C
	for gcvm-msysgit@m.gmane.org; Tue, 26 Feb 2013 18:29:40 +0100
Received: by mail-vb0-f55.google.com with SMTP id fc21sf18876vbb.20
        for <gcvm-msysgit@m.gmane.org>; Tue, 26 Feb 2013 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf:from:to
         :cc:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:x-pobox-relay-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=hu+hxrY9k9DMswcdiZws0W/v9Dg/6Zw872kZi3a5FMk=;
        b=oc7f4JCRy+MrEpe61bScs9Se9VFoKnPGIAlgsvTy66u6bmDt7ojRuegjqVtVVTeq54
         IMBPoa9eCoMgOOlqtFAvPKewI8x1zc11YFh4cQ43c16ikNJdZQ6mImW6jbWnlplzq789
         xvJRB3WC21wXmh5snCubvDFEqC53vlwZ905arFcYe66T0ZLACcy1KSqSq2HHYv5fZD5O
         nBblGhwCVngjMTziJHZmGlXtmQg/Ar314UpTnJ638eDwiC/UkGrP+Z9gFno+iiRPsTVb
         AQfZL8lIEjmsa0cuBhoxP0ty 
X-Received: by 10.49.96.196 with SMTP id du4mr1467182qeb.37.1361899758854;
        Tue, 26 Feb 2013 09:29:18 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.76.67 with SMTP id i3ls1555808qew.92.gmail; Tue, 26 Feb
 2013 09:29:17 -0800 (PST)
X-Received: by 10.224.189.78 with SMTP id dd14mr1584084qab.0.1361899757481;
        Tue, 26 Feb 2013 09:29:17 -0800 (PST)
X-Received: by 10.224.189.78 with SMTP id dd14mr1584082qab.0.1361899757472;
        Tue, 26 Feb 2013 09:29:17 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id x1si411852qci.2.2013.02.26.09.29.17;
        Tue, 26 Feb 2013 09:29:17 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 043BEBC8C;
	Tue, 26 Feb 2013 12:29:17 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6625BC89;
	Tue, 26 Feb 2013 12:29:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B304BC86; Tue, 26 Feb 2013
 12:29:16 -0500 (EST)
In-Reply-To: <CABPQNSZSv71_W6Y5rxo0nSBAemiiuTOyB=1Ag6txLy56BEbMFQ@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 26 Feb 2013 17:55:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B82D792-803A-11E2-AD2F-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217152>

Thanks.

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
