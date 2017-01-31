Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66B91F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 20:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdAaUUv (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 15:20:51 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36242 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdAaUUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 15:20:48 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so29525224pfo.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 12:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qln5pR4x0zb8Rty2+gDoEtT0B7PYuExBdvEGGqqjBLU=;
        b=TvIL7/76PDnmKTrz+Hoc9Hf4H2FYv4BPDTXMjPvipTktu3MhA4fkomHAsnw85jXbbf
         2CVYE7dCs+Y8LSHd2+pQeikND0uVi4zzBhf6lpoJ/wwTV347T1fzKIHbfh69NuczAFR4
         +gJS8j63rFNvGarztj3676nWL9FJB4TNJV12IGuqDlrGYsiiPjDEPPOPUq/OPFVaRWGz
         nmpvHOz8PA3xv+ctGjqDI5DTbyFU2YRHdHnVyEmkB0R33T6iaxyV0xM3KC2ommPpvsxe
         CTCasg2WYwYUKyjNjzr/HFgq75UTEX8lTB3shuOf8t6ypL823aw+l6Abn7TqkSP05Fqh
         J3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qln5pR4x0zb8Rty2+gDoEtT0B7PYuExBdvEGGqqjBLU=;
        b=E1l63rFY6SDQ5+r0w7sDbmVzZqs7pJWkOSui3saby4sHDObjMBf+CTpFqmYT+YtVzz
         e3y4T8R0MauUpFvDFkDYrethOQGXu5VZVN+s7eCqa37VPY/PiOW19REBMdzK2Oe5T1yb
         iwPLQ2uaZnbfj8GqunsyB1kep+agIm6ROw+YWzpLDYFf2HliN2djIvWLqTOQVwvdgggS
         zpa/uHbx6YWl9EFc8Ylu2tGn5yAkXZP0I6pjMA848WbdlZI1PmNB+icN7ni/yjgCKKQ/
         m41hUhsyl9lMC8M4Nqnycr2vfm0QyYHijO1z3sASS6JZzUoziMvQe1sTZrdu8LvReDZR
         2Fkg==
X-Gm-Message-State: AIkVDXKy2aMYAiba4i7Yy2LyyR9MSLTnetdBX2qtns4L6w9a+SJEXObEU/hYJeZWgzR1Sw==
X-Received: by 10.84.173.195 with SMTP id p61mr42051682plb.63.1485894023105;
        Tue, 31 Jan 2017 12:20:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id d128sm43296251pfg.56.2017.01.31.12.20.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 12:20:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>
Subject: Re: [PATCH] Documentation: implement linkgit macro for Asciidoctor
References: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net>
        <20170126001344.445534-1-sandals@crustytoothpaste.net>
        <20170126034655.fwzow2mgkjj5dpek@sigill.intra.peff.net>
        <20170126074304.GA26530@starla>
        <xmqq1svp7lcs.fsf@gitster.mtv.corp.google.com>
        <20170126191841.GA6060@dcvr.yhbt.net>
        <20170127004050.23jrq5iqwfxcwmik@genre.crustytoothpaste.net>
Date:   Tue, 31 Jan 2017 12:20:20 -0800
In-Reply-To: <20170127004050.23jrq5iqwfxcwmik@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Fri, 27 Jan 2017 00:40:50 +0000")
Message-ID: <xmqqtw8fq8vv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Thu, Jan 26, 2017 at 07:18:41PM +0000, Eric Wong wrote:
>> > Eric Wong <e@80x24.org> writes:
>> Junio C Hamano <gitster@pobox.com> wrote:
>> > +          "<citerefentry>\n"
>> > +            "<refentrytitle>#{target}</refentrytitle>"
>> > +            "<manvolnum>#{attrs[1]}</manvolnum>\n"
>> > +          "</citerefentry>\n"
>> >          end
>> 
>> You need the '\' at the end of those strings, it's not like C
>> since Ruby doesn't require semi-colons to terminate lines.
>> In other words, that should be:
>> 
>>           "<citerefentry>\n" \
>>             "<refentrytitle>#{target}</refentrytitle>" \
>>             "<manvolnum>#{attrs[1]}</manvolnum>\n" \
>>           "</citerefentry>\n"
>> 
>
> This change is fine with me.

OK, I just squashed the final one in.  Will merge to 'next' shortly.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 11f76506b6..b21e5808b1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -179,7 +179,8 @@ ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
 ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook45
-ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
+ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
 endif
 
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 09f7088eea..ec83b4959e 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -13,10 +13,10 @@ module Git
           prefix = parent.document.attr('git-relative-html-prefix')
           %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>\n)
         elsif parent.document.basebackend? 'docbook'
-          %(<citerefentry>
-<refentrytitle>#{target}</refentrytitle><manvolnum>#{attrs[1]}</manvolnum>
-</citerefentry>
-)
+          "<citerefentry>\n" \
+            "<refentrytitle>#{target}</refentrytitle>" \
+            "<manvolnum>#{attrs[1]}</manvolnum>\n" \
+          "</citerefentry>\n"
         end
       end
     end
