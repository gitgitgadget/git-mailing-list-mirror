From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] Teach fast-import to print the id of each imported
 commit
Date: Tue, 12 Oct 2010 13:48:56 -0500
Message-ID: <20101012184856.GA16103@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-2-git-send-email-david.barr@cordelta.com>
 <AANLkTinRDoSHhzYnnvckPYyiZrsOX1mJECBMb5bNbMJ=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 20:52:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5jxe-0003OR-QV
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 20:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758042Ab0JLSwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 14:52:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38338 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab0JLSwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 14:52:24 -0400
Received: by ewy20 with SMTP id 20so1504551ewy.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=K+w9VqsR9Wv9ZscjOJ7+GL4vRDzcLPpzeHp2XNRcabU=;
        b=NePeGhwETrpsctBk6cuQdg68VMb+pb+C3XOiM2lHUTX/44Z7Xn/11OlUKYGF2UxU19
         dSqTbXmzxKtxT81T+HUX4peegj6hMLt0W2CKxspP9XWDf3nbk5P5ruGLsFgPAI0yhrZg
         kk2z5xFqDbdqYwU/K/l8ITXVQRnsvClYzoI6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=D2GcHz/1xs56MAUjgFhLaOEeAc0BjBq/0CqxZbRc+dQ1VNfxZnADx+yqUolTMhZyL8
         X+ZQqVgS4+l0G3mIV9P3RliPul0B0R+JsrDtK64vNyG8DAkAkS8VPyikxvi987LfY/Yn
         sA9fIPQfOdwrDgJIDWg2Lg0Blx1Iak70GJLBA=
Received: by 10.14.45.77 with SMTP id o53mr2224251eeb.1.1286909540109;
        Tue, 12 Oct 2010 11:52:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x54sm3338078eeh.5.2010.10.12.11.52.16
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 11:52:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinRDoSHhzYnnvckPYyiZrsOX1mJECBMb5bNbMJ=@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158866>

Sverre Rabbelier wrote:
> On Tue, Oct 12, 2010 at 15:50, David Barr <david.barr@cordelta.com> w=
rote:

>> + =C2=A0 =C2=A0 =C2=A0 } else if (!prefixcmp(feature, "report-fd=3D"=
)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 option_report_fd(=
feature + strlen("report-fd=3D"));
>
> Note that adding it here means that we _do_ support in-stream
> 'report-fd' specification, which is fine by me since it's overridable
> on the commandline, but there was some discussion earlier that we
> _shouldn't_ support this.

Reference: http://thread.gmane.org/gmane.comp.version-control.git/15628=
0

Thanks for the reminder.  I still think Sam is right fwiw.
