From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 3/6] http-backend: handle refspec argument
Date: Tue, 19 Apr 2016 14:57:57 -0400
Organization: Twitter
Message-ID: <1461092277.5540.108.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-4-git-send-email-dturner@twopensource.com>
	 <CAPig+cRSE-BCPdrSbrCYmTcT6EsabKnekr2GEAbmBsc5=jxnHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:58:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asaql-0004IL-7q
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135AbcDSS6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 14:58:02 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34266 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbcDSS6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 14:58:00 -0400
Received: by mail-qg0-f54.google.com with SMTP id c6so14980242qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=y2C26fU7OjY9fvTOIGzR90Hm6SgbxYM5v1bq6h8U3MU=;
        b=dEZxT5RowHRuSCc9EH5XHG83BIdkRfL5FrdlnuUykq//WirohN2+W6tHAD78Xy/EG3
         I5ZsNz5z5g9cOHtt/PWKcjcEw8JuCQB2qj4KRqQYgJ+SLjvv0CkJMrZtwkLa/IF+kNjp
         L7w8KTjwdBO9wGuW53Y/DCZZ20IfpGBYAQBFg8uIYT+nZcSYr75IztyNDxQcHPNiPAme
         mRUN0B7dHMhmk1s9W4NK1EozCmc4kTys/rJ2wdq+jA0WsVRdHC733veRmk+NjO1CJFCQ
         RZ88GPQuoYq5OHDxspXS7sTl2AwmEn0qZoHUXBQXGUZyguZkv6luXLEtWjY6/DY2YW74
         Ewgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=y2C26fU7OjY9fvTOIGzR90Hm6SgbxYM5v1bq6h8U3MU=;
        b=i6mz3x8DhS9/e8e6xSNev2S+JxpX7j3DTdwVmO6kYO8JYNd3DIW5qcK2W3XVS+Ogj1
         +Jj9uObJnnqOSofI1HnZ6ynSyPgi+nDYy45fefuhZgeiXxcJdrZ5qVMUuY+4s+Hwb8E+
         h7HjoRwbs/loMJlPMdr2ZMUB+tZs/b4Vr8Lo3qyDKQDSyRgxEKr4t9rdxi5Oss6n71Z7
         pEpM300tYztv+X2NUs2KagBLvDJeKTcZpvQkLJ0Qe040kG95JWstFDjT71dMUU3Uulhv
         xF7JnFccgKBTPsJOIWJvtcEdIo/Gg7T4O9TY0zrtHUK0NeuuXR7BUC0p5KWPwWwaCE0N
         nRqQ==
X-Gm-Message-State: AOPr4FXcPmqWz12G7WSsbtVz5EX4RZOvtaQroSC1abAkcNv9ZD3W9Iy3FsEr1TsuubcLjA==
X-Received: by 10.140.248.8 with SMTP id t8mr5948380qhc.50.1461092279208;
        Tue, 19 Apr 2016 11:57:59 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r66sm3432278qhe.47.2016.04.19.11.57.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 11:57:58 -0700 (PDT)
In-Reply-To: <CAPig+cRSE-BCPdrSbrCYmTcT6EsabKnekr2GEAbmBsc5=jxnHQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291904>

On Sat, 2016-04-16 at 21:51 -0400, Eric Sunshine wrote:
> On Fri, Apr 15, 2016 at 3:19 PM, David Turner <
> dturner@twopensource.com> wrote:
> > +               if (refspec) {
> > +                       struct strbuf interesting_refs =
> > STRBUF_INIT;
> > +                       strbuf_addstr(&interesting_refs, "-
> > -interesting-refs=");
> > +                       strbuf_addstr(&interesting_refs, refspec);
> > +                       argv_array_push(&argv,
> > interesting_refs.buf);
> > +                       strbuf_release(&interesting_refs);
> > +               }
> 
>     if (refspec)
>         argv_array_pushf(&interesting_refs,
>             "--interesting-refs=%s", refspec);


Will fix, thanks.

> >                 argv_array_push(&argv, ".");
> >                 run_service(argv.argv, 0);
> >                 argv_array_clear(&argv);
> > @@ -841,6 +905,19 @@ int main(int argc, char **argv)
> > +               if (starts_with(arg, "--interesting-refs=")) {
> > ...
> > +                       continue;
> > +               }
> 
> Is this leaking the string list?

Yes, intentionally.  interesting_refspec is a global that we look at
later.  
