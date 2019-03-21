Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571C220248
	for <e@80x24.org>; Thu, 21 Mar 2019 21:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCUVDy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Mar 2019 17:03:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:55072 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUVDw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 17:03:52 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x2LL3mpT070457
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 17:03:49 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Fabio Aiuto'" <polinice83@libero.it>, <git@vger.kernel.org>
References: <1553195171.1436.1.camel@libero.it>         <002901d4e01a$88bdd220$9a397660$@nexbridge.com> <1553196739.1436.3.camel@libero.it>
In-Reply-To: <1553196739.1436.3.camel@libero.it>
Subject: RE: Semantic errors
Date:   Thu, 21 Mar 2019 17:03:40 -0400
Message-ID: <000501d4e029$93624940$ba26dbc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIEdXnYK9I+sdb3lPFNGef240rKTAJETcuKAWAyt0SlmkGWcA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Of On March 21, 2019 15:32, Fabio Aiuto wrote:
> Il giorno gio, 21/03/2019 alle 15.16 -0400, Randall S. Becker ha
> scritto:
> > On March 21, 2019 15:06, Fabio Aiuto wrote:
> > > I'm browsins git code with Eclipse. I'm on a local branch called
> > > "studio" based on master (last public commit e902e9b by Junio C
> > > Hamano on Monday March 11 2019). I've built everything by changing:
> > > CFLAGS = -g -Wall (removing -O2 to have smooth trace in debugging).
> > > But the environment detects the following semantic errors (I made no
> > > edits!!!):
> > > Description	Resource	Path	Location	Type
> > > Symbol 'GIT_HTML_PATH' could not be resolved	git.c	/g
> > > it
> > > line 154	Semantic Error
> > > Symbol 'GIT_MAN_PATH' could not be resolved	git.c	/gi
> > > t
> > > line 158	Semantic Error
> > > Symbol 'GIT_INFO_PATH' could not be resolved	git.c	/g
> > > it
> > > line 162	Semantic Error
> > > Symbol 'active_cache' could not be resolved	commit.c
> > > /git
> > > /builtin	line 899	Semantic Error
> > > Field 'ce_intent_to_add(active_cache[i])' could not be resolved
> > > commit.c	/git/builtin	line 899	Semantic Error
> > > Symbol 'active_nr' could not be resolved	commit.c	/gi
> > > t/bu
> > > iltin	line 889	Semantic Error
> > > Symbol 'active_nr' could not be resolved	commit.c	/gi
> > > t/bu
> > > iltin	line 898	Semantic Error
> > > Field 'oid' could not be resolved	commit.c	/git/built
> > > in
> > > line 1654	Semantic Error
> > > Symbol 'active_nr' could not be resolved	commit.c	/gi
> > > t/bu
> > > iltin	line 901	Semantic Error
> > > Symbol 'active_cache_tree' could not be resolved	commit.c
> > > /git/builtin	line 1654	Semantic Error
> > > Symbol 'active_cache_changed' could not be resolved	commit.c
> > > /git/builtin	line 418	Semantic Error
> > > Symbol 'active_cache_tree' could not be resolved	commit.c
> > > /git/builtin	line 419	Semantic Error
> > > Symbol 'active_nr' could not be resolved	commit.c	/gi
> > > t/bu
> > > iltin	line 254	Semantic Error
> > > Symbol 'active_cache' could not be resolved	commit.c
> > > /git
> > > /builtin	line 255	Semantic Error
> > >
> > > I can debug without problems, but what if I should trece through one
> > > of those errors?
> > > How can I fix them?
> >
> > This situation occurs in many projects in ECLIPSE, not only git. The
> > errors are likely coming from one of the error parsers that you have
> > enabled in your workspace. Look in the Project Properties or Workspace
> > Preferences under C/C++ Build/Settings in the Error Parsers tab for
> > your build configuration. You may have to turn off some of those.
> > There is also the C/C++ General/Code Analysis Preferences setting
> > where you might have to turn off the problematic errors. I have found
> > that this is a common situation for code that is imported into ECLIPSE
> > from other platforms, where the GNU error and analysis tools are
> > overly aggressive by default.
> >
> > Good luck.
> > Randall
> >
> > -- Brief whoami:
> >  NonStop developer since approximately 211288444200000000
> >  UNIX developer since approximately 421664400
> > -- In my real life, I talk too much.
> >
> >
> >
> Thank you I tried to disable all of them, but they all remain. For example the
> variable 'active_nr' is actually never declared. That's so strange. Hope to
> solve this all soon. I'm freezed...

It is very likely in ECLIPSE either in workstation or project settings relating to error parsers (turn everything off). It still may be an error parser issue. One key thing... do not use -Wall. There are also settings about what to do in some error conditions configured in ECLIPSE. -Wall could be probably triggering a response from one of the error parsers. But the Semantic Error type is not normally from the compiler; rather, it is from ECLIPSE CDT pre-scanning the code. Anyway, check out other -W settings to disable all warnings as a start. If you are building in Cygwin or Mingw, you probably can ignore the ECLIPSE errors, especially if git actually built. If you are trying to mix a managed build and a non-managed build in the same project, you are going to be out of luck.

