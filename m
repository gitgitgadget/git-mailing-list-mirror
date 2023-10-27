Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511F2DF66
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEF1FA
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 05:45:43 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id D166923F67;
	Fri, 27 Oct 2023 08:45:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwMDX-dfC-00; Fri, 27 Oct 2023 14:45:35 +0200
Date: Fri, 27 Oct 2023 14:45:35 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: using oldest date when squashing commits
Message-ID: <ZTuw7ziOnTunMmML@ugly>
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com>
 <ZTeZ3KEQLIVU/sq2@ugly>
 <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com>
 <xmqqpm143p46.fsf@gitster.g>
 <59731c05-c3f6-4815-8411-783bb1c2aac4@kdbg.org>
 <70b8d4d8-f4b5-4cd7-b73a-1d7393d84266@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <70b8d4d8-f4b5-4cd7-b73a-1d7393d84266@xiplink.com>

On Fri, Oct 27, 2023 at 08:34:40AM -0400, Marc Branchaud wrote:
>I never use "fixup -C" (or -c), but I do use squash/fixup a lot.  I 
>find that I would prefer it if Git used the most recent Author date 
>from the set of commits being combined, rather than preserving the 
>picked commit's Author date.
>
that would be unreliable, as plain amends wouldn't be reflected. that 
may be rare in your workflow, but still.

>Sometimes it takes quite a while for me to get a piece of work sorted 
>out, and I would rather have the Author date in the end-result commit 
>reflect the work's completion time than its initiation time.
>
afaict, you need to get used to `--amend --reset-author` all commits 
before you push to achieve this reliably. that can be easily automated 
by using -x with rebase -i (filter-repo (ex filter-branch) would also 
work).

regards
