Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0090020970
	for <e@80x24.org>; Tue, 11 Apr 2017 21:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbdDKVrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 17:47:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35976 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbdDKVrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 17:47:51 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so1734906pgh.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLUMFo7PvOWED8UmB1JKm07GB1bjcl6TppENG1agYEc=;
        b=BSgAmRgEGMRdz9WH2//Gsy8Vje6pNfwizkeaJFrO9joBazk5CE/kFYeXzZGvwSyBV7
         CQijrPBN3sHLjD/dyUdxZzDo4yvROkO4R8YUaUmg2QcgGnR9ZSmeu+Ne8WpQWsYENwV9
         pUnGJAtScJnJGMo53RK0TzCU+IEMAuyDxWu9ztZ1aXxNaNKCbmrZc3UPkcB0e5IkqzHo
         MnUjdETVAi7aJLAe0brMDBOlBmrzBMlRwFR6cSAD0IHKrJU+8y7dui5n944YePHozmBH
         yf3js99fu2jSx3S+jlXr/BSyf++EL+A5k2q1LjdzI7oK0bvLJr6rhUFO0gbPuiYA7A3q
         eykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLUMFo7PvOWED8UmB1JKm07GB1bjcl6TppENG1agYEc=;
        b=bsDzm2WttUzihVW3zVzu9IkVsO/uy6TWcX42dLOolH5GwbxAY2j5pRKkQLpZugMnY8
         ZlDt7nDG6RUBPvSxs/dPz1uhPDVFPkBED4e8QuHu8sLqST/3XPmjn9KoO316Lst4LOlo
         BE9rSY/14XC+bpMPr8L9SQOroDzReW+lXaR0qfaXetzHg2GLowoF4JlgCU6EsIAqjUWY
         cZJBh/CMhVCwMMqvvk30Dg8qTOcme5Nz28N1J+aNY4C6be3vUDOBE0q9u1gftqG3jQx3
         OlZsFy1vawkp4VOxCSL2b7lpYxLP6lqRqmO90JvhADt2WFVKmQrmdvkXnFhB9yE9lVdQ
         HxIQ==
X-Gm-Message-State: AFeK/H1wRNp4QhMc9BfmvyKLLwYNRe5jq73MssMTU7/P4tRJZm6CZeWCxO97V/39uCXQlQ==
X-Received: by 10.99.122.22 with SMTP id v22mr66437790pgc.226.1491947270679;
        Tue, 11 Apr 2017 14:47:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c434:5e79:6b7e:ed6b])
        by smtp.gmail.com with ESMTPSA id m194sm32375622pga.62.2017.04.11.14.47.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 14:47:49 -0700 (PDT)
Date:   Tue, 11 Apr 2017 14:47:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: show clearer error message upon ERR
Message-ID: <20170411214748.GR8741@aiede.mtv.corp.google.com>
References: <20170410210511.8505-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410210511.8505-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> Currently, fetch-pack prints a confusing error message ("expected
> ACK/NAK") when the server it's communicating with sends a pkt-line
> starting with "ERR".  Replace it with a less confusing error message.

Yay!

> (Git will send "ERR" lines when a "want" line references an object that
> it does not have. This is uncommon, but can happen if a repository is
> garbage-collected during a negotiation.)
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 2 ++
>  1 file changed, 2 insertions(+)
[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -276,6 +276,8 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
>  			return ACK;
>  		}
>  	}
> +	if (skip_prefix(line, "ERR ", &arg))
> +		die(_("git fetch-pack: got remote error '%s'"), arg);

nit about the error message: since this isn't a sign of an internal
error, we don't need to tell the user that it happened in git
fetch-pack.  How about using the same error used e.g. in
run_remote_archiver and get_remote_heads?

		die(_("remote error: %s"), arg);

With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

Follow-up ideas:

* would it be straightforward to verify this error message is produced
  correctly in tests?  If not, is there some way to manually trigger it
  as a sanity-check?

* Documentation/technical/pack-protocol.txt only says that an error-line
  can be produced in response to the initial git-upload-pack command.
  Can it be updated to say where they are now allowed?

* Are there other points in the protocol where it would be useful to
  allow an error-line?  Is there some lower level place where they could
  be handled?

diff --git i/fetch-pack.c w/fetch-pack.c
index 688523bfd8..4bed270c54 100644
--- i/fetch-pack.c
+++ w/fetch-pack.c
@@ -277,7 +277,7 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 		}
 	}
 	if (skip_prefix(line, "ERR ", &arg))
-		die(_("git fetch-pack: got remote error '%s'"), arg);
+		die(_("remote error: %s"), arg);
 	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
 }
 
