Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.zombino.com (c3.zombino.com [91.107.222.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E5DD4B
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 12:44:32 -0800 (PST)
Received: from [192.168.1.115] (port-92-195-213-20.dynamic.as20676.net [92.195.213.20])
	by mail.zombino.com (Postfix) with ESMTPS id 3BB798189F
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 20:44:31 +0000 (UTC)
Message-ID: <830936c7-bcbb-480a-a5b1-7029a626d58b@zombino.com>
Date: Fri, 17 Nov 2023 21:44:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Content-Language: en-US
To: git@vger.kernel.org
References: <20231117202513.20604-1-adamm@zombino.com>
 <20231117203253.21143-1-adamm@zombino.com>
From: Adam Majer <adamm@zombino.com>
In-Reply-To: <20231117203253.21143-1-adamm@zombino.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-17 21:32, Adam Majer wrote:
> +test_expect_success 'remove empty refs/ subdirectory' '
> +	git -C bare.git cat-file -e 60dd8ad7d8ed49005c18b7ce9f5b7a45c28df814 &&
> +	test_dir_is_empty bare.git/refs/heads &&
> +	test_dir_is_empty bare.git/refs/tags &&
> +	rm -r bare.git/refs &&
> +	GIT_DIR="$PWD"/bare.git git -C bare.git cat-file -e 60dd8ad7d8ed49005c18b7ce9f5b7a45c28df814

In the test, I've first tried to use GIT_CEILING_DIRECTORIES="$PWD" here 
instead, but git went up into the parent directory anyway. I'm not sure 
if this is a bug, or feature, or my misunderstanding.

- Adam

