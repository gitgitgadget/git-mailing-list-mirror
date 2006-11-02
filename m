X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: how to pass ssh options to git?
Date: Thu, 02 Nov 2006 12:18:48 +0100
Message-ID: <4549D418.3050606@iaglans.de>
References: <vpqejsm433c.fsf@ecrins.imag.fr> <20061102093153.GF7468@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:19:09 +0000 (UTC)
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
In-Reply-To: <20061102093153.GF7468@mellanox.co.il>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30732>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfaaw-0005UX-5v for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752742AbWKBLSr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbWKBLSr
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:18:47 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:46084 "EHLO
 vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP id
 S1752742AbWKBLSq (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 06:18:46 -0500
Received: from localhost (localhost [127.0.0.1]) by
 vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 427C13ED2; Thu,  2
 Nov 2006 12:18:45 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1]) by localhost
 (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pdBqQClw5G5F; Thu,  2 Nov 2006 12:18:33 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with
 ESMTP id A58263E6C; Thu,  2 Nov 2006 12:18:32 +0100 (CET)
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Sender: git-owner@vger.kernel.org

Michael S. Tsirkin wrote:
> Quoting r. Matthieu Moy <Matthieu.Moy@imag.fr>:
>> Subject: Re: how to pass ssh options to git?
>>
>> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
>>
>>> How is it possible to pass ssh options to git?
>>> for example, I use these options to log into some machine:
>>> ssh -i <private> -o HostKeyAlias=<alias> -p <port> -l <user> <address>
>> Not answering the question, but this can go to ~/.ssh/config :
>>
>> Host *.domain.net
>> User some_user
>> IdentityFile ~/.ssh/foobar
>>
> 
> I know, problem is I want to use different options at different times.
> I could use -F configfile ssh option, but how to pass *that* to git?

you can setup different host-entries as kind of virtual hosts in your 
hosts-section. that is what i do

host blah1.domain.net
hostname www.domain.net
user blah1
IdentityFile .ssh/blah
Port 523434

host blah2.domain.net
hostname www.domain.net
user blah1
IdentityFile .ssh/blah
Port 22

The first host-section i use in an environment, where i cannot get 
through port 22.


Sincerly
