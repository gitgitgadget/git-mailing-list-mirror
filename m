Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF8620C11
	for <e@80x24.org>; Wed,  6 Dec 2017 16:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbdLFQso (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 11:48:44 -0500
Received: from elephants.elehost.com ([216.66.27.132]:26315 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdLFQsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 11:48:43 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vB6Gmetj055197
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Dec 2017 11:48:40 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <002701d36eaa$ef39bab0$cdad3010$@nexbridge.com> <xmqqtvx3hkst.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtvx3hkst.fsf@gitster.mtv.corp.google.com>
Subject: RE: [RFE] install-doc-quick.sh should accept a commit-ish
Date:   Wed, 6 Dec 2017 11:48:33 -0500
Message-ID: <004001d36eb2$10f8ef20$32eacd60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQICkUn7lL/zXxjqd6+ejk5GFK/TrwJ08QvsosSZLJA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 6, 2017 11:40 AM, Junio C Hamano wrote:
>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>> Having the git-manpages repo available is fantastic for platforms that 
>> cannot easily build documentation on demand, for example, when too 
>> many dependencies that do not build properly.
>> It would be really nice to have a version of install-doc-quick.sh to
either:
>> 1. Use whatever version is checked out in git-manpages; or
>> 2. Use the proper commit associated with the git commit being 
>> installed (0a8e923 for v2.6.0 , as an example); or
>> 3. Allow the commit to be passed through the Documentation Makefile on
demand so that any version of documentation can be installed.

>Do you mean something like this so that you can say "not the tip of the
master branch but this one?"

> Documentation/install-doc-quick.sh | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

>diff --git a/Documentation/install-doc-quick.sh
b/Documentation/install-doc-quick.sh
>index 327f69bcf5..83764f7537 100755
>--- a/Documentation/install-doc-quick.sh
>+++ b/Documentation/install-doc-quick.sh
>@@ -3,8 +3,9 @@
 
> repository=${1?repository}
> destdir=${2?destination}
>+head=${3+master}
>+GIT_DIR=
 
>-head=master GIT_DIR=
> for d in "$repository/.git" "$repository"
> do
> 	if GIT_DIR="$d" git rev-parse refs/heads/master >/dev/null 2>&1

Providing I can pass that through make via something like quick-install-man
head=commit-ish, that's what I'm hoping.

Cheers,
Randall


