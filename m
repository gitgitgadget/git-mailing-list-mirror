From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: recognize absolute path on Windows
Date: Wed, 16 Apr 2014 10:19:54 -0700
Message-ID: <xmqqbnw1i43p.fsf@gitster.dls.corp.google.com>
References: <1397635698-6252-1-git-send-email-kusmabite@gmail.com>
	<xmqqfvldi4ue.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysgit@googlegroups.com,  johannes.schindelin@gmx.de,  j.sixt@viscovery.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBP7XXKNAKGQEUZAICHQ@googlegroups.com Wed Apr 16 19:20:01 2014
Return-path: <msysgit+bncBCG77UMM3EJRBP7XXKNAKGQEUZAICHQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f60.google.com ([209.85.213.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBP7XXKNAKGQEUZAICHQ@googlegroups.com>)
	id 1WaTVA-0000rm-JU
	for gcvm-msysgit@m.gmane.org; Wed, 16 Apr 2014 19:20:00 +0200
Received: by mail-yh0-f60.google.com with SMTP id c41sf2417799yho.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Apr 2014 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=g0zILEBan/uT+avaqDOzbNN+wjbtSQxtPOmuFc3N08U=;
        b=Cnt1/53F4HMnmLlG4muTSbknpmfo0Ql2nhqPgu42u8ikR6yPldldJWoaS7pLD9R7Xr
         PeWD07IYkaVXoSFryRdeuxFnM2q0BkDZhsVG7KlmVR/KqvT+hBD5x538LYZ/SQI+VBwl
         iDAQUaizLc2jeuWDGmJOrlA6mVgr61FVn16zZUpbtoEQh27qCJ2PAxpZBWo6zYF9dSRS
         GOmrAFTnS0P9FNZqAZm/vFS4vX/focUbTzwXBpLEaL6QUP8emBuA2XPpwjnZJVotPJMc
         cZ/iM7x5ubY84XTiia6IV2A4HHQOIMpb0ZqooJWuMuJrgdMzgZhwnXnS2E+VN4H3u5CO
         s+ww==
X-Received: by 10.50.8.1 with SMTP id n1mr185122iga.5.1397668799640;
        Wed, 16 Apr 2014 10:19:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.79.162 with SMTP id k2ls1178852igx.26.gmail; Wed, 16 Apr
 2014 10:19:58 -0700 (PDT)
X-Received: by 10.66.121.136 with SMTP id lk8mr4362739pab.34.1397668798826;
        Wed, 16 Apr 2014 10:19:58 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id n7si441136qcz.2.2014.04.16.10.19.58
        for <msysgit@googlegroups.com>;
        Wed, 16 Apr 2014 10:19:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5655E7C7F8;
	Wed, 16 Apr 2014 13:19:58 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38D027C7F3;
	Wed, 16 Apr 2014 13:19:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97FAE7C7F2;
	Wed, 16 Apr 2014 13:19:56 -0400 (EDT)
In-Reply-To: <xmqqfvldi4ue.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Apr 2014 10:03:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 54E4304C-C58B-11E3-9596-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246349>

Junio C Hamano <gitster@pobox.com> writes:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> So let's manually check for these in that case, and fall back to
>> the File::Spec-helper on other platforms (e.g Win32 with native
>> Perl)
>> ...
>> +sub file_name_is_absolute {
>> +	my ($path) = @_;
>> +
>> +	# msys does not grok DOS drive-prefixes
>> +	if ($^O eq 'msys') {
>> +		return ($path =~ m#^/# || $path =~ m#[a-zA-Z]\:#)
>
> Shouldn't the latter also be anchored at the beginning of the string
> with a leading "^"?
>
>> +	}
>> +
>> +	require File::Spec::Functions;
>> +	return File::Spec::Functions::file_name_is_absolute($path);
>
> We already "use File::Spec qw(something else)" at the beginning, no?
> Why not throw file_name_is_absolute into that qw() instead?

Ahh, OK, if you did so, you won't have any place to hook the "only
on msys do this" trick into.

It somehow feels somewhat confusing that we define a sub with the
same name as the system one, while not overriding it entirely but
delegate back to the system one.  I am debating myself if it is more
obvious if it is done this way:

        use File::Spec::Functions qw(file_name_is_absolute);
        if ($^O eq 'msys') {
                sub file_name_is_absolute {
                	return $_[0] =~ /^\// || $_[0] =~ /^[A-Z]:/i;
                }
        }

>>  # Returns 1 if the message was sent, and 0 otherwise.
>>  # In actuality, the whole program dies when there
>>  # is an error sending a message.
>> @@ -1197,7 +1209,7 @@ X-Mailer: git-send-email $gitversion
>>  
>>  	if ($dry_run) {
>>  		# We don't want to send the email.
>> -	} elsif ($smtp_server =~ m#^/#) {
>> +	} elsif (file_name_is_absolute($smtp_server)) {
>>  		my $pid = open my $sm, '|-';
>>  		defined $pid or die $!;
>>  		if (!$pid) {
>> @@ -1271,7 +1283,7 @@ X-Mailer: git-send-email $gitversion
>>  		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
>>  	} else {
>>  		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
>> -		if ($smtp_server !~ m#^/#) {
>> +		if (!file_name_is_absolute($smtp_server)) {
>>  			print "Server: $smtp_server\n";
>>  			print "MAIL FROM:<$raw_from>\n";
>>  			foreach my $entry (@recipients) {
>> -- 
>> 1.9.0.msysgit.0
>>
>> -- 
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
