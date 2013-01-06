From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jk/pathspec-literal] t6130-pathspec-noglob:
 Windows does not allow a file named "f*"
Date: Sun, 06 Jan 2013 12:00:51 -0800
Message-ID: <7vbod2nkss.fsf@alter.siamese.dyndns.org>
References: <50E9852F.2060005@kdbg.org>
 <20130106143319.GA10690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>,  Git Mailing List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCG77UMM3EJRB55PU6DQKGQEMDZSONQ@googlegroups.com Sun Jan 06 21:01:13 2013
Return-path: <msysgit+bncBCG77UMM3EJRB55PU6DQKGQEMDZSONQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f185.google.com ([209.85.161.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB55PU6DQKGQEMDZSONQ@googlegroups.com>)
	id 1TrwPA-00026R-92
	for gcvm-msysgit@m.gmane.org; Sun, 06 Jan 2013 21:01:12 +0100
Received: by mail-gg0-f185.google.com with SMTP id q6sf10958847ggc.22
        for <gcvm-msysgit@m.gmane.org>; Sun, 06 Jan 2013 12:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf:from:to
         :cc:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:x-pobox-relay-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=69LB4CLpls+tSooI5rod14q6uK43e+cgNdQYnRSkYx4=;
        b=Ztcm+yJ4xwfg9Z1EU6FWnsQbdvvYLZ9OgIY9TVdpWvaY1+TbXapzSQ6PeHJ6XwzySB
         +I7qFVrStOefsSWYYbu2ZmM1ZKPVOzXEsi2WhTQYlqFxrtsp6mk8PZ+BIT0FCilcfuEb
         +cfVjPOuKLDkSD9xFwCY/hOc7aVGpxq33PNv3GLg/2cDZzQPoLb7rak4oMPJNLhBmyLh
         QN0bpifZIOL0aoepe4PStSqfhCq3l5rhJAtdM14fVbSFXVAPjCDgyyfHUQwFVgzUmv3e
         rrCStHaquX0iXr41t3M68+DS 
X-Received: by 10.49.81.72 with SMTP id y8mr10002456qex.42.1357502456282;
        Sun, 06 Jan 2013 12:00:56 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.30.36 with SMTP id p4ls8793143qeh.74.gmail; Sun, 06 Jan
 2013 12:00:54 -0800 (PST)
X-Received: by 10.224.205.65 with SMTP id fp1mr35318212qab.4.1357502454909;
        Sun, 06 Jan 2013 12:00:54 -0800 (PST)
X-Received: by 10.224.205.65 with SMTP id fp1mr35318211qab.4.1357502454897;
        Sun, 06 Jan 2013 12:00:54 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id fg3si5448813qcb.2.2013.01.06.12.00.54;
        Sun, 06 Jan 2013 12:00:54 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72FBAA4BD;
	Sun,  6 Jan 2013 15:00:54 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6473EA4BC;
	Sun,  6 Jan 2013 15:00:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C32B5A4BB; Sun,  6 Jan 2013
 15:00:53 -0500 (EST)
In-Reply-To: <20130106143319.GA10690@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 6 Jan 2013 09:33:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6E9F938-583B-11E2-ADC2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212835>

Jeff King <peff@peff.net> writes:

> On Sun, Jan 06, 2013 at 03:07:43PM +0100, Johannes Sixt wrote:
>
>> Windows disallows file names that contain a star. Arrange the test setup
>> to insert the file name "f*" in the repository without the corresponding
>> file in the worktree.
>> [...]
>> -	test_commit star "f*" &&
>> +	# insert file "f*" in the commit, but in a way that avoids
>> +	# the name "f*" in the worktree, because it is not allowed
>> +	# on Windows (the tests below do not depend on the presence
>> +	# of the file in the worktree)
>> +	git update-index --add --cacheinfo 100644 "$(git rev-parse HEAD:foo)" "f*" &&
>> +	test_tick &&
>> +	git commit -m star &&
>
> Thanks, looks obviously correct to me.
>
> Sorry to break Windows again. It seems I learn about a new gotcha with
> every patch series. :)

Thanks, both.

It appears that pushing things earlier to 'next' (and unfortunately
even to 'master') rather than later seems to be the only way to help
catching little gotchas like this ;-).

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
