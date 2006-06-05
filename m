From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Mon, 5 Jun 2006 02:10:46 +0200
Message-ID: <f36b08ee0606041710r695924cdgaea7822d987ebe94@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
	 <46a038f90606012116t478edacex72a441544f395af4@mail.gmail.com>
	 <200606040116.38036.robin.rosenberg.lists@dewire.com>
	 <Pine.LNX.4.64.0606031631480.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 05 02:10:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn2gF-00089x-0d
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 02:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWFEAKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 20:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWFEAKs
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 20:10:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:19083 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932342AbWFEAKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 20:10:47 -0400
Received: by nf-out-0910.google.com with SMTP id c31so1695934nfb
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 17:10:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G20YUwtZ7ovU91W+RjBWrNTPiNUtpN1W91AItGHiDBYmXF1IWVzeSUtN3AnHtbE1J3/Vh4s9FsZ2TlFFFEvAczYUZKhVbEYVcFiZgPcZ9viB45AJdh1d4QLdYab4SfTHwaPpofaOyizC8YbGU4hrKDsO0qld2tq1D9rV8qMnr94=
Received: by 10.49.56.20 with SMTP id i20mr3888445nfk;
        Sun, 04 Jun 2006 17:10:46 -0700 (PDT)
Received: by 10.48.209.12 with HTTP; Sun, 4 Jun 2006 17:10:46 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606031631480.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21299>

On 6/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
+static unsigned long autodetect_crlf(unsigned char *src, unsigned long size)
> +{
> +       unsigned long newsize = 0;
> +       unsigned char *dst = src;
> +       unsigned char last = 0;
> +
> +       while (size) {
> +               unsigned char c = *src++;

size--;
is missing

> +               if (last == '\r' && c == '\n') {
> +                       dst[-1] = '\n';
> +               } else {
> +                       newsize++;
> +                       dst++;
> +                       if (dst != src)
> +                               dst[-1] = c;
> +               }
> +               last = c;
> +       }
> +       return newsize;
> +}

Yakov
