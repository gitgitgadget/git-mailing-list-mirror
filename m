Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED531F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 00:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbdAZAl0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 19:41:26 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33430 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdAZAlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 19:41:25 -0500
Received: by mail-lf0-f54.google.com with SMTP id x1so51254250lff.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 16:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=64nGCQ24ct8Qf9L4asD2ApsYqEiIYnJ/wMs5Lus56Ak=;
        b=haCYqLqKEcqBXwByy3RW8rg9EnloqFyhSWtkVdv1rIR8KWj/0C57BnwF1DqiqHqf5V
         RR60F9SLvkMVUp27VdDIxO9cQ1zNn5NlUzpXFXEaQsl8usJdlgsrJzhfuhJOLl5uLvbA
         Z/1rn4vZ/gdePXNVZV7x62MU7yrDqGEOcpThC9/lD4Q9WKPSrAuIt4ONR3rTdIIGlvZ9
         G6kIF4jtVg+MhJ883mDTNleFxinG78Ar8elGqUtL8h5+ABQ1TVvwuoY6K8cL/oNrbAQJ
         VtrCGfCx59RdLirnEkTT/ELCudEODp5wNjkd1Og3cB/Pu1qsMba36dNH6ZJOTGM1KDf6
         0LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=64nGCQ24ct8Qf9L4asD2ApsYqEiIYnJ/wMs5Lus56Ak=;
        b=ASMedLVomJXCX2gKTQ1zzpFi2Vp1/NE2oTCoHAuEWLZ1veuhKL3+3hfj0fpRkLGC2B
         GAI85Lzl/eGR5+4AjVIWDH15TpsWwgHFvfL4LqYAGrOFvho/YU7vzzPM1UoKnimuBeKO
         XZgLsiTfLvxRV/wAYvwx52t7cyRYY7mNFtRfSCQkkrMl/C7UeKqwnyZuvlZB1g11JJEQ
         /7jUPsc1D0b73gnBxjBtmaAkq0wHzUIm0VEalaPs4W5Eh9AOwfbIvLoftMRV1EL4csKd
         P3s24SgD/MjM42hY70IgPUl5r8qRf1Uqy5JxWC1jKNb286rT6x/UtXfxXOaschSEgpgc
         h2Zg==
X-Gm-Message-State: AIkVDXIr5UQNorDAB3vKSHcBeZuMZQrcfaehl1o1b0IPl6FT9coCoqTAxE0rh35YWPYcUtC6yLequBnX76JY4Q==
X-Received: by 10.25.141.12 with SMTP id p12mr36835lfd.147.1485391258701; Wed,
 25 Jan 2017 16:40:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 25 Jan 2017 16:40:38 -0800 (PST)
In-Reply-To: <CAE1pOi0CgfxQTygg_i3dc_-_Lb8qgOOk_0hg+goJvm7PyLZseg@mail.gmail.com>
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
 <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
 <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
 <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com>
 <xmqqh94m7leb.fsf@gitster.mtv.corp.google.com> <CAE1pOi0CgfxQTygg_i3dc_-_Lb8qgOOk_0hg+goJvm7PyLZseg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 25 Jan 2017 16:40:38 -0800
Message-ID: <CA+P7+xocc==-8ad-OVTahMDABA0-spDPEw05JTHopfO7Ovj2RQ@mail.gmail.com>
Subject: Re: Force Confirmation for Dropping Changed Lines
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 3:57 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> On 25 January 2017 at 15:46, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>>> Mmm, that sounds complex. The "my-code.x" is made up so I could keep
>>>> my example as simple as possible. In reality, it's Maven's POM files
>>>> (pom.xml).
>>>>
>>>> So there is no setting for any of this? There is no way to switch off
>>>> auto merging for certain files?
>>>
>>> Not really sure, but a quick google search revealed
>>> https://github.com/ralfth/pom-merge-driver
>>>
>>> Maybe that will help you?
>>
>> Its readme seems to indicate that it is either solving a different
>> problem, or solving the same problem with the opposite goal in mind,
>> in that its goal seems to be to forcibly resolve what textually does
>> not resolve cleanly by choosing sides with an arbitrary policy, so
>> that humans do not have to get involved when they ordinarily would
>> have to.
>>
>> Hilco's goal sounded to me the opposite---to force conflict even
>> when the two histories did what textually does resolve cleanly and
>> require humans to get involved even when they ordinarily wouldn't
>> have to.
>
> Yes, unfortunately, you are correct. This seems to do the exact
> opposite of what I want.
>
> Before I start learning about custom merge drivers, is what I want
> even possible? If yes, would you happen to know some good examples of
> (custom) merge drivers? (Python, Ruby, Java are all okay.)

Setting the merge driver to "unset" will do what you want, but it
would leave the current branch as the tentative answer and doesn't
actually make it easy to resolve properly. That would only require
putting "pom.xml merge=unset" in the .gitattributes file.

That might be what you want, but it doesn't actually try to update the
file during the merge so you'd have to hand-fix it yourself.

Thanks,
Jake
