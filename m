Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C359F1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 20:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeFAUvF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 16:51:05 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60860 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFAUvF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 16:51:05 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w51KoKjt058868
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 1 Jun 2018 16:50:21 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Robert P. J. Day'" <rpjday@crashcourse.ca>,
        "'Git Mailing list'" <git@vger.kernel.org>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
Subject: RE: how exactly can git config section names contain periods?
Date:   Fri, 1 Jun 2018 16:50:14 -0400
Message-ID: <00ce01d3f9ea$270a0d30$751e2790$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLj/WJVzloODYh08FJkhfx2cEZUrqIr2Psw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> Of Robert P. J. Day
> Sent: June 1, 2018 4:14 PM
> To: Git Mailing list <git@vger.kernel.org>
> Subject: how exactly can git config section names contain periods?
> 
> 
>   more oddities in my travels, this from Doc.../config.txt:
> 
> "The file consists of sections and variables.  A section begins with the
name
> of the section in square brackets and continues until the next section
begins.
> Section names are case-insensitive.  Only alphanumeric characters, `-` and
`.`
> are allowed in section names.
>                                   ^ ?????
> 
>   what? how can section names contain periods? reading further,
> 
> "Sections can be further divided into subsections.  To begin a subsection
put
> its name in double quotes, separated by space from the section name, in
the
> section header, like in the example below:
> 
> --------
>         [section "subsection"]
> 
> 
>   ok, so how on earth would i use "git config" at the command line to set
a
> config variable with some arbitrary level of subsections? let's try this:
> 
>   $ git config --global a.b.c.d.e rday
> 
> huh ... seemed to work fine, and added this to my ~/.gitconfig:
> 
>   [a "b.c.d"]
>           e = rday
> 
> as i see it, the first component is intgerpreted as the section name, the
last
> component is the variable/key(?) name, and everything in between is
> treated as subsection(s), which is not at all obvious from that Doc file,
or from
> "man git-config".
> 
>   and if a section name can contain periods, how would you specify that at
the
> command line?

I'm with Robert on this. I would have thought that the interpretation should
have been:

["a.b.c.d"]
         e = rday

Confused as well,

Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



