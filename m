From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] t0027: Support NATIVE_CRLF
Date: Fri, 17 Apr 2015 16:44:09 -0400
Message-ID: <CAPig+cS6XELr0zEa_SiCM25rQENerEtBS9xVeLi4sc61nAa6Mg@mail.gmail.com>
References: <55312A45.8060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:44:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjD7Y-0001Us-80
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 22:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbbDQUoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 16:44:12 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36151 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbDQUoK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2015 16:44:10 -0400
Received: by igblo3 with SMTP id lo3so21565061igb.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=7EBniW32WPYiuJjaPymIpgERjStt9y0gnKBGF9XiHjA=;
        b=GPcF4w2XSMaFE1rd05G/8Lkbe2n5S7HKE4SG2Fp7YR8rZN5SWc9HnlncAFKEMwQGF9
         rQf3mpqIP7cRHj+BUO+jbMIzBJVb3oShFNU+YHx6p+tH/8h36NAeHPjzXp7/9LJ2mDtU
         15RDVtjPtRugEAYXnQEuOLdMp57fY3YirJa/Dv1c/rGlmHwhOhotGtOy4mecwJdn7y48
         CE+o//kMF+0LoUEjpxBeP+zSKgv6FsnGjvb+MmmuX7awLBKaJmYB+9BO+/IE+tkRNjWn
         mCQ2IHCg6BvEQSCpdrrnV7j8Aj1MEBv23DyA7SVXhwIK9ChIql/yRxu+d2JtVVfIRfM2
         W4ZQ==
X-Received: by 10.50.43.231 with SMTP id z7mr5543156igl.22.1429303449952; Fri,
 17 Apr 2015 13:44:09 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 17 Apr 2015 13:44:09 -0700 (PDT)
In-Reply-To: <55312A45.8060008@web.de>
X-Google-Sender-Auth: P83a4zFxsglVIcYkCwtPQy-ahTM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267388>

On Fri, Apr 17, 2015 at 11:44 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> Without this patch, t0027 expects the native end-of-lines to be a sin=
gle
> line feed character. On Windows, however, we set it to a carriage ret=
urn
> character followed by a line feed character. Thus, we have to modify
> t0027 to expect different warnings depending on the end-of-line marke=
rs.
>
> Adjust the check of the warnings and use these macros:
>   WILC:  Warn if LF becomes CRLF
>   WICL:  Warn if CRLF becomes LF
>   WAMIX: Mixed line endings: either CRLF->LF or LF->CRLF
>
> Improve the information given by check_warning():
> Use test_cmp to show which warning is missing (or should'n t be there=
)

s/should'n t/shouldn't/

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
