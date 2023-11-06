Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4F2FE09
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF2AF
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 14:35:20 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3A6MVrZY715041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Nov 2023 22:31:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dragan Simic'" <dsimic@manjaro.org>,
        "'Sandra Snan'" <sandra.snan@idiomdrottning.org>
Cc: <git@vger.kernel.org>
References: <87cywmintp.fsf@ellen.idiomdrottning.org> <ef30a484525157579c64249a396f10ae@manjaro.org>
In-Reply-To: <ef30a484525157579c64249a396f10ae@manjaro.org>
Subject: RE: first-class conflicts?
Date: Mon, 6 Nov 2023 17:34:59 -0500
Organization: Nexbridge Inc.
Message-ID: <002901da1101$7d39a420$77acec60$@nexbridge.com>
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
Thread-Index: AQHWZdBcA4qCxkx3tZKGWDlhmagPvAGyBA0ZsGefmJA=
Content-Language: en-ca

On November 6, 2023 5:01 PM, Dragan Simic wrote:
>On 2023-11-06 22:17, Sandra Snan wrote:
>> Is this feature from jj also a good idea for git?
>> https://martinvonz.github.io/jj/v0.11.0/conflicts/
>
>Hmm, that's quite interesting, but frankly it makes little sense to me.
>See, the source code in a repository should always be in a compileable or
runnable
>state, in each and every commit, so going against that rule wouldn't make
much
>sense.  Just think about various CI/CD tools that also expect the same.

It seems to me, perhaps naively, that the longer a conflict persists in a
repository, the greater the potential for chaotic results. There are,
notably, at least two fundamental types of conflicts:

1. Content conflict, where a point in a file is modified in two (or n)
branches being combined, is what git tries to ensure never happens. The
longer such a conflict exists in a file, the greater the variance from a
buildable or consistent state will persist and will likely be increasingly
harder to resolve.

2. Semantic conflicts, where unrelated modification points cause
incompatibilities are much harder to resolve and quantify - many are, in
fact, undetectable from a computational standpoint (as in detecting general
semantic conflicts is an uncomputable problem). The longer those persist,
partly when they are missed by pull requests/code reviews, the more
persistent a defect can become.

3. I am avoiding matters such as code optimization conflicts which are
outside the scope of the proposal.

In either case, storing conflicts in the integration branches of a
repository is, in my view, a bad thing that eventually can make the
repository unsustainable. I will concede that keeping conflicts around in
non-integration branches may have intellectual value for recording research
and development progress.

This is just my opinion.
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



