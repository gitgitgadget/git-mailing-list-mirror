From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t5541: test more combinations of --progress
Date: Tue, 01 May 2012 13:53:06 -0700
Message-ID: <7vehr38vyl.fsf@alter.siamese.dyndns.org>
References: <20120501084048.GA21904@sigill.intra.peff.net>
 <20120501084307.GC4998@sigill.intra.peff.net> <4FA04B4C.4090507@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Cc: Jeff King <peff@peff.net>,  Clemens Buchacher <drizzd@aon.at>,  dfowler
 <davidfowl@gmail.com>,  git@vger.kernel.org,  msysgit@googlegroups.com,  Paul
 Betts <paul@github.com>,  David Ebbo <david.ebbo@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: msysgit+bncCI3_0YzZExC1moH9BBoEzIwtqw@googlegroups.com Tue May 01 22:53:10 2012
Return-path: <msysgit+bncCI3_0YzZExC1moH9BBoEzIwtqw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gy0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCI3_0YzZExC1moH9BBoEzIwtqw@googlegroups.com>)
	id 1SPK4M-00007E-8d
	for gcvm-msysgit@m.gmane.org; Tue, 01 May 2012 22:53:10 +0200
Received: by ghbf19 with SMTP id f19sf4564036ghb.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 May 2012 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=3oXdXLaY/MNlB372fSE1hqiFPBeonVSIE+XDcXM5Qms=;
        b=4Q5UlhKryT7l+xA/xgnFczWg/RIAk3v5/06CknZzoQdC5lp0w1ZAoyGnLyUJ7Ns8UZ
         fSXwFj84scbOZ53oHc8GLtyfBTAK1AMBy4tCO9+ZxNKFjdIxYoKBnTNCnujTr/iQ/T1d
         +I5ITJE3zmmqt9QBOO/3Inom06XPgV5obvXOU=
Received: by 10.52.97.101 with SMTP id dz5mr713282vdb.3.1335905589282;
        Tue, 01 May 2012 13:53:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.52.67.103 with SMTP id m7ls2418967vdt.3.gmail; Tue, 01 May
 2012 13:53:08 -0700 (PDT)
Received: by 10.52.23.146 with SMTP id m18mr41214996vdf.7.1335905588646;
        Tue, 01 May 2012 13:53:08 -0700 (PDT)
Received: by 10.52.23.146 with SMTP id m18mr41214995vdf.7.1335905588637;
        Tue, 01 May 2012 13:53:08 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id cz20si7302421vdb.0.2012.05.01.13.53.08;
        Tue, 01 May 2012 13:53:08 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E86D6E27;
	Tue,  1 May 2012 16:53:08 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DF76E26;
	Tue,  1 May 2012 16:53:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C63CC6E23; Tue,  1 May 2012
 16:53:07 -0400 (EDT)
In-Reply-To: <4FA04B4C.4090507@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Tue, 01 May 2012 22:45:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7ACD788-93CF-11E1-86FC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196744>

Zbigniew J=EAdrzejewski-Szmek  <zbyszek@in.waw.pl> writes:

>> +test_expect_success 'push --progress shows progress to non-tty' '
>> +	cd "$ROOT_PATH"/test_repo_clone &&
>> +	test_commit progress &&
>> +	git push --progress 2>&1 | tee output &&
>> +	grep "^To http" output &&
>> +	grep "^Writing objects" output
>> +'
>> +
> I understand that test_i18ngrep is not necessary, because pack-objects.c
> is not internationalized. But wouldn't it make sense to use
> test_i18ngrep in preparation, so that tests don't have to be modified
> later on?

In this test, we are not interested in making sure the progress output is
properly localized.  I'd rather see it keep using grep and if you really
care, run "git push" under "LANG=3DC LC_ALL=3DC" or something reliable inst=
ead.

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
