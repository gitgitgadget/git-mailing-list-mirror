Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5C15AFE
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 40CMEgqM2096534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 22:14:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Raul Rangel'" <rrangel@google.com>
Cc: <git@vger.kernel.org>
References: <CAHQZ30Ad6+YM9qnCOeNNy8e2k-AbYR_bBXTups-7z6=ioyqS5Q@mail.gmail.com> <xmqqply68c87.fsf@gitster.g>
In-Reply-To: <xmqqply68c87.fsf@gitster.g>
Subject: RE: Make git ls-files omit deleted files
Date: Fri, 12 Jan 2024 17:18:28 -0500
Organization: Nexbridge Inc.
Message-ID: <038a01da45a5$47faf380$d7f0da80$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQIirW+J62odjb4l2PtVtO5Lgt9YEgKJJGkWsDGmI4A=

On Friday, January 12, 2024 4:37 PM, Junio C Hamano wrote:
>Raul Rangel <rrangel@google.com> writes:
>
>> I'm trying to copy my current git worktree to a new directory, while
>> including all modified and untracked files, but excluding any ignored
>> files.
>
>Curiously missing from the above is "unmodified".  You only talked about
modified,
>untracked, and ignored, but what do you want to do with them?
>
>As you are grabbing the files from the working tree, I suspect that you do
not want
>to base your decision on what is in the index, which means that ls-files
might be a
>wrong tool for the job.

Coupled with ls-files, using git status --porcelain might give some insight
into what the condition of each modified and untracked file/directory is.

