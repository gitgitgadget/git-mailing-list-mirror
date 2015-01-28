From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 21/21] t3080: tests for git-list-files
Date: Wed, 28 Jan 2015 17:19:27 +0700
Message-ID: <CACsJy8DKJiXpHU4v3vsrgG0dDQ1akGYzfW9cgVJ=mPtdHjsbZw@mail.gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
 <1422189476-7518-22-git-send-email-pclouds@gmail.com> <CAPig+cQ8AuoA=ZNaOiZ_JQb-fKtXa-mFhoYQg+eWJxF3eFy9FA@mail.gmail.com>
 <CAO2U3QhA1bGAKmM4OL0VVuOfwaocqmFEsQdZNhSqf_7tkJ+=WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:43:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGe9A-0008JG-NK
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbbA2Bnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:43:49 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:49108 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbbA2Bns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:43:48 -0500
Received: by mail-ie0-f180.google.com with SMTP id rl12so27685676iec.11
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 17:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jBNj8V1gbTgycevkNugWhQPyxHrL3Z8JpdYkdl8gm68=;
        b=pCtK54yUikTYs4lcru0cICQtyV0dhKp5k60R85Ptc/YZSMhC3zZos00i6XbS994pcJ
         cR/BMij+wAvKQJSoFJOdiSCfzpa8coQvDRUiAgj5/0nAhBKQWKAhc1wYeia3zTpSQMBm
         cwPBEhv7KhysCy486wvu1acqefUlR30IdNXWsYoJwPOGr8uBU55in4x754RcYR8aKMm6
         H36Of0AhYYNJybGHui7npDuKMJc7YHqrfkibkiCJqf2BbUemy2oraW+ijz0Sg3fHvtmy
         fIu6roGZ7JQK8atWdURukaF95nmVXW9OFrbK3J7hikfXqWFW2kzorCyK7t/nyXzXFRdO
         8fbw==
X-Received: by 10.107.19.28 with SMTP id b28mr2790663ioj.83.1422440398054;
 Wed, 28 Jan 2015 02:19:58 -0800 (PST)
Received: by 10.107.131.34 with HTTP; Wed, 28 Jan 2015 02:19:27 -0800 (PST)
In-Reply-To: <CAO2U3QhA1bGAKmM4OL0VVuOfwaocqmFEsQdZNhSqf_7tkJ+=WQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263129>

On Wed, Jan 28, 2015 at 11:44 AM, Michael Blume <blume.mike@gmail.com> wrote:
> Test 3 is failing on my mac:
>
> expecting success:
> test_config color.ls.file red &&
> test_config color.ls.directory green &&
> test_config color.ls.submodule yellow &&
> git list-files --color=always >actual &&
> test_cmp "$TEST_DIRECTORY"/t3080/color_ls actual
>
> --- /Users/michael.blume/workspace/git/t/t3080/color_ls 2015-01-28
> 04:40:23.000000000 +0000
> +++ actual 2015-01-28 04:42:59.000000000 +0000
> @@ -1,3 +1,3 @@
> -dir
> -file
> -gitlink
> +dir
> +file
> +gitlink

Urgh.. colors do not send well over plain text.. I just realized we
have test_decode_color to convert colors to text descriptions.. will
fix..

Anyway, I think i may know why it fails. I suppose  the env variable
LS_COLORS is not defined, or defined as empty in your shell?
-- 
Duy
