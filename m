Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BD54764
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760524; cv=none; b=pElin5N723xlQnf3GvYvMWIMlyS452CXrY4vt5QC8pClIyBOzGIqiktx8BxdREuPs8SyF0AHMBduWpn8kb1VGOd8iC1ZkCQkyYrFrJqqgj0CqnGfP/x1dpdeh4Nuh08nK6H+qBdIkohGYZVvCM9JU+eGCzDBr+2NPljV81iNyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760524; c=relaxed/simple;
	bh=sovI0ieWcyT1X5EO4OfzgYDTjnag0xGdaEs8d5gBhXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=qvCS31oWQry2an7YX326MrjU9DNDntqWZoV0JjXsNfRc+7nolsercOlDlCBs7qjMctNHWAiku9q68KNS+T+lvf8PAwGzkbg5gpNA5IJZ/F87QvWxhHNzyXaz3TXfwTLG8+jZLWCQAt6tzP8VNU2Ik1eJj0h1GOT/W7J1hqlw4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4c6vjF5pDsz7QfkD
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 09:15:13 +0200 (CEST)
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4c6vj46JQxzRmxB;
	Thu, 21 Aug 2025 09:15:04 +0200 (CEST)
Message-ID: <0e7cacac-b113-49de-be4b-a689e81815fb@kdbg.org>
Date: Thu, 21 Aug 2025 09:15:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH gitk] gitk: add README.md with contribution guidelines
Content-Language: en-US
To: Michael Rappazzo <rappazzo@gmail.com>
References: <20250820195229.45943-1-rappazzo@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250820195229.45943-1-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you. However, I hate to say that this isn't the text that I would
expect on the front page of the repository.

An important part is missing: first-time visitors are not addressed at
all. We should state what this software is about and show examples how
to use it effectively, perhaps include a link to the manual
(https://git-scm.com/docs/gitk).

I would prefer not to have format-patch+send-email tutorial in this text
nor how to make Github PRs. It is OK to have links to tutorials. The
prefix [PATCH gitk] hasn't been used in the past, but we do have the
convention that commit summaries have the prefix 'gitk:'. This alone
distinguishes submissions sufficiently (and then also simplifies using
'git format-patch' a bit).

Do not say that "this is the official repository". Remember that every
clone would say that, too. That would be confusing. In the Git world,
this status isn't achieved by proclamation, but by convention.

I wouldn't include the details how Gitk is also shipped with the Git
repository, but at most that it is. It is not even necessary to
discourage people from making patches in the gitk-git/ directory. `git
am -3` can cope with such patches quite well. Allowing such
contributions lowers the entry barrier.


Am 20.08.25 um 21:52 schrieb Michael Rappazzo:
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  README.md | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 README.md
> 
> diff --git a/README.md b/README.md
> new file mode 100644
> index 0000000000..adf7a0ba85
> --- /dev/null
> +++ b/README.md
> @@ -0,0 +1,63 @@
> +# gitk - The Git Repository Browser
> +
> +This is the official repository for gitk, a graphical Git repository browser.
> +
> +## Repository Status
> +
> +- **Official Repository**: https://github.com/j6t/gitk
> +- **Integration**: This repository is regularly merged into the main Git repository (git.git) via subtree merges into the `gitk-git/` subdirectory
> +
> +## Contributing
> +
> +Contributions are welcome! The preferred method for submitting patches is via email to the Git mailing list, as this allows for more thorough review and broader community feedback. However, GitHub pull requests are also accepted.
> +
> +All commits must be signed off (use `git commit --signoff`).
> +
> +### Email Patches
> +- Create patches from this repository (github.com/j6t/gitk), not from the `gitk-git/` subdirectory in git.git
> +- Send patches to the Git mailing list: git@vger.kernel.org and CC the maintainer: j6t@kdbg.org
> +- Follow the Git project's patch submission guidelines
> +- Include `[PATCH gitk]` in the subject line
> +
> +#### Creating and Sending Patches
> +After committing your changes:
> +```bash
> +git format-patch -1 --subject-prefix="PATCH gitk"
> +git send-email --to=git@vger.kernel.org --cc=j6t@kdbg.org *.patch
> +```
> +
> +For `git send-email` configuration, see the [documentation](https://git-scm.com/docs/git-send-email) (search for "Examples of SMTP Servers").
> +
> +For information about subscribing to the Git mailing list, see [subscription info](https://git.wiki.kernel.org/index.php/GitCommunity). Note that subscription is not required to participate in patch discussions.
> +
> +### GitHub Pull Requests
> +- Fork this repository and create a feature branch
> +- Submit a pull request with a clear description of your changes
> +
> +## Building
> +
> +gitk is a Tcl/Tk application. It requires Tcl/Tk to be installed on your system.
> +
> +### Running directly
> +```bash
> +./gitk
> +```
> +
> +### Installation
> +To install system-wide, you can use either `make` or `meson`:
> +
> +```bash
> +# Using Make
> +make install
> +
> +# Using Meson
> +meson setup builddir
> +meson compile -C builddir
> +meson install -C builddir
> +```
> +
> +Both build systems will handle setting the correct Tcl/Tk interpreter path and installing translation files.
> +
> +## License
> +
> +gitk is distributed under the GNU General Public License, either version 2, or (at your option) any later version.
> \ No newline at end of file

