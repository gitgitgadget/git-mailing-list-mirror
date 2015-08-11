From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revisions --stdin: accept CRLF line terminators
Date: Tue, 11 Aug 2015 15:14:10 -0700
Message-ID: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
References: <55CA594D.5020103@kdbg.org>
	<xmqqr3n9pkzc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCG77UMM3EJRBNHHVGXAKGQESZIEHYY@googlegroups.com Wed Aug 12 00:14:16 2015
Return-path: <msysgit+bncBCG77UMM3EJRBNHHVGXAKGQESZIEHYY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f63.google.com ([209.85.220.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBNHHVGXAKGQESZIEHYY@googlegroups.com>)
	id 1ZPHoF-0002rF-CI
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 00:14:15 +0200
Received: by paxl1 with SMTP id l1sf19388253pax.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=rHYM8/ovcC09TON3ZXE7/8ejsQS+O0lGxsl1Ewyu0iA=;
        b=ayExqpH3lSpFENkQ79o8c2DbiyqlfU2OvK9RjUntlYaL4e8K684/7ds4rR2GkjyBcZ
         NqNRnvwZMFCcTw+mWjvm+jg8MseWxH3hH3huzFixsaGLzzr4GQL8hK5fU/E1W0Tlzei3
         3NcL+3oMaGlOcf5nkJKmiYHkHpeV0t+NGqmftq+Tq5/pNVXHlFL5m+8v+oJXXA3g8rab
         K1FHKOjvI/RfIdUK0o2PFqWEGYZaAx6PDnhdNB6kVS6ZalQ6t4PmNDGtvrR3tAR7KanD
         O4Q5B8W29VotgIoKPlJ7GetOUXkNmBTxtPGA6++J/P2yOadYEeAFNBa/F8qI96fR1KYz
         j/nw==
X-Received: by 10.182.39.136 with SMTP id p8mr133893obk.8.1439331254547;
        Tue, 11 Aug 2015 15:14:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.241.69 with SMTP id wg5ls1356957obc.49.gmail; Tue, 11 Aug
 2015 15:14:12 -0700 (PDT)
X-Received: by 10.182.85.197 with SMTP id j5mr26985416obz.23.1439331252572;
        Tue, 11 Aug 2015 15:14:12 -0700 (PDT)
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com. [2607:f8b0:400e:c02::22e])
        by gmr-mx.google.com with ESMTPS id eq2si361970pbb.2.2015.08.11.15.14.12
        for <msysgit@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 15:14:12 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c02::22e as permitted sender) client-ip=2607:f8b0:400e:c02::22e;
Received: by mail-pd0-x22e.google.com with SMTP id g1so88032007pdr.2
        for <msysgit@googlegroups.com>; Tue, 11 Aug 2015 15:14:12 -0700 (PDT)
X-Received: by 10.70.43.79 with SMTP id u15mr51439410pdl.84.1439331252410;
        Tue, 11 Aug 2015 15:14:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id os7sm3884536pbb.23.2015.08.11.15.14.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 15:14:11 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <xmqqr3n9pkzc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 11 Aug 2015 14:35:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c02::22e
 as permitted sender) smtp.mailfrom=jch2355@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275735>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> On Windows, 'git rebase -i' with rebase.missingCommitsCheck set to
>> warn or error reports:
>>
>>    Dropped commits (newer to older):
>>    'atal: bad revision '410dee56...
>>
>> The error comes from the git rev-list --stdin invocation in
>> git-rebase--interactive.sh (function check_todo_list)....

We have other places that take long list of things via --stdin
option.  It somehow feels incomplete to patch only rev-list and not
others, doesn't it?

I looked at hits from 'grep -e --stdin Documentation/'.  Here are
the findings.

1. These use strbuf_getline() to get one line at a time into a
   strbuf and expects the line termination stripped off (i.e. these
   callers do not want to worry about having LF at the end):

        check-attr --stdin
        check-ingore --stdin
        check-mailmap --stdin
        checkout-index --stdin
        hash-object --stdin-paths
        http-fetch --stdin
        notes --stdin
        send-pack --stdin
        update-index --index-info

2. Any command in the "log" family uses strbuf_getwholeline(), so it
   needs to know about the LF at the end explicitly:

        rev-list --stdin
        show --stdin
        cherry-pick --stdin
        ...

3. This uses fgets() into a fixed buffer; it calls get_sha1_hex() on
   it, and the expected input is one 40-hex per line, so it does not
   matter if there is an extra CR at the end immediately before LF.

        diff-tree --stdin

4. This slurps everything in-core, instead of going line-by-line.

        update-ref --stdin

Now, I am wondering if it makes sense to do these two things:

 * Teach revision.c::read_revisions_from_stdin() to use
   strbuf_getline() instead of strbuf_getwholeline().

 * Teach strbuf_getline() to remove CR at the end when stripping the
   LF at the end, only if "term" parameter is set to LF.

Doing so would solve 1. and 2., but we obviously need to audit all
the other uses of strbuf_getline() to see if they can benefit (or if
some of them may be broken because they _always_ need LF terminated
lines, i.e. CRLF terminated input is illegal to them).

As to 3., I think it is OK.  The code structure of 4. is too ugly
and needs to be revamped to go one line at a time first before even
thinking about how to proceed, I would think.

Thoughts?

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
