From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 39/47] setup: limit get_git_work_tree()'s to explicit
 setup case only
Date: Tue, 18 Jan 2011 20:59:37 +0700
Message-ID: <AANLkTinTSiDhfcEzYVji0xD44BY0HPpzLYuZoNgMPdkt@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com> <20110118074400.GA4185@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 15:00:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfC6c-0005YX-8j
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 15:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725Ab1AROAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 09:00:10 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:62775 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab1AROAJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jan 2011 09:00:09 -0500
Received: by wwi17 with SMTP id 17so3228641wwi.1
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 06:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=fl5tn1fnualmoqjWBcj+cNHDkscLdEv+lB/RBM+sc84=;
        b=WYu0WZSsDKiMjsFDhRkouftlRvPuPISlPIFaQNl7yHp4DjbRqlw2GT8e3uARL/fjFF
         H/kGJRyhH5dPLXZB2xypy5+8OHlE416Hrdx2A5xp0eWgDSvkHl0n3haB9W/1QkFm88/A
         lhHo92H+hFTqzH1SxrK3RRcnezeWHSk/Q687w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=C4gJSZA4m0JXtJd56WglEyZ9zSP4gYhcQEmE3h9bDSP6q7zjgCBWkBtO+anGNP+DM/
         zAtISn+SlgagQ3gfnogmg5yrJPkhPYfZ7ZTLkFj6AdNJ0zM+LdsMXcTsKutaLx1uvxsu
         wvAwxOuxOVq5YpVEHOnvyRHqvleNT8+e/1Wqs=
Received: by 10.216.51.67 with SMTP id a45mr1199581wec.19.1295359207320; Tue,
 18 Jan 2011 06:00:07 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 18 Jan 2011 05:59:37 -0800 (PST)
In-Reply-To: <20110118074400.GA4185@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165198>

2011/1/18 Jonathan Nieder <jrnieder@gmail.com>:
> How about something like this patch? =C2=A0It only concerns the
> GIT_WORK_TREE variable and --work-tree command line option; the
> semantics of core.worktree are unaffected.

Perhaps only activate your code if $GIT_WORK_TREE is absolute path?
Things may go wild if $GIT_WORK_TREE is relative. We can die() if
GIT_WORK_TREE is set but not used. Annoying, but better than leave the
errors unseen.

> (Sorry, no real patch yet. =C2=A0Updating the test to reflect the cha=
nge is
> a pain in the neck.)

Yeah, I count on it to (over-)catch every mistakes in setup code :D
--=20
Duy
