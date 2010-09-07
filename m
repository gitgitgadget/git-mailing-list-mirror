From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Re: [PATCH] Fix compat/regex ANSIfication on MinGW
Date: Tue, 7 Sep 2010 14:56:42 +0200
Organization: Viscovery Software GmbH
Message-ID: <201009071456.43845.j.sixt@viscovery.net>
References: <OFF09696E1.DC0D98D7-ONC1257793.0070A82E-C1257793.00758522@DCON.DE>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com,
 =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
 git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 johannes.schindelin@gmx.de
To: karsten.blees@dcon.de
X-From: msysgit+bncCJOK-OFUEI_tmOQEGgRD-SR_@googlegroups.com Tue Sep 07 14:57:12 2010
Return-path: <msysgit+bncCJOK-OFUEI_tmOQEGgRD-SR_@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCJOK-OFUEI_tmOQEGgRD-SR_@googlegroups.com>)
	id 1Osxja-0000eU-Iy
	for gcvm-msysgit@m.gmane.org; Tue, 07 Sep 2010 14:57:10 +0200
Received: by fxm3 with SMTP id 3sf714024fxm.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 07 Sep 2010 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :message-id:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding:content-disposition;
        bh=L9GnMwUy6BJZAOI9AS/7HE2xquCInJjuTw11fnRGojA=;
        b=r+rF9VrtEmhviBlKJBmj5oxVAklqp/t1azvbtR7izxKs+UCVGmJU37cJmwSTughukj
         MCriczeBUMGpB3PIuByZMuelzDcFPg/2Pna5epXiVTkZM/iKAkUzTfxQhbewtj1ZFg2m
         ISVGS28+BQ9G203Z7rGE3Z4Xdte877jJekBsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:message-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding:content-disposition;
        b=cBTnn5ZUiDejylGPZw9xvH8iqHBo65cHjsEux9tn1j54CjOnBbtlhnyMUhJJY7AFqE
         eI07G3WsJ4PDZHF13gbfZI9aKI0YLHqgwxgeNyw3mjnk4vSmky16gjyuJ80OmjT91+GX
         x6d3zS+kDd6ZrqKq9mdVlTBsMimtESJjJ63aw=
Received: by 10.223.75.25 with SMTP id w25mr133140faj.35.1283864207457;
        Tue, 07 Sep 2010 05:56:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.32.142 with SMTP id c14ls1199847fad.2.p; Tue, 07 Sep 2010
 05:56:46 -0700 (PDT)
Received: by 10.223.121.140 with SMTP id h12mr255412far.26.1283864206244;
        Tue, 07 Sep 2010 05:56:46 -0700 (PDT)
Received: by 10.223.121.140 with SMTP id h12mr255411far.26.1283864206214;
        Tue, 07 Sep 2010 05:56:46 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by gmr-mx.google.com with ESMTP id l23si1805088fam.14.2010.09.07.05.56.46;
        Tue, 07 Sep 2010 05:56:46 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=213.33.87.14;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B67F9CDF96;
	Tue,  7 Sep 2010 14:56:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id EA29919F7E0;
	Tue,  7 Sep 2010 14:56:43 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <OFF09696E1.DC0D98D7-ONC1257793.0070A82E-C1257793.00758522@DCON.DE>
X-Original-Sender: j.sixt@viscovery.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 213.33.87.14 is neither permitted nor denied by best guess record for domain
 of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155701>

On Freitag, 3. September 2010, karsten.blees@dcon.de wrote:
> Johannes Sixt <j.sixt@viscovery.net> wrote on 26.08.2010 09:58:26:
> > Am 8/25/2010 20:24, schrieb Karsten Blees:
> > > this doesn't compile if internal_function is #defined non-empty (e.g.
>
> on
>
> > > mingw/msysgit). The old-style definitions work.
> > >
> > > In file included from compat/regex/regex.c:78:
> > > compat/regex/regexec.c:357: error: conflicting types for
>
> 're_search_2_stub'
>
> > > compat/regex/regexec.c:44: note: previous declaration of
> >
> > 're_search_2_stub' was
> >
> > > here
> >
> > Here's a fix.
>
> Sorry, I realize I should've cross-posted this to the msysgit list (adding
> cc).
>
> In the meantime, Dscho has fixed the function definitions in the msysgit
> fork like so:
> static int internal_function
> re_search_2_stub (struct re_pattern_buffer *bufp,...
>
> Your patch removes internal_function from the declaration, so now it
> doesn't compile again...

Sorry for the complication. Please feel free to submit a patch that implements 
the conclusion of this discussion. I don't mind how the problem is solved 
(but I do agree that moving "internal_funcion" to the front would be 
cleanest - now that I got to know that this is a possible solution :-).

-- Hannes
