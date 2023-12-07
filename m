Received: from mail.zombino.com (c3.zombino.com [91.107.222.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F861BDC
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:20:46 -0800 (PST)
Received: from [10.168.5.44] (unknown [81.95.8.245])
	by mail.zombino.com (Postfix) with ESMTPS id 7C8CC98C27;
	Thu,  7 Dec 2023 08:20:44 +0000 (UTC)
Message-ID: <d47f6496-0328-480b-8296-da9e812f6e1b@zombino.com>
Date: Thu, 7 Dec 2023 09:20:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Content-Language: en-US
To: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
 <ZWethlRRtuQLDRlJ@nand.local>
 <20231206210836.GA106480@coredump.intra.peff.net>
From: Adam Majer <adamm@zombino.com>
In-Reply-To: <20231206210836.GA106480@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/6/23 22:08, Jeff King wrote:
> On Wed, Nov 29, 2023 at 04:30:46PM -0500, Taylor Blau wrote:
> 
>> On Tue, Nov 28, 2023 at 02:04:46PM -0500, Jeff King wrote:
>>>    - whatever is consuming the embedded repos could "mkdir -p refs
>>>      objects" as needed. This is a minor pain, but I think in the long
>>>      term we are moving to a world where you have to explicitly do
>>>      "GIT_DIR=$PWD/embedded.git" to access an embedded bare repo. So
>>>      they're already special and require some setup; adding an extra step
>>>      may not be so bad.
>>
>> I hope not. I suppose that using embedded bare repositories in a test
>> requires additional setup at least to "cd" into the directory (if they
>> are not using `$GIT_DIR` or `--git-dir` already). But I fear that
>> imposing even a small change like this is too tall an order for how many
>> millions of these exist in the wild across all sorts of projects.
> 
> I dunno. I am skeptical that there are millions of these. Who really
> wants to embed bare git repos except for projects related to Git itself,
> which want test vectors? Is there a use case I'm missing?
Well, it's an "easy" thing to do, instead of recreating these test cases 
from sources like it's done here. It seems this is what happens in 
projects like Gitea.

As to the original questions you've raised earlier in the thread, I 
thought about it, and I don't really have a compelling reason to try to 
force this patch into Git. At least, I do not feel it necessary to try 
to argue the points you've raised. If that means the patch is ignored, 
I'm ok with that.

The reasons I put it here is simply I found that it fixes an issue I 
came across and that "everything else" worked. I don't know the 
intricacies of current or future git plans and I would rather delegate 
such discussion to the experts.

Best regards,
Adam
