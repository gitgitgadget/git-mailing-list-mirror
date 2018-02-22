Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108881F404
	for <e@80x24.org>; Thu, 22 Feb 2018 17:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933605AbeBVRwZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 12:52:25 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37116 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933470AbeBVRwW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 12:52:22 -0500
Received: by mail-pg0-f53.google.com with SMTP id y26so2287557pgv.4
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y4oHIvrWdexpIOjbvmgYXiDFSnWfU53aAunDfmYSTJQ=;
        b=JbkjPjhRw5k94VuKv8EyMl5+/BnA1HcmLBqB5nP7KAFnxK7rTUNJ4hg2KtkXPNPQm3
         FKG1LodrVVKksp5NJxr0hMaXSLEpOiup32/RvQodWv6vhfjrmxJmK/5HpPEi2ccEP14a
         FAt1AV7qQX5hpqtm0xbEIbEiwAPou75arO+jb/E+xCZwBsqcK2RpXcO2Q+USTUPx36nn
         K63boQjdtGauCqztAGjDnTsnrIIp0ZE701SeA11GqH4SG+jjomYzylAbqZat9/pjI/CI
         IRTPDg0Hd0PoGPOyWVWyKd0hByZypl0U/yu5m3Bwy4U15aeLEUrH22rApAxaCRQpK/NH
         IkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y4oHIvrWdexpIOjbvmgYXiDFSnWfU53aAunDfmYSTJQ=;
        b=NzFvuel98ao2wIPatClNUUfighYz5Xp/IDAYdkWnjsSA4m3iHM922jqKtLHMAxBe7v
         BbItuR+IIY5TkWQQaTT/buVOgIiwKUsSsptYm0sKPtasLy6evUjy4MoesI9fYPVFCywp
         CM2YXL8Nct8xcOKC1gJ2j8JIOEW5k09lqGn7ajr6Rq0jX5FL4hltw2LZod7qbcN0XUYe
         Ashlodkc964IYUUE2tt4AJWYYHFeqtk3SUzadRNKSCh8uZv17TY6+bS+mwk52rBY21Fe
         CQTi3C/iVq87hdrB3uCQOXY4R2KVaWVWdl1jrWj/YWw3fK50sF7eM5n/7hk12zptSNQ3
         I4Og==
X-Gm-Message-State: APf1xPCroIigdW+4w0eMBKlh3juXR/h/v0bYoPNCPzxw04nkM4+UzCM0
        anzwMyEy+vFDa0v1HH+eatBpvQ==
X-Google-Smtp-Source: AH8x224apFJL0brO/onn8VZIoGzZXgcKusE/WZ9CbdtSjFEkJ+FNpeR7zZsfnyqhMUNkQulrehZFqQ==
X-Received: by 10.98.93.87 with SMTP id r84mr7683690pfb.131.1519321941518;
        Thu, 22 Feb 2018 09:52:21 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id c185sm972312pfb.146.2018.02.22.09.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 09:52:20 -0800 (PST)
Date:   Thu, 22 Feb 2018 09:52:19 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Dorian Taylor <dorian.taylor.lists@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: bug in HTTP protocol spec
Message-ID: <20180222175219.GA185096@google.com>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
 <20180221221516.GA7944@sigill.intra.peff.net>
 <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
 <20180222053722.GB133592@aiede.svl.corp.google.com>
 <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Dorian Taylor wrote:
> 
> > On Feb 21, 2018, at 9:37 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > 
> > Thanks for writing it.
> > 
> > Do you mind if we forge your sign-off?  (See Documentation/SubmittingPatches
> > item '(5) Certify your work' for details about what this means.)
> 
> Sure, or I can just re-paste:
> 
> Signed-off-by: Dorian Taylor <dorian.taylor.lists@gmail.com>
> 
> ---
> Documentation/technical/http-protocol.txt | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> index a0e45f2889e6e..19d73f7efb338 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -214,14 +214,17 @@ smart server reply:
>   S: Cache-Control: no-cache
>   S:
>   S: 001e# service=git-upload-pack\n
> +   S: 0000
>   S: 004895dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0multi_ack\n
>   S: 0042d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
>   S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
>   S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
> +   S: 0000
> 
> The client may send Extra Parameters (see
> Documentation/technical/pack-protocol.txt) as a colon-separated string
> -in the Git-Protocol HTTP header.
> +in the Git-Protocol HTTP header. Note as well that there is *no* newline
> +after the `0000`.
> 
> Dumb Server Response
> ^^^^^^^^^^^^^^^^^^^^
> @@ -264,8 +267,8 @@ Servers MUST set $servicename to be the request parameter value.
> Servers SHOULD include an LF at the end of this line.
> Clients MUST ignore an LF at the end of the line.
> 
> -Servers MUST terminate the response with the magic `0000` end
> -pkt-line marker.
> +Servers MUST follow the first pkt-line, as well as terminate the
> +response, with the magic `0000` end pkt-line marker.
> 
> The returned response is a pkt-line stream describing each ref and
> its known value.  The stream SHOULD be sorted by name according to
> @@ -278,6 +281,7 @@ Extra Parameter.
> 
>  smart_reply     =  PKT-LINE("# service=$servicename" LF)
> 		     *1("version 1")
> +		     "0000"
> 		     ref_list
> 		     "0000"
>  ref_list        =  empty_list / non_empty_list
> 
> ---
> 
> > 
> >> Note I am not sure what the story is behind that `version 1`
> >> element, whether it's supposed to go before or after the null packet
> >> or if there should be another null packet or what. Perhaps somebody
> >> more fluent with the smart protocol can advise.
> > 
> > I believe the 'version 1' goes after the flush-packet.
> 
> I took a traipse through the code and couldn’t determine it one way or another, but my money is on that looking something like `000aversion 1\n` on the wire.

Yes the version string goes along with the ref_list in v1 like so:

  # service=<service>
  0000
  version 1
  ref_list
  0000

This is because it is part of the payload which is actually delivered to
the git fetch/push binary where as the "# service" bit is used by the
remote helper to identify smart vs not smart servers.

> 
> --
> Dorian Taylor
> Make things. Make sense.
> https://doriantaylor.com
> 



-- 
Brandon Williams
