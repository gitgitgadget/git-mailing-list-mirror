Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3E920189
	for <e@80x24.org>; Wed, 22 Jun 2016 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbcFVSaK (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 14:30:10 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34505 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbcFVSaI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2016 14:30:08 -0400
Received: by mail-io0-f172.google.com with SMTP id g13so44807172ioj.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 11:30:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D8Lo3vqVasSZTJPlky+ngaPt2KPJWerMZi15G2zR6IM=;
        b=jdxoubJqGacuE/PpfEwpzF0AT07vt0wLIt22eqe/gED1PVVSatDtnway6qKg3Vh7aV
         AB6cmtoWB3rkTHJCCD4HzEjIQQT8SZjp8vfYHL+WxmtJ2AT23z7QCoNdqSfyPA6q98TZ
         eCPhdwbCh4D2wbvRyHZOQVVOaXmGpLB/5bvBZ0xxGZcbtRZpZm0+9VTLUZSVIFSG50jO
         Cz3iFIuiEsdQZVYcuKeLgklmTJpo6wzfIloTGE15Z9Xhw1p25flBUJmWKvKZWy8EQwo6
         SwKJEZ8bvLczZ0vBu4fzCirafX/ZbVUC0v/RITEvAO5sfG+XJ/Z71BjsCQFltIeQVHMT
         EstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D8Lo3vqVasSZTJPlky+ngaPt2KPJWerMZi15G2zR6IM=;
        b=cxH2N5vtQy0WVrL7BS7Emkgf9Ieq0X2jeq3XuhjQHGdZ9BOiQrIzZbHYFOq63vXL82
         4ivaKCP2CTNxG4ob4/sDVPyGJwAw/PNjpm9cmN5PK3eP679kjQHsfq5Eg7HzUXjoxOuE
         cSXanLZKKYvqbEGovTaJ4lMj9fgxNDDZHTV5P/f3vpVR+tudtKWgOMaNj+g7KVuF9AM2
         veoe8n/e8MZItzNRGfX0zlWuPKVoI1Ov0WMCnlvO5pzTN4v524GsUK6nKGXe+UEdd5Qk
         x9cs3WmoLWPcmzARNjGNiA/96+3iNcZMIEgxrgaU3vjqEohiJjqhZpba39kbC6stq/3i
         bfoA==
X-Gm-Message-State: ALyK8tL3QV0AONhuIyx3l6GnD3w5RWs8RT007nMa3/uDsDWmjOc2ck1WqipnxAMMU7qKjWYEv8QC8eRAPqwIzA==
X-Received: by 10.107.22.131 with SMTP id 125mr41857953iow.128.1466620207805;
 Wed, 22 Jun 2016 11:30:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 22 Jun 2016 11:29:38 -0700 (PDT)
In-Reply-To: <CACsJy8CSVvZfwjG+zAEpG6tAWYAWVkrkz4RP32Hrr9O1A_8ZMg@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com> <xmqq4m8rz9qr.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CSVvZfwjG+zAEpG6tAWYAWVkrkz4RP32Hrr9O1A_8ZMg@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 22 Jun 2016 20:29:38 +0200
Message-ID: <CACsJy8BQxAkpoT7GVNgtM-0n1pMZeV5TRCiSn6TsYeATWeU=EA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Fix icase grep on non-ascii
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 2:26 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 18, 2016 at 6:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>
>>> v6 fixes comments from Ramsay and Eric. Interdiff below.
>>
>> Another thing I noticed with this is that the non-ascii test breaks
>> when run under dash (but passes under bash).  You need to have is_IS
>> locale on the system to see the breakage, it seems (which is why I
>> didn't see it so far).
>
> Is it a special version, maybe from debian? It works for me on gentoo.
>
>> ~/w/git/temp/t $ equery  --quiet list dash
> app-shells/dash-0.5.8.2
>> ~/w/git/temp/t $ dash ./t7812-grep-icase-non-ascii.sh
> # lib-gettext: Found 'is_IS.utf8' as an is_IS UTF-8 locale
> # lib-gettext: Found 'is_IS.iso88591' as an is_IS ISO-8859-1 locale
> ok 1 - setup
> ok 2 - grep literal string, no -F
> ok 3 - grep pcre utf-8 icase
> ok 4 - grep pcre utf-8 string with "+"
> ok 5 - grep literal string, with -F
> ok 6 - grep string with regex, with -F
> ok 7 - pickaxe -i on non-ascii
> # passed all 7 test(s)
> 1..7

Can any shell wizards explain this to me? With this code

BS=\\
echo ${BS}${BS}

Debian's dash returns a single backslash while bash returns two
backslashes. Section 2.2.1 [1] does not say anything about one
backslash (hidden behind a variable!) after escaping the following one
and still eats the one after that..

[1] http://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html
-- 
Duy
