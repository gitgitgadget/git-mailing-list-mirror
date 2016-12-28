Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EE7200E0
	for <e@80x24.org>; Wed, 28 Dec 2016 05:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbcL1Fco (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 00:32:44 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36590 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbcL1Fcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 00:32:43 -0500
Received: by mail-yw0-f176.google.com with SMTP id a10so181596267ywa.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 21:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rmIZP2dG0IzBUfWHjCosgt6jLLy90J7S0KkCv0hvu8g=;
        b=YtygdnnYLkUsyRJKDcDFXUuObCVEEPdCAgdTRzZfnmHJ7wJDqI9byU0vOVNTWvVUqb
         4O+3ZiPmnoN3fDkthR/0VegR9q51BaKuw9YiJ3ZM11Oiu5DzdwhVZeBHBZpbik50DMec
         p5C7B5apBU45I6LErPeRF0/OEqRRwYr5x9ZpdzgKBai50xDjx5bZsgS0ZcOBl4nqU8Uu
         hDqu4s5J7J4LE/2I+Y6UaGgim/uCSfCpdVr0utM+bRbjTORYjqw99Mgi1vRLU8kM/dsb
         tL1xxLtmwT45FfKNefRRpENAeFl3Eq+9WaeRTtaWT7G5bGSgdF//kisAUkB8adIEFcF0
         Tu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rmIZP2dG0IzBUfWHjCosgt6jLLy90J7S0KkCv0hvu8g=;
        b=VOs5OI9kss/3YkI6h59wof8g+Y1YYuWAROJ8fCbohG8kVZtc9fzpP47gWRTZzmxlkJ
         epwDeJ5OvXo2dDPAWYVeEFFxK75+JUrM+zL1A74Hvfy3j36tx/h58nQJ5WmgZyJVZ/Eh
         kskafMwZtfgyjOQxRC+gWfdPhwVPa5lVpujAFyZLHybZ7cz07CTfBdYfACOC+zlyWFTe
         6EGGYWAFwfR/Uyt111ZeVSbpMlNtifwE3i+DVMDkH7BEg1bpZI+ZbOCr9phgCY8nFLQK
         YlIbSTvsiiY5KpXRgPUrhnS4mYP03BXO03Ifc5T12LIMdVwi35QgIZLYosvD+W38PyjR
         b45A==
X-Gm-Message-State: AIkVDXIhcITsaqDRoDWnxTusNM9qsrSlgJfPes1ywyQfv5HAmZEvzP+haHFGgNJOBkKmy+wVfqYYo7LOEfN9Mw==
X-Received: by 10.13.210.132 with SMTP id u126mr27692976ywd.122.1482903162932;
 Tue, 27 Dec 2016 21:32:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.177.158 with HTTP; Tue, 27 Dec 2016 21:32:22 -0800 (PST)
In-Reply-To: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
References: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 27 Dec 2016 21:32:22 -0800
Message-ID: <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com>
Subject: Re: HowTo distribute a hook with the reposity.
To:     "John P. Hartmann" <jphartmann@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 5:34 PM, John P. Hartmann <jphartmann@gmail.com> wrote:
> I would like a hook in .got/hooks to be made available to all who clone or
> pull a particular project.  I'd also like the hook to be under git control
> (changes committed &c).  I added a hook, but git status does not show it.
> Presumably git excludes its files in .git/ from version control lest there
> be a chiken-and-egg situation.
>
> Is there a way to achieve this?  Or a better way to do it?
>
> Thanks,  j.

Best way I found, was add a script with an "installme" shell script or
similar that you tell all users of the repository that they are
expected to run this to install the scripts. You can' make it happen
automatically.

Thanks,
Jake
