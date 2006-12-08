X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: shallow clones, was Re: What's cooking in git.git (topics)
Date: Fri, 08 Dec 2006 15:42:56 +0530
Message-ID: <45793AA8.8010704@gmail.com>
References: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612070035570.28348@wbgn013.biozentrum.uni-wuerzburg.de> <87zma06ptm.fsf@wine.dyndns.org> <Pine.LNX.4.63.0612071557580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 10:13:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LwRbHXyoDGeKvd3wjGBElLMvAuAsZaUUKRFsDvzFE1gAoJS2CcOC3ku7A6Bdk6tkLwiHzdqCAWfTt2wzWdoq5KHMKTmhcWjgWuD2/tG/IubgOPYNpTRrCiGpHDSb6V1Oau2einLa1qGPFWhC1vZQUhhfHz9XEzSIoT2Veq+gBZc=
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.63.0612071557580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33677>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GscjO-00079N-Tp for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425312AbWLHKNW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425322AbWLHKNW
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:13:22 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:34821 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1425312AbWLHKNV (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 05:13:21 -0500
Received: by nz-out-0102.google.com with SMTP id s1so496895nze for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 02:13:21 -0800 (PST)
Received: by 10.65.54.9 with SMTP id g9mr5510652qbk.1165572800932; Fri, 08
 Dec 2006 02:13:20 -0800 (PST)
Received: from ?217.76.227.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id e11sm2549983qbc.2006.12.08.02.13.12; Fri, 08 Dec 2006 02:13:19 -0800
 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
>.
>> I'm not sure what reaction you expect, but this is something a lot of 
>> our occasional Wine users are requesting. The Wine full history is 80Mb, 
>> and that's a big download if you just want to try a quick patch. Now of 
>> course you won't see these users around here hacking on shallow clone, 
>> most likely they just went and downloaded Wine from the CVS mirror 
>> instead. But it's a shame to have to maintain a CVS mirror just for that 
>> purpose...
> 
> Sorry, I was just mumbling about the fact that I would _like_ to hear back 
> about successes and failures. If there are problems I want to fix them.
> 
>>


How about this. This is already reported 

kvaneesh@kvaneesh-laptop:/tmp$git clone --depth 2 /home/opensource/git git.test
.....
 100% (743/743) done


kvaneesh@kvaneesh-laptop:/tmp$cd git.test/
[master@git.test]$ git fsck-objects



[master@git.test]$ git fetch --depth 4
remote: Generating pack...
remote: Done counting 872 objects.
...
 100% (1/1) done
Total 1 (delta 0), reused 0 (delta 0)
Unpacking 1 objects
 100% (1/1) done


[master@git.test]$ git fsck-objects
dangling commit aca085e577688108a2480b96a2f7077424a74e4d
dangling commit b360cca0b100e14abffa4cae78521b493c783738
dangling commit cd976f5c52694acb4b23c3f2425ed4f0a47ec799
