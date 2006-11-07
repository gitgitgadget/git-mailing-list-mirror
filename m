X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: If merging that is really fast forwarding creates new commit
   [Was: Re: how to show log for only one branch]
Date: Tue, 07 Nov 2006 13:46:34 +0200
Message-ID: <4550721A.9030504@tromer.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org> <Pine.LNX.4.64.0611060928180.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 11:47:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
In-Reply-To: <Pine.LNX.4.64.0611060928180.3667@g5.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31063>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhPQb-0005sm-Uf for gcvg-git@gmane.org; Tue, 07 Nov
 2006 12:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932142AbWKGLrh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 06:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWKGLrh
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 06:47:37 -0500
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:16081 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S932142AbWKGLrg (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 06:47:36 -0500
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.7/8.12.11) with ESMTP id kA7Bl7WS006650; Tue, 7 Nov 2006 13:47:09 +0200
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi Linus,

On 2006-11-06 19:48, Linus Torvalds wrote:
> 
> On Mon, 6 Nov 2006, Linus Torvalds wrote:
>> Besides, doing an empty commit like that ("I fast forwarded") literally 
>> doesn't add any true history information. It literally views history not 
>> as history of the _project_, but as the history of just one of the 
>> repositories. And that's wrong.
> 
> Btw, absolutely the _only_ reason people seem to want to do this is 
> because they want to "pee in the snow" and put their mark on things. They 
> seem to want to show "_I_ did this", even if the "doing" was a total 
> no-op and they didn't actually generate any real value.

In a project that uses topic branches extensively, the merge-induced
commits give a useful cue about the logical grouping of patches. They
let you easily glean the coarse-grained history and independent lines of
work ("pickaxe made it to next", "Linus got the libata updates") without
getting bogged down by individual commits, just by looking at the gitk
graph. Fast-forwards lose this information, and the more you encourage
them, the less grokkable history becomes.

Empty commits may be the wrong tool to address this (for all the reasons
you gave), but there's certainly useful process information that's
currently being lost.

