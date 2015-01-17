From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Sun, 18 Jan 2015 00:35:30 +0100
Message-ID: <54BAF1C2.60103@web.de>
References: <20150114211712.GE1155@peff.net>	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>	<20150115222719.GA19021@peff.net>	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>	<20150115235752.GB25120@peff.net>	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>	<20150116013256.GA25894@peff.net>	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com> <xmqqzj9i1rci.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, msysgit@googlegroups.com, 
 =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>, 
 Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: msysgit+bncBCUZ3EUT2ADRBUPD5OSQKGQENGS4J4Q@googlegroups.com Sun Jan 18 00:35:49 2015
Return-path: <msysgit+bncBCUZ3EUT2ADRBUPD5OSQKGQENGS4J4Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBUPD5OSQKGQENGS4J4Q@googlegroups.com>)
	id 1YCcuA-0008GA-Tu
	for gcvm-msysgit@m.gmane.org; Sun, 18 Jan 2015 00:35:46 +0100
Received: by mail-wi0-f191.google.com with SMTP id n3sf694308wiv.8
        for <gcvm-msysgit@m.gmane.org>; Sat, 17 Jan 2015 15:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=QKHx/SKGoUzDzLaccH6lKjQpi4izLdXBHWNTtpwEoTA=;
        b=OnewM0SnjVG9Sn8Kw+uG24wldbLOLKmal6KyRLZV/O/4orGqJ/VQzlrOmfj1/bpodE
         +M/FCmmz6j4Qor4t6IeCjnQIJtJKZmeCN0yt/iTZeS9M3b5hyG2TKBH32OZXxO+dLapJ
         2WF2XG0jwCQdBrDfO1zKoqjaC0Yzki5FzmH9IA8EJhn55wt+j8L65b+wZYYkkQrBFWaH
         SPvFOJsG379r8G0uRIqNYYL7mZMX4lmz0T9Igvl854NqZYwiFa/o0e6TQPKPzwPnnAO2
         ekbnM/1DH+wHFipuUXvmpDO3Cc22pf4LXZ8KDv/Ys7ml6CSpieHyO7Lafd1Jb2wxKxyN
         mNyQ==
X-Received: by 10.180.211.206 with SMTP id ne14mr68288wic.2.1421537746527;
        Sat, 17 Jan 2015 15:35:46 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.103.226 with SMTP id fz2ls555878wib.38.gmail; Sat, 17 Jan
 2015 15:35:45 -0800 (PST)
X-Received: by 10.194.77.1 with SMTP id o1mr2753512wjw.1.1421537745612;
        Sat, 17 Jan 2015 15:35:45 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.17.12])
        by gmr-mx.google.com with ESMTPS id v8si567344wif.1.2015.01.17.15.35.45
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jan 2015 15:35:45 -0800 (PST)
Received-SPF: pass (google.com: domain of tboegi@web.de designates 212.227.17.12 as permitted sender) client-ip=212.227.17.12;
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MN4Oy-1Y61CK2jEG-006hBv; Sun, 18 Jan 2015 00:35:36
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqzj9i1rci.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:/EhTY5dF93smO0YGJpIJywPqWcwEIqDy46e5TEziso0B7N4ZlWD
 g0DpFzGqwZrqOQEB7Q3SAIkNNxYJ+xD6jPK5JsE7yXNOgyXKCXOLKLaOWgPNx85t69DUT/F
 tQdIN2JrlhdZ0FvZQIEq/d9KH4RfnsiiadcioGMeqJ1ZsbSSDubZ+SRjo6BiBWx5WSnpMd3
 yjVvtOSVFm85jrnTR33fA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of tboegi@web.de designates 212.227.17.12 as permitted
 sender) smtp.mail=tboegi@web.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262593>

Hm, being one day offline and there are lots of ideas and
new patches, I like that.
I run these test under msys and cygwin on latest pu (a3dc223ff234481356c):


./t0001-init.sh
./t0004-unwritable.sh
./t0061-run-command.sh
./t0070-fundamental.sh
./t1004-read-tree-m-u-wf.sh
./t1300-repo-config.sh
./t1301-shared-repo.sh
./t1308-config-set.sh
./t2026-prune-linked-checkouts.sh
./t3600-rm.sh
./t3700-add.sh
./t4039-diff-assume-unchanged.sh
./t4056-diff-order.sh
./t5537-fetch-shallow.sh
./t7300-clean.sh
./t7503-pre-commit-hook.sh
./t7504-commit-msg-hook.sh
./t7508-status.sh

(msys passes or skips all)

Without digging further, these fail on my cygwin:

$ grep "not ok" p.txt
not ok 29 - init notices EPERM
not ok 2 - write-tree should notice unwritable repository
not ok 3 - commit should notice unwritable repository
not ok 4 - update-index should notice unwritable repository
not ok 5 - add should notice unwritable repository
not ok 3 - mktemp to unwritable directory prints filename
not ok 13 - funny symlink in work tree, un-unlink-able
not ok 23 - proper error on non-accessible files
not ok 4 - prune directories with unreadable gitdir
not ok 15 - Test that "git rm -f" fails if its rm fails
not ok 16 - When the rm in "git rm -f" fails, it should not remove the file from the index
not ok 20 - Re-add foo and baz
not ok 21 - Modify foo -- rm should refuse
not ok 22 - Modified foo -- rm -f should work
not ok 23 - Re-add foo and baz for HEAD tests
not ok 24 - foo is different in index from HEAD -- rm should refuse
not ok 23 - git add should fail atomically upon an unreadable file
not ok 24 - git add --ignore-errors
not ok 25 - git add (add.ignore-errors)
not ok 26 - git add (add.ignore-errors = false)
not ok 27 - --no-ignore-errors overrides config
not ok 4 - unreadable orderfile
not ok 28 - removal failure
not ok 61 - status succeeds in a read-only repository

If we remove POSIXPERM from CYGWIN, all tests pass ;-)
but some are skipped :
< ok 26 - init creates a new deep directory (umask vs. shared)
< ok 3 - run_command reports EACCES
< ok 4 - unreadable directory in PATH
< ok 113 - preserves existing permissions
< ok 2 - shared=1 does not clear bits preset by umask 002
< ok 3 - shared=1 does not clear bits preset by umask 022
< ok 5 - update-server-info honors core.sharedRepository
< ok 6 - shared = 0660 (r--r-----) ro
< ok 7 - shared = 0660 (rw-rw----) rw
< ok 8 - shared = 0640 (r--r-----) ro
< ok 9 - shared = 0640 (rw-r-----) rw
< ok 10 - shared = 0600 (r--------) ro
< ok 11 - shared = 0600 (rw-------) rw
< ok 12 - shared = 0666 (r--r--r--) ro
< ok 13 - shared = 0666 (rw-rw-rw-) rw
< ok 14 - shared = 0664 (r--r--r--) ro
< ok 15 - shared = 0664 (rw-rw-r--) rw
< ok 16 - info/refs respects umask in unshared repo
< ok 17 - git reflog expire honors core.sharedRepository
< ok 18 - forced modes
< ok 4 - find-copies-harder is not confused by mode bits
< ok 10 - shallow fetch from a read-only repo
< ok 32 - git clean -d with an unreadable empty directory
< ok 7 - with non-executable hook
< ok 8 - --no-verify with non-executable hook
< ok 13 - with non-executable hook
< ok 14 - with non-executable hook (editor)
< ok 15 - --no-verify with non-executable hook
< ok 16 - --no-verify with non-executable hook (editor)

I'm not sure what is the best way forward, it seems as if CYGIN is "half POSIX" now.


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
