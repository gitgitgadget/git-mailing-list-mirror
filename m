From: David Aguilar <davvid@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sat, 14 May 2011 05:51:36 -0700
Message-ID: <20110514125133.GA765@gmail.com>
References: <7viptz5j82.fsf@alter.siamese.dyndns.org>
 <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
 <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
 <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
 <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
 <4DB9329E.7000703@op5.se>
 <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <buozkmw5w3j.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sat May 14 14:51:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLEK0-0004RU-9y
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 14:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443Ab1ENMvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 08:51:47 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44582 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab1ENMvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 08:51:46 -0400
Received: by pwi15 with SMTP id 15so1524971pwi.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Q1up6h23P4aaYRHuEtZJGFl5NctKBapOxHUWbWXziDw=;
        b=bQxlJX6T/InsuNEzE1/qiItHOIzy4AIXd751MXORgdRQ3q5wEQHBsafBrv2cIcx8CE
         jjOVrJwkReJof2JnKwfyVwwCPeE8/9AUUy1cW8aLN3xVsXyjeO5vjGvXCcyZTd8Lo4e7
         SQEXw/5NB6zH2GnJzhw5hoZ6u/MlGWFR/tmDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VLepoOH67tfHhvzYY76mFxQoBRQhRiG18CXme+nkyjCn3GPvVot0pF1lotDoj5iMFd
         yRh+ycpbYg43VHmxW+zpTgf3JZRWyor+NLDroGa3bGQ0tw/xaCXMP3NbXVI+McxHaFS+
         ycy2L91uLX5aTJz2V9BX6hgNWiBZ+A7xNOUvg=
Received: by 10.142.119.35 with SMTP id r35mr1516944wfc.411.1305377505937;
        Sat, 14 May 2011 05:51:45 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k7sm2973869wfa.14.2011.05.14.05.51.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 May 2011 05:51:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <buozkmw5w3j.fsf@dhlpc061.dev.necel.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173581>

On Mon, May 09, 2011 at 01:36:16PM +0900, Miles Bader wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Do you or do you not run "apt-get install git-superadd"?
> >
> > One possible answer may be to run "apt-get install git-superadd", and then
> > the users who want "git add" to behave in a new way to opt-in to use the
> > "plug-in".  I think that is what Jon is getting at.
> 
> If aliases could override built-in command names, it'd be easy enough
> ("alias add=superadd") ... [with some feature to allow suppressing the
> alias to prevent recursion, e.g. an environment variable or something.]

I always thought this restriction was a good thing.

The usability argument usually goes that it's generally
bad for "git frotz" somewhere to behave different from
"git frotz" somewhere else.

Keeping this "limitation" is good for the sake of consistency.

This topic is orthogonal to the plugin rfc, though.
-- 
					David
