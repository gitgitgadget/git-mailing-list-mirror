X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 18:39:44 +0100
Message-ID: <e5bfff550612110939r58df1a73ud28983633c12e487@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
	 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org>
	 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com>
	 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
	 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
	 <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org>
	 <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com>
	 <Pine.LNX.4.64.0612110855550.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612110905180.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 17:39:55 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R7RRjdrqDElrzK3wrFDtwdTLVJu9dYJAzbZ96JnaAaIax0YsbIi8qkIZVR920/2ywFQXnrizY+UvIxkBeWRueBwVQEHgGgHhqK4mWyUNuc3EORzt4wKe8oASRB1apvakQviX/73ueoKN5H7yfCCJLXvsCeFcaFETND6j21G7H3k=
In-Reply-To: <Pine.LNX.4.64.0612110905180.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34021>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtp81-0007lz-Hi for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762998AbWLKRjq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 12:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763001AbWLKRjq
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 12:39:46 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:42591 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762998AbWLKRjp (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 12:39:45 -0500
Received: by py-out-1112.google.com with SMTP id a29so948267pyi for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 09:39:45 -0800 (PST)
Received: by 10.35.76.9 with SMTP id d9mr12786953pyl.1165858784980; Mon, 11
 Dec 2006 09:39:44 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Mon, 11 Dec 2006 09:39:44 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 11 Dec 2006, Linus Torvalds wrote:
> >
> > That's not timing what I asked. That's just timing the "git-rev-list". You
> > need to time the "cat" part too. Either use a script, or do something like
> >
> >       time sh -c "git-rev-list ... | cat > /dev/null".
>
> Btw, if you do this, you'll actually see one of the _real_ advantages of
> pipes.
>
> On an SMP system, you'll easily get output like "110%CPU", since now the
> git-rev-list and the user can run in parallel. Of course, they can do so
> with temp-files too, but then you have all the "is it a true EOF, or is it
> just the fact that the writer hasn't written everything yet" problem (and
> the _normal_ solution for that is to simply not allow any overlapping
> work).
>

Sorry for wrong data, I will repost as soon as I can.

Regarding the _normal_  solution we have one more hipotesys to take
advantage of: git-rev-list when has nothing more to read..exits.

This is what lead to the exit loop condition based on git-rev-list is
still alive, instead of messing with an EOF.

     eof  = (no more data && !rev_list_is_running);

With this we could enter the loop one more time then necessary, but
nothing else bad should happen.

