Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5200A1F51C
	for <e@80x24.org>; Fri, 18 May 2018 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeERPiE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 18 May 2018 11:38:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:27631 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeERPiD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 11:38:03 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w4IFc0QO026012
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 May 2018 11:38:00 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Anmol Sethi'" <me@anmol.io>
Cc:     "'Jacob Keller'" <jacob.keller@gmail.com>,
        "'Git mailing list'" <git@vger.kernel.org>
References: <285692D0-1DE8-4CAF-9BCE-F1A04D5C66B5@anmol.io> <CA+P7+xqQZzTrm274rbbP_O85Y+YGZ4PQ8PMFJnJtKR4wR0AObQ@mail.gmail.com> <002a01d3eddb$cdd3d8f0$697b8ad0$@nexbridge.com> <FE668F59-95D7-48AB-AD3B-A37AE404B368@anmol.io>
In-Reply-To: <FE668F59-95D7-48AB-AD3B-A37AE404B368@anmol.io>
Subject: RE: Add option to git to ignore binary files unless force added
Date:   Fri, 18 May 2018 11:37:53 -0400
Message-ID: <009901d3eebe$32dd09a0$98971ce0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKXlS0WnUPf5I5iLIWLccbtRU0F4AJsQdWKATKpy1gCClaZaKKBBb7w
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 18, 2018 7:31 AM, Anmol Sethi <me@anmol.io>
> That works but most binaries do not have a file extension. Its just not
> standard on linux.
> 
> > On May 17, 2018, at 8:37 AM, Randall S. Becker <rsbecker@nexbridge.com>
> wrote:
> >
> > On May 16, 2018 11:18 PM, Jacob Keller
> >> On Wed, May 16, 2018 at 5:45 PM, Anmol Sethi <me@anmol.io> wrote:
> >>> I think it’d be great to have an option to have git ignore binary
> >>> files. My
> >> repositories are always source only, committing a binary is always a
> mistake.
> >> At the moment, I have to configure the .gitignore to ignore every
> >> binary file and that gets tedious. Having git ignore all binary files would be
> great.
> >>>
> >>> This could be achieved via an option in .gitconfig or maybe a
> >>> special line in
> >> .gitignore.
> >>>
> >>> I just want to never accidentally commit a binary again.
> >>
> >> I believe you can do a couple things. There should be a hook which
> >> you can modify to validate that there are no binary files on
> >> pre-commit[1], or pre- push[2] to verify that you never push commits
> with binaries in them.
> >>
> >> You could also implement the update hook on the server if you control
> >> it, to allow it to block pushes which contain binary files.
> >
> > What about configuring ${HOME}/.config/git/ignore instead (described at
> https://git-scm.com/docs/gitignore). Inside, put:
> >
> > *.o
> > *.exe
> > *.bin
> > *.dat
> > Etc....

I have a similar problem on my platform, with a different solution. My builds involve GCC binaries, NonStop L-series binaries (x86), and a NonStop J-series binaries (itanium). To keep me sane, I have all build targets going to separate directories, like Build/GCC, Build/Lbin, Build/Jbin away from the sources. This allows me to ignore Build/ regardless of extension and also to build different targets without link collisions. This is similar to how Java works (a.k.a. bin/). Much more workable, IMHO, than trying to manage individual binaries name by name or even by extension. I also have a mix of jpg and UTF-16 HTML that would end up in false-positives on a pure binary match and I do want to manage those.

What helps me is that I do most of my work in ECLIPSE, so derived resources (objects, generated sources) get auto-ignored by EGit, if you can make your compiler arrange that - but that's an ECLIPSE thing not a file system thing.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



