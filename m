From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 10/16] grep: skip files that have not been checked out
Date: Sun, 14 Sep 2008 11:56:03 -0700 (PDT)
Message-ID: <m3zlmamu9s.fsf@localhost.localdomain>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	<1221397685-27715-2-git-send-email-pclouds@gmail.com>
	<1221397685-27715-3-git-send-email-pclouds@gmail.com>
	<1221397685-27715-4-git-send-email-pclouds@gmail.com>
	<1221397685-27715-5-git-send-email-pclouds@gmail.com>
	<1221397685-27715-6-git-send-email-pclouds@gmail.com>
	<1221397685-27715-7-git-send-email-pclouds@gmail.com>
	<1221397685-27715-8-git-send-email-pclouds@gmail.com>
	<1221397685-27715-9-git-send-email-pclouds@gmail.com>
	<1221397685-27715-10-git-send-email-pclouds@gmail.com>
	<1221397685-27715-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 20:57:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kewmb-0001LH-4w
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 20:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbYINS4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbYINS4J
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 14:56:09 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:12158 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbYINS4G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 14:56:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so166720and.103
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=1qHCL1a3vWSXajSebT2OpREU74njnM0PF/t+3KMT05Q=;
        b=tmvUxBu9sLTiUEG04AgEylMkCtpE0mcnGe4mLOLuAEndrdpfTU+dmKrQzmQFqQIR8A
         mB2hMwhOuUbZPQmZkSuH6SuKkJmNuZbPLNB3JgxRvAtnOI8OSVJpfmQOxTNJKBqdmbpq
         ztd8pUL7cR9PdYOBttgrIhU/aiBI8E2Z/PbfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=cVElT0E7HIzPN8CdQxKy6EYSDmABxpCOcHPUZRXGFyUQUDzoKdBbPIPe9Hq7plO5sp
         nSKeJtwOjrSEJZAI8Y6dsIQtBJ1b2Tyjt4g5ODjyc3HvEUGlN1FCRwqa2syZeo9wLgoS
         na7blWm8RmkpEx8UHGPfh1ZIhIpCeag/a7ugg=
Received: by 10.86.71.1 with SMTP id t1mr5226751fga.36.1221418564176;
        Sun, 14 Sep 2008 11:56:04 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.193])
        by mx.google.com with ESMTPS id l12sm33616fgb.6.2008.09.14.11.56.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 11:56:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8EIu1ct014124;
	Sun, 14 Sep 2008 20:56:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8EIu0oF014121;
	Sun, 14 Sep 2008 20:56:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221397685-27715-11-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95854>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy    <pclouds@gmail.com> writes=
:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin-grep.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

No changes to Documentation/git-grep.txt?
--=20
Jakub Narebski
Poland
ShadeHawk on #git
