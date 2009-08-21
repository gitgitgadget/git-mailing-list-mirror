From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v4 04/19] Teach Git to respect skip-worktree bit 
	(reading part)
Date: Fri, 21 Aug 2009 16:19:01 +0700
Message-ID: <fcaeb9bf0908210219h1c2a4702i81661ced00f39232@mail.gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com> 
	<1250776033-12395-2-git-send-email-pclouds@gmail.com> <1250776033-12395-3-git-send-email-pclouds@gmail.com> 
	<1250776033-12395-4-git-send-email-pclouds@gmail.com> <1250776033-12395-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 11:19:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeQHR-0006Si-TO
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 11:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbZHUJTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 05:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755153AbZHUJTU
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 05:19:20 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:65439 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbZHUJTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 05:19:19 -0400
Received: by ywh3 with SMTP id 3so815324ywh.22
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=OYM4m2xqlh6dWBDHf8dvjxBZLre8CzJ3TagSA9wfxqg=;
        b=U2ebSUgxnBFTPrjKOb6UYV0TvQwXAxdzH62p0KcY2f8ad66I6QG+DGwh5y7F+BUA/j
         5UPS7EDKQkngtDmgEIfooX9X0rehoOcnMy73jOIQoeMLRdLbLLGjH9ozgG/ExJsyxrjw
         txUwcJoinryup4CyLULycrddtGsQ+k122QYY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=aXBD+J7KP2mloTZJs7++GD9Y9rbGIzwapReqrivWr6GDybVSiws9J9vuqDw8drq+dP
         +8m/4sb8nX1Exzo5yyQR6JPnNe2QxqXunAutff40DujZZ4fAtQz0q5YSe/mJ16SUGacE
         i9LPmhhv3ZAgIOWHTOWWKiPc6WR5s1rwwzvAw=
Received: by 10.100.233.19 with SMTP id f19mr773505anh.72.1250846361046; Fri, 
	21 Aug 2009 02:19:21 -0700 (PDT)
In-Reply-To: <1250776033-12395-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126700>

2009/8/20 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> grep: turn on --cached for files that is marked skip-worktree
> ls-files: do not check for deleted file that is marked skip-worktree
> update-index: ignore update request if it's skip-worktree, while stil=
l allows removing
> diff*: skip worktree version

I kept reminding myself and still managed to miss it. skip-worktree
bit is not completely independent from assume-unchanged. It shares
CE_MATCH_IGNORE_VALID flag in ie_match_stat(). Should have mentioned
that in commit log.
--=20
Duy
