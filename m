Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AE41F404
	for <e@80x24.org>; Fri,  2 Feb 2018 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeBBTQH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 14:16:07 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34991 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeBBTQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 14:16:06 -0500
Received: by mail-qk0-f173.google.com with SMTP id 69so12115099qkz.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PsFaaEm2G2QyhkbdbT8Kb/mVRpyFLtlg3cdEdgOpnP0=;
        b=RINZjbYS0RntaJdg46WE9SDFs0hAt/iVSpdaq6bGDRyr3UutYlgIVABPX6kybBTtAK
         +lgubW+V3Yiq5CeEEYslj0iOxfbB0UNtPQaRgAQJ3ay6us/4ztu7aSlQBj1Rnna3gtaG
         sztDQasnNmUnPph6m3pLwBeQIcI/8Tmg9zW/qFmS3BYR27bYf9RO/fVSliSnhvbVTvfr
         yQAzqEfKH6qvOjoOzLMWgDbbkMfg8cDwB8I7KTql2UItzlfbtE7Y9OiSbEHHes2mgpaU
         eMFJ6dpdUuihILT4qVU6G912maY979qLqo+B9uW7xX9BUDPQIZ9vgGaIfYyPPSlfgapw
         lP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PsFaaEm2G2QyhkbdbT8Kb/mVRpyFLtlg3cdEdgOpnP0=;
        b=lcJvESL88WwHCFyD01arTOg+yZRe3rNwPnBMPAS6zDM0436ozv0ufWctEPiC4tp8ZT
         152cnTNeSIqqnj3zF8d00eZGRMMZuH+M96NAmIELlnuo7DDHb3pjneXQbJSwfJvLkKlH
         FEMnfMo0OMsmkM6bgbUn49muND68GEmG20zh4iIP7+E5ikx1ieGMm0wzN/0xAKGo3F7Q
         Srkf7HA8wG5cscwypCAdOajSAlo4AiYNrPDy/oPy6ryaBKoqgoyoQTGm/UKVywSlIY2L
         TMBSJ257unvZmqCMOc/q7mMVH1ocHzHa3voZhvf1vNGw1jZscABZGSaEHTkjX6Xmw7iY
         J0Mg==
X-Gm-Message-State: AKwxyte9+YFMfQRI9K9MnY8q6U1s+6xFT57qMhJ6qqAJiCrIriZpdroT
        WvpUVZI3wCNl0ook2kM8Kv5hf0lf1qGUvVGhPGQ=
X-Google-Smtp-Source: AH8x224L9e5Aq1mRl1YV9WaHhzD6f9jDrINqW2zHdV4fVhekE68do6qLqJuVa69dzg8XTdpyGXPM6h84RjBt9l1WENo=
X-Received: by 10.55.123.69 with SMTP id w66mr61186350qkc.326.1517598965189;
 Fri, 02 Feb 2018 11:16:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 11:16:04 -0800 (PST)
In-Reply-To: <52737deb-a5dc-27d6-3c0c-0d8b8de991c5@suse.com>
References: <e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com>
 <CAPig+cT8vKyhq6DvFMz-0CPRO-Y7R4EE_JhN6yuiSUNXW8-Yww@mail.gmail.com>
 <fa3f512a-bd77-80c7-4fec-071639f62d26@suse.com> <CAPig+cTDHsBSPZ+o+jh9bDvJ7NcZ3DGe+penppPwyupCJzmhAA@mail.gmail.com>
 <52737deb-a5dc-27d6-3c0c-0d8b8de991c5@suse.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 14:16:04 -0500
X-Google-Sender-Auth: FnQD_lzbE01DvRVv3ZOuyjfNGfo
Message-ID: <CAPig+cQF2HzmtVdHqtQcOf0B-yA8Kpj-CZbPmdQotGwtdYpxvw@mail.gmail.com>
Subject: Re: [PATCHv2] tag: add --edit option
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 11:48 AM, Nicolas Morey-Chaisemartin
<nmoreychaisemartin@suse.com> wrote:
> What message do you suggest ?  As I said in a previous mail, a
> simple "Editor failure, cancelling {commit, tag}" should be enough
> as launch_editor already outputs error messages describing what
> issue the editor had.
>
> I don't think suggesting moving to --no-edit || -m || -F is that
> helpful.  It's basically saying your setup is broken, but you can
> workaround by setting those options (and not saying that you're
> going to have some more issues later one).

If it's the case the launch_editor() indeed outputs an appropriate
error message, then the existing error message from tag.c is already
appropriate when --edit is not specified. It's only the --edit case
that the tag.c's additional message is somewhat weird. And, in fact,
suppressing tag.c's message might be the correct thing to do in the
--edit case:

    static void create_tag(...) {
        ...
if (launch_editor(...)) {
   if (!opt->use_editor)
       fprintf(stderr, _("... use either -m or -F ..."));
            exit(1);
}

I don't feel strongly about it either way and am fine with just
punting on the issue until someone actually complains about it.
