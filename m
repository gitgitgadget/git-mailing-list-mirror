From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Tue, 7 Feb 2012 08:19:47 +0700
Message-ID: <CACsJy8D_yT3wzX1+Yfnwn7mtPiXz1smDGXxCtW62gHcCnTt0mw@mail.gmail.com>
References: <CB5179E9.3B751%joshua.redstone@fb.com> <4F2C6276.1070100@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 02:20:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuZje-0000Ih-5X
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 02:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab2BGBUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 20:20:19 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64427 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab2BGBUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 20:20:18 -0500
Received: by wics10 with SMTP id s10so4579919wic.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 17:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gCi0/plPioz9CXAkM8nze2eugIdyich8Vc+2Bcl+3JM=;
        b=xOyvf1zNLwHEL4LNhYK+2yG7obXrXK8i8JNUGMl2CPTJ6DAGgf11vK+7Uu/UpU/b1s
         Bo2ZlYHh9iFLdpP6g4UQvz5YzIzL/0brzbfvsgzH2Tc+WJX3zzxiPR5D2DCHCaqla1Np
         qgH42k20nlJOznLY2YIT08GRhkLNT/ZxSxnF4=
Received: by 10.181.13.113 with SMTP id ex17mr30931882wid.15.1328577617270;
 Mon, 06 Feb 2012 17:20:17 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 17:19:47 -0800 (PST)
In-Reply-To: <4F2C6276.1070100@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190130>

On Sat, Feb 4, 2012 at 5:40 AM, Sam Vilain <sam@vilain.net> wrote:
> There have also been designs at various times for sparse check=E2=80=93=
outs; ie
> check=E2=80=93outs where you don't check out the root of the reposito=
ry but a
> sub=E2=80=93tree.

There is a sparse checkout feature in git (hopefully from one of the
designs you mentioned) and it can checkout subtrees. The only problem
in this case is it maintains full index. So it only solves half of the
problem (stat calls), reading/writing large index just slows
everything down.
--=20
Duy
