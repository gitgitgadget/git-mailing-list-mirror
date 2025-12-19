Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1762248A4
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140915; cv=none; b=gr32NhFmeVVdNs/L1Az4ayI4nZkjsAUaM5MGFfF4vdQoZfFEYxBz73G/wUNTCRm0d/q7FmWy1yuuH2B4Vi4cmdo2C1e5IrzCWFM/zKj38Tjybeat0HUCDUy173Xm8jYAgQEJ/Bzj+nao1P6t+29Lj2mhEDfV4HDm8A0xvepr+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140915; c=relaxed/simple;
	bh=254h+rnIILqMOw8kiNZb95WbZOAri/nCfi0ipmdHu8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ok3Q7RS0CCnb0LD706Io8vegb6DshUq/guHX3/2cI4dKOiGLg2wkN9rtRco1AD754v/o5izJG40O5hpmHfEMAf3Su5tTss1YNEU46KAanvDMfntRWg6W6cIps0mpO12HGSIyi95cAtKpMtk/KRSRWaGyvVbsKoFYirE2H45BvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MchJJLvs; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MchJJLvs"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso13532085e9.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 02:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766140911; x=1766745711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3r1zs/WTgFhQJVrFwskMzkSmZ7WyLurWaO88ACMSgiQ=;
        b=MchJJLvsBxpT94FNvpQnVi2nTURjsA/61k7dFn6SNVkR8D8XN2069ev/6T4gsUXbqB
         NNYZZgn8/U4NdBKQqPvf1tJ0SjZDACRLyZ7godLTDrnCiQ677ccyxzu14TEQZTIeswsz
         ZRcvJnjpH7RXBWJcya9bkpn4hOQ6yeI8/b2IPDUKHkDIlxjUFhBCZoFI4U0Qt2+oEO++
         rNiVPqxFKmdNIYX4cEr+iyYSbsUqX5855ls3ZrVjGXRl07aybB1m/4jLyj/gm57gnnbH
         joW8CTuUCd6FUiDyslPDyONa9GAZQnTxrDvQks7/aAFZoYaHVRUTG0W3W0AjGs01T5tZ
         mutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766140911; x=1766745711;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r1zs/WTgFhQJVrFwskMzkSmZ7WyLurWaO88ACMSgiQ=;
        b=ZsGngNVPfhPXiJvpi1Dx4r+bX/A7FeLQFgcah8SwODySvfYg7a0a5oZhRbEPln4IFc
         2ornmSXWjASrjUnOkRxrZv40HKRUov0VurSjVQ8ixGFBZFAmhLoi3j9jjJashjM7pdVv
         7I4Rkjbro66kk+qybwGgPTbxYB2+0O4XT6759X4xQiA8idyj8MEa34msMwDGUPEFeMMz
         AtnEb1beyG4NohI9Q+Rydr93bVQ+VVX4PcIHuN1+uZs9/lKxuz7u1ByFcihzWeXmE/46
         NjSZEX3cZ0L75rupBCeK6Z1wjChWmoqfKDSH+8syW96miUkg8Pgmh/nPKz8Wu2lZxEJ8
         PryQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLRO1zzxFVbi9aCSY1oGdPk6Eqil2PDA/Iu2pvQOuBNPyDpEqAx8Z02JK4si7WOZMsh28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDVpX3M7n4tSqzrotZbdTrkzlZmnM471IuBulQyHasTYg75rsx
	01rutqjRX6SABgCyDqcbIL1eD+v4nY5H4arTnTFl5ps1HCx9Z0IgmLyu
X-Gm-Gg: AY/fxX7WLGBWqxX+wnPkHswR6xvt73ooCjnw7Y/DJUirjP82oJTzbI4VeChkUqXOVy7
	nUZ6wlWR1wYa7N8O5eCUUy33djWNVt3J3Xhs6DYCGcjRUrK+R0yyyZlQVxG16djiw7R2iMP/L5M
	xj5yOnzH++P/oxp0mBqKFgHLZmRkNXsx21lCtxLh9lIBFS2UyNLaHgtVR/zx08eZIHCpBuVi25i
	qf7TSOhOLY7Q71flH8xAW8Sg/DSOawZCiNaE76IXwONZdrXClvEy+M98t8G+FWlz+dTPtFZ73aB
	cFhAJ1tuEgAMKYIRM7OweMcaRheATarL1bJ8RXqD0Ji1k4x8gZrB5Ggh9e6miJaRvtAA84d11aF
	zIPZ0fYb/2GcUrw7DrX6thp+EAL9I7cbqLv2uYj3tGGC67asAcnXvFssGQz3SSf/wflfrSEjbnC
	LmcV3WDxV2fHPYOtg2mNs8uaLgAFc24bAp9EqwmDBx/CQioOL45qoPtrbYanlBbdq1KA==
X-Google-Smtp-Source: AGHT+IHGcr5Dtw5JV5fPbrcFjdjkS4BVL1JIJ0//8eL6zA9nI0n2NR/fnnG0/6MmZafuss7Fvpl5BQ==
X-Received: by 2002:a5d:5888:0:b0:431:307:21fc with SMTP id ffacd0b85a97d-4324e42e79emr3038251f8f.23.1766140911002;
        Fri, 19 Dec 2025 02:41:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea225fcsm4420121f8f.16.2025.12.19.02.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 02:41:50 -0800 (PST)
Message-ID: <03034879-2d8e-4ab1-96ff-ff125e7d059e@gmail.com>
Date: Fri, 19 Dec 2025 10:41:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: changes for adding new features --snapshot,
To: Abdullah <abdullahindo888@gmail.com>, git@vger.kernel.org
References: <CAG-pPd-4StfLAsassx-fqzavHJkAmi8P5UkgvqE3Yz-yGJ7GUw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAG-pPd-4StfLAsassx-fqzavHJkAmi8P5UkgvqE3Yz-yGJ7GUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It would be helpful if there was a commit message explaining what this 
new feature is and why it is needed. There are some comments in the code 
explaining what it does but not why it is useful. Given that a commit is 
a snapshot of the working copy I'm not sure why you'd want to save an 
additional copy. As the code comments indicate you have not tested this 
code I wonder how you know that what you're proposing is useful.

Thanks

Phillip

On 18/12/2025 05:02, Abdullah wrote:
> ---
>   builtin/commit.c |   2 +
>   snapshot.c       | 108 +++++++++++++++++++++++++++++++++++++++++++++++
>   snapshot.h       |  13 ++++++
>   3 files changed, 123 insertions(+)
>   create mode 100644 snapshot.c
>   create mode 100644 snapshot.h
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0243f17d53..e880409be7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -43,6 +43,7 @@
>   #include "commit-graph.h"
>   #include "pretty.h"
>   #include "trailer.h"
> +#include "snapshot.c"
> 
>   static const char * const builtin_commit_usage[] = {
>    N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]]
> [--amend]\n"
> @@ -1545,6 +1546,7 @@ struct repository *repo UNUSED)
>    int fd;
>    struct object_id oid;
>    static struct option builtin_status_options[] = {
> + OPT_BOOLEAN(0, "snapshot", &opts.snapshot, "Create snapshot of staged files")
>    OPT__VERBOSE(&verbose, N_("be verbose")),
>    OPT_SET_INT('s', "short", &status_format,
>        N_("show status concisely"), STATUS_FORMAT_SHORT),
> diff --git a/snapshot.c b/snapshot.c
> new file mode 100644
> index 0000000000..8c117a7314
> --- /dev/null
> +++ b/snapshot.c
> @@ -0,0 +1,108 @@
> +#include "snapshot.h"
> +#include "run-command.h"
> +#include "strbuf.h"
> +#include "utf8.h"
> +#include <time.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +
> +#define DEFAULT_SNAPSHOT_DIR ".git/snapshots"
> +/*
> +## Idea
> +The `--snapshot` flag would create a copy of all staged files in a
> timestamped folder before the commit is made. Users could configure
> the snapshot folder, defaulting to `.git/snapshots`.
> +
> +## Example Usage
> +
> +# Enable snapshot feature
> +git config snapshot.enable true
> +
> +# Optional: configure snapshot folder
> +git config snapshot.folder "../snapshots"
> +
> +# Stage files and commit with snapshot
> +git add .
> +git commit -m "Initial commit" --snapshot
> +
> +# Example snapshot folder created:
> +# ../snapshots/2025-12-17_14-30-00_Initial_commit/
> +
> +# Notes:
> +these codes are never tested, I send it just to know if it fits to
> your development
> +*/
> +
> +// Get snapshot folder from config, or fallback to default
> +static char *get_snapshot_dir(void) {
> +    const char *cfg_dir = git_config_get_string("snapshot.folder");
> +    if (cfg_dir && *cfg_dir)
> +        return strdup(cfg_dir);
> +    return strdup(DEFAULT_SNAPSHOT_DIR);
> +}
> +
> +// Check if snapshot is enabled
> +int snapshot_enabled(void) {
> +    const char *val = git_config_get_string("snapshot.enable");
> +    return val && strcmp(val, "true") == 0;
> +}
> +
> +// Get current timestamp for folder name
> +static void get_timestamp(char *buffer, size_t size) {
> +    time_t now = time(NULL);
> +    struct tm *tm_info = localtime(&now);
> +    strftime(buffer, size, "%Y-%m-%d_%H-%M-%S", tm_info);
> +}
> +
> +// Create snapshot of staged files
> +int create_snapshot(const char *message) {
> +    char timestamp[64];
> +    char snapshot_path[1024];
> +
> +    char *snapshot_dir = get_snapshot_dir();
> +    if (!snapshot_dir) {
> +        fprintf(stderr, "Failed to get snapshot directory\n");
> +        return -1;
> +    }
> +
> +    // Ensure base folder exists
> +    if (mkdir(snapshot_dir, 0755) != 0 && errno != EEXIST) {
> +        perror("mkdir snapshot_dir");
> +        free(snapshot_dir);
> +        return -1;
> +    }
> +
> +    get_timestamp(timestamp, sizeof(timestamp));
> +
> +    // Sanitize commit message
> +    char sanitized_msg[512];
> +    snprintf(sanitized_msg, sizeof(sanitized_msg), "%s", message);
> +    for (char *p = sanitized_msg; *p; p++)
> +        if (*p == ' ') *p = '_';
> +
> +    // Create snapshot folder path
> +    snprintf(snapshot_path, sizeof(snapshot_path), "%s/%s_%s",
> snapshot_dir, timestamp, sanitized_msg);
> +
> +    if (mkdir(snapshot_path, 0755) != 0) {
> +        perror("mkdir snapshot_path");
> +        free(snapshot_dir);
> +        return -1;
> +    }
> +
> +    // Copy staged files
> +    char cmd[2048];
> +    snprintf(cmd, sizeof(cmd),
> +             "git diff --name-only --cached | xargs -I{} cp --parents
> {} \"%s\"",
> +             snapshot_path);
> +
> +    int ret = system(cmd);
> +    if (ret != 0) {
> +        fprintf(stderr, "Failed to copy staged files\n");
> +        free(snapshot_dir);
> +        return -1;
> +    }
> +
> +    printf("Snapshot created at %s\n", snapshot_path);
> +    free(snapshot_dir);
> +    return 0;
> +}
> diff --git a/snapshot.h b/snapshot.h
> new file mode 100644
> index 0000000000..7542538f1f
> --- /dev/null
> +++ b/snapshot.h
> @@ -0,0 +1,13 @@
> +#ifndef SNAPSHOT_H
> +#define SNAPSHOT_H
> +
> +#include "cache.h"
> +#include "dir.h"
> +
> +// Check if snapshot feature is enabled
> +int snapshot_enabled(void);
> +
> +// Create snapshot of staged files with commit message
> +int create_snapshot(const char *message);
> +
> +#endif // SNAPSHOT_H

