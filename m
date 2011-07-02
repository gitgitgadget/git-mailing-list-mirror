From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/13] revert: Catch incompatible command-line options
 early
Date: Sat, 2 Jul 2011 04:53:34 -0500
Message-ID: <20110702095334.GA19090@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-10-git-send-email-artagnon@gmail.com>
 <20110621170416.GN15461@elie>
 <BANLkTinN6KdPnuMWbrdE4jf4ijKDC=35Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 11:53:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcwtX-0005uk-Ab
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 11:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab1GBJxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 05:53:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54094 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab1GBJxm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 05:53:42 -0400
Received: by iyb12 with SMTP id 12so3379189iyb.19
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KKYEc8eWKs9BjBJyolFVL3QLhe2F9aY0FAsgwSwTV+c=;
        b=q668awRtcpQTTIS4rD3MtWK3KNX59GPzVyJRxrUOhATAoZ+xDkPPqp0B6vTKH1qDzO
         m2rJtCvN124ednXP0bZ8yaKFKPBfRftqyQKocy9CORpMD+7U42tE+pSQYqKMeo9oDMDx
         WHY4KQ3MA1GwOquqGcCLkUYowIrtEir2H6XhU=
Received: by 10.42.171.132 with SMTP id j4mr4737246icz.414.1309600421746;
        Sat, 02 Jul 2011 02:53:41 -0700 (PDT)
Received: from elie (adsl-68-255-98-241.dsl.chcgil.sbcglobal.net [68.255.98.241])
        by mx.google.com with ESMTPS id a9sm1705009icy.6.2011.07.02.02.53.39
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 02:53:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinN6KdPnuMWbrdE4jf4ijKDC=35Aw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176549>

Hi Ram,

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> The naive reader (i.e., me) wonders: how long does this option parsi=
ng
>> and populating the options structure that we want to delay until aft=
er
>> verify_opt_compatible take? =C2=A0Does that delay matter or is there=
 some
>> other reason for this change?
>
> I've tried to spell out the motivation for this change more clearly i=
n
> my latest iteration.  Does this look alright?
>
>     revert: Catch incompatible command-line options in parse_args
>
>     Some incompatible command-line options are caught in pick_commits
>     after parse_args has parsed the options and populated the options
>     structure.  Change this so that parse_args only parses valid
>     command-line options instead of returning an unusable options
>     structure.  However, this does not mean that we will never need t=
o
>     check the options structure; when a sequencer API is written futu=
re,
>     callers will call in with a pre-populated options structure whose
>     validity we will still need to check.  Also, provide a
>     verify_opt_compatible function to handle incompatible options in =
a
>     general manner.

Alas, I still don't get it.  How can I (the fearful reader) demonstrate
the problem that this fixes?  Is it a big problem?  How does the patch
fix it?  Does the patch have downsides, or is it mostly risk-free?
