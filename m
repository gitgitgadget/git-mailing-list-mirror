From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] checkout: apply Dscho's dwim even with "--" present
Date: Fri, 29 Oct 2010 18:59:22 -0500
Message-ID: <20101029235922.GB21410@burratino>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
 <7vbp6c7ski.fsf@alter.siamese.dyndns.org>
 <20101029194639.GA1738@burratino>
 <7vsjzo691r.fsf@alter.siamese.dyndns.org>
 <20101029235358.GA21410@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 01:59:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PByr7-0000rt-16
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 01:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab0J2X73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 19:59:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61452 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab0J2X71 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 19:59:27 -0400
Received: by gyg4 with SMTP id 4so2312726gyg.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pUPgWEKwaPhZKi/OcTFJ6jK+z50KlTzEKefNjI4uwR0=;
        b=uUNxwr6DLbMOZaeiLAnAu7J98v7D6OhsAFkNbH8rbluMHz9xUmGyTyUj9D1E23v2LA
         YzIV3273fQWWIpUU7YYOX74nfZ8/vuk2f53NStFEFuUpNQcYJYy8UQ4DZx2oZuT6swzn
         oDYx/58AYomvoMbsSA3g4YahBmxUMjryV+LIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FsCFxtrhpfd11mw7Xa+gt4udKVND7bQALPFq2xIhTEOdOK739HhxQYyaYn3YKCtQS4
         nad5c6sXxeCc3W9+DlIAI3AsO2a8Ku6abU0f3Zkz1yoNq8RbLBvXPgsGEv2hklOUojR/
         jPR6kYgjQticQq+siXv4hdEC/v04edd3hEPyw=
Received: by 10.151.43.21 with SMTP id v21mr22852344ybj.196.1288396767064;
        Fri, 29 Oct 2010 16:59:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm2871418qck.17.2010.10.29.16.59.25
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 16:59:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101029235358.GA21410@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160368>

Jonathan Nieder wrote:

> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> +			    (argc == has_dash_dash ? 2 : 1)) {

Hmph --- this should read

			    (argc == (has_dash_dash ? 2 : 1)))

for correctness and sanity.
