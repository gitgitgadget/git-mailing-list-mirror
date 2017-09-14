Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED0820281
	for <e@80x24.org>; Thu, 14 Sep 2017 09:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdINJRP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 05:17:15 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:44840 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdINJRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 05:17:14 -0400
Received: by mail-io0-f177.google.com with SMTP id v36so16334066ioi.1
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h4EXK+n0DtjrCVMY4rw4ONHEED/YgAAWVtYUN7LoLac=;
        b=h2rLfXORnNxGWeBkKMRLX7RRJE/3k7I9JrlcH9PG4nOb6ZrZaNIr/QiOLs3bKcM1Ne
         L4igwItNF1N5YdxuUAx4s8cqOktT0ZjnwFBhFqe6IsRKToFHtuwlOQVR7DFVLcAwx+KP
         OPalOolydWx/joNq8MEaDK7mwoTWiBbZB9mdZV22j0yt/RX53Cd+3+FEtcSvB0GDYzRy
         Mf+N7CcF5znVqz4YiUkWTW51vHaYgRtXf4sFyAM4vHL6wZLHa9Lro7uRT1LE1UJNu84Q
         gFo4xgIgOs8Cdp8NjcSlu278/2xOorbaDM8mpDiPBqS5qEX3iPoQdMd55tbMRw+B0xh2
         j05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h4EXK+n0DtjrCVMY4rw4ONHEED/YgAAWVtYUN7LoLac=;
        b=cHqDEBaAyUYIW/F8aZaRRfZmF7QFq+IJaVOcWgRmJxI8dRPbO9ovlMpNFGRRPxUsTv
         MwfumOhn14lGWVhPJCQ0e1bCaEnl2P3kBbU8K8Qx8r+YXdTeyl5xm23HAfVXbcAEdmw1
         8vr0DuuJsWlGbc48Jpwjb6W485se2htwDAnt+fGYmsFDA4xgaml3KvBAic5s2F2UQNXU
         gOvZvgzv9jvi+fbRMk89FYxI+8pJUnBkq1x1IOdRJSeEoEe01G+8nK9RFHdZay+xWrHV
         DJvHSL9zZ7c7yL2GbdhHQBHRnfCuO8vqvE6L6QGTWSnVY45oQsEBnOrmtqT3CfBgRWli
         HXOw==
X-Gm-Message-State: AHPjjUjE5ZhsO1f7IjGUUuQ8LzUrc/f+Hzeev4wgz/ncUOXlo8XkN3+d
        MWdP/PIWoi/1K1X78BtJZUrvmGB2ard9AJBak4Y=
X-Google-Smtp-Source: AOwi7QAGXZkTJeSgDVDBtSXVjMguphFTkZq8xsLtMIUs9dTP9wS2AePrQwX7eUrtvF0CFWH7sI8r7JKN0kH8Kj8WC2M=
X-Received: by 10.107.20.14 with SMTP id 14mr1586517iou.69.1505380633374; Thu,
 14 Sep 2017 02:17:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Thu, 14 Sep 2017 02:17:12 -0700 (PDT)
In-Reply-To: <xmqqbmnwxwfw.fsf@gitster.mtv.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-14-chriscool@tuxfamily.org> <xmqqbmnwxwfw.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2017 11:17:12 +0200
Message-ID: <CAP8UFD2+-0DYRO+PN+Ertn3TvoXEpghWfv=-He9+0kVSA=TNxA@mail.gmail.com>
Subject: Re: [PATCH v5 13/40] external odb: add 'put_raw_obj' support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 9:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Add support for a 'put_raw_obj' capability/instruction to send new
>> objects to an external odb. Objects will be sent as they are (in
>> their 'raw' format). They will not be converted to Git objects.
>>
>> For now any new Git object (blob, tree, commit, ...) would be sent
>> if 'put_raw_obj' is supported by an odb helper. This is not a great
>> default, but let's leave it to following commits to tweak that.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>
> I thought in an earlier step that I saw this thing initialized in
> the codepath that adds alternate object stores, which are read-only
> places we "borrow" from.  Being able to write into it is good, but
> conceptually it no longer feels correct to initialize it from the
> alternate object database initialization codepath.
>
> Another way to say it is that an object store, whether it is local
> or external, is not "alt" if it will result in storing new objects
> we locally create.  It's just an extension of our local object
> store.

I guess you are talking about the following code in "[PATCH v5 10/40]
Add initial external odb support":

+void prepare_external_alt_odb(void)
+{
+       static int linked_external;
+       const char *path;
+
+       if (linked_external)
+               return;
+
+       path = external_odb_root();
+       if (!access(path, F_OK)) {
+               link_alt_odb_entry(path, NULL, 0, "");
+               linked_external = 1;
+       }
+}
+
 void prepare_alt_odb(void)
 {
        const char *alt;
@@ -650,6 +666,7 @@ void prepare_alt_odb(void)
        link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);

        read_info_alternates(get_object_directory(), 0);
+       prepare_external_alt_odb();
 }

Would it be ok if I do the following:

- rename prepare_external_alt_odb() to just prepare_external_odb(), as
this would avoid confusion between alt_odbs and external odbs
- remove the call to prepare_external_odb() in prepare_alt_odb()
- add a prepare_alt_and_external_odb() that just calls
prepare_alt_odb() and then prepare_external_odb()
- replace all the calls to prepare_alt_odb() with calls to
prepare_alt_and_external_odb()

?
