Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0445620954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdKVRdn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:33:43 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37354 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdKVRdn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:33:43 -0500
Received: by mail-qt0-f194.google.com with SMTP id d15so24758032qte.4
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CO3S+kvsrIBQLlyzWtjBNu21jLrTrS5tT/i1tL4lOPM=;
        b=Xo5IMaWyl0LUdDhUDmoKbhe7Xab7KV3wo/RMbXqSRdJSjTof1hVnkj0LsQUppYLcLD
         YnTVaUgJi4LSHQ53sxpiAv24cAp/btpGxBq37pNBSCjTOTHYHFpD00UHY+9wP4gPMAiM
         j6Av+eE2vcLsrxW+y1d0iIc0a/SEzrNaj1cavP//WV5MH9+MKEj0qNRfhLZ1XtstjXdt
         7YpOBBTQSMC3ZQGbsYskfyIE4wghi6DXuueiiDGwDQhGz77yMN4V6nmDlq+ZeRlkpxwW
         U89TBqHC3uv0s/hk4B3e/GESylFK8PJ0bEM6YJGEOSMYezL9hoMrCl/8xhkTP1n3CZUR
         a1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CO3S+kvsrIBQLlyzWtjBNu21jLrTrS5tT/i1tL4lOPM=;
        b=s9wfB05Sql2w/fv2I4KMuFXxopAZV8b4dzXwK3kt4WumEWrtszDP2CvKIKT1p1GC7p
         atf3PeYEA7gIdj9eyuisJ8lTWDIkeR3RakRXJBHNUODCzVOMJ22DX6XCgyXIcqqkGI/u
         FKFs0bUta5dtgPQYktQ0EhLmIj+NlJEbCDQQQp7kv4YtHFfmgHvd+gDHRfBm1/favAZY
         d1K9aMK3cl/lSKQ0uTkmaWS+5QK86YI2xeZyHmTbxAu8hmY+cTF2sfzFd5fssKhzFetm
         i9oY1junBBH1Je3Gt3SvyFi46HmY5Jq/MgIt+ZEgzo6cpO9SJZXerJ3bfIhglV3DN7CB
         4caA==
X-Gm-Message-State: AJaThX5CuzdG3vI2KOcGHZRvJSyYLzEjYJKpsa6bp0axLWqFYYKAh2Wf
        GoeW0NFTdf2JIR7wb3/p4WY9phUYZk2lcTTk7X8=
X-Google-Smtp-Source: AGs4zMbx4eOhQjlx9IbaDgl7HQKaplyUq88PN4bxqxsknSD9zP4/Me5YKEq9kELeP29x8vJFoLZm71gm1J8jWt2LC6s=
X-Received: by 10.200.35.28 with SMTP id a28mr15497527qta.51.1511372022428;
 Wed, 22 Nov 2017 09:33:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Wed, 22 Nov 2017 09:33:42 -0800 (PST)
In-Reply-To: <919EA31C-FDC5-4694-9614-157042D2DA82@gmail.com>
References: <20171117135109.18071-1-lars.schneider@autodesk.com>
 <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com> <919EA31C-FDC5-4694-9614-157042D2DA82@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 22 Nov 2017 12:33:42 -0500
X-Google-Sender-Auth: p7k7EHwJDBhsNSpYJMONmL5_Yuk
Message-ID: <CAPig+cQ=E4Ohybf_zPKEPMQg5iW+eqG4Y4Jcd4pNz9pk9i4+sA@mail.gmail.com>
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 11:53 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> On 17 Nov 2017, at 20:41, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> * emacsclient already prints its own message ("Waiting for Emacs...",
>> which runs together with Git's message). Perhaps treat emacsclient as
>> a special case and skip printing this message if emacsclient is in
>> use: if (strstr(...,"emacsclient"))
>
> If Junio et al. are ok with the special handling of emacs, then I am happy
> to add this change in v3. If we look for "emacsclient", then would this
> cover emacs on Linux and Windows, too? (I am no emacs user)

Yes, searching for "emacsclient" should work on all platforms (Linux,
MacOS, Windows, BSD). Most of the time, the full value of EDITOR is
just "emacsclient", but sometimes emacsclient is located at an
out-of-the-way location, not in PATH, such as in my example
(/long/path/to/emacsclient). On Windows, it's actually called
"emacsclientw", but that should be matched just fine when searching
for "emacsclient".
