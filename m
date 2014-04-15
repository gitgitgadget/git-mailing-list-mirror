From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] send-email: recognize absolute path on Windows
Date: Tue, 15 Apr 2014 13:37:24 -0700
Message-ID: <xmqq1twyl46z.fsf@gitster.dls.corp.google.com>
References: <1397551465-10968-1-git-send-email-kusmabite@gmail.com>
	<534D0ADB.7070702@viscovery.net>
	<CABPQNSafmC-7zNJZJSZm598pF37_xUMUopgZ3c=ttL_wRDYsfQ@mail.gmail.com>
	<xmqq61maledq.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBCFRW2NAKGQE2YUL3UY@googlegroups.com Tue Apr 15 22:37:31 2014
Return-path: <msysgit+bncBCG77UMM3EJRBCFRW2NAKGQE2YUL3UY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f61.google.com ([209.85.220.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBCFRW2NAKGQE2YUL3UY@googlegroups.com>)
	id 1WaA6k-0002AQ-8f
	for gcvm-msysgit@m.gmane.org; Tue, 15 Apr 2014 22:37:30 +0200
Received: by mail-pa0-f61.google.com with SMTP id fb1sf2152978pad.26
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Apr 2014 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=3fq1kBVp3MCF6ebdjINodQtzI9Y3pG1r3c8YLjUyiBQ=;
        b=BNOyDOT0xBgEu5oLkhbB8elayE/mCYaVYWFUEu4D6/Ctp9Gr3/rqrKSsz7e+hCJGL5
         38VCLPBcY00vM2CJzszp0S8kscDuP0Bwv8z26trnPezX0VKAIhuSv+K2FHyFQLJa1g11
         2lZaqmxJCmWCt25rUjOsO3r2xIrKteFsLPXqwB/xP5V4LXbAG8YF5czc7XXhrgoqWzjW
         W5BXbClGCFogF7dNqyAJHjZUDxJ283S68Co8wAw5CTY0hstpjahc1WQr4uCUkf+bpG9Z
         4FNGifNI6/l0ByVAlkoD1OUD1GlSFPveJr9PmewB6I8HH92vGS2YgrmMnQAJqhWCMP/z
         Xgbw==
X-Received: by 10.140.82.38 with SMTP id g35mr73081qgd.23.1397594248562;
        Tue, 15 Apr 2014 13:37:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.97.8 with SMTP id l8ls362775qge.27.gmail; Tue, 15 Apr 2014
 13:37:28 -0700 (PDT)
X-Received: by 10.236.132.239 with SMTP id o75mr1629341yhi.19.1397594248258;
        Tue, 15 Apr 2014 13:37:28 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ga1si3532318qcb.0.2014.04.15.13.37.28
        for <msysgit@googlegroups.com>;
        Tue, 15 Apr 2014 13:37:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E896C7D29E;
	Tue, 15 Apr 2014 16:37:27 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD11A7D29D;
	Tue, 15 Apr 2014 16:37:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A94F7D29B;
	Tue, 15 Apr 2014 16:37:26 -0400 (EDT)
In-Reply-To: <xmqq61maledq.fsf_-_@gitster.dls.corp.google.com> (Junio
	C. Hamano's message of "Tue, 15 Apr 2014 09:57:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C1786498-C4DD-11E3-860B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246299>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, both.  I'd expect another round then?
>
> -- >8 --
> From: Erik Faye-Lund <kusmabite@googlemail.com>
>
> On Windows, absolute paths might start with a DOS drive prefix,
> which these checks fail to recognize.
>
> Use file_name_is_absolute from File::Spec::Functions for
> portability.  The Perl module msysgit has been shipping needs to be
> updated for this patch to work, though.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> Helepd-by: Johannes Sixt <j6t@kdbg.org>
> ---
>
>  git-send-email.perl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index fdb0029..eda3917 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -25,7 +25,7 @@
>  use Data::Dumper;
>  use Term::ANSIColor;
>  use File::Temp qw/ tempdir tempfile /;
> -use File::Spec::Functions qw(catfile);
> +use File::Spec::Functions qw(catfile file_name_is_absolute);
>  use Error qw(:try);
>  use Git;
>  
> @@ -1197,7 +1197,7 @@ sub send_message {
>  
>  	if ($dry_run) {
>  		# We don't want to send the email.
> -	} elsif ($smtp_server =~ m#^/#) {
> +	} elsif (file_name_is_absolute($smtp_server)) {
>  		my $pid = open my $sm, '|-';
>  		defined $pid or die $!;
>  		if (!$pid) {
> @@ -1271,7 +1271,7 @@ sub send_message {
>  		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
>  	} else {
>  		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
> -		if ($smtp_server !~ m#^/#) {
> +		if (file_name_is_absolute($smtp_server)) {

Obviously this has to be "!file_name_is_absolute($smtp_server)" ;-)

>  			print "Server: $smtp_server\n";
>  			print "MAIL FROM:<$raw_from>\n";
>  			foreach my $entry (@recipients) {
>
> -- 

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
