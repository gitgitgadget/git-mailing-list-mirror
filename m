Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBE343D9D
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875310; cv=none; b=T2KUaQUy85tEpQ3EpX+F8lmfKkSb+267Hza2BMzRUX6MpuEuo44duzlE6N+80yUwXt97k4a7LoVLyW/IisW2P8uF8QSayzJhi6jtZpch6KtwD9NGZwlWkvG4yxeMqEqPeemk5LXs07yliPWqN0TKcjOXt8fwHr+Bqo8HQXR6nm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875310; c=relaxed/simple;
	bh=gW3ydgz535ui+gQUMynjLd8Jk3rrkkdJttL5Dv2YxVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+D0CF0pWc95i3E6YAjOqTrQmqLU/TXLn9pPaU7ykOrpkCVkqHdmC8q2JuzDdwVFBzNXZuXXycqmegP9730gl/3rWaGln3TY4HG9ldrCfm+SWwrwmlmdGIwJKWg5c9dcWzBMc/pNIDvWGrFOt4ooxxLjgtRwX/EJV1AXFC2J+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=HdUKvZRc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YlF2ryyg; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="HdUKvZRc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YlF2ryyg"
DKIM-Signature: a=rsa-sha256; b=HdUKvZRcjh/D+8LsV/HmKvpY+iG2Yg4rwd2sNh3A/KEO2lXHJg0uRS5W5Mh20SKwbx+EHQ0rcpLWyf2+auI9IXIz4M471sfubqpBWnosDtnl+alR8svjStlJtxRWS0XrFHqNLryuN9lUq1SV3MG/BGOLkTcwlxpzJZCVnQTt2xf2QKQjoIVPiFJqaUSxAXsuNuE0gub7x0GIBp2C9wEKJH6rnpURqvd2NNY2RKREDo9MBzUdFQsp5wExh+TAWDbgrP/Hgta4eJ3YRw911pscwfX8Nt19PkRgYymtK/bXnabyLnk2ouVNRdSsslHwxgZM3K4uDoMjo0KCmuGL/btTSA==; s=purelymail1; d=malon.dev; v=1; bh=gW3ydgz535ui+gQUMynjLd8Jk3rrkkdJttL5Dv2YxVA=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=YlF2ryygOyoWyJMfpSFq4YHfAhGt91sB9k36Oo4uil/bm2whsgboyx0SE2FcEZG8AWRWPQyEXFJyaEOs6cVZOIjDOMPaio/oVntwREvULpcUG0tBuF/Qq2ezgsQpZQ002aX6vAp7iZP5oykLpq4AlaJ7lbD5ZIwKaV7eYKi1NQpbt92nhGBUvuwUUJIH20fTbaQDVUxA/AZdTA02jE4BsybrtR7v7bxhMhOA1BcA7HVF36G4dr9YUlP6+lExfcokJJsf+r3FahfWBixzQ7+8floyhaUktb6UnoNOWqEcgfSV3gPmTRiI81Ea0uWyi1nIYj21UACjinAr09qtuEtreQ==; s=purelymail1; d=purelymail.com; v=1; bh=gW3ydgz535ui+gQUMynjLd8Jk3rrkkdJttL5Dv2YxVA=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 603343343;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 16:55:05 +0000 (UTC)
Message-ID: <79e2b5b4-fc9e-4ca6-a4ff-dff93a3c64bc@malon.dev>
Date: Mon, 13 Jul 2026 00:54:58 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/9] environment: move pager_program into
 repo_config_values
Content-Language: en-US
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260709161145.13349-1-cat@malon.dev>
 <20260712111734.1073514-1-cat@malon.dev>
 <20260712111734.1073514-5-cat@malon.dev>
 <DJWNK8BOFIAW.3VVAROHMKVDWE@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <DJWNK8BOFIAW.3VVAROHMKVDWE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/26 22:12, Pablo Sabater wrote:
> On Sun Jul 12, 2026 at 1:17 PM CEST, Tian Yuchen wrote:
>> The 'pager_program' variable is currently defined as a file-scoped
>> static string in pager.c. Move it into 'struct repo_config_values'.
>>
>> The configuration parsing logic remains strictly within pager.c to
>> respect subsystem boundaries. The read/write operations are simply
>> redirected to the repository-specific structure using
>> 'repo_config_values()'.
>>
>> Similar to the recent editor_program migration, no standalone getter
>> is introduced to keep the code minimal. The dynamically allocated
>> memory is now managed by 'repo_config_values_clear()'.
>>
>> On top of that, fix a memory leak in pager.c while we are at it.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>>   environment.c |  2 ++
>>   environment.h |  1 +
>>   pager.c       | 26 +++++++++++++++++---------
>>   3 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/environment.c b/environment.c
>> index a65d575af4..975c9cb9eb 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -725,6 +725,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
>>   	cfg->attributes_file = NULL;
>>   	cfg->excludes_file = NULL;
>>   	cfg->editor_program = NULL;
>> +	cfg->pager_program = NULL;
>>   	cfg->apply_sparse_checkout = 0;
>>   	cfg->branch_track = BRANCH_TRACK_REMOTE;
>>   	cfg->trust_ctime = 1;
>> @@ -742,4 +743,5 @@ void repo_config_values_clear(struct repo_config_values *cfg)
>>   	FREE_AND_NULL(cfg->attributes_file);
>>   	FREE_AND_NULL(cfg->excludes_file);
>>   	FREE_AND_NULL(cfg->editor_program);
>> +	FREE_AND_NULL(cfg->pager_program);
>>   }
>> diff --git a/environment.h b/environment.h
>> index 8178ebab76..39b6691b47 100644
>> --- a/environment.h
>> +++ b/environment.h
>> @@ -92,6 +92,7 @@ struct repo_config_values {
>>   	char *attributes_file;
>>   	char *excludes_file;
>>   	char *editor_program;
>> +	char *pager_program;
>>   	int apply_sparse_checkout;
>>   	int trust_ctime;
>>   	int check_stat;
>> diff --git a/pager.c b/pager.c
>> index 35b210e048..bc55546670 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -5,6 +5,8 @@
>>   #include "run-command.h"
>>   #include "sigchain.h"
>>   #include "alias.h"
>> +#include "repository.h"
>> +#include "environment.h"
>>
>>   int pager_use_color = 1;
>>
>> @@ -13,7 +15,6 @@ int pager_use_color = 1;
>>   #endif
>>
>>   static struct child_process pager_process;
>> -static char *pager_program;
>>   static int old_fd1 = -1, old_fd2 = -1;
>>
>>   /* Is the value coming back from term_columns() just a guess? */
>> @@ -75,10 +76,15 @@ static void wait_for_pager_signal(int signo)
>>
>>   static int core_pager_config(const char *var, const char *value,
>>   			     const struct config_context *ctx UNUSED,
>> -			     void *data UNUSED)
>> +			     void *data)
> 
> Could this change behaviour that a caller expects?
> 
> (looking at the hunk below) we are now using repo_config_values() which
> contains the condition 'repo != the_repository'. This means that if there
> is a caller that sends anything but the_repository, it will BUG() out.
> 
> Before this patch it would have worked, it worked because callers were
> sending the correct repository. Now we enforce it.
> 
> If we check the callers we can see that everyone sends the_repository,
> so this new assert is fine and prevents sending submodules by mistake.
> 
> Makes sense.
> 

;)


> I think it's worth mentioning that on the commit body/function.
> 

Okay, will add a line to briefly explain this. Something like what Junio 
said:

	All current callers of git_pager() and
	check_pager_config() indeed pass 'the_repository', so this new
	enforcement does not harm them.

>>   {
>> -	if (!strcmp(var, "core.pager"))
>> -		return git_config_string(&pager_program, var, value);
>> +	struct repository *r = data;
>> +
>> +	if (!strcmp(var, "core.pager")) {
>> +		FREE_AND_NULL(repo_config_values(r)->pager_program);
>> +		return git_config_string(&repo_config_values(r)->pager_program, var, value);
>> +	}
> 
> Ok. Now that pager_program is not file-scoped we drop the UNUSED and
> pager_program now lives in the per-repo field.
> Then we change the address where ->pager_program (which we access through
> repo_config_values()) points to.
> 
> FREE_AND_NULL() is new, before this patch it must have been leaking,
> good job.
> 
> Similar to previous patches, let's change the pattern to only call
> repo_config_values() once and use the pointer it returns.
> 
>> +
>>   	return 0;
>>   }
>>
>> @@ -91,10 +97,10 @@ const char *git_pager(struct repository *r, int stdout_is_tty)
>>
>>   	pager = getenv("GIT_PAGER");
>>   	if (!pager) {
>> -		if (!pager_program)
>> +		if (!repo_config_values(r)->pager_program)
>>   			read_early_config(r,
>> -					  core_pager_config, NULL);
>> -		pager = pager_program;
>> +					  core_pager_config, r);
>> +		pager = repo_config_values(r)->pager_program;
> 
> Same as above, let's call repo_config_values() once.
> 
>>   	}
>>   	if (!pager)
>>   		pager = getenv("PAGER");
>> @@ -302,7 +308,9 @@ int check_pager_config(struct repository *r, const char *cmd)
>>
>>   	read_early_config(r, pager_command_config, &data);
>>
>> -	if (data.value)
>> -		pager_program = data.value;
>> +	if (data.value) {
>> +		free(repo_config_values(r)->pager_program);
>> +		repo_config_values(r)->pager_program = data.value;
> 
> Same pattern. This also frees, but the log says "a" memory leak is fixed
> in this patch, should we change it to two?

Nice catch.

> 
>> +	}
>>   	return data.want;
>>   }
> 
> I peeked at later patches of this series and the multiple calls of
> repo_config_values() pattern keeps appearing.
> I haven't finished reviewing 5-9. If you reroll before I get to those
> patches, it may be worth fixing this pattern across the whole series.
> 
> Regards,
> Pablo

For those cases where multiple calls to repo_config_values() appear in a 
single function body, I will fix such pattern by using cfg.

Thanks, yuchen
