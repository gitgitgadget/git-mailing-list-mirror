Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB6B1FD09
	for <e@80x24.org>; Wed, 31 May 2017 19:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdEaTQa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 15:16:30 -0400
Received: from ntbbs.santronics.com ([76.245.57.69]:58848 "EHLO
        secure.winserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdEaTQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 15:16:29 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 May 2017 15:16:29 EDT
DKIM-Signature: v=1; d=isdg.net; s=tms1; a=rsa-sha1;
        c=simple/relaxed; t=1496257852; h=Received:Received:Received:
        Received:Message-ID:Date:From:Organization:To:Subject:List-ID;
        bh=p3a7A9y+f3XlAbeOosp9RcJdF04=; b=iR6rFSTA879fSe8jxmBbv37tEkffu
        01X4ArXuMIhlFgTIFvoH2WBV60N26udt7+qwjneFnw/8MKZAGG7SGg+VPddZOz7E
        0QngbVddPTPQEifSzAeZvedsfd2d992ydC+K9NmxBt/3uMooDfZtcpEXJkJh3mnD
        xuviRUJ5TlHs9k=
Received: by winserver.com (Wildcat! SMTP Router v7.0.454.5)
          for git@vger.kernel.org; Wed, 31 May 2017 15:10:52 -0400
Authentication-Results: dkim.winserver.com;
         dkim=pass header.d=beta.winserver.com header.s=tms1 header.i=beta.winserver.com;
         adsp=pass policy=all author.d=isdg.net asl.d=beta.winserver.com;
Received: from beta.winserver.com ([76.245.57.74])
          by winserver.com (Wildcat! SMTP v7.0.454.5) with ESMTP
          id 616751487.1.1816; Wed, 31 May 2017 15:10:51 -0400
DKIM-Signature: v=1; d=beta.winserver.com; s=tms1; a=rsa-sha256;
        c=simple/relaxed; t=1496257692; h=Received:Received:Message-ID:
        Date:From:Organization:To:Subject:List-ID; bh=NfpXtL9RYsRiPMFPRc
        tgE6FYraUzia9FYOCcHtf4b+I=; b=vqPOOuI00wSU74u8fMsZoQBuQCvGi8QGeg
        6umWkJiNqiexbuzwyjZlGpGhYuQc+KJyJH9AQadIr1unAwhFJJAKeDxWE6ZoCoQz
        79iZ020Xk00gNZiAD1bVKDWn1ussSoSTn5QF+r5z3iT3fsjpVZNSBkyrl9Mp9tER
        iDCcGe1QU=
Received: by beta.winserver.com (Wildcat! SMTP Router v7.0.454.5)
          for git@vger.kernel.org; Wed, 31 May 2017 15:08:12 -0400
Received: from [192.168.1.68] ([99.121.5.8])
          by beta.winserver.com (Wildcat! SMTP v7.0.454.5) with ESMTP
          id 1159327439.9.500332; Wed, 31 May 2017 15:08:08 -0400
Message-ID: <592F153A.7020403@isdg.net>
Date:   Wed, 31 May 2017 15:10:50 -0400
From:   Hector Santos <hsantos@isdg.net>
Organization: Santronics Software, Inc.
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.8.1
MIME-Version: 1.0
To:     git@vger.kernel.org
Subject: Git Daemon on Windows fatal error.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I am relatively new to GIT (coming from CVS and SVN) and I am 
trying to setup "Git Daemon" on windows.

I got it working for Local network communications:

d:\local\wc5\testgit>git clone git://localhost/http clone10
Cloning into 'clone10'...
remote: Counting objects: 526, done.
remote: Compressing objects: 100% (520/520), done.
Receiving objects: 100% (526/526), 1.38 MiB | 0 bytes/s, done.
remote: Total 526 (delta 81), reused 0 (delta 0)
Resolving deltas: 100% (81/81), done.

but it fails over the wire when using the public host domain:

d:\local\wc5\testgit>git clone git://public.example.dom/http clone11
Cloning into 'clone11'...
remote: Counting objects: 526, done.
remote: Compressing objects: 100% (520/520), done.
remote: Total 526 (delta 81), reused 0 (delta 0)
fatal: read error: Invalid argument
fatal: early EOF
fatal: index-pack failed

Sometimes its a different initial fatal error but generally the same.  
Once or twice, a repeat MAY work, but often not.

Short of digging into the git source code, I did as much research 
online and tried the various config options suggestions, changing the 
packet size, etc, to no avail.

To me, this seems like a "Socket Half Close" problem.   If anyone is 
aware of what appears to be a long time "known" problem, and have a 
real solution, it would be greatly appreciated.   Otherwise, I am very 
interesting in exploring the Half Close solution as I've seen similar 
behavior in other internet hosting servers in the past.   A simple 
closesocket() wrapper funciton did the trick:


// HalfCloseSocket() performs a TCP Half Close by calling shutdown()
// which signals the remote that no more data is going to be
// sent (FIN signal). HalfCloseSocket() then goes into a
// recv() loop to wait for the remote to acknowledge the close.
// This acknowledgment comes as a recv() return value
// of zero (less).

BOOL HalfCloseSocket(SOCKET socket)
{
     if (shutdown(socket,SD_SENT) != 0) {
         return FALSE;
     }
     int ret = 0;
     int msecs = 10; // poor man sanity check
     char buf[8*1024];
     while ((ret = recv(socket, buf,sizeof(buf),0)) > 0) {
         buf[0] = 0;
         buf[1] = 0;
         msecs--;
         if (msecs == 0) break;
     }
     return closesocket(socket);
}

While I rather not get into the source, I am willing to explore the 
effort if there is no other option.

Thanks for any input you can provide

Hector Santos
Santronics Software, Inc.

-- 
HLS



