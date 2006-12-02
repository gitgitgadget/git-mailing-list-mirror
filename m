X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: On removing files and "git-rm is pointless"
Date: Sat, 02 Dec 2006 17:59:05 -0300
Message-ID: <200612022059.kB2Kx565009646@laptop13.inf.utfsm.cl>
References: <torvalds@osdl.org>
NNTP-Posting-Date: Sat, 2 Dec 2006 20:59:59 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Sat, 02 Dec 2006 09:37:03 -0800." <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33049>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqbxg-00047Z-Ep for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162465AbWLBU7t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162467AbWLBU7t
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:59:49 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:61197 "EHLO
 pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1162465AbWLBU7s
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:59:48 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by pincoya.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id
 kB2KxEgm022117; Sat, 2 Dec 2006 17:59:24 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kB2Kx565009646; Sat, 2
 Dec 2006 17:59:06 -0300
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

[...]

> One thing to look out for: "git rm" actually defaults to the recursive 
> behaviour, something that might take people by surprise. If you give it a 
> directory name, it will happily delete all tracked files from within that 
> directory, even without "-r". That is probably a design mistake. So it 
> would probably make sense to:
> 
>  - without "-r", don't do the partial matches at the beginning (but still 
>    do globbing matches, of course, so "git rm dir/*" wouldn't need an 
>    "-r", but "git rm -r dir/", which does the same thing, _would_ need an 
>    "-r" to be effective)

The command should never even see the '*' here. Globbing is handled
(uniformly) by the shell. Don't loose that.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
