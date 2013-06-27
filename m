From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 21:57:34 +0200
Message-ID: <51CC992E.3020604@kdbg.org>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, 
 msysGit Mailinglist <msysgit@googlegroups.com>,
 Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
 Pat Thoyts <patthoyts@users.sourceforge.net>,
 Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCJYV6HBKQILDMVSRYCRUBHHUGISK@googlegroups.com Thu Jun 27 21:57:42 2013
Return-path: <msysgit+bncBCJYV6HBKQILDMVSRYCRUBHHUGISK@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f188.google.com ([74.125.82.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQILDMVSRYCRUBHHUGISK@googlegroups.com>)
	id 1UsIK3-0000E1-FV
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 21:57:39 +0200
Received: by mail-we0-f188.google.com with SMTP id o12sf257849wes.5
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=DQiwRDZY7hBs1vwUMj5R3hvqJhYwC2MRIaWxmCryXj4=;
        b=Hg3jHtTojkXk6u9Dr9OWT3ZAerzVhYK5GG0NaCKsSubRwNCgxv9q6OAWDm8EB4IIns
         JKpQ5Wb2M4rXL1l0poLTuUv0EkuX6J/v3hAkHquwkn8E+PPNIk5TrwywO3pRJsK7BBGu
         kwv7oEf1+8jLCvkHNB7c0ecefnvmtJGx1kNAqToWu9PgNMe/n+T3uro9Eo2eglO74tec
         keKo9mi8J2MaC7eyVELtoR/C2A1QbpZj8h2lNqBE9Px78J2fD8midmGazBlPPcs71pMX
         DEfdY0nGjZ28YTC30a2fJzYvV1zcn49yF3mNF9B6tPsNBKiQqnavhSwbRKblXl12lnr2
         g9JQ==
X-Received: by 10.180.206.1 with SMTP id lk1mr13570wic.16.1372363059213;
        Thu, 27 Jun 2013 12:57:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.102.100 with SMTP id fn4ls18965wib.24.gmail; Thu, 27 Jun
 2013 12:57:36 -0700 (PDT)
X-Received: by 10.15.35.194 with SMTP id g42mr10677079eev.4.1372363056555;
        Thu, 27 Jun 2013 12:57:36 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp3.bon.at. [213.33.87.17])
        by gmr-mx.google.com with ESMTPS id bk51si747883eeb.0.2013.06.27.12.57.36
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 12:57:36 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.17 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.17;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AC33BCDF83;
	Thu, 27 Jun 2013 21:57:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 175D919F5F4;
	Thu, 27 Jun 2013 21:57:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 213.33.87.17 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229150>

Am 27.06.2013 14:47, schrieb Sebastian Schuberth:
> diff --git a/git-archimport.perl b/git-archimport.perl
> index 9cb123a..ed2c741 100755
> --- a/git-archimport.perl
> +++ b/git-archimport.perl
...
> @@ -477,8 +477,8 @@ sub process_patchset_fast {
>          unlink @$del;
>          while (@$del) {
>              my @slice = splice(@$del, 0, 100);
> -            system('git-update-index','--remove','--',@slice) == 0 or
> -                            die "Error in git-update-index --remove: $! $?\n";
> +            system('git update-index','--remove','--',@slice) == 0 or
> +                            die "Error in git update-index --remove: $! $?\n";

Shouldn't this become 'git','update-index'?

>          }
>      }
> 
> @@ -496,25 +496,25 @@ sub process_patchset_fast {
>              }
>              # print "moving $from $to";
>              rename($from, $to) or die "Error renaming '$from' '$to': $!\n";
> -            system('git-update-index','--remove','--',$from) == 0 or
> -                            die "Error in git-update-index --remove: $! $?\n";
> -            system('git-update-index','--add','--',$to) == 0 or
> -                            die "Error in git-update-index --add: $! $?\n";
> +            system('git update-index','--remove','--',$from) == 0 or
> +                            die "Error in git update-index --remove: $! $?\n";
> +            system('git update-index','--add','--',$to) == 0 or
> +                            die "Error in git update-index --add: $! $?\n";

Twice here, too.

>          }
>      }
> 
>      if (my $add = $ps->{new_files}) {
>          while (@$add) {
>              my @slice = splice(@$add, 0, 100);
> -            system('git-update-index','--add','--',@slice) == 0 or
> -                            die "Error in git-update-index --add: $! $?\n";
> +            system('git update-index','--add','--',@slice) == 0 or
> +                            die "Error in git update-index --add: $! $?\n";

Again.

>          }
>      }
> 
>      if (my $mod = $ps->{modified_files}) {
>          while (@$mod) {
>              my @slice = splice(@$mod, 0, 100);
> -            system('git-update-index','--',@slice) == 0 or
> +            system('git update-index','--',@slice) == 0 or

Ditto.

-- Hannes

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
