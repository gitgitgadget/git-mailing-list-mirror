From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re* [PATCH] send-email: recognize absolute path on Windows
Date: Tue, 15 Apr 2014 22:49:53 +0200
Message-ID: <CABPQNSbZvJQY-yYRf5ee_jjiqrVk5GYK-rZJ2ApH=t7c4V-nMA@mail.gmail.com>
References: <1397551465-10968-1-git-send-email-kusmabite@gmail.com>
 <534D0ADB.7070702@viscovery.net> <CABPQNSafmC-7zNJZJSZm598pF37_xUMUopgZ3c=ttL_wRDYsfQ@mail.gmail.com>
 <xmqq61maledq.fsf_-_@gitster.dls.corp.google.com> <xmqq1twyl46z.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBGVXW2NAKGQEO46UDEY@googlegroups.com Tue Apr 15 22:50:36 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBGVXW2NAKGQEO46UDEY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f183.google.com ([209.85.128.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBGVXW2NAKGQEO46UDEY@googlegroups.com>)
	id 1WaAJP-0002zn-LS
	for gcvm-msysgit@m.gmane.org; Tue, 15 Apr 2014 22:50:35 +0200
Received: by mail-ve0-f183.google.com with SMTP id oz11sf2170350veb.20
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Apr 2014 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=z8agMS6pJ13X3JYuUGXwakWK1VyMb5wYuJKm6686bk0=;
        b=CnMM9xxnopvyH7P7CqqyvWXLG1LGrwsh5XKgnFEql/uKM3fuAlfcaEMYrl/sl1ql92
         nJZd4VBm/5B4e8j7u5/P1ZWHz5wUlldi+GMWNtjzrqvwqYmvuilpisW74a0Vyn8a/rG1
         pgJvvnknj5DR5FrZAA31D+sETQxDqTbHslA9nBmLmxi8N11898WrCP80tlhMmfglZUWx
         GtE8Wo5DatjWhGFPI7Bo2SFUbKroIQPFWzo0Na991EI8l3vPnDnZXB0g8bq5/yerMCxz
         Hr1fqfM/Q+7wkzwp1/+KlfjC3TWoVVp+6dy8Mt/swXhL8tKHMiduMr4vNahvTrkceFnp
         LezA==
X-Received: by 10.50.114.133 with SMTP id jg5mr13714igb.1.1397595034743;
        Tue, 15 Apr 2014 13:50:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.61.137 with SMTP id p9ls646926igr.8.gmail; Tue, 15 Apr 2014
 13:50:34 -0700 (PDT)
X-Received: by 10.68.216.230 with SMTP id ot6mr1891211pbc.3.1397595033980;
        Tue, 15 Apr 2014 13:50:33 -0700 (PDT)
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com [2607:f8b0:4001:c05::231])
        by gmr-mx.google.com with ESMTPS id iq7si4415488igb.0.2014.04.15.13.50.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 13:50:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::231 as permitted sender) client-ip=2607:f8b0:4001:c05::231;
Received: by mail-ig0-f177.google.com with SMTP id ur14so269037igb.10
        for <msysgit@googlegroups.com>; Tue, 15 Apr 2014 13:50:33 -0700 (PDT)
X-Received: by 10.42.21.133 with SMTP id k5mr430028icb.1.1397595033887; Tue,
 15 Apr 2014 13:50:33 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 15 Apr 2014 13:49:53 -0700 (PDT)
In-Reply-To: <xmqq1twyl46z.fsf@gitster.dls.corp.google.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::231
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246300>

On Tue, Apr 15, 2014 at 10:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thanks, both.  I'd expect another round then?
>>
>> -- >8 --
>> From: Erik Faye-Lund <kusmabite@googlemail.com>
>>
>> On Windows, absolute paths might start with a DOS drive prefix,
>> which these checks fail to recognize.
>>
>> Use file_name_is_absolute from File::Spec::Functions for
>> portability.  The Perl module msysgit has been shipping needs to be
>> updated for this patch to work, though.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> Helepd-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>
>>  git-send-email.perl | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index fdb0029..eda3917 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -25,7 +25,7 @@
>>  use Data::Dumper;
>>  use Term::ANSIColor;
>>  use File::Temp qw/ tempdir tempfile /;
>> -use File::Spec::Functions qw(catfile);
>> +use File::Spec::Functions qw(catfile file_name_is_absolute);
>>  use Error qw(:try);
>>  use Git;
>>
>> @@ -1197,7 +1197,7 @@ sub send_message {
>>
>>       if ($dry_run) {
>>               # We don't want to send the email.
>> -     } elsif ($smtp_server =~ m#^/#) {
>> +     } elsif (file_name_is_absolute($smtp_server)) {
>>               my $pid = open my $sm, '|-';
>>               defined $pid or die $!;
>>               if (!$pid) {
>> @@ -1271,7 +1271,7 @@ sub send_message {
>>               printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
>>       } else {
>>               print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
>> -             if ($smtp_server !~ m#^/#) {
>> +             if (file_name_is_absolute($smtp_server)) {
>
> Obviously this has to be "!file_name_is_absolute($smtp_server)" ;-)
>

Heh, yeah. Apart from that, your patch is identical to mine. But, ugh.
Modifying File::Spec into thinking msys is Win32 doesn't seems to
work, as I get other random path-errors in that case:

"Error in tempdir() using \tmp\XXXXXXXXXX: Parent directory (\tmp) is
not a directory at /libexec/git-core/git-send-email line 554"

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
