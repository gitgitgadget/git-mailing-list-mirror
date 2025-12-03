Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388822A7F9
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805168; cv=none; b=rDbqro7sbfIpqNTrQX8VqvLpcSXb7xjkykZIJgT2F6XwDk4FhDRPh9LGAKdTW1RtJpDfhBnrQOiEkhd9bcR2i97s7YFqAqEDVSNgQjxYtbrHnjVfuBEwF99LPVO3dznjwipmAMTNX/0Xmcx0aGS83Sfk1VjQnfPfjjywnFy/9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805168; c=relaxed/simple;
	bh=bvCZk3eiw9pJQwvkHegbm2ZgeNSEZcuomvu9l9mH7xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJeeATuejkkMOFOOZE6uPgqmQQhow5FctQmeFFt5tSPCltiuZt+q/kEyjKEZLpQEEp134qEttA6BCVnHPkw5dQox4PbryqcVTcNNtyJJG2u3PaJeAEfZWxO0ex2pabHFDGOh3RMOUSX8R6OSxUR1szpakg9kba+ZgeHUlrkPh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IJ7ceZQi; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IJ7ceZQi"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-642fcb38f35so233028d50.1
        for <git@vger.kernel.org>; Wed, 03 Dec 2025 15:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1764805165; x=1765409965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkdr+zhnyLe3k7h/5WJv01jnd/hm5GzIJcZ/it7+BoI=;
        b=IJ7ceZQiddM3RruJ6Upot1mdvRCDCJn3RiL/hBtvBr0k5hpHqBv4QY/f/OnYOzTKd0
         wR4ZqXmbKt5tIKP19BKHe11+p6tZgymz3u2FzjmjSfII11dRcF/MWQXfJrm8XkLSF4qI
         rrJrWqKcHSO0fukdVyjSNtlDsrul4vhrijLmTAoP/OYuVepMHadhqP1uqQrxleHgWSv0
         mTJJDxqOsNIKqX8jRExNt8Gr5T5nUwSX3EfiR+bbAkTP8beTlYEgDnONzyR4l0KlzKNh
         W6jZcAyzq5WuUoysG1rGosCBF28R2BxLZo8FNfuSH5PNMTw18gP3VDXc17wtsO+hlPk7
         ko3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805165; x=1765409965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkdr+zhnyLe3k7h/5WJv01jnd/hm5GzIJcZ/it7+BoI=;
        b=wA/DYWGGQkIME1aj1VexuXyEG4BZtei66R7IMKrKygWDa3AMpY/oRxvQSfwQw5+T9w
         7wQbJx7WtZB8zn6TmoaBX9f8oJz04sgtKkszh4jgyLUvHEVxdcpav2WUQ+p4SgsDD+St
         cQGjpBGURUQ6cIBhANZFItk+wWzgyIYF5IE1QuGhFd57FMsbXPpRbp//FkQBfC+bnnec
         h7SilkyO0scupZN03zjYMUdh4ZtdlB3hLP9Hn4EurhQLzhWInc5xHPR3viOsOr6NBdKd
         ykfZNFrfAmzvSgmAWErlBXyRaJgpwbxreCxIXAPm7cGanReuHmUvHxCn9EhMAGO4l0Ge
         0tFw==
X-Gm-Message-State: AOJu0YwgPDm8sh+aZLNSPMsquoLC/SoFN8hL9DAn7R/r+/p1pT/mNrHz
	DhNSrHgGOiRjiqXj3LWWpA6NngYpwHRtDAWLr3ObsIAROQkDrV/3hbC0SYDkFV9Y4R4=
X-Gm-Gg: ASbGncs6ia/K30SHZ2Jq7SrCEPHeTMAHPTqYDbnokNqt6RJM/MEGV7ccCfcUSsNhu+j
	zCi12FHp4YB83zXvztOyD7PiG5J7M1YZXeju3JDzfFZWbzO661unbwm/3Paj3wpRU9Ivy9/SAh0
	rVL+VSMJIr38M+nnR4UTIk05heT+Dy409CPSy8lKsANhTuEORD2hdwvpW43ur3+UdSifwyNg/Wi
	wkEXR4HAE26O4hgPj16uNb0EHrL6JrWMdB84b0XkP/TO4wiBDsqMFWlNfqdKwsgJTpXHn/Jr2D3
	k8RCnwSSNS8jfBuwSSeb/De3N7svBiBLMghV4VdyqmJuFIHRKXmY9L+ogDI/EsDcF4p0AC10Ek3
	AxxP038Uk8SHD2m/xNWQeAaBW6TcJV3rGuI+rjHpQuqwW523Eq/43neVG5ERupzQmkpSM7WrHgH
	PvqceIMsDwirucACZ0m2PYbhkotlioMIT5DgOXrkK+7u2yRw4GttY3eNEe6r7UrIcG/7nlHvHZb
	1ztcGW/FRabDidi6g==
X-Google-Smtp-Source: AGHT+IFMroWvZRLLqMD8hiXCXhrlc9jWHPPuymSCGRiXJqC8xUpQIEnZpBjvIwGB4f4rhBB70r3EeQ==
X-Received: by 2002:a53:acd7:0:20b0:641:f5bc:697c with SMTP id 956f58d0204a3-6443704b3ffmr2473878d50.72.1764805165135;
        Wed, 03 Dec 2025 15:39:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad0d3f600sm79719177b3.9.2025.12.03.15.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:39:24 -0800 (PST)
Date: Wed, 3 Dec 2025 18:39:23 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
Message-ID: <aTDKK6Ibcx35q3Tz@nand.local>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>

Hi Paulo,

On Tue, Dec 02, 2025 at 03:07:27PM +0000, Paulo Casaretto via GitGitGadget wrote:
> The .lock.pid file is created when a lock is acquired (if enabled), and
> automatically cleaned up when the lock is released (via commit or
> rollback). The file is registered as a tempfile so it gets cleaned up
> by signal and atexit handlers if the process terminates abnormally.

(For the purposes of this review, I'll ignore the naming conventions
that are discussed elsewhere in the thread, which I think can be
resolved separately of any technical concerns.)

> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index ce099e78b8..6fdd509d34 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -1010,6 +1010,16 @@ be in the future).
>  	the background which do not want to cause lock contention with
>  	other operations on the repository.  Defaults to `1`.
>
> +`GIT_LOCK_PID_INFO`::
> +	If this Boolean environment variable is set to `1`, Git will create
> +	a `.lock.pid` file alongside each lock file containing the PID of the
> +	process that created the lock. This information is displayed in error
> +	messages when a lock conflict occurs, making it easier to identify
> +	stale locks or debug locking issues. The PID files are automatically
> +	cleaned up via signal and atexit handlers; however, if a process is
> +	terminated abnormally (e.g., SIGKILL), the file may remain as a stale
> +	indicator. Disabled by default.

Regardless of whether or not we expose this functionality behind an
environment variable or configuration, I think it would be nice to be
able to turn PID tracking on and off for different components (e.g., for
scenarios where you care about who is holding open, say, $GIT_DIR/index,
but not who is creating a lock during ref creation).

If we determined this through an environment variable, I think it would
be reasonable to adopt the convention from the "core.fsync"
configuration and use a comma-separated list. Alternatively, we could
adopt that same convention for a configuration variable, say,
"core.lockfile".

But I think that having this exposed as a per-component setting via
configuration is preferable than a global switch, since callers don't
have to remember to set this variable in their environment to get the
desired effect. Callers that want to opt-in or out of this feature on a
one-off basis can still override the configuration via the top-level
"-c" flag.

>  `GIT_REDIRECT_STDIN`::
>  `GIT_REDIRECT_STDOUT`::
>  `GIT_REDIRECT_STDERR`::
> diff --git a/lockfile.c b/lockfile.c
> index 1d5ed01682..4a694b9c3d 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -6,6 +6,9 @@
>  #include "abspath.h"
>  #include "gettext.h"
>  #include "lockfile.h"
> +#include "parse.h"
> +#include "strbuf.h"
> +#include "wrapper.h"
>
>  /*
>   * path = absolute or relative path name
> @@ -71,6 +74,62 @@ static void resolve_symlink(struct strbuf *path)
>  	strbuf_reset(&link);
>  }
>
> +/*
> + * Lock PID file functions - write PID to a .lock.pid file alongside
> + * the lock file for debugging stale locks. The PID file is registered
> + * as a tempfile so it gets cleaned up by signal/atexit handlers.
> + */
> +
> +static int lock_pid_info_enabled(void)
> +{

With the above suggestion, I think this function would get a little more
complicated to instead take a component argument. That's not a huge deal
in and of itself, but callers that *create* a lockfile will have to
somehow pass in the component name when acquiring the lock.

> +	return git_env_bool(GIT_LOCK_PID_INFO_ENVIRONMENT, 0);
> +}
> +
> +static struct tempfile *create_lock_pid_file(const char *lock_path, int mode)
> +{
> +	struct strbuf pid_path = STRBUF_INIT;
> +	struct strbuf content = STRBUF_INIT;
> +	struct tempfile *pid_tempfile = NULL;
> +	int fd;
> +
> +	if (!lock_pid_info_enabled())
> +		return NULL;
> +
> +	strbuf_addf(&pid_path, "%s%s", lock_path, LOCK_PID_SUFFIX);
> +	fd = open(pid_path.buf, O_WRONLY | O_CREAT | O_TRUNC, mode);

I'm not sure whether or not we should pass O_EXCL here, but I think it
depends on the naming convention we pick.

> +	if (fd >= 0) {

This is a style preference, but I'd suggest handling the happy path
outside of this conditional if possible by inverting it. Perhaps
something like:

    if (fd < 0)
        goto out;

    strbuf_addf(&content, ...);
    if (write_in_full(fd, content.buf, content.len) < 0)
        warning_errno(...);

    close(fd);
    pid_tempfile = register_tempfile(pid_path.buf);

    out:
        strbuf_release(...);
        return pid_tempfile;

> +static int read_lock_pid(const char *lock_path, uintmax_t *pid_out)
> +{
> +	struct strbuf pid_path = STRBUF_INIT;
> +	struct strbuf content = STRBUF_INIT;
> +	int ret = -1;
> +
> +	strbuf_addf(&pid_path, "%s%s", lock_path, LOCK_PID_SUFFIX);
> +	if (strbuf_read_file(&content, pid_path.buf, LOCK_PID_MAXLEN) > 0) {
> +		char *endptr;
> +		*pid_out = strtoumax(content.buf, &endptr, 10);
> +		if (*pid_out > 0 && (*endptr == '\n' || *endptr == '\0'))
> +			ret = 0;

Same note here. I'd suggest setting "ret = 0" during initialization, and
inverting this conditional to:

    if (*pid_out <= 0 || (*endptr != '\n' && *endptr != '\0')) {
        warning(...);
        ret = -1;
        goto out;
    }
> +		else
> +			warning(_("malformed lock pid file '%s'"), pid_path.buf);
> +	}
> +	strbuf_release(&pid_path);
> +	strbuf_release(&content);
> +	return ret;
> +}
> +
>  /* Make sure errno contains a meaningful value on error */
>  static int lock_file(struct lock_file *lk, const char *path, int flags,
>  		     int mode)
> @@ -80,9 +139,12 @@ static int lock_file(struct lock_file *lk, const char *path, int flags,
>  	strbuf_addstr(&filename, path);
>  	if (!(flags & LOCK_NO_DEREF))
>  		resolve_symlink(&filename);
> -
>  	strbuf_addstr(&filename, LOCK_SUFFIX);
> +

These look like stray whitespace changes that were left behind from
development.

> +		if (pid_status == 1)
> +			strbuf_addf(buf, _("Lock is held by process %"PRIuMAX". "
> +			    "Wait for it to finish, or remove the lock file to continue"),
> +			    pid);
> +		else if (pid_status == -1)
> +			strbuf_addf(buf, _("Lock was held by process %"PRIuMAX", "
> +			    "which is no longer running. Remove the stale lock file to continue"),
> +			    pid);
> +		else
> +			strbuf_addstr(buf, _("Another git process seems to be running in this repository. "
> +			    "Wait for it to finish, or remove the lock file to continue"));

On one hand I prefer the new "Another git process" message for when we
don't have a PID lockfile. But on the other hand, I think the "If it
still fails, a git process may have crashed..." message is useful for
users who may not be immediately aware of the consequences of simply
removing the lockfile to continue.

I do think the original message is somewhat verbose, so maybe the change
here in the non-PID case is worth doing. What are your thoughts?

> +
> +		strbuf_release(&lock_path);
>  	} else
>  		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),
>  			    absolute_path(path), strerror(err));
> @@ -207,6 +292,8 @@ int commit_lock_file(struct lock_file *lk)
>  {
>  	char *result_path = get_locked_file_path(lk);
>
> +	delete_tempfile(&lk->pid_tempfile);
> +

Do we want to wait to delete the PID file until after we know that we
successfully committed the lockfile?

> +/* Maximum length for PID file content */
> +#define LOCK_PID_MAXLEN 32

Makes sense ;-). This should be plenty of space, since on my system
maximum PID value is 2^22:

    $ cat /proc/sys/kernel/pid_max
    4194304

> +test_expect_success 'PID info file cleaned up on successful operation when enabled' '
> +	git init repo4 &&
> +	(
> +		cd repo4 &&
> +		echo content >file &&
> +		env GIT_LOCK_PID_INFO=1 git add file &&
> +		# After successful add, no lock or PID files should exist
> +		! test -f .git/index.lock &&
> +		! test -f .git/index.lock.pid

These should be:

    test_path_is_missing .git/index.lock &&
    test_path_is_missing .git/index.lock.pid

instead of bare "! test -f"'s.

Thanks,
Taylor
