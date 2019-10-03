Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA28F1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfJCUfn (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:35:43 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:43667 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJCUfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:35:42 -0400
Received: by mail-qt1-f181.google.com with SMTP id c3so5477936qtv.10
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WXXcggCy27jLGxtLDs4RyXwUuEih15cFhg0oeFKVb8w=;
        b=UnW6DENwpIfi7N3cCGDKHiCSWGdHSQlZFpOXqHhJevWPZlcmbmXJulOnWM/AF+fNmm
         l2BK86mi3nAKdFkG5NbYIjaornI2ju9vMDwj0Nrkm4jUroalQlk2dP8frboMx6jTUE9b
         0W1vBmEemwhKQBgW92J0Thod/NnxDD5M81W4XxPDE8PUADQfn5B5nLoaJ1v0XTIsiYQk
         aksa5sd7MmLguj7rfmluINzBot3oxEjsGHw6sGfwRbXJrYZXOAGX5BKa9VxAguJgavue
         dETnzMqzzxSHz0Qyz3BAZX9bvLueHYZHvc7zVZGERCYCCv6MWQDafK4vlj3P03DJXo8M
         PZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WXXcggCy27jLGxtLDs4RyXwUuEih15cFhg0oeFKVb8w=;
        b=qb2wfevQl87p+lv9wDYGa9D0E/kiFDfXQtBEIGsVy9rUEawvGnf/zSbLyqcIPJGHH3
         rOe0+Ej5z+frORuh04V84Gt1hlmfba+rvR5HBuX5SyqW04fDdE9rdqMprPUH7vuhX630
         nx9Ci6+Z0O62x75wwoMtmloj2DCJfUpMX9L3BgNYbKKDvIrMWo1SNqq44GN4vDORrsSi
         Dd04/EEFTtM/nUXxar3TlLBLtxZkSiG/hNnxidbc6M+DVTtzulVCP7kSGyDKmGvpdSgE
         By6GTclMuRvf+tLawuk6ev1PKnlDPsO8OMj1IahPore9wQcb+cztk9nVLn6Xk7kcEDRa
         Qrug==
X-Gm-Message-State: APjAAAUiOXk5Y8bebfORkxiPIZopr62HXQUj2Fm5CjjoAeOMOzFvKOpU
        I5CLJxmM+oh52j6+KDqZ9msNvJp1gtHcB565GLk1MQ==
X-Google-Smtp-Source: APXvYqwXZzWK3AvjxbVsAwlLEbERsaf72O5PSuFwMJH4mhUdxkMDkehEJHY3dRbBpGNi/t05NdhFEe8mVWK7GLwcfW8=
X-Received: by 2002:ad4:42a2:: with SMTP id e2mr10249201qvr.189.1570134940690;
 Thu, 03 Oct 2019 13:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAP_ANik21_mkUdqwd0YQS4VDa80AnqQ+Xa1jWsQ7ihnfyQymYw@mail.gmail.com>
 <CAJoAoZkq1=VfJ05J8L2AvJjp6GxoTNTF6pNFAzQ1rx+7LKk6bQ@mail.gmail.com> <CAP_ANinzBvysKE6QWUinmNzcvKqsRv10VSjFGChoK-0Nz4KT7Q@mail.gmail.com>
In-Reply-To: <CAP_ANinzBvysKE6QWUinmNzcvKqsRv10VSjFGChoK-0Nz4KT7Q@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 3 Oct 2019 13:35:29 -0700
Message-ID: <CAJoAoZ=5aK50T9ugMww9Po0whFUSfOYY4djVhUvCU_azn2SABA@mail.gmail.com>
Subject: Re: [Outreachy] Outreachy internship program
To:     gespinoz gespinoz <gespinoz2019@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi George, it sounds like you are probably using Git for Windows
(https://github.com/git-for-windows/git).

I'm actually not very familiar with how folks who primarily use GfW as
their client manage their contributions to the main Git project.
However, I know there are plenty - the GfW maintainer is an active
contributor upstream.

I'm CCing the Git mailing list as well as the GfW maintainer in the
hopes that you can get some help from somebody who regularly uses the
workflow you're trying to achieve. :)

Unfortunately I use Linux everywhere and so I can't try to replicate
what you're doing - but once you have a good workflow and are able to
finish the My First Contribution tutorial we should still be able to
work together.

Can you be specific about which "official website" you downloaded Git
from (share a URL), and paste the command you run and error message
you receive? Please also share the output you see when you run "uname
-a" in Git Bash.

 - Emily


On Thu, Oct 3, 2019 at 12:40 PM gespinoz gespinoz
<gespinoz2019@gmail.com> wrote:
>
> Hello,
>
> Great! Thanks for the tips Emily! This mentor and internship program soun=
ds awesome which is why I decided to apply. I=E2=80=99ll look through it to=
 see if there=E2=80=99s a specific micro project available later on today a=
nd run it through you.
>
> I am having one slight issue, I=E2=80=99m not sure why I can=E2=80=99t us=
e the =E2=80=9Cmake=E2=80=9D command to run Makefile, I=E2=80=99ve done it =
at school in the past so I was a bit familiar with Makefile and how it help=
s compile things. This is what I did. I downloaded git from the official gi=
t website, installed it, then I found the repository link and I cloned it i=
n the git bash client to my desktop. I=E2=80=99m using windows at home but =
at school I used an iMac and when I cloned repositories I used iTerm and pu=
shed to git within iTerm. I=E2=80=99m guessing the git bash is similar sinc=
e I was able to open and edit files using vim commands similar in iTerm whe=
n I was going through the walkthrough. So now I=E2=80=99m stuck on the =E2=
=80=9Cmake=E2=80=9D step to see if I added the psuh feature in correctly. I=
 also noticed when I looked at the INSTALL page on github it made it seem l=
ike maybe installing it through the website wasn=E2=80=99t the right idea? =
Maybe that=E2=80=99s why I can=E2=80=99t use make? I also can=E2=80=99t use=
 man correctly. For both I get bash command does not exist. Should I instal=
l something similar to iTerm instead on windows and just start fresh? ty.
>
> George!
>
> On Thu, Oct 3, 2019 at 11:14 AM Emily Shaffer <emilyshaffer@google.com> w=
rote:
>>
>> Hi George,
>>
>> Great to hear that you're walking through the MyFirstContribution
>> tutorial - that's a great introduction to how the Git project gets
>> stuff done.
>>
>> This is my first time mentoring for Outreachy, but as I understand it,
>> you will start by doing a microproject so everybody can see if you are
>> a good fit for the project. The community discussed the list of
>> microprojects for applicants to try in this mailing list thread:
>> https://public-inbox.org/git/20190916184208.GB17913@google.com/
>> I don't think you need to wade through the replies on that thread to
>> determine whether the microproject you are interested in is available,
>> although you're certainly welcome to. You can also ask me if you see a
>> microproject you are interested in and I will be happy to help
>> summarize it and point you in the right direction :)
>>
>> It is also probably a good idea for you to search that mailing list
>> archive for "[Outreachy]" so you can see what Outreachy interns have
>> done in the past and try to emulate how they submitted finished
>> microprojects.
>>
>> The tutorial you said you're reading covers how to send your
>> contributions for review when you're done, but if you find you're
>> having trouble or want someone to check that you've formatted it
>> right, you can let me know!
>>
>>  - Emily
>>
>> On Wed, Oct 2, 2019 at 9:55 PM gespinoz gespinoz <gespinoz2019@gmail.com=
> wrote:
>> >
>> > Hello Emily,
>> >
>> > How are you? My name is George Espinoza and I am one of the applicants=
 in the Outreachy internship program. I hope you are doing well! I wanted t=
o introduce myself and connect as I am interested in the Git open source pr=
oject that you are mentoring. I'm currently creating my work environment an=
d tinkering with the git program while doing the myfirstcontribution walk-t=
hrough. I have had a bit of experience using git for a school i attended ov=
er the summer that used it for clone and pushing repositories. We worked wi=
th iTerm and I learned how to use vim as well. I know some basics, in no wa=
y a master yet/ I hope to learn more as I progress in making contributions!
>> >
>> > After I set up my environment I will join the IRC channel and introduc=
e myself in the project's public chat and go from there searching how and w=
hat I should first contribute.  I'll also join the mailing list. If you hav=
e any tips or advice that would be great! I'm looking forward to working wi=
th you and learning more about Open Source Projects! Thank you.
>> >
>> > sincerely,
>> > George Espinoza
