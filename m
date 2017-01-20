Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BDD20756
	for <e@80x24.org>; Fri, 20 Jan 2017 15:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbdATPd7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 10:33:59 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34318 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752683AbdATPd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 10:33:58 -0500
Received: by mail-yw0-f182.google.com with SMTP id w75so91099057ywg.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=pYEgqnO9GDL86F5bCcpPP1raKEWGyHPVawJvDyAg69Q=;
        b=Rl5UcvU+RUClG4AR7KbRr4UzQxuss0q9/wNfZofrGhZHWuMu2YbTKdArGD+1K85hZM
         DKU+8ip6MZWeo+0Frev9oUh613EaDB0Vnzet4eYZYxShHHdVQGEaV1iNzHCK1YxdTbSJ
         RFDkxruW38TjjOCuhCiqc9d7zoDKvR3AQ1KWOV0SGE8LHBGB4h1mnjT4wOtn/KVQYZEW
         TzEiwS8hzEH1PevNfqXo95dP1eZiNlnOfsnVbS0awkRqvzaiw+RcRswvVexUao4ja3t+
         oGESYAKlFtsuNEPdMZyfwPcNZS2hEPy5LndgaPjj6GYkHQGLPORY5zGvKQI6VOUOhu9l
         5P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=pYEgqnO9GDL86F5bCcpPP1raKEWGyHPVawJvDyAg69Q=;
        b=amKXFAIgvCJL5YlAaalUNW4MJW9WAY2ePMuRFA93C82dBxOrf+VVPTPZRkdpLo+AwO
         fn3JQYuct81bL0XWE5yqP70xA44cJZ474xJhlUsibBrn/HLEh9deJGbWggilSGINkr6+
         UQZU9maAdWlfciFT+1YeP8wOSBbgvxL25tzDVtNzraprkY7CmElwxIhChwBMmq3KLtzB
         dYExrc/2+RvrPuyjLyQcucNnWCIB4aw78jov+17x8xzTQrkfR8bN4J3+HKdgzXriXcS1
         zCVSOyJ874ecODDGW/XeZ/PdCkP4i2wQ/vIajgsgsL98tTID69FpBaw1z7/pCfNP6bql
         enKA==
X-Gm-Message-State: AIkVDXIAcP/4PoeCJcIHn+Jio4K8z+gO3VwpZqlCxRZcl0niproylrlojgnFaeeiMN9w9c7xOSB0oSbzqURjZg==
X-Received: by 10.55.214.152 with SMTP id p24mr12674497qkl.223.1484925900009;
 Fri, 20 Jan 2017 07:25:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.66 with HTTP; Fri, 20 Jan 2017 07:24:39 -0800 (PST)
In-Reply-To: <CAKcFC3ZYwrVfEZ2Xua1kpQVeOMKY-wM=oce9JQhz4Tnookf8Dg@mail.gmail.com>
References: <CAKcFC3aqjLNUNKPDZ08rO_SBkY84uvHBerCxnSchAe8rH0dnMg@mail.gmail.com>
 <CAKcFC3ZN+=o_2t4AawCE0c4Tw+t_XJKTHtEq9d7bv-ht5euPbw@mail.gmail.com>
 <CAKcFC3aHZP5-MJaNj4vv_qBwY3xNRodYnfw0P-G-Q+XfaRf=Cw@mail.gmail.com> <CAKcFC3ZYwrVfEZ2Xua1kpQVeOMKY-wM=oce9JQhz4Tnookf8Dg@mail.gmail.com>
From:   jean-christophe manciot <actionmystique@gmail.com>
Date:   Fri, 20 Jan 2017 16:24:39 +0100
Message-ID: <CAKcFC3YZMA7AP+9d5nuUfeAjyu67cRT=djVh5Znh=Gj-Gr6UWg@mail.gmail.com>
Subject: Re: fatal: bad revision 'git rm -r --ignore-unmatch -- folder'
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've finally found the correct command after some significant research:
git filter-branch --tag-name-filter cat --index-filter "git rm -r
--cached --ignore-unmatch ${file_path}/${file_name}" --prune-empty
--force -- --all

On Fri, Jan 20, 2017 at 4:23 PM, jean-christophe manciot
<actionmystique@gmail.com> wrote:
> I've finally found the correct command after some significant research:
> git filter-branch --tag-name-filter cat --index-filter "git rm -r --cached
> --ignore-unmatch ${file_path}/${file_name}" --prune-empty --force -- --all
>
> On Thu, Jan 19, 2017 at 9:42 AM, jean-christophe manciot
> <actionmystique@gmail.com> wrote:
>>
>> Also some context information:
>> Ubuntu 16.10 4.8
>> git 2.11.0
>>
>> On Thu, Jan 19, 2017 at 9:32 AM, jean-christophe manciot
>> <actionmystique@gmail.com> wrote:
>> > In case you were wondering whether these files were tracked or not:
>> >
>> > git-Games# git ls-files Ubuntu/16.04
>> > Ubuntu/16.04/residualvm_0.3.0~git-1_amd64.deb
>> > Ubuntu/16.04/scummvm-data_1.8.0_all.deb
>> > Ubuntu/16.04/scummvm-data_1.9.0_all.deb
>> > Ubuntu/16.04/scummvm-dbgsym_1.8.2~git20160821.bad86050_amd64.deb
>> > Ubuntu/16.04/scummvm-dbgsym_1.9.0_amd64.deb
>> > Ubuntu/16.04/scummvm_1.8.0_amd64.deb
>> > Ubuntu/16.04/scummvm_1.9.0_amd64.deb
>> >
>> > On Tue, Jan 17, 2017 at 4:30 PM, jean-christophe manciot
>> > <actionmystique@gmail.com> wrote:
>> >> Hi there,
>> >>
>> >> I'm trying to purge a complete folder and its files from the
>> >> repository history with:
>> >>
>> >> git-Games# git filter-branch 'git rm -r --ignore-unmatch --
>> >> Ubuntu/16.04/' --tag-name-filter cat -- --all HEAD
>> >> fatal: bad revision 'git rm -r --ignore-unmatch -- Ubuntu/16.04/'
>> >>
>> >> git does not find the folder although it's there:
>> >>
>> >> git-Games# ll Ubuntu/16.04/
>> >> total 150316
>> >> drwxr-x--- 2 actionmystique actionmystique     4096 Nov 19 13:40 ./
>> >> drwxr-x--- 4 actionmystique actionmystique     4096 Oct 30 14:02 ../
>> >> -rwxr-x--- 1 actionmystique actionmystique  2190394 May  9  2016
>> >> residualvm_0.3.0~git-1_amd64.deb*
>> >> ...
>> >> -rw-r--r-- 1 actionmystique actionmystique 67382492 Oct 13 09:15
>> >> scummvm-dbgsym_1.9.0_amd64.deb
>> >>
>> >> What is going on?
>> >>
>> >> --
>> >> Jean-Christophe
>> >
>> >
>> >
>> > --
>> > Jean-Christophe
>>
>>
>>
>> --
>> Jean-Christophe
>
>
>
>
> --
> Jean-Christophe



-- 
Jean-Christophe
