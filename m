From: Baz <brian.ewins@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Fri, 11 Jan 2008 12:19:16 +0000
Message-ID: <2faad3050801110419h20acbda8me1cbdb4c6e06a086@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
	 <fm1h7t$nnr$1@ger.gmane.org>
	 <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>
	 <fm44ck$299$1@ger.gmane.org>
	 <4d8e3fd30801101449u11aabd73mba233301df157160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Douglas Stockwell" <doug@11011.net>, git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 13:19:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDIrV-0007mf-Dh
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 13:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250AbYAKMTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 07:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757534AbYAKMTU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 07:19:20 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:6262 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558AbYAKMTT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 07:19:19 -0500
Received: by py-out-1112.google.com with SMTP id u52so1608640pyb.10
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 04:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FhA6jdGMA1Efey0NZq6CJXzwfBnKV5T/ZZdjl8kDy3Y=;
        b=teU5YWgp32B5RxV1hWw+8E4Vy0XtcxP9edRLX05NYzEu6YtZQIBJJK8wn9xqPtGUOpxncNm44GrThNDECqocaY5fda9NTUvWlGpKaGOOLrfOUGaLCoImeSPbXZW6hIi9YChrUdBE+16j3xoRH8wWPy3/7dvbZuaLzwSTkXJY6tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QXGn+hznzpe1sVrUZtrS0yibuuQJAHlp6huqkp5rJ2llWO3YrJOdaIm2J7PkvBehdQW8uBIQyqkdQoR0IoG5MJwk76Hl4d1TxYmVUOBLLDV06N/bH8LWQjxpe/4ZfBJA4MWiOtSAkup/zX9bh917bWGFX85C1aFlov3KrOfKXCo=
Received: by 10.142.157.15 with SMTP id f15mr1578798wfe.16.1200053956549;
        Fri, 11 Jan 2008 04:19:16 -0800 (PST)
Received: by 10.142.43.18 with HTTP; Fri, 11 Jan 2008 04:19:16 -0800 (PST)
In-Reply-To: <4d8e3fd30801101449u11aabd73mba233301df157160@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70153>

On Jan 10, 2008 10:49 PM, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On Jan 10, 2008 4:45 AM, Douglas Stockwell <doug@11011.net> wrote:
> > Paolo Ciarrocchi wrote:
> >
> > > Well, it would be nice to add this information to the wiki, it's still
> > > mentioning
> > > that you require an external program for supporting the TLS connection.
> > > I'll do that when I'll get my box working with the configuration you suggested,
> > >
> > > What I'm getting at the moment is:
> > > paolo@paolo-desktop:~/git$ git-send-email -compose -to
> > > paolo.ciarrocchi@gmail.com /home/paolo/Desktop/patch/
> > > snip
> > > snip
> > > Can't locate Net/SMTP/SSL.pm in @INC (@INC contains:
> >
> > As indicated, the module you need is Net::SMTP::SSL, if there is no
> > package for ubuntu, you can install it using CPAN:
> >
> > perl -MCPAN -e 'install Net::SMTP::SSL'
>
> I'm now getting:
> Unable to initialize SMTP properly.  Is there something wrong with
> your config? at /home/paolo/bin/git-send-email line 638.

You also need to have Authen::SASL installed. Do you have that? As I
recall I needed to edit the code to even see that error.

With Authen::SASL and Net::SMTP::SSL, you can get 1 patch at a time in
via gmail. The alternative connection mode which git-send-email
doesn't support yet is to connect over smtp then negotiate TLS using
'STARTTLS'. If you do this then you can send multiple patches via
gmail with a single call to git-send-email.

There was a patch offered a while back from Simon Sasburg to add
starttls support to git-send-email. At the time I questioned it but I
hadn't seen the 1-patch-at-a-time limit then. Thread:
http://kerneltrap.org/mailarchive/git/2007/10/31/373400
(nb the key thing added by this patch is starttls, not tls)

>
> I tried to get help on #git but I failed, it looks like other people
> are getting the same error.

Hope this helps,
Baz

>
> Ciao,
> --
> Paolo
> http://paolo.ciarrocchi.googlepages.com/
> -
>
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
