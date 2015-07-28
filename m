From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: git branch command is incompatible with bash
Date: Tue, 28 Jul 2015 12:01:04 +0200
Message-ID: <55B752E0.7020901@gmail.com>
References: <20150727121253.GC17338@2vizcon.com> <55B69E68.90306@kdbg.org> <xmqqh9opgtjz.fsf@gitster.dls.corp.google.com> <55B72F09.3030000@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anatol Rudolph <a.rudolph@2vizcon.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 12:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK1hJ-00008V-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 12:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbbG1KBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2015 06:01:17 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36008 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422AbbG1KBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 06:01:15 -0400
Received: by wicgb10 with SMTP id gb10so148826788wic.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SnZhyKk3+27xB+xjcbADIAv/jivTA7SzStup0ak5LyI=;
        b=f+MihEWLpMyxvonVjUczGh0P4euX85E8CiZOUIle5x8CUsgdXTxnE6rwgPKMzkwLVb
         rAu658VLIabv954yOxl246fwtmDxUm9Pao7hCe0b7OmDr+MEeJ3Pt6mFTxUcPTLvc7dG
         9KHTUo7+syF/kcEwxPNOyiuz0aNOqTAs5Q5oQFfsYY6TCLk5YzeEyYvJYh+BnWgFzZc9
         /GNBAek47mx3+Uto2seQPfZR/7x8rzlUWWk/QmKPSjga+5tmNHvoonWNaMAyUvrfY1/g
         bGu1IzWJTrSmwInWeb4aSd9UhllblX3GG661kPtqLSLYK+aMXmFY1zdfAKXTsRIlQ9VT
         HT4Q==
X-Received: by 10.181.11.229 with SMTP id el5mr5015187wid.40.1438077673925;
        Tue, 28 Jul 2015 03:01:13 -0700 (PDT)
Received: from [192.168.130.220] ([158.75.2.130])
        by smtp.gmail.com with ESMTPSA id y1sm18205153wib.7.2015.07.28.03.01.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 03:01:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <55B72F09.3030000@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274764>

W dniu 2015-07-28 o 09:28, Johannes Sixt pisze:
> Am 27.07.2015 um 23:49 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Try
>>>
>>>    branchName=3D$(git rev-parse --abbrev-ref HEAD)
>>
>> Hmm, interesting.
>>
>>      $ git checkout --orphan notyet
>>      $ git rev-parse --abbrev-ref HEAD
>>      $ git symbolic-ref --short HEAD
>>
>
> Please don't scare newcomers with these corner cases ;-)

:-P

Yet another corner case:

   $ git checkout origin/master # or v1.0.0
   $ git rev-parse --abbrev-ref HEAD
   $ git symbolic-ref --short HEAD

> I see this:
>
> $ git rev-parse --abbrev-ref HEAD
> HEAD
> fatal: ambiguous argument 'HEAD': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'

Errr... this error message is errorneous (well, at least somewhat
misleading). Git should know that HEAD is not a path, and that
--abbrev-ref doe not need no revision.

> $ git symbolic-ref --short HEAD
> notyet
>
> Are you trying to say that the result of 'rev-parse --abbrev-ref HEAD=
'
> is suboptimal and that of 'symbolic-ref --short HEAD' is OK?

--=20
Jakub Nar=C4=99bski
