From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] match-trees: factor out fill_tree_desc_strict
Date: Thu, 13 Jun 2013 17:00:30 -0400
Message-ID: <CAPig+cQGTWBPhC1L1+-b9UE1u-tyNKwNQhVdauojzc984LPNrA@mail.gmail.com>
References: <1371147568-31348-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 13 23:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnEdJ-0004yF-Cs
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 23:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758986Ab3FMVAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 17:00:33 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37232 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738Ab3FMVAc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jun 2013 17:00:32 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so8025862lbi.5
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MLvfKdmwXgjWyjkR/lXykWoxdp/aoxSr+ZhtKxTdWsg=;
        b=ETpPcn2s/gGxfogP56EbktRFdEWhZ2xYWnDVhaoLJW6/xToyK/PqHq0Fc88nFhpcGS
         7TC2bVE39dEzvk7T+Yu4Ph3f7AQSHDMj/h+66R4lXLXBoLposKPQq9YX7JvvXYwmuXTP
         QpiplDyCFe5P7Itm3Vz/y1N5bPx9YWHm98pSyiet9gr9IV3bV6fDDB2BJEhIsfiM/Y2R
         pIKOPtCsZkfSsf+DyWzdVEO0XYEgzXhKfv/TdBGUEMHiWo4BLQ8DIYzl9weqwIPhbSIJ
         4KKtDg9xDLHozJIQwvLW/OZ13neM9OmFY/WgB57gF2RyJ/gN5hYAsnSjw7LY1p3WvuNP
         kTvg==
X-Received: by 10.112.77.164 with SMTP id t4mr2116131lbw.52.1371157230731;
 Thu, 13 Jun 2013 14:00:30 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 13 Jun 2013 14:00:30 -0700 (PDT)
In-Reply-To: <1371147568-31348-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
X-Google-Sender-Auth: sInh4BnVjZNPhaOyECp_GLEk8DU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227776>

On Thu, Jun 13, 2013 at 2:19 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Deduplicate code by moving tree_desc initialtization into a helper

s/initialtization/initialization/

> function, fill_tree_desc_strict.  It is like fill_tree_descriptor,
> except that it only accepts tree hashes and no tree references (tags,
> commits).  No functional change.
>
> Signed-off-by: Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>
