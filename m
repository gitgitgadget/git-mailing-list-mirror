Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5D71F404
	for <e@80x24.org>; Fri, 23 Feb 2018 13:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeBWNZo (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 08:25:44 -0500
Received: from fallback15.m.smailru.net ([94.100.179.50]:60476 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751015AbeBWNZn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 08:25:43 -0500
X-Greylist: delayed 3425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Feb 2018 08:25:43 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=SC/iq3B+/qd29DKOeFoUDa88TH2GdchYl139gMAj8+s=;
        b=wd+JNs1bPSSc6DK5WXMG8RpdRqcJYxdx9bPSskMATqKAfyUqy7gs//V4gXc6R4qdg1SC6Ssu7+w6AyeflSFyVKuqjpCdnocjTMkYanu9e/4e72WzVjwPyrk1aTbS73IML+1xVDhKqPveYX84stQvY0ccQJAJZi1QSLvsQzhiRQI=;
Received: from [10.161.76.75] (port=33538 helo=smtp16.mail.ru)
        by fallback15.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1epCSp-0003vu-Uk
        for git@vger.kernel.org; Fri, 23 Feb 2018 15:28:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=SC/iq3B+/qd29DKOeFoUDa88TH2GdchYl139gMAj8+s=;
        b=wd+JNs1bPSSc6DK5WXMG8RpdRqcJYxdx9bPSskMATqKAfyUqy7gs//V4gXc6R4qdg1SC6Ssu7+w6AyeflSFyVKuqjpCdnocjTMkYanu9e/4e72WzVjwPyrk1aTbS73IML+1xVDhKqPveYX84stQvY0ccQJAJZi1QSLvsQzhiRQI=;
Received: by smtp16.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1epCSk-00016h-Sm; Fri, 23 Feb 2018 15:28:31 +0300
Date:   Fri, 23 Feb 2018 15:28:26 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derek Fawcus <dfawcus+lists-git@employees.org>,
        git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180223122826.zuqncwduvf2n2all@tigra>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <20180221210339.GA43094@accordion.employees.org>
 <87bmgif2pa.fsf@evledraar.gmail.com>
 <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A5CB4B1B7A477D25829D6DBCD0DC3C349A7F6F029A795A6D84725E5C173C3A84C3677AC51C039AA0BA22C3C1C42D93ADDF1F42DF47398C4A6DC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4158BCF03995F10A6BD48759C29EA5CF597605B135CE73CA5FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5545FDFB7B8FD931EAFA1D16F12A50A0109DF358E7E8DE9BF462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C900532B6DFB9EC464CB0C309DD8A65CAECEA792FBECB46828FAF3AC45910FB9EB2A7FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 11:14:20PM +0100, Peter Backes wrote:

[...]
> atime, in contrast, was clearly one of the rather nonsensical 
> innovations of UNIX: Do one write to the disk for each read from the 
> disk. C'mon, really? It would have been a lot more reasonable to simply 
> provide a generic way for tracing read() system calls instead; then 
> userspace could decide what to do with that information and which of it 
> is useful and should be kept and perhaps stored on disk. Now we have 
> this ugly hack called relatime to deal with the problem.
[...]

IIUC, the purpose of atime can be more apparent if you consider it in
the context of the time it appeared: the systems were multi-user but the
disks were small, so a question "what files are lying there but appear
to be unused" was rather sensical to ask as such files could be found,
reported and then considered for deletion of moving off rotating media
to tapes etc.

