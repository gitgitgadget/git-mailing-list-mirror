From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/4] Properly accept quoted space in filenames
Date: Fri, 21 Nov 2014 15:21:44 -0800
Message-ID: <xmqqa93kywaf.fsf@gitster.dls.corp.google.com>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
	<1416526682-6024-3-git-send-email-philipoakley@iee.org>
	<xmqqegswyygc.fsf@gitster.dls.corp.google.com>
	<9E7656E05CE648B3A357858B4520110D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "GitList" <git@vger.kernel.org>,  "Marius Storm-Olsen" <mstormo@gmail.com>,  "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,  "Jonathan Nieder" <jrnieder@gmail.com>,  "Michael Wookey" <michaelwookey@gmail.com>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,  "Msysgit" <msysgit@googlegroups.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: msysgit+bncBCG77UMM3EJRBCUSX6RQKGQEMOWB22I@googlegroups.com Sat Nov 22 00:21:49 2014
Return-path: <msysgit+bncBCG77UMM3EJRBCUSX6RQKGQEMOWB22I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f191.google.com ([209.85.192.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBCUSX6RQKGQEMOWB22I@googlegroups.com>)
	id 1XrxWN-0006Pl-To
	for gcvm-msysgit@m.gmane.org; Sat, 22 Nov 2014 00:21:48 +0100
Received: by mail-pd0-f191.google.com with SMTP id z10sf780125pdj.28
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 15:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=BI4OM4afwALNcORXyhDtMw0RPAbIUDBZUTK7R8I++zs=;
        b=wMvbczyGs6OOqbeZAiBNyk2m0DuyQAZZGHTA4PXXo8awT/zS+BqapaIO2mNYI1xV8G
         caFIKQMFlawLQ8D7wrhWuNwoxme8zcte8EgV5QS+OfMy2pDH3gtj9veEbrEZ0DOlSsON
         VvnLDrdwLy5Ksq/Hr9VtaGYPPoP82iUMpCyWXA58GUfuawElkfJWVKCGi0ZRxDtOWcrw
         LncEUQcm+HZzWLjuKZiBc8Nmmtg01vOZmH0Nt9ve9lTwgExqMT4bAluHWz5U7ZmkrDsS
         Zt4kNOph/S02xFqQ3txIg2SOjFl3FBQQMA47xoss5/auf2ZqWV2pwT2oZx7t6SYKKC50
         0Nsw==
X-Received: by 10.50.41.73 with SMTP id d9mr11598igl.15.1416612107023;
        Fri, 21 Nov 2014 15:21:47 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.143.37 with SMTP id sb5ls72702igb.44.gmail; Fri, 21 Nov
 2014 15:21:46 -0800 (PST)
X-Received: by 10.66.150.162 with SMTP id uj2mr6684008pab.35.1416612106487;
        Fri, 21 Nov 2014 15:21:46 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id b3si1686963qcq.2.2014.11.21.15.21.46
        for <msysgit@googlegroups.com>;
        Fri, 21 Nov 2014 15:21:46 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AC2C2065E;
	Fri, 21 Nov 2014 18:21:46 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1124C2065D;
	Fri, 21 Nov 2014 18:21:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 776262065C;
	Fri, 21 Nov 2014 18:21:45 -0500 (EST)
In-Reply-To: <9E7656E05CE648B3A357858B4520110D@PhilipOakley> (Philip Oakley's
	message of "Fri, 21 Nov 2014 23:11:08 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28E07388-71D5-11E4-9832-42529F42C9D4-77302942!pb-smtp1.pobox.com
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

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> Philip Oakley <philipoakley@iee.org> writes:
>>
>>>  sub handleCompileLine
>>>  {
>>>      my ($line, $lineno) = @_;
>>> -    my @parts = split(' ', $line);
>>> +    # my @parts = split(' ', $line);
>>> +    my @parts = quotewords('\s+', 0, $line);
>>
>> Can somebody enlighten me why/if quotewords is preferrable over
>> shellwords in the context of this patch?
>
> "No" - Ignorance is bliss ;-) I think my cargo culting was the result
> of some googling for "quoting perl variables" or some such, which
> obviously came up with quotewords - I'm happy to take advice on this
> one!
>
> quotewords did appear to work though back when I wrote this: 86dcfcf
> (Properly accept quoted space in filenames, 2012-05-06)

A quick websearch shows me:

  http://cpansearch.perl.org/src/CHORNY/Text-ParseWords-3.29/ParseWords.pm

and comparing the implementations of the two, the difference boils
down to just one line to me.

    sub shellwords {
        my (@lines) = @_;
        my @allwords;

        foreach my $line (@lines) {
            $line =~ s/^\s+//;
            my @words = parse_line('\s+', 0, $line);
            pop @words if (@words and !defined $words[-1]);
            return() unless (@words || !length($line));
            push(@allwords, @words);
        }
        return(@allwords);
    }

In quotewords, the call to parse_line uses $keep not hardcoded 0
(which would not make any difference in the context of your patch),
and it assumes parse_line() never returns a singleton "undef" so the
line "pop ... if @words is a list with 'undef' as its sole element"
is missing.

Of course, the caller would become smaller and sweeter, i.e.

    my @parts = shellwords($line);

I am not familiar with if Perl folks have certain convention to
decide when to use which one, though ;-)




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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
