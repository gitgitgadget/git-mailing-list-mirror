Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92749203C1
	for <e@80x24.org>; Wed, 16 Nov 2016 09:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754763AbcKPJk7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 04:40:59 -0500
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:45350 "EHLO
        19.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752886AbcKPJkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 04:40:55 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Nov 2016 04:40:55 EST
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 095371BB70
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 10:25:48 +0100 (CET)
Received: from RCM-ns322269.ip-176-31-238.eu (LFbn-1-459-240.w86-245.abo.wanadoo.fr [86.245.167.240])
        (Authenticated sender: postmaster@rapsys.eu)
        by player169.ha.ovh.net (Postfix) with ESMTPSA id 5E707580095;
        Wed, 16 Nov 2016 10:25:44 +0100 (CET)
Received: from LFbn-1-459-240.w86-245.abo.wanadoo.fr ([86.245.167.240])
 by mail.ovh.net
 with HTTP (HTTP/1.1 POST); Wed, 16 Nov 2016 10:25:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Nov 2016 10:25:44 +0100
From:   =?UTF-8?Q?Rapha=C3=ABl_Gertz?= <mageia@rapsys.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: gitweb html validation
In-Reply-To: <xmqqy40ks301.fsf@gitster.mtv.corp.google.com>
References: <13c9b4a74d82a1f0ed3f626406a43e92@rapsys.eu>
 <20161115182632.GA17539@gmail.com>
 <xmqqy40ks301.fsf@gitster.mtv.corp.google.com>
Message-ID: <add4ba7fced68430c421c6b0ec388a13@rapsys.eu>
X-Sender: mageia@rapsys.eu
User-Agent: Roundcube Webmail/1.2.1
X-Originating-IP: 86.245.167.240
X-Webmail-UserID: postmaster@rapsys.eu
X-Ovh-Tracer-Id: 2746069874588610263
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelfedrudeggddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 16.11.2016 01:05, Junio C Hamano a écrit :
> Ralf Thielow <ralf.thielow@gmail.com> writes:
> 
>> Only block level elements are
>> allowed to be inside form tags, according to
>> https://www.w3.org/2010/04/xhtml10-strict.html#elem_form
>> ...
>> I think it's better to just move the <form>-Tag outside of the
>> surrounding div?
>> Something like this perhaps, I didn't test it myself yet.
> 
> That sounds like a sensible update to me (no, I do not run gitweb
> myself).  Is this the only <form> we have in the UI, or is it the
> only one that is problematic?
> 
There is an other form in the cgi line 4110 :
         print $cgi->start_form(-method => "get", -action => $action) .
               "<div class=\"search\">\n" .

But this one has a <div class="search"> inside.

The problem with projsearch I want to change is that the div is around 
the form without a container inside.

I agree with moving the <div class="projsearch"> inside the form if it's 
a better option.

Best regards
