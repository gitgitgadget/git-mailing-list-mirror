Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4E200BF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE7297
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:52:16 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 32C4920386;
	Mon, 23 Oct 2023 13:52:04 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1quz5w-fWa-00; Mon, 23 Oct 2023 19:52:04 +0200
Date: Mon, 23 Oct 2023 19:52:04 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
Message-ID: <ZTayxB0Nm7AEyafp@ugly>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <a85c80eb-65ab-4b8c-ba94-de71516da5ef@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a85c80eb-65ab-4b8c-ba94-de71516da5ef@gmail.com>

On Mon, Oct 23, 2023 at 05:01:02PM +0100, Phillip Wood wrote:
>On 23/10/2023 14:00, Oswald Buddenhagen wrote:
>> +unless "fixup -c" is used. In the latter case, the message is 
>> obtained
>> +only from the "fixup -c" commit (having more than one of these is
>> +incorrect).
>
>This change is incorrect - it is perfectly fine to have more than one 
>"fixup -c" command. In that case we use the message of the commit of the 
>final "fixup -c" command.
>
i know that this is the case, see the previous thread (which i failed to 
link by header, cf.  
https://lore.kernel.org/all/20231020092707.917514-1-oswald.buddenhagen@gmx.de/T/#u 
).

>One case where there can be multiple "fixup -c" commands is  when a 
>commit has been reworded several times via "git commit 
>--fixup=reword:<commit>" and the user runs "git rebase --autosquash"
>
a cleaner solution would be recognizing the situation and not generating 
these contradicting commands in the first place. of course that would be 
more complexity, but it would also allow catching accidental use.

of course i can go back to documenting the status quo, but it seems kind 
of wrong.

>In the case of
>
>pick A
>fixup -C B
>
>don't we keep the authorship from A and just use the commit message from B?
>
uhm. we clearly do. that means i was given incorrect advice in 
https://lore.kernel.org/all/YjXRM5HiRizZ035p@ugly/T/#u (and so the 
thread is still looking for a resolution) ...

regards
