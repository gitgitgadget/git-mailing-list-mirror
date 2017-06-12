Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796C21F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 17:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbdFLRij (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 13:38:39 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34152 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbdFLRii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 13:38:38 -0400
Received: by mail-pg0-f43.google.com with SMTP id v18so47864583pgb.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EJkif2wrGLWXVuGFQWgtNG/VrmY7hyh0lI7h8ZBY9f0=;
        b=Zw7F9iVaSbs5LZkiUdI+AVGwthfrSx0PaI+KCTCI0P7RjKgxNN60o1V2n4DBWUMtof
         4x8iLXIa+v+qMWmoxeqgqZ/Vcr3FrJ2dLp4sIP65jKl/Bzq6exRqvYuruWhaC+KCpecz
         T1t2BOz69f5nsUSxl2w7DhdZkSmwHogF2KcEx+F7xLARwQv8vvdtr3rwhsJLtFQqGbbO
         lN3VZHzi922pYp+ipK+o1yJxSviDIQmLBOItvYGPkSDnONC+ZbZN6EtoJEIlDshIJVxI
         HpVfBwUbcBgmJnEHW3kFXzFesPuzENctIDohL8fqLUc4M26ANY9oueXUUoRpwdt7JdCq
         3rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EJkif2wrGLWXVuGFQWgtNG/VrmY7hyh0lI7h8ZBY9f0=;
        b=GVHIapQVgaOXHpCHH2GyZXOV8QYxjXeIrZvIYCuh7Xmtnn/pN7pAX2tGFWbqCKe/T0
         WCmcNQoFVlAEWqoCsuO+Z7BeZU8tq1/dJUVjrBPtKHFL3D5sfyy1/Xkow/mkSSSAhMJh
         TftoYz8sIdRwtMKboDS1Tq9jp67heHdHIwX+Tk7va/bzG2PFRLx0sMLJVB2FN5YUltLF
         g3eZRReLC/h2nBBW77Hnr+5VNZbCLbq4LbjnZisl6e1WPYo6/ezqW63WgfV7MQhh/xAq
         bQyqa+ygeO1zN5CNX6n3uZbJ2sm0JjHjk63XSaELrx4V6chq548L50qr/m542FGfYZbk
         5HPg==
X-Gm-Message-State: AODbwcBtHdzOXUo1/eIny16Tuzuy1gh8Z6BbihKYLcMREd7sJOnxyoNK
        ofZTl818v/XFig==
X-Received: by 10.98.33.205 with SMTP id o74mr39776007pfj.11.1497289117759;
        Mon, 12 Jun 2017 10:38:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id p23sm21364921pfi.52.2017.06.12.10.38.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 10:38:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Small issue with "add untracked" option of 'git add -i'
References: <1497278015.7302.13.camel@gmail.com>
Date:   Mon, 12 Jun 2017 10:38:36 -0700
In-Reply-To: <1497278015.7302.13.camel@gmail.com> (Kaartic Sivaraam's message
        of "Mon, 12 Jun 2017 20:03:35 +0530")
Message-ID: <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> * He chooses to use 'git add -i' to stage changes
> * He chooses option 4, accidentally, instead of option 5. He is shown
> the following menu,
>
>> *** Commands ***
>>   1: status	  2: update	  3: revert	  4: add
>> untracked
>>   5: patch	  6: diff	  7: quit	  8: help
>> What now> 4
>>   1: test-file
>> Add untracked>> 
>
> * He exits by hitting return but he is shown this weird message found
> below.
>
>> No untracked files.
>
> * He is surprised on seeing this.
>
> Why is that message shown when "there are untracked files" but the user
> doesn't add them to the staging area?

It comes from this snippet in git-add--interactive.perl:

        sub add_untracked_cmd {
                my @add = list_and_choose({ PROMPT => __('Add untracked') },
                                          list_untracked());
                if (@add) {
                        system(qw(git update-index --add --), @add);
                        say_n_paths('added', @add);
                } else {
                        print __("No untracked files.\n");
                }
                print "\n";
        }


After prompting to get the list of desired files, if the user chose
nothing, the message is shown.  "No untracked files chosen." is
probably what the code wants to say, I would think.

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 709a5f6ce6..98c9f20578 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -711,7 +711,7 @@ sub add_untracked_cmd {
 		system(qw(git update-index --add --), @add);
 		say_n_paths('added', @add);
 	} else {
-		print __("No untracked files.\n");
+		print __("No untracked file chosen.\n");
 	}
 	print "\n";
 }
