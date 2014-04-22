From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: recognize absolute path on Windows
Date: Tue, 22 Apr 2014 09:50:47 -0700
Message-ID: <xmqqk3ah71g8.fsf@gitster.dls.corp.google.com>
References: <1397635698-6252-1-git-send-email-kusmabite@gmail.com>
	<xmqqfvldi4ue.fsf@gitster.dls.corp.google.com>
	<xmqqbnw1i43p.fsf@gitster.dls.corp.google.com>
	<CABPQNSbcWjg3nLPD9U114zSk5rBNupOGLr901u4ptCkdiiKvCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>,  Johannes Sixt <j.sixt@viscovery.net>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRB3F33KNAKGQE2ERVP4I@googlegroups.com Tue Apr 22 18:50:58 2014
Return-path: <msysgit+bncBCG77UMM3EJRB3F33KNAKGQE2ERVP4I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f185.google.com ([209.85.128.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB3F33KNAKGQE2ERVP4I@googlegroups.com>)
	id 1WcduH-0005j1-9U
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 18:50:53 +0200
Received: by mail-ve0-f185.google.com with SMTP id jw12sf1558848veb.22
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Apr 2014 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=LrtkD8AdqmxYeoHHWydByiRB+zd2Ca+E5JZHhOqAI+0=;
        b=fkRpOAqJKZR5tu3ZdREE2IQDVjEEL2LvCve5ALJwtgN7DkBMpKaxthFjvYmBIOEXCi
         oi26ano8jlLYbJvIDNJSp6lwbv+DY9Hq+Z98VBNa6Br1nApaUaofOfcPs83htLocZjhb
         WYbOwe6EjlaRxEFhkUrkkNLbXVDUlpaehS9PIOQl91eXN+gjeoq5qYjUQS6UUVNmY1eH
         0sH4g3w73gKcJ5mTfyxsFVTnGE7KG/Wa8s8D/k9texJBhQS4o75cQUqDvU3OXz/iND/N
         ao7E1u6qEJv4QiaCvOhWkt0vndDNextH+0MJb1iCJDW9EK8cVYER2FDGH8eI/edsabXe
         //PQ==
X-Received: by 10.50.221.99 with SMTP id qd3mr747496igc.6.1398185452494;
        Tue, 22 Apr 2014 09:50:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.138.194 with SMTP id qs2ls2210028igb.37.canary; Tue, 22 Apr
 2014 09:50:51 -0700 (PDT)
X-Received: by 10.66.137.8 with SMTP id qe8mr22809315pab.46.1398185451877;
        Tue, 22 Apr 2014 09:50:51 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id n7si6129015qcz.2.2014.04.22.09.50.51
        for <msysgit@googlegroups.com>;
        Tue, 22 Apr 2014 09:50:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BBBD7F5CA;
	Tue, 22 Apr 2014 12:50:51 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D2807F5C8;
	Tue, 22 Apr 2014 12:50:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A72A27F5C0;
	Tue, 22 Apr 2014 12:50:48 -0400 (EDT)
In-Reply-To: <CABPQNSbcWjg3nLPD9U114zSk5rBNupOGLr901u4ptCkdiiKvCA@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 22 Apr 2014 14:15:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4184D634-CA3E-11E3-BF1F-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246752>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>>> Shouldn't the latter also be anchored at the beginning of the string
>>> with a leading "^"?
>>>
>>>> +    }
>>>> +
>>>> +    require File::Spec::Functions;
>>>> +    return File::Spec::Functions::file_name_is_absolute($path);
>>>
>>> We already "use File::Spec qw(something else)" at the beginning, no?
>>> Why not throw file_name_is_absolute into that qw() instead?
>>
>> Ahh, OK, if you did so, you won't have any place to hook the "only
>> on msys do this" trick into.
>>
>> It somehow feels somewhat confusing that we define a sub with the
>> same name as the system one, while not overriding it entirely but
>> delegate back to the system one.  I am debating myself if it is more
>> obvious if it is done this way:
>>
>>         use File::Spec::Functions qw(file_name_is_absolute);
>>         if ($^O eq 'msys') {
>>                 sub file_name_is_absolute {
>>                         return $_[0] =~ /^\// || $_[0] =~ /^[A-Z]:/i;
>>                 }
>>         }
>>
>
> In this case, we end up requiring that module even when we end up
> using it, no?

Also somebody earlier mentioned that we would be redefining, which
has a different kind of ugliness, so I'd agree with the code structure
of what you sent out (which has been queued on 'pu').

My earlier question "don't we want to make sure 'C:' is at the
betginning of the string?" still stands, though.  I do not think I
futzed with your regexp in the version I queued on 'pu'.

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
For more options, visit https://groups.google.com/d/optout.
