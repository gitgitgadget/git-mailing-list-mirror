From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 13/23] worktree: introduce "add" command
Date: Sat, 4 Jul 2015 09:53:38 +0700
Message-ID: <CACsJy8A2eB2-t4t4oxvWiTnEFr7jJxcVBnn+zHq4uNNTk3sypg@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com> <1435969052-540-14-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 04:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBDao-0000mr-0s
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 04:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbbGDCyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 22:54:10 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34193 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbbGDCyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 22:54:08 -0400
Received: by igcsj18 with SMTP id sj18so198323815igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U1aIGUcugzylDXR2JgPrSVR4oeE5mJ+IezzFGq0rYww=;
        b=bNgJvbfsQxaphqVQWnES8DNb32v3NZXEbw4Ir/OriDRp5ROiZT+QNV09704G+umwt7
         Su1axJlgeYWUCyiZ47RkixYf6j8TH7YSTrIK/jHcnP/m4MzVajZiFJ+65YsXrt2uf2M8
         p3FEkpXshntL6UavwHQBW2gfZX+fiZtYgcRAH/r+sMNfdY1guvCPI+6Dg1CJq5jU4wSm
         0Y6QEi1agJzKVJVFNjRkNUJ8Dcsl87AomJ5ag2pagRVoh5Q1mdBvp4Jl6W7bX3wmbWnc
         u0Ndmu6CzK1j1xBQC77HuLyNY1zQ9E9MKUFA0BTeFRCVmEpY9g7f5kt/NtDMMcqON7q3
         2EGQ==
X-Received: by 10.42.93.17 with SMTP id v17mr21538823icm.42.1435978447492;
 Fri, 03 Jul 2015 19:54:07 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 3 Jul 2015 19:53:38 -0700 (PDT)
In-Reply-To: <1435969052-540-14-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273348>

On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>  COMMANDS
>  --------
> +add <path> <branch>::
> +
> +Check out `<branch>` into a separate working directory, `<path>`, creating
> +`<path>` if necessary. The new working directory is linked to the current
> +repository, sharing everything except working directory specific files
> +such as HEAD, index, etc. If `<path>` already exists, it must be empty.

Side note, "must be empty" is an implementation limitation. I think
the two-way merge employed by git-checkout can deal with dirty <path>
and only perform the checkout if there is no data loss. But we can
leave this for later.
-- 
Duy
