Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227AA1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbdDFUOD (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:14:03 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35505 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbdDFUOC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:14:02 -0400
Received: by mail-wr0-f171.google.com with SMTP id o21so50968636wrb.2
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=4jb5wGlIOaivVMyaYxtNf8aKttBzqkWPl1GAYWJIZgI=;
        b=idYBZwX0++PwQ2CPk4Vjmvds4LS3HRv08ZeULtxwvOHhjH6wmiE1dmzGJXQZHhOhDy
         wMvTAUHJlnDrmuhNIGgdsL8jldm6vn9PN5AopdnYxgYAmXT7nRg0ULA4JZVDzugTLptF
         fuVtzszH4F8E85IfXZj26nf6d6K40rnWj7jeo3k4Sb4TzBQjC9g/eTQI0813lyBRK/ym
         wayKiHdsOT479336icOuO0BcUgKTeLnYA8yDyFDXpuUKOqP+LA1JwMwn9elxWIIoOLxG
         DEw4y5rO4DVcO/Cmdk/JeprBgSuhQzRPtBIzLFMhVlvNjgvCKMHSUy8yMFO80+4htfoC
         Km1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4jb5wGlIOaivVMyaYxtNf8aKttBzqkWPl1GAYWJIZgI=;
        b=T5T045C1pa5Y0LdNuDe6qeb2YMyYwEp7t7s/l9XEB40nx+NnKVN6xx/46DjNxpeJzo
         ZusKMUeza6vlVvRLegN+2bJ6PFJaBJKkhTEUn4fKFKlJ9OBujhGtsiDPRWsz1eTFj/oo
         0a08KFbuM6Or058l/m8OcRG9L37DyPthc2+WF5Q3fn8kEcOmLyvFdxJYa07fsNvd2oBa
         7RXCvVQQMHQx3LRRuZ23tJ1QrBkEFxKGHOubUDaGDLKA+K1n8qN5QhYohMH53S6dG3hp
         FkDSSjyF05V2UbzOmbOBB1Xc90cqcqNguhQHceEDncIeW0B+ZS9fmDdrDy1LfvsqLxbE
         4Nvw==
X-Gm-Message-State: AFeK/H3QgTp2eIV9rRPWatUXZ2/y7Fi6JvyzQN9HXyTH0csduRt5HgShvfL2JgdwrGfDzQ==
X-Received: by 10.223.177.195 with SMTP id r3mr32185008wra.40.1491509639494;
        Thu, 06 Apr 2017 13:13:59 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.180.64])
        by smtp.gmail.com with ESMTPSA id 46sm3356049wru.37.2017.04.06.13.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Apr 2017 13:13:58 -0700 (PDT)
Subject: Re: how-to get commit content with pre-receive hook ?
To:     Eric Belhomme <rico-ml@ricozome.net>, git@vger.kernel.org
References: <955c152a-b278-ecfd-8bc7-671c3aa81dc6@ricozome.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <0dec12a8-b3d2-41e5-4563-4bec2a6df7be@gmail.com>
Date:   Thu, 6 Apr 2017 22:13:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <955c152a-b278-ecfd-8bc7-671c3aa81dc6@ricozome.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Eric,

On 06/04/2017 16:03, Eric Belhomme wrote:
> Until now I ever had a quite "basic" Git usage, but now I'm working 
> on a project based on Git hooks feature.. and I'm a very beginner 
> with Git hooks !
> 
> My need consist doing a syntax check on submitted files before a 'git 
> push'. So the right hook is 'pre-receive' and I'm already able to 
> identify the files I want to check using 'git show'.
> 
> But I don't know how to get the *content* of the file being submitted 
> to run my syntax check rules against it !
> 
> I googled but most examples using pre-receive I found are doing 
> sanity check on enveloppe but never on actual content of the file !
> 
> Could someone here put me on the rails ?

I`m yet another beginner with both Git hooks and Bash scripting, but 
I`ve managed to patch something up that might give you an idea, just 
drop it inside your "pre-receive" hook file:

	while read oldrev newrev
	do
		for commit in $(git rev-list --reverse $oldrev..$newrev)
		do
			for file in $(git diff-tree --no-commit-id --name-only -r $commit)
			do
				echo "$(git show $commit:$file)" >&1
			done
		done
	done
	exit 1

This should reject any push attempt, returning back *content* of each 
changed file for each new commit.

Feel free to adapt as needed, like processing/checking file content 
instead of sending it over, allowing or rejecting the push 
accordingly, and also handling corner cases (for example, "oldrev" 
value of 0000... in case of a new ref creation).

I guess there might be better ways (comments welcome), but this 
should at least get you going... and I`ve learned something new as 
well ;)

Regards,
Buga
