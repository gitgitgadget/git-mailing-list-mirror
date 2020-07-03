Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC09C433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C928F20870
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgGCNw4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 3 Jul 2020 09:52:56 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21103 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCNw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 09:52:56 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 063DqpcD019236
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Jul 2020 09:52:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'demerphq'" <demerphq@gmail.com>
Cc:     "'Jason Pyeron'" <jpyeron@pdinc.us>, "'Git'" <git@vger.kernel.org>,
        "'Matthew Horowitz'" <mhorowitz@pdinc.us>,
        "'Jakub Trzebiatowski'" <cubuspl42.1@gmail.com>
References: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com> <0e9801d6508d$c1f55560$45e00020$@pdinc.us> <03df01d6508f$873cc320$95b64960$@nexbridge.com> <CANgJU+XM2Y-Dp5odRfSecqYeZQ+Ft0okvB6RNUs=hyAdJDJ-gw@mail.gmail.com>
In-Reply-To: <CANgJU+XM2Y-Dp5odRfSecqYeZQ+Ft0okvB6RNUs=hyAdJDJ-gw@mail.gmail.com>
Subject: RE: Is git compliant with GDPR?
Date:   Fri, 3 Jul 2020 09:52:45 -0400
Message-ID: <04e201d65141$3e6d4180$bb47c480$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQI3a36ohrugQlw4W93V7edqWZTq6QHTAPwuAmyewSgBwf4pv6gDnPow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 3, 2020 2:23 AM, demerphq wrote:
> On Thu, 2 Jul 2020 at 18:42, Randall S. Becker <rsbecker@nexbridge.com>
> wrote:
> > I am not speaking for the Git Foundation here, nor am I a lawyer; However,
> to use some practices from some of my customers who have this concern,
> the team members are directed to use tokenized names and email addresses
> that can be resolved by their security teams during an audit. Obviously the
> team members recognize the tokens so they know who is making what
> change. This means that externally, any names/emails that might get pushed
> upstream are non-identifying.
> 
> I think this is a really good point. I think git could make itself much more
> GDPR friendly by having some support for this type of idea built in.
> 
> Not sure how it could work, maybe some kind of object that can be deleted
> after the fact which maps an identifier used for the author with name and
> email. If that name and email change the object can be updated, and if there
> is a need to "forget" the author, the object can be deleted. The object would
> not be shared on clone, so it would stay private to the repo that held it.
> 
> I guess you can argue that this isnt git's problem. But at a corporate level, it
> will be seen as git's fault regardless if it cause a big disruption. It could/would
> also be a reason that european companies might decide not to use git.

How you choose to identify yourself to git is entirely arbitrary. There are SSO solutions used by GitHub that have the personal information stripped out. I contend that this is not git's problem because anyone can use anything to self-identify. Git does not care. Policies can be implemented (commit-hooks) to automatically tokenize but that's up to what the corporation wants to do. In fact, git is less subject to GDPR issues than other VCS systems, which uses the logon credentials that are personal-identifying in many locations and could represent a security vulnerability. So while a corporation can choose to find fault with git, the fault is in their own credential management policies.

It might be worth some documentation to explain this.

