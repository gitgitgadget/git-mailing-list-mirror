Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF131F404
	for <e@80x24.org>; Mon, 10 Sep 2018 13:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeIJSXv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 10 Sep 2018 14:23:51 -0400
Received: from elephants.elehost.com ([216.66.27.132]:51391 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeIJSXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 14:23:51 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8ADTckt087340
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 09:29:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Sergei Haller'" <sergei@sergei-haller.de>, <git@vger.kernel.org>
References: <CAPO0KtU=do8nmJggP4-k1BingdseZUuRjWraGjuN01VoEYU=1Q@mail.gmail.com>
In-Reply-To: <CAPO0KtU=do8nmJggP4-k1BingdseZUuRjWraGjuN01VoEYU=1Q@mail.gmail.com>
Subject: RE: Multiple GIT Accounts & HTTPS Client Certificates - Config
Date:   Mon, 10 Sep 2018 09:29:32 -0400
Message-ID: <001901d4490a$528d7590$f7a860b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIrt3KbW8Z/p3+87XLbzxuKXaNiWKQ6pITg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 10, 2018 4:09 AM, Sergei Haller wrote:
> my problem is basically the following: my git server (https) requires
> authentication using a clent x509 certificate.
> 
> And I have multiple x509 certificates that match the server.
> 
> when I access the https server using a browser, the browser asks which
> certificate to use and everything is fine.
> 
> When I try to access the git server from the command line (git pull or similar),
> the git will pick one of the available certificates (randomly or alphabetically)
> and try to access the server with that client certificate. Ending in the
> situation that git picks the wrong certificate.
> 
> I can workaround by deleting all client certificates from the windows
> certificate store except the "correct" one => then git command line will pick
> the correct certificate (the only one available) and everything works as
> expected.
> 
> Workaround is a workaround, I need to use all of the certificates repeatedly
> for different repos and different other aplications (non-git), so I've been
> deliting and reinstalling the certificates all the time in the last weeks...
> 
> How can I tell git cmd (per config option??) to use a particular client
> certificate for authenticating to the https server (I could provide fingerprint
> or serial number or sth like that)
> 
> current environment: windows 10 and git version 2.18.0.windows.1
> 
> Would be absolutely acceptable if git would ask interactively which client
> certificate to use (in case its not configurable)
> 
> (I asked this question here before:
> https://stackoverflow.com/questions/51952568/multiple-git-accounts-
> https-client-certificates-config
> )

Would you consider using SSH to authenticate? You can control which private key you use based on your ~/.ssh/config entries, which are case sensitive. You can choose the SSH key to use by playing with the case of the host name, like:

github.com
Github.com
gitHub.com

even if your user is "git" in all cases above. It is a bit hacky but it is part of the SSH spec and is supported by git and EGit (as of 5.x).

Cheers,
Randall

--
Randall S. Becker
Managing Director, Nexbridge Inc.
LinkedIn.com/in/randallbecker
+1.416.984.9826



