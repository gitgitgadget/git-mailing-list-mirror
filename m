From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 8/9] test: replace shebangs with descriptions in shell libraries
Date: Tue, 26 Nov 2013 00:18:31 -0500
Message-ID: <CAPig+cQizcuPjastanvyKkuo2=p9BPhBE-PhBC2J2EKwXvLekg@mail.gmail.com>
References: <20131125205119.GQ4212@google.com>
	<20131125210306.GY4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 06:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlB2j-0001TG-8y
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 06:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab3KZFSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 00:18:33 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:37069 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab3KZFSc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 00:18:32 -0500
Received: by mail-la0-f52.google.com with SMTP id y1so1912994lam.25
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 21:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7eZltD4zMYYkCbQOWrwcpKIIYeO3FMyKpjvDdhCf5lQ=;
        b=qtGuAT7cb1oaNr1uNu4etdYQ65FgRAAlzyap8BrGt8+0BqxGGAEXgeHDKVmVXTRoD9
         hmC0XExoDH1OT15KM/yP/WWk8YowPcUuITz0Wax+ZbtkX5Yx1cnNUCJ0qh46tyfndrvL
         kvq6LMIl/Psvlhk8bJI+tywXReq2SRwqfXnTrXP8X4XlBhujjC8RBmQDi13+bPlMDTDB
         bYnQPwkaLpvrAkPv6uqSc3JTYtqkAbEPv2spCBW2yLD/0INKVL08liuvc/BaS6TYwx8l
         xBCrLUvXoUVXuUcy50DXXoWupfquudLamYr5dEWqn7lzJrLLWdd8xYUhayJVGsHH7vmt
         l6dA==
X-Received: by 10.152.120.102 with SMTP id lb6mr3455642lab.37.1385443111227;
 Mon, 25 Nov 2013 21:18:31 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Mon, 25 Nov 2013 21:18:31 -0800 (PST)
In-Reply-To: <20131125210306.GY4212@google.com>
X-Google-Sender-Auth: q5sWoTI2DIwfAlEQiCj66NrxoUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238371>

On Mon, Nov 25, 2013 at 4:03 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> A #! line in these files is misleading, since these scriptlets are
> meant to be sourced with '.' (using whatever shell sources them)
> instead of run directly using the interpreter named on the #! line.
>
> Removing the #! line shouldn't hurt syntax highlighting since
> these files have filenames ending with '.sh'.  For documentation,
> add a brief description of how the files are meant to be used in
> place of the shebang line.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/t/lib-bash.sh b/t/lib-bash.sh
> index 11397f7..10b76df 100644
> --- a/t/lib-bash.sh
> +++ b/t/lib-bash.sh
> @@ -1,7 +1,6 @@
> -#!/bin/sh
> -#
> -# Ensures that tests are run under Bash; primarily intended for running tests
> -# of the completion script.
> +# Shell library sourced instead of ./test-lib.sh by tests that need
> +# to run under Bash; primary intended for tests of the completion

s/primary/primarily/

> +# script.
>
>  if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
>         # we are in full-on bash mode
