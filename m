From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 3/5] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Sat, 12 Jan 2008 17:51:43 +0800
Message-ID: <46dff0320801120151s7959edddp1e1f8b506da79e4e@mail.gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	 <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	 <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	 <bce0ee9fde688c27fc788fab91a571184918da67.1200122041.git.pkufranky@gmail.com>
	 <7vabnbv3sb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 10:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDd2B-00017A-H2
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 10:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762395AbYALJvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 04:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762076AbYALJvq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 04:51:46 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:43779 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761947AbYALJvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 04:51:45 -0500
Received: by py-out-1112.google.com with SMTP id u52so2077307pyb.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XbyJGOY3fBfp65+CFn7tpnDrXprtXo+UCqN64jzc9FY=;
        b=ifm/TcdqW6hxkhNPyKwQ2c4Vm2m0YXc4tHtekQiI8caf4b60bjCHa54Rk3gMF5x4d9yvrC5hxZS2HujpCePwcaqZi0Rk31IlcYQeaBGIPS8PNCYKXLiE9TDgvTRnxKLCOWysLF8fauC2bCpXBZuVcCeCcozxpBlZWlTBs8B2cWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AAt923r8h8kRZjZ7djjvRNphcl+m6n5+2wrWlrq3I0Pdnbz6AN2k13LRTpr4Cy+XhduX5k1bBpQ6rBv4CZTjiFls2VFawihIgFyKuBayMIvFxWAh1DxHbrK/23zNOgUrNShMLSMxwb8L5U0Ob/quwegSa3MvJh+hCzQBCZpR68o=
Received: by 10.35.67.18 with SMTP id u18mr4799960pyk.64.1200131503759;
        Sat, 12 Jan 2008 01:51:43 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 12 Jan 2008 01:51:43 -0800 (PST)
In-Reply-To: <7vabnbv3sb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70304>

On Jan 12, 2008 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
> > @@ -265,6 +267,10 @@ set_name_rev () {
> >  #
> >  modules_summary()
> >  {
> > +     summary_limit=${summary_limit:-1000000}
>
> Why a million?
Because i think a million is big enough. I'd better define a constant
for unlimited number.
>
> > +     summary_limit=$((summary_limit<0?1000000:summary_limit))
>
> This is doubly bashism.  Variables must be referenced with $,
> and $(( conditional ? iftrue : iffalse )) is not POSIX.
>
Ok, i'll fix this.


-- 
Ping Yin
