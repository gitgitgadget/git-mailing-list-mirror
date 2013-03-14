From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Fri, 15 Mar 2013 00:00:58 +0100
Message-ID: <CABPQNSZO8q0LQJKj+xVcU=g3z-nSaGYGokN8tzrLfSfS4ypHCg@mail.gmail.com>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
 <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
 <7vmwu6x72q.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
 <7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBJ5ORGFAKGQEQZ66VUY@googlegroups.com Fri Mar 15 00:03:28 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBJ5ORGFAKGQEQZ66VUY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f188.google.com ([209.85.160.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBJ5ORGFAKGQEQZ66VUY@googlegroups.com>)
	id 1UGHBH-00070U-HT
	for gcvm-msysgit@m.gmane.org; Fri, 15 Mar 2013 00:03:27 +0100
Received: by mail-gh0-f188.google.com with SMTP id z12sf1012175ghb.15
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=XqVtewL+E/qEeC5MY1NIuaSB+0o1q1XrSwC95grq1Cw=;
        b=korkqP15xHXXADzEmj2AIfirrBac8L83X7iYpPM5USAu01oaS2Bpy3VmXLtfQYAvh7
         ozEB4yNHu2ZU9PBq5b3nAy6XnpUypkriJc0V0bCU+ktCuDBbFjDME4l1o1kCE5CB8mGi
         t0u4JCY0wAuWKXundQkBq64mA2y+NVTtyHXrZdnvBSc1FSJ+vbEZslCvtu2/1H6o6WRb
         cnRSoh3X8z/F8Gk77Hu7h7NEcQkChTae5KUpbL49E4/6WBEwGEWQT5zw9J0MlHeMlKDh
         Ln4NZOZ4mskuH7zPkzN/0D+IIny5TnjU1OjffxJW4Ju 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=XqVtewL+E/qEeC5MY1NIuaSB+0o1q1XrSwC95grq1Cw=;
        b=JbvZ2652eZq9x5g+tpbaaf06Prr3Woyh10UTQ33Fiyqyg6PAPvM12mvu+QtLudCGDE
         wonBNQ+TmU3pD3FZqMrtqF+WPXS5azHs7UNh8NyQHEO9OglX4La2HXx8bGqEaXtGWz/w
         igtkQuG5RndwcVKBPG4WBm6YwYLHegHDbio1KUsYHaMgCvQ0yq4bEFny6uKNSWKnmJNh
         /+S7p37O9ZGguX3s9X/aonXnAt1ug0pMA3ho1VS91/qb+2/omWd50fc/RSPSew5GBswx
         NzEaocV70gkp8u1ogJS9U0F1N+iHhez5Df0cNxx77yNnA1NlcH 
X-Received: by 10.50.40.103 with SMTP id w7mr3646507igk.11.1363302184167;
        Thu, 14 Mar 2013 16:03:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.42.137 with SMTP id o9ls259041igl.15.gmail; Thu, 14 Mar
 2013 16:03:03 -0700 (PDT)
X-Received: by 10.50.183.164 with SMTP id en4mr19760421igc.2.1363302098208;
        Thu, 14 Mar 2013 16:01:38 -0700 (PDT)
Received: from mail-ie0-x231.google.com (mail-ie0-x231.google.com [2607:f8b0:4001:c03::231])
        by gmr-mx.google.com with ESMTPS id r9si6047igl.1.2013.03.14.16.01.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 16:01:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::231 as permitted sender) client-ip=2607:f8b0:4001:c03::231;
Received: by mail-ie0-f177.google.com with SMTP id 16so3710515iea.22
        for <msysgit@googlegroups.com>; Thu, 14 Mar 2013 16:01:38 -0700 (PDT)
X-Received: by 10.50.202.6 with SMTP id ke6mr3923583igc.30.1363302098086; Thu,
 14 Mar 2013 16:01:38 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Thu, 14 Mar 2013 16:00:58 -0700 (PDT)
In-Reply-To: <7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::231
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218181>

On Thu, Mar 14, 2013 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Apparently, ftps is also handled by cURL and most likely requires SSL.
>>
>> How about optimizing for the common case and instead of prefixcmp(url,
>> "https:")) ask for !prefixcmp(url, "http:")?
>
> I think that is a very sensible way to go.
>
> As to ALL vs DEFAULT, given that its manual page is riddled with a
> scary warning:
>
>     This function must be called at least once within a program (a
>     program is all the code that shares a memory space) before the
>     program calls any other function in libcurl. The environment it sets
>     up is constant for the life of the program and is the same for every
>     program, so multiple calls have the same effect as one call.  ... In
>     normal operation, you must specify CURL_GLOBAL_ALL. Don't use any
>     other value unless you are familiar with it and mean to control
>     internal operations of libcurl.
>
> I think we should stick to ALL.  So
>
>         flags = CURL_GLOBAL_ALL;
>         if (!prefixcmp(url, "http:"))
>                 flags &= ~CURL_GLOBAL_SSL;
>
> would be the way to go.
>
> But this is assuming that nobody feeds our client a http:// URL to
> the server that redirects us to the https:// version (or we do not
> follow such a redirect).  I offhand do not know if that is a valid
> assumption, though.
>

Thanks, both. Very sensible points. I'll re-roll a new version
tomorrow, but it could indeed be that the redirect-case can make this
a no-go.

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
