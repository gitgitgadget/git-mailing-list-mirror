From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 10:51:03 -0800
Message-ID: <CA+P7+xqa8+DopurNGnuW1HKMOmj2r2mvahossK_11SyMSWm2_g@mail.gmail.com>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
 <20160225014149.GA31616@sigill.intra.peff.net> <CA+P7+xpfuPkwcdeXVTiTdqRCX16J4pus-wmxe7Sipu_GXCNSoA@mail.gmail.com>
 <20160225070036.GA5654@sigill.intra.peff.net> <20160225071159.GA22529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:51:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ10b-0005Wt-MF
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 19:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371AbcBYSvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 13:51:24 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34604 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933225AbcBYSvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 13:51:24 -0500
Received: by mail-io0-f170.google.com with SMTP id 9so92931918iom.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cMqSvLdRfGEe3jr1FgQHvFFTO6I70BXT4Wnr+CACCg4=;
        b=b4r6/yucDM23OSbPSKFTqceS/Dcyi6e8ng04R6q3+aWJmhQCRxekWUz1J6cg/zm6C0
         REaz851oHDK5oMJqTuwNQwdb/wGCGtfSCmfYx20evE5sE9NVOAImNR2IA6iEmrQAjXI0
         RYdziAoTktIFd0hCfqc2Gdh0UaUiD1Ti3XKhCKWGO5PNCV76K4N4UH+4cokV7Li18O8b
         4W81DKajzvnz6SdTmB6/ry/AQng0SAkuRDkcriljt58KEcZ2K48GfO8GLQjh0znBoJPO
         OFFjksMw33lnk5oW+FiqE98EODy36SWSs65BieWGaPccDBB5WG4f7adoHCm0PmNSJVS0
         8qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cMqSvLdRfGEe3jr1FgQHvFFTO6I70BXT4Wnr+CACCg4=;
        b=jyJoB+AD+ERS7qZJ2UHmf3l4yQUeILTUjOnlJFKIaA4jjEn/x5oc/1+xBnUzzcT6DM
         Jf9B/AmuZfBa3LhvpwDq1wG4mroNANduDRoLLgqkvD8/BtHx+7YssdGAbRrUqcIvkdZz
         6h+KDbPhlApb2l81YPFPZz88MhrV1CWz1++VGkNXii7atqZQUeczGQAz2QCj6WtDyIwD
         MZSItZIqOoFQHDUI0zEYzG7iwdE/BF+SpCXVtkakHkubUKplc87PVNjGhbAB7jP7qA6B
         n4V9nyyDRt0HtHTdBCdvi6waMf/6DFluXYiqbaATC48XQFNlRl0IG1T9JAt2xlUSpFys
         mbcQ==
X-Gm-Message-State: AG10YORyQyCmzfMFOGIyB5vILl5m4xSLrHhq87ZN5Wz8QBi72HLV69Sxfa0BXNRC5ChQ6jVD6efPdGISbfBCLQ==
X-Received: by 10.107.166.195 with SMTP id p186mr4475121ioe.146.1456426283258;
 Thu, 25 Feb 2016 10:51:23 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 25 Feb 2016 10:51:03 -0800 (PST)
In-Reply-To: <20160225071159.GA22529@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287414>

On Wed, Feb 24, 2016 at 11:11 PM, Jeff King <peff@peff.net> wrote:
>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>                            const char *depth, const char *reference, int quiet)
>  {
> @@ -145,7 +166,7 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>         argv_array_push(&cp.args, path);
>
>         cp.git_cmd = 1;
> -       cp.env = local_repo_env;
> +       add_submodule_repo_env(&cp.env_array);
>         cp.no_stdin = 1;
>
>         return run_command(&cp);


Ignore my previous comment. The cp.env API is *very* subtle. If the
line is just a name, it removes the environment variable, while
"name=value" adds it. That is definitely not what I was expecting
here, so I misread how it works.

I am sending a v3 with an extended test similar to the one that Jeff suggested.

Thanks,
Jake
