Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEFF1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 17:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfHURkW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 13:40:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39868 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfHURkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 13:40:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so1715153pgi.6
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JWq6pfnhMI0AVQNIDeNB5C+4KgKGHcAEokVc00jhyn8=;
        b=a6m9Be81OPQFq//5HYqWKzFb41XVN44Kj8wgI8vwHR20CGSmmd4PMNSLyWpnrxeRNH
         awlsZ8atd3jVQvEL27O7zTsm/fBH/GnPnjxBtl8Dxi0SNVO6jvNwjWRWcDXf2dCL2Xqh
         nGT/sDWGOFlTdTmZnEjZyuVK2bm6h+MNg6o6HCh27CetMlTWV9JQD/byJggTlRGBECrf
         s2dsDOza2UGbxE6KYIYBFWQbmhUCI+OCWzACKL2eeOWxwQXaC3Mpo6hxv8mbCuYiAnuG
         CygXzWkxrujoVikD/5c38Tn5oULgIXaHG1uGHP/apwCDuZT/xGU5467f46dRimE3Cipg
         YQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JWq6pfnhMI0AVQNIDeNB5C+4KgKGHcAEokVc00jhyn8=;
        b=GW9P5MQIXmvMZN55woVU25EKVQ9wksfahtn12ZABSr3ETRdmIVNk/PGZo8y7NpvT8z
         C3tDBAUjnS0uhu335mwIBUQTjGgUe9Zj0Q0VjMCk7sBn2EA+OvjtI84+zIFkIfAKV7WG
         pb3HU0BOmAwnAz4wxUnMXtOFE61vV/xcMxbqYerPl6szabMT7ZVweQsRzuLAMbNMabDN
         +VIcWZVFTNEz17+BEdzHZ+NTVT42H1X3BfFYsss5zO28kzs+sl52ZvQsVqRnHpX/6iza
         pfyzoEweq7qspePLKHgV3s54W/LsJLVxIWUDPz65AG5TRSYOyESWzr2k8Dld2Eiu8YA4
         8vzw==
X-Gm-Message-State: APjAAAWl0WvHJb7NWyLF/0UEkzAcM1sWTF+icV3+xqaddgBPhkHyuH6/
        egl0TDEH5tvM/hyDWpHj5Viq4Q==
X-Google-Smtp-Source: APXvYqxw4qoLGxOgngZlqJkmKhtG2kdTdrgsPzbkvFl97uP/4XgrAvdOSWI5RUISIlf8cQgvs8HQVA==
X-Received: by 2002:a17:90a:21eb:: with SMTP id q98mr1106217pjc.23.1566409220787;
        Wed, 21 Aug 2019 10:40:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 11sm33687746pgo.43.2019.08.21.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 10:40:20 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:40:13 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] bugreport: generate config whitelist based on docs
Message-ID: <20190821174013.GA35435@google.com>
References: <20190817003926.102944-3-emilyshaffer@google.com>
 <20190817203846.31609-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190817203846.31609-1-martin.agren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 17, 2019 at 10:38:46PM +0200, Martin Ågren wrote:
> On Sat, 17 Aug 2019 at 02:42, Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > Add a new step to the build to generate a whitelist of git-config
> > variables which are appropriate to include in the output of
> > git-bugreport. New variables can be added to the whitelist by annotating
> > their documentation in Documentation/config with the line
> > "// bugreport-include".
> 
> These "// bugreport-include" show up in the rendered manpages, both with
> AsciiDoc and Asciidoctor. :-(

Hmm, I don't see it in the troff or the HTML with asciidoc using `make`
- but I do see with asciidoctor, or `asciidoc -d html5`. Nice catch,
thanks.

> 
> > --- a/Documentation/config/sendemail.txt
> > +++ b/Documentation/config/sendemail.txt
> > @@ -1,63 +1,63 @@
> > -sendemail.identity::
> > +sendemail.identity:: // bugreport-exclude
> >         A configuration identity. When given, causes values in the
> 
> If I put each comment on a line of its own (after the config option, but
> I suppose before would work the same way), Asciidoctor truly ignores
> them and everything's fine. And AsciiDoc renders this one and others
> like it ok.
> 
> > -sendemail.aliasesFile::
> > -sendemail.aliasFileType::
> > -sendemail.annotate::
> > +sendemail.aliasesFile:: // bugreport-exclude
> > +sendemail.aliasFileType:: // bugreport-exclude
> > +sendemail.annotate:: // bugreport-include
> 
> However, AsciiDoc (version 8.6.10) seems to effectively replace those
> comments with an empty line during processing, and it makes quite the
> difference here. Instead of these appearing in a compact comma-separated
> list, they are treated as individual items in the description list with
> no supporting content.
> 
> FWIW, I like the idea of annotating things here to make it harder to
> forget this whitelisting when adding a new config item.
> 
> Below is what I came up with as an alternative approach. Feel free to
> steal, squash and/or ignore as you see fit.

This is cool - I'll add this to the commit chain and build on top of it.
Thanks!

> 
> BTW, I'm not sure the grep invocation is portable (-R ? -h ? -P ? -o ?).

Yeah, I'll see what I can do about that (recursive, no filename,
Perl-compatible regex, match only) - I can probably replace this with
something like `find | xargs pgrep` - I'll keep digging. Thanks.

> We should probably also do the usual "create a candidate output file,
> then move it into place" dance for robustness.
> 
> I do think we should test the generated whitelist in some minimal way,
> e.g., to check that it does contain something which objectively belongs
> in the whitelist and -- more importantly IMHO -- does *not* contain
> something that shouldn't be there, such as sendemail.smtpPass.

Good point, I'll add a test for this.

Thanks very much for this!
 - Emily
