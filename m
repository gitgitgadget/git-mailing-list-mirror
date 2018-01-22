Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E986C1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 12:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeAVMDW (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 07:03:22 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36940 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeAVMDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 07:03:21 -0500
Received: by mail-pf0-f173.google.com with SMTP id p1so6928018pfh.4
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 04:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AuX3euFYQ+Txom62L/H7i1RgHP5wq0yB2W29AccLT9Q=;
        b=RhE6iUHBLHuLXpp/N1v2LNVtk6Lwqr80O/WBIZSq+k8N60smaB38j3rguSrERPJNGu
         txZxdktIRD53dyH/S0Ehzhg8dUONg0aJKfnv7ZCmOHTkpCwVtEBQKNRUO8pn0IXq3WLb
         NDFUnd8ly8GvBp5b1bok/92y46xwkTOE68InKBmg5aulQ6N57TlPQGrj1clRZI60TZ4x
         8Yr9Rilkk1UH0ebROkE8NreBzOlPvGKBaycmmbjnlkzLltzUNyGYR/Ic2/XjAikwj8Bp
         f7kwGEH6GV5BSitf8Q0K90661KAdKSLju7J7IW8mpdSI0OKfaQUVaSbzvXHkJq+1BFQN
         7r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AuX3euFYQ+Txom62L/H7i1RgHP5wq0yB2W29AccLT9Q=;
        b=FUesFBQJ92HV7W7ucVhmUKArqeb+TWmtdpilP5fSxLTnoGUIL5bDmUSQyqGSthO4fV
         g/8o0315Gcn0q2KSl3/NiX3t2jcDtSY5UPb6cm8SvdsFuTlFq4JO2LzuIkTemuipTKJW
         cnIXIO99jOQTSNFpG3zoQyMJiO/0jIID2YavZl/P0uN/ZysXPkMUnOWwvbtvPClExlkN
         /CqvCyQU8hKKH7Sn3M/4Vh3VMn5JVZ1ib13v47trDEB80Gg1sx6hmlpidskvwWsdMDNE
         W4pkMAUb+aNFT/leZmtkwhW3mamODkK8UnlH0l5i6zzbATKOWURYowarOb6POVteOs93
         JhQA==
X-Gm-Message-State: AKwxytdiRGd5u6Zb8x1BbkYctL1xtLC8Gk1fO/jAsvTqBAymNo8o5Mgf
        HbbZFT6n6oBSF52bm9+oELc=
X-Google-Smtp-Source: AH8x227gPis90+zx+kA64+LWac2qmOOAmy/zGlo36ZOTcFofTaL6rQM0TDTZWybyOlG59+COgxWf0A==
X-Received: by 10.98.147.154 with SMTP id r26mr8195783pfk.207.1516622600790;
        Mon, 22 Jan 2018 04:03:20 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id n76sm622002pfh.95.2018.01.22.04.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 04:03:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:03:15 +0700
Date:   Mon, 22 Jan 2018 19:03:15 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 10/14] notes: convert write_notes_tree to object_id
Message-ID: <20180122120315.GC5980@ash>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <e0d8c7e8d42762f912f1ec3eb40810d18d6533d4.1516617960.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d8c7e8d42762f912f1ec3eb40810d18d6533d4.1516617960.git.patryk.obara@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 12:04:33PM +0100, Patryk Obara wrote:
> @@ -1141,12 +1142,13 @@ int write_notes_tree(struct notes_tree *t, unsigned char *result)
>  	cb_data.next_non_note = t->first_non_note;
>  
>  	/* Write tree objects representing current notes tree */
> -	ret = for_each_note(t, FOR_EACH_NOTE_DONT_UNPACK_SUBTREES |
> -				FOR_EACH_NOTE_YIELD_SUBTREES,
> -			write_each_note, &cb_data) ||
> -		write_each_non_note_until(NULL, &cb_data) ||
> -		tree_write_stack_finish_subtree(&root) ||
> -		write_sha1_file(root.buf.buf, root.buf.len, tree_type, result);
> +	flags = FOR_EACH_NOTE_DONT_UNPACK_SUBTREES |
> +		FOR_EACH_NOTE_YIELD_SUBTREES;
> +	ret = for_each_note(t, flags, write_each_note, &cb_data) ||
> +	      write_each_non_note_until(NULL, &cb_data) ||
> +	      tree_write_stack_finish_subtree(&root) ||
> +	      write_sha1_file(root.buf.buf, root.buf.len, tree_type,
> +			      result->hash);

Hmm.. new indentation style. I'm not complaining though. I think it
looks good.

--
Duy
