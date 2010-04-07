From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] remote-curl: ensure that URLs do not have a trailing 
	slash
Date: Wed, 7 Apr 2010 23:57:28 +0800
Message-ID: <p2ube6fef0d1004070857j874c2b60z6a4794d472b0ee8a@mail.gmail.com>
References: <1270651892-5712-1-git-send-email-rctay89@gmail.com>
	 <7viq83e1pd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 17:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXdI-0001Si-Qa
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810Ab0DGP5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 11:57:30 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:35641 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729Ab0DGP53 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 11:57:29 -0400
Received: by iwn35 with SMTP id 35so653109iwn.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=imWgwzk1rULAA0tdyCiMZ7bo8NxNMqHVELh0fxfutLE=;
        b=bo0cnzrFaOM5Nzli5eYWgc9+RRKTRxAK6C9vYaB2zek4u8Mzxz2QEczjJPSi/z4724
         SXQ+N2tiTZA9f3Y8KwTRjUCLlyvR59EIoOQcPf0S1rlMkGQd0xg9S0uclgEVpUqWeW7S
         lCQIbak1sdo9CZzOtpcoq/SbCsVc2sRrJzkrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cgjqdGFG/+bz6apwu5rmzGIZ5iQTe4EzTYliSNi3eqqH6J4xBE7GzCEpAPkPt0lHDc
         hE0L4jJH8l5V5UwezxF7l7OOl1vcAbRbKu+rB3TdVAKNbE3gHythXVKRzlMfzGcGMrBQ
         10ukJ1KYFzYad5iREtgKkOUek3DGJ6xC2yILQ=
Received: by 10.231.10.65 with HTTP; Wed, 7 Apr 2010 08:57:28 -0700 (PDT)
In-Reply-To: <7viq83e1pd.fsf@alter.siamese.dyndns.org>
Received: by 10.231.167.4 with SMTP id o4mr1774110iby.66.1270655848601; Wed, 
	07 Apr 2010 08:57:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144240>

Hi,

On Wed, Apr 7, 2010 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> The code does not look like it is making sure things do not have a
> trailing slash. =A0For example, if svc has trailing slash, either %s/=
%s or
> strbuf_addf() would have the last character of svc in rpc->service_ur=
l.
>
> You are fixing something else.
>
> The new code avoids duplicated slashes in the middle if "url" can but=
 does
> not necessarily end with a slash. =A0Is that what you are trying to f=
ix?

the commit message is misleading, yes. I'll have another go at it.

> =A0I
> wonder if it makes more sense to make sure "url" always ends with a s=
lash
> at the calling sites where it is obtained from either the end user or=
 from
> the running environment...

Good idea.

--=20
Cheers,
Ray Chuan
