Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.zombino.com (c3.zombino.com [91.107.222.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A14394
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 01:43:31 -0800 (PST)
Received: from [10.168.5.44] (unknown [81.95.8.245])
	by mail.zombino.com (Postfix) with ESMTPS id 4150D912E4;
	Mon, 20 Nov 2023 09:43:29 +0000 (UTC)
Message-ID: <ab332078-dd49-41cf-a3d1-6a67a507b122@zombino.com>
Date: Mon, 20 Nov 2023 10:43:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
To: Junio C Hamano <gitster@pobox.com>, Glen Choo <glencbz@gmail.com>,
 Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
References: <20231117202513.20604-1-adamm@zombino.com>
 <20231117203253.21143-1-adamm@zombino.com> <xmqqbkbppbrd.fsf@gitster.g>
Content-Language: en-US
From: Adam Majer <adamm@zombino.com>
In-Reply-To: <xmqqbkbppbrd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/23 00:24, Junio C Hamano wrote:
> Adam Majer <adamm@zombino.com> writes:
> 
>> In a garbage collected bare git repository, the refs/ subdirectory is
>> empty.  In use-cases when such a repository is directly added into
>> another repository, it no longer is detected as valid.
> 
> Josh & Glen [*], isn't this a layout that we  explicitly discourage and
> eventually plan to forbid anyway?
> 
> *1* who worked on e35f202b (setup: trace bare repository setups, 2023-05-01)

This is fair enough. Completely removing embedded git repos would cause 
some pain in test suites as it was discussed in the thread for that 
commit[1]. Gitea (for example) has a few dozen embedded bare 
repositories for tests.

In either case, running `git gc` on a bare repository makes it no longer 
detectable as a git repository after checkout, GIT_DIR or not. This 
seems to be unintentional and not linked to the other discussion.

- Adam
