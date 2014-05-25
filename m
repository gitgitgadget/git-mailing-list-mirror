From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] gc --auto: do not lock refs in the background
Date: Sun, 25 May 2014 07:32:50 +0700
Message-ID: <CACsJy8C3KLfh9haFh==OyGm5Hsf02i8dUVLxyLtdJEup49XhrA@mail.gmail.com>
References: <CACsJy8BfziZ7ciyKL0+X3rT9EfH_0E8nKNu9mTb_WSeTYWix_Q@mail.gmail.com>
 <1400978309-25235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kilobyte@angband.pl, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 25 02:33:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoMNR-0006QI-Ku
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 02:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbaEYAdW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2014 20:33:22 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:59402 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbaEYAdV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 May 2014 20:33:21 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so10108683qgd.37
        for <git@vger.kernel.org>; Sat, 24 May 2014 17:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LkcdAqbD/Gt4MeZkmDemMfWT3oxhPshA51v8+Xu7eu4=;
        b=1GjXLZhBnNtOjK2wLViM95MDXDQyikMwp/Riaa5oC4DKZZQrK07go6WwJkhZTIAqUU
         ziMR71Yiuk9WII7Eqw3an+rt0EKMCVPqmYYV4/zi92yrb2UA3LH3BQ0hHWrmzY7VRv1F
         Qy/RAWX0enbbf8bcQZewDnhVeIgqgslOJPvLtHWS/gFPcyp5jnSV7WZaN9mIQtbKwXCR
         Aq6LhvunMZD1caFubX2qe0zKd4xmvR3lqDD7QifPfJ9nE0DcaxTD76Y5DNQGerb/GeXm
         sRCtg17ywVfeT8ZmkOXmgfIgYZ2xfelB3glqL6yl9O9G2UDz8+LgRB+ABlxoocIxfKMG
         PG8w==
X-Received: by 10.140.107.137 with SMTP id h9mr18823021qgf.30.1400978000985;
 Sat, 24 May 2014 17:33:20 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 24 May 2014 17:32:50 -0700 (PDT)
In-Reply-To: <1400978309-25235-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250065>

On Sun, May 25, 2014 at 7:38 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Keep running pack-refs and "reflog --prune" in foreground to stop
> parallel ref updates. The remaining background operations (repack,
> prune and rerere) should impact running git processes.

Eck.. s/should impact/should not impact/
--=20
Duy
