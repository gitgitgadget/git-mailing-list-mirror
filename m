From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 06/19] git_remote_helpers: push all refs during a
 non-local export
Date: Thu, 9 Jun 2011 00:21:07 +0200
Message-ID: <BANLkTi=TYArAgp_+fXvOSDMqsyteQJrVCg@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-7-git-send-email-srabbelier@gmail.com> <20110608194205.GI27715@elie>
 <20110608221908.GB15530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 00:21:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUR8L-0000wR-5m
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 00:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab1FHWVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 18:21:48 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38987 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab1FHWVs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 18:21:48 -0400
Received: by qwk3 with SMTP id 3so457693qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=CUvX0yDgkRDaDUHnAzG99Oz9+662UofCxaZOD5OVRRM=;
        b=ol0TAkx4K2CrOp8zqZQ69y1H3GSOFjYJxxSTLlD8Wv8GGkX9oVH/EUTAx+TXg/oa39
         Qp+NWSbB1k1aaj3OmZn8d7j4VzzT4JqjkvR3jorf+9kwc8TOGOZK1OBChp8sp3f3kQJy
         DpW+9F6EveVzzc8gDCO0yb0ogAIRsZRlA7J/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KqcyktaM0XRZ9ndHK0qGCmvZtX31v2NKx0lgrb5tXDEl01Do6FYUslBNwYzWOhxa84
         F0ybbVlUiWpNzcJijxTtf+W0LqIBFEyZ5n6/uX2xg4+XA2KiS1fp7l0k1u4GHCER+K8r
         oB2qOjOoWSdLwiUS2kXUb4+P2Z3rpTjaL7yYY=
Received: by 10.229.135.12 with SMTP id l12mr5075qct.53.1307571707100; Wed, 08
 Jun 2011 15:21:47 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 15:21:07 -0700 (PDT)
In-Reply-To: <20110608221908.GB15530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175470>

Heya,

On Thu, Jun 9, 2011 at 00:19, Jeff King <peff@peff.net> wrote:
> If we do a fix that allows "refs/heads/foo:refs/heads/bar", then it
> should also properly allow "+refs/heads/foo:refs/heads/bar". Which I
> think means changing the single "export" command in the ref-helper to
> something like:
>
> =C2=A0export refs/heads/foo
> =C2=A0export refs/heads/foo:refs/heads/bar
> =C2=A0export +refs/heads/force

Or, since we changed import, to:

export
refs/heads/foo
refs/heads/foo:refs/heads/bar
+refs/heads/force
\n

--=20
Cheers,

Sverre Rabbelier
