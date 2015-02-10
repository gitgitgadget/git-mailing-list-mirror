From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-file: correctly open files when in a subdir
Date: Tue, 10 Feb 2015 12:57:42 -0800
Message-ID: <xmqqwq3pv60p.fsf@gitster.dls.corp.google.com>
References: <CAPHKiG7vzKbtH7=cXD-7Cta=a-iy-ViMustn98z+VEog5ep2sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLHsU-0001mZ-4l
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 21:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbbBJU5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 15:57:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751381AbbBJU5p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 15:57:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86EA937537;
	Tue, 10 Feb 2015 15:57:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GuoCfDUBhdygZkTkob6oH87z704=; b=RJJcho
	HwpaCq5mtSnb8M4TKtwm1gk92oRl1PApqUPmRvUA+0i3Z2pRh5mWqcgCQrvcEwr0
	d8plvxR/mvd0K/3aXTVE/HP2gTqIIGWr5KCCrbFYquvv+jjasmFyJ3VwFOVwc1JW
	JAOL0UEiagTtHLzK97N3eSkCwAtbwqSe9Fjuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J8mbHUPLbN8XV/B1KXFPRJIcFF2U190q
	GCP/luDSrODT0T6HqWCk8DwTCm0Wwr+HVqqDEeCUEq/Apb28OZ+Z6g10/huzqekP
	TZqN5QH1QR6oqVMfl/x9MwEnt+odt0DILqMwnnJV4KIlIh3/PW3HyMFM3WBaSZmw
	kBK96D8PlWA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DDA937536;
	Tue, 10 Feb 2015 15:57:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 001EE37534;
	Tue, 10 Feb 2015 15:57:43 -0500 (EST)
In-Reply-To: <CAPHKiG7vzKbtH7=cXD-7Cta=a-iy-ViMustn98z+VEog5ep2sg@mail.gmail.com>
	(Aleksander Boruch-Gruszecki's message of "Tue, 10 Feb 2015 21:23:55
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7590B9E6-B167-11E4-9388-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263648>

Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
writes:

> run_setup_gently() is called before merge-file. This may result in changing
> current working directory, which wasn't taken into account when opening a file
> for writing.
>
> Fix by prepending the passed prefix. Previous var is left so that error
> messages keep refering to the file from the user's working directory
> perspective.
>
> Signed-off-by: Aleksander Boruch-Gruszecki
>     <aleksander.boruchgruszecki@gmail.com>

Please don't line wrap the footer.

> ---
>  builtin/merge-file.c  | 3 ++-
>  t/t6023-merge-file.sh | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

This patch does not apply.

> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 844f84f..232b768 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -90,7 +90,8 @@ int cmd_merge_file(int argc, const char **argv,
> const char *prefix)

Please do not line-wrap the patch, either.

>
>      if (ret >= 0) {

The original has a single tab at the beginning of this line to
indent, not four spaces.

>          const char *filename = argv[0];
> -        FILE *f = to_stdout ? stdout : fopen(filename, "wb");
> +        const char *fpath = prefix_filename(prefix, prefixlen, argv[0]);
> +        FILE *f = to_stdout ? stdout : fopen(fpath, "wb");
>
>          if (!f)
>              ret = error("Could not open %s for writing", filename);
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> index 3758961..fdd104c 100755
> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -72,6 +72,12 @@ test_expect_success 'works in subdirectory' '
>      ( cd dir && git merge-file a.txt o.txt b.txt )
>  '
>
> +mkdir -p dir/deep
> +cp new1.txt orig.txt new2.txt dir/deep
> +test_expect_success 'accounts for subdirectory when writing' '
> +    (cd dir && git merge-file deep/new1.txt deep/orig.txt deep/new2.txt)
> +'

Interesting.  Makes us wonder why the one before this new one you
added did not catch the issue, doesn't it?

> +
>  cp new1.txt test.txt
>  test_expect_success "merge without conflict (--quiet)" \
>      "git merge-file --quiet test.txt orig.txt new2.txt"
