Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BF1FDF
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B8BA
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 03:18:08 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id EC14620300;
	Tue, 24 Oct 2023 06:18:04 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvEU8-pMS-00; Tue, 24 Oct 2023 12:18:04 +0200
Date: Tue, 24 Oct 2023 12:18:04 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: phillip.wood@dunelm.org.uk
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: using oldest date when squashing commits
Message-ID: <ZTeZ3KEQLIVU/sq2@ugly>
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com>

On Tue, Oct 24, 2023 at 10:26:29AM +0100, Phillip Wood wrote:
>On 20/03/2022 08:05, Johannes Sixt wrote:
>> Am 19.03.22 um 13:48 schrieb Oswald Buddenhagen:
>>> during interactive rebasing, i sometimes find it necessary to move a
>>> hunk from one commit to a later one in the branch. now, if that hunk
>>> cannot be re-ordered with the later commit due to conflicting with it,
>>> it becomes necessary to squash the later commit onto a temporary commit
>>> created from the extracted hunk, not the other way around (or using a
>>> stash). unfortunately, this causes the author date of the later commit
>>> to be reset, which can rather seriously falsify the date if the branch
>>> is long-lived.
>> 
>> You want `fixup -C` in the todo-list. See the hints near the end of the
>> todo-list.
>
>Unfortunately "fixup -C" only copies the commit message not the 
>authorship

>(that's usually a good thing
>
why? what would that be useful for? it seems rather counter-intuitive.
it's also inconsistent with commit -c/-C's behavior, which seems like a 
red flag to me.

>but not it means it wont work for what Oswald wants to do).

>Maybe we should add another flag for fixup/squash commands to take the 
>authorship from that commit.
>
that's a possibility. but given the above, it might be better to simply 
change the behavior of -c/-C to keep the UI lean and consistent with 
commit's behavior.

regards
