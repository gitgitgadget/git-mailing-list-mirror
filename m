From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Wed, 8 Jun 2005 20:52:49 +1000
Message-ID: <2cfc40320506080352f50d351@mail.gmail.com>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org>
	 <20050607094947.GC2676@pasky.ji.cz>
	 <2cfc403205060702594da21fb1@mail.gmail.com>
	 <20050608085834.GC7916@pasky.ji.cz>
	 <2cfc403205060802315ba2433a@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 12:49:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfy7H-0005Dg-4Q
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 12:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVFHKwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 06:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVFHKwz
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 06:52:55 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:51208 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262156AbVFHKwu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 06:52:50 -0400
Received: by rproxy.gmail.com with SMTP id i8so238915rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 03:52:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H9rna+1THGZSqTFZ5V1KZlOuVScL2gfJJEUIfbDAuFVEDVV2o51W6Y0WFqz/CQfD2szZsWgYfEempyx3h9yP9Svi4K0OWCDGiZDDrCxxhhvqlb6/+YzOgnfmZ4uvIICYPd7h/jjAqEHruBubq/oQaQ2JKY+fubZlX/rsvvpLk9g=
Received: by 10.38.75.73 with SMTP id x73mr197689rna;
        Wed, 08 Jun 2005 03:52:50 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 8 Jun 2005 03:52:49 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <2cfc403205060802315ba2433a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ok, this is how --wrt-author sorts your example:

(Original example transposed so that variable width fonts don't play
havoc with the layout)

a10 b9
| \  |
a9  b8
|    |
a8  b7
|    | 
a7  b6
| /  |
a6  b5
| \  |
a5  b4
|    |
a4  b3
| \  |
a3  b2
|    |
a2  b1
| /
a1

with respect to a and b respectively

A         B

| b9      | b9
^ a10     ^ a10
| b8      | a9
| b7      | a8          
| b6      | a7
| b5      ^ b8
^ a9      | b7
| a8      | b6
| a7      | a6
| a6      | a5
| b4      | a4
| b3      | a3
^ a5      | a2
| a4      ^ b5
| b2      | b4
| b1      | b3
^ a3      | b2
| a2      | b1
= a1      = a1

In otherwords, B doesn't see any of A's changes after a1 until b6,
whereas A sees some of B's changes at a4 and some at a6, then not
again until a10.

jon.
