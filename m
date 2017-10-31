Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4898820437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbdJaVwy (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:52:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21097 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbdJaVwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:52:53 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (68-187-17-162.static.smrt.tn.charter.com [68.187.17.162])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v9VLqm3Z037390
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 31 Oct 2017 17:52:49 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Kevin Daudt'" <me@ikke.info>,
        "'Eyjolfur Eyjolfsson'" <eyjolfureyjolfsson@tprg.com>
Cc:     <git@vger.kernel.org>
References: <CAO-WtQhAPjoWnWyMPi5SkCSUM_y8A=hsbLk-MUfnCSBvWnBRNQ@mail.gmail.com> <20171031212251.GB7777@alpha.vpn.ikke.info>
In-Reply-To: <20171031212251.GB7777@alpha.vpn.ikke.info>
Subject: RE: Is it possible to convert a Json file to xml file with Git
Date:   Tue, 31 Oct 2017 17:52:48 -0400
Message-ID: <001801d35292$9871bd10$c9553730$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK6T/wu27nAPXDFkdet15nRf/MkewHktPbhoSFdKoA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On October 31, 2017 5:23 PM, Kevin Daudt wrote:
> > On Tue, Oct 31, 2017 at 05:28:40PM +0000, Eyjolfur Eyjolfsson wrote:
> > I have a question.
> > Is it possible to convert a Json file to XML with Git
> 
> git is a version control system, which is mostly content agnostic. It
knows
> nothing about json or xml, let alone how to convert them.
> 
> You might want to use some kind of programming language to do the
> conversion.

Speculating... one possible reason to do this is during a protocol
conversion effort, where definitions are moving from XML to JSON form. In
legacy VCS systems, keeping interface definitions in one file and converting
the content may be important. However, in git, with its concept of atomicity
(multiple files are committed in a single version across the whole
repository), dropping one file (e.g., XML) and adding another (e.g., JSON),
can be done in one commit, and never lost or confused as to what is
intended. This makes git ideal for modernization and evolutionary projects.

If, however, there is an application or systemic requirement to change the
content of a file from XML to JSON without changing the name - I've seen it
happen - you may want to consider building a smudge filter that understands
the difference and maps between the two, to allow git diff operations
between old and new formats. I would not recommend using this approach
except as a last possible resort. Make a new file as Kevin intimated.

Just Musing on the Topic,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



