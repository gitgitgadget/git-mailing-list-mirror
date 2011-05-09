From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 21:13:44 +1000
Message-ID: <BANLkTimGEU0vFOCEsWaF_T4EOPQwnWip6g@mail.gmail.com>
References: <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506172334.GB16576@sigill.intra.peff.net>
	<BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
	<20110509073535.GA5657@sigill.intra.peff.net>
	<BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
	<20110509081219.GB6205@sigill.intra.peff.net>
	<BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
	<20110509104446.GB9060@sigill.intra.peff.net>
	<BANLkTikUjGLBH6_ze7EvRfoKb9h-RREmuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 13:13:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJOPO-0002CF-Ls
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 13:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab1EILNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 07:13:46 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33750 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab1EILNp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 07:13:45 -0400
Received: by vxi39 with SMTP id 39so5632638vxi.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g5Vsi1yK6QtmEhlDpHC1QSzqp4D1y54XA70YTKNe3kg=;
        b=diyJ8PTfeeD7mRTAVWXVuNIFy0X0ZIWGDikEDGAEi6SFk05Xg2U2BsJ0J7Wp6SUpAd
         zak4TCaXBsbmhMUk/Ad7wAn6c37Tvm3CZCYCgjHPPhPW929PY78neuS3QYmlXjsho3e4
         puKDH1B6pZCTqWtckJBZO+F2WrR+vGfarg0jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oWvnaXsZx0VUVFDzI/6Czt+YI2Ewa8rpb6oN6uR4wMjSWchQE9P7Bx5hZi5r6tBmac
         6i5wEVib7NRbKmgEhidgQrr9810V3GvCPUVTMMNXK8ZaFjO3y0WqoQvSug/IakIvDkDL
         05O3FFrAccRVzd7I6/aq7vMGGIINzcjVO9OhA=
Received: by 10.52.169.135 with SMTP id ae7mr3188286vdc.79.1304939624798; Mon,
 09 May 2011 04:13:44 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Mon, 9 May 2011 04:13:44 -0700 (PDT)
In-Reply-To: <BANLkTikUjGLBH6_ze7EvRfoKb9h-RREmuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173221>

On Mon, May 9, 2011 at 9:07 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> On Mon, May 9, 2011 at 8:44 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, May 09, 2011 at 06:45:56PM +1000, Jon Seymour wrote:
>>
>>> I am starting to think that deploy-via-zip/tar is unworkable for th=
e
>>> case where the extension wants to supply html, since I think an
>>> attempt has to be made to deploy HTML in the path reported by git
>>> --html-path for reasons of HTML =C2=A0linkability from extension ba=
ck to
>>> the pages from git-core.
>>
>> Yeah, I don't see a way around that without post-processing the HTML
>> links at install time (or creating a symlink farm with all of the HT=
ML
>> pages).
>>
>>> So, suppose we call it --preferred-extension-path*, then if the use=
r
>>> (root or otherwise) defines
>>>
>>> =C2=A0 =C2=A0 git config core.preferrred-extension-path ${HOME}/.gi=
tplugins
>>>
>>> then they get to choose where the installer next run will install e=
xtensions.
>>
>> I thought about suggesting that, but a config option didn't seem a g=
ood
>> fit to me. The decision of where to put a package seems more likely =
to
>> be related to which _package_ it is, than which user you are. So a
>> command-line option would make more sense. And even if you have a co=
nfig
>> option, you would sitll need a command-line one to override, so it's=
 not
>> like you are reducing the amount of code or complexity.
>>
>> Which again makes it not a git issue at all, but an issue for
>> package-writers who want to provide a script. It's their job to inte=
ract
>> with the user and find out where the user wants to put things (i.e.,
>> personal or system directories).
>>
>> I don't really see any need for git's role in this to be more than:
>>
>> =C2=A01. Check a set list of directories for extra paths to add to P=
ATH and
>> =C2=A0 =C2=A0 MANPATH.
>>
>> =C2=A02. Tell the packager's script what that set list is, so they c=
an be
>> =C2=A0 =C2=A0 sure to put their files in the right spot.
>>
>

BTW: the reason why I want the git actually installed to provide this
hint about the best place to install,
rather than use installation script heuristics is that the locally
installed git + the user supplied configuration
is in a much better situation to suggest a good choice than an install
script that is trying to be platform and distribution agnostic.

jon.
