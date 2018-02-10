Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7641F576
	for <e@80x24.org>; Sat, 10 Feb 2018 10:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbeBJKg5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 05:36:57 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35573 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJKg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 05:36:56 -0500
Received: by mail-ot0-f179.google.com with SMTP id a2so10084230otf.2
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 02:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nNNabxv97jbEOCJR/tr5WY9E0QHyU2PyI1mzZwTuyjU=;
        b=hqVWcaZ7RG3e252CJy5oK8s2HhWI7RPBpU6M1+HWcXIHA8oR7iJHgapHb/MRzWJb5S
         8Zn4zq0UvTrGDsKjnZbBJtGS8xhQhynN+6RGYK8NEQtlY5SuCsQWyErjWbDUaQNqRljL
         4wvpjwnjBsMNJKUtBXfH+o8qzjRIw6XJZ4O6gYtjmWitzD7NlDnfliQBW9XDZxNaM2e0
         BqmdqcQmbMQFDtbmVaUwPS5ZK6cw9QlTJAC8VyD7bFtYFcJ9LTQ/M9eVN74u34UwUEuX
         ueBlVUy5dMgBLJaFIZDD0W8oO0C2KQRSVKVE1OBFMM+o6tLW0kQidb0iojvqvvXGeAa+
         2ANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nNNabxv97jbEOCJR/tr5WY9E0QHyU2PyI1mzZwTuyjU=;
        b=Ynh0kCQPXO+k0taWwMdqX3k7s6JGow6RYZZx83hgb5laNTXT7IhAKgtSJtnr38ikN3
         BGm85kxSm4KiWRKTyTrgwZiQq4BbcBW0LrR7FSN/eH7y3kc+I07PaxrBj4PloTOw0M8f
         YLwscYenZwMEC7EP20EUkQMfpJyKFlvNdtIEDBem88/t4pIxWUcYHBr76z9MFzDOQ8Ac
         fjJPQq+IPWqAEHtBt8/51fIDmenE3ZIn2U6zLdqzdOs2Ud0E+M5pxuvQACpTQ5kfp0c6
         rHOFESST6DsH2bhEK53gYJoWw0/wyPvpkApp59Vfem7lKnNcwdHTBK/9j7aHuMIuHdPs
         MVtw==
X-Gm-Message-State: APf1xPBMVJFlZVomnEfYtNmZwqEM+oQ/IzCPXu1Cbhx7EWF/uQqmP5P4
        NEVIyqoJavENix/lgRa+By3MrHzn8JqtCrAUwyE=
X-Google-Smtp-Source: AH8x225DiNj4Y9K9Kqdwj16b9Ewh6Y/0lLPc4Jp07y9bmWDTka7J0jwWVwysOqN2zn6Mk4Sv20CkBPdWDy8jPBpgtWo=
X-Received: by 10.157.53.5 with SMTP id o5mr4264594otc.181.1518259015812; Sat,
 10 Feb 2018 02:36:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sat, 10 Feb 2018 02:36:25 -0800 (PST)
In-Reply-To: <CAGZ79kabQ1WvxxjFV+fgq8b142yNrtGZC_Vqac+5b3CkUpbi2w@mail.gmail.com>
References: <20180205235508.216277-1-sbeller@google.com> <CACsJy8CGgekpX4cZkyyTSPrj87uQVKZSOL7fyT__P2dh_1LmVQ@mail.gmail.com>
 <CAGZ79kabQ1WvxxjFV+fgq8b142yNrtGZC_Vqac+5b3CkUpbi2w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Feb 2018 17:36:25 +0700
Message-ID: <CACsJy8DvkjqL0i7mGbFQmAm0Ncvr4SeRMeZTzUzGdMB0Y86aeA@mail.gmail.com>
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository object
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 1:06 AM, Stefan Beller <sbeller@google.com> wrote:
>> Something else.. maybe "struct repository *" should not be a universal
>> function argument to avoid global states. Like sha1_file.c is mostly about the
>> object store, and I see that you added object store struct (nice!).
>> These sha1 related function should take the object_store* (which
>> probably is a combination of both packed and loose stores since they
>> depend on each other), not repository*. This way if a function needs
>> both access to object store and ref store, we can see the two
>> dependencies from function arguments.
>
> I tried that in the beginning and it blew up a couple of times when I realized
> that I forgot to pass through one of these dependencies.
> Maybe we can go to the repository and shrink the scope in a follow up?

I think it's a good thing to do. We need to make these implicit
dependencies explicit sooner or later.

Also, perhaps at the earlier steps you don't need to add everything to
the_respository yet. You can have the_object_store, the_parsed_object
(and we already have get_main_ref_store()), then use them internally
without touching the API, which helps reduce code change. For example,
read_sha1_file() could be converted to take "struct object_store *"
all the way

void *read_sha1_file_extended(const unsigned char *sha1,
      enum object_type *type,
      unsigned long *size,
      int lookup_replace)
{
        struct object_store *store = &the_object_store;
        ...
        // more access to "store"
}

When every piece is in place, the API change can be made be removing
that "store = &the_object_store" line and make "store" an argument of
read_sha1_file().
-- 
Duy
