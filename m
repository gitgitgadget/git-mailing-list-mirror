Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AF2AF05
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DEFBD
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 14:18:48 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3AEMFQIj2510089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 22:15:27 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Todd Zullinger'" <tmz@pobox.com>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqo7fwxn4s.fsf@gitster.g> <053501da173c$ac5b4470$0511cd50$@nexbridge.com> <ZVPiQKhem7ew8o_8@pobox.com>
In-Reply-To: <ZVPiQKhem7ew8o_8@pobox.com>
Subject: RE: [Potential Bug] Test t0301.34 hangs - Git v2.43.0-rc2
Date: Tue, 14 Nov 2023 17:18:37 -0500
Organization: Nexbridge Inc.
Message-ID: <053e01da1748$87594670$960bd350$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE8MOyTBz1sksdqK8tKcbeiTUdwZgJNoRpKAtwlGmOxjOB5gA==
Content-Language: en-ca

On Tuesday, November 14, 2023 4:10 PM, Todd Zullinger wrote:
>rsbecker@nexbridge.com wrote:
>> When running the full suite, I found that t0301.34 hangs on NonStop
>> x86 (Big Endian). No details at this point - will rerun this, but this
>> is a regression from rc1.
>
>FWIW, this test ran fine on Fedora's s390x architecture.
>That's little solace, I know, but may help rule out some potential causes.
>
>    t0301-credential-cache.sh ..........................
>    ...
>    ok 34 - helper (cache) can forget user
>    ...
>    # passed all 44 test(s)
>
>The build log is available here (for a few weeks or so -- it was only a
test build):
>
>https://kojipkgs.fedoraproject.org//work/tasks/4976/109024976/build.log

Well... it looks transient. I reran the test with and without verbose in ksh
and bash without any difficulty. It might just be a timing issue.

I guess we can ignore this one for now unless it becomes persistent.

