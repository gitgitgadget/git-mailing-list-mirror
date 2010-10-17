From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Sun, 17 Oct 2010 10:59:34 -0500
Message-ID: <20101017155934.GC301@burratino>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
 <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
 <20101014200027.GA18813@burratino>
 <7vwrph4eeb.fsf@alter.siamese.dyndns.org>
 <AANLkTikc80ev+ex6-9RDgO_h-4LEuZf6M9hPAfVQ9oSX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 18:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Vhf-0005wm-EJ
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 18:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab0JQQDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 12:03:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64786 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020Ab0JQQDM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 12:03:12 -0400
Received: by gyg13 with SMTP id 13so20220gyg.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HLdok+ijOM50Qp1p953ra5zW5TNQ/OestjH97zP6pJ8=;
        b=U5G3vapogXR4LIF+YpR8whTAnlJMiDz6OzEAFpMs22Z2MgT7G4qlGIt3LBVgUo1KSc
         dT7fzMrkmOot5AQ87SxvbnfeEbqszp8i1U1fcsSCKIAFPGBLv5DuT+SxKyOO/vxBiz5Y
         S3rffZh+rY5e95s469bw0yw7gI0qytGPpvl98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VC+urkStxL736TxVweEuw8QDa+bsB2vNU/6pl7fSus0zYpI7+wycaxiLtJ0mnwptoV
         04qw4ZpRYlFv6CNCE//f3jdpDMLjfluXnSO/E2EUywJbjI/uKxHYjvTMJbfsDIu3qkbk
         f2ZDN3NZJYxO/usTP9gv7YpTg1C3k8JtrSNs8=
Received: by 10.236.110.178 with SMTP id u38mr5519806yhg.19.1287331391368;
        Sun, 17 Oct 2010 09:03:11 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r25sm5347396yhc.0.2010.10.17.09.03.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 09:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikc80ev+ex6-9RDgO_h-4LEuZf6M9hPAfVQ9oSX@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159206>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Do you mean to re-arrange it so that there's a patch at the front of
> the series that introduces gettext.h with only the fallbacks:
>=20
>     #define _(s) (s)
>     #define N_(s) (s)
>=20
> And then merge the ~120 gettextize patches first and do the
> infrastructure later?

I don't think that's what he was saying, but I think that _would_ be
helpful.  So the history could look like:

                     infrastructure
                    /              \
 introduce gettext.h                ab/i18n
                    \              /
                     gettextization
                          /
                          merges from master where appropriate,
                          perhaps just at the beginning for simplicity.


That way, each side could have patches rearranged or squashed when
needed without disrupting the other.

What do you think?
