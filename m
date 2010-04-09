From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: potential improvement to 'git log' with a range
Date: Sat, 10 Apr 2010 01:33:01 +0200
Message-ID: <h2gadf1fd3d1004091633qe27d49f0m2ecb461e56f405b1@mail.gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 01:33:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NhI-0006Fr-Ck
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab0DIXdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 19:33:07 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:40507 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab0DIXdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 19:33:02 -0400
Received: by fxm23 with SMTP id 23so3147951fxm.21
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 16:33:01 -0700 (PDT)
Received: by 10.103.11.8 with HTTP; Fri, 9 Apr 2010 16:33:01 -0700 (PDT)
In-Reply-To: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
Received: by 10.102.13.10 with SMTP id 10mr369750mum.87.1270855981188; Fri, 09 
	Apr 2010 16:33:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144488>

On Sat, Apr 10, 2010 at 1:24 AM, Aghiles <aghilesk@gmail.com> wrote:
> If I type:
>
> =A0 =A0git log FETCH_HEAD~4..HEAD
>
> I get something. But if I type:
>
> =A0 =A0git log HEAD..FETCH_HEAD~4
>
> I get nothing. Is there a good reason for that ?
>

Yes.

$ git log -h
usage: git log [<options>] [<since>..<until>] [[--] <path>...]

So <since> and <until> are not equivalent. It list commits in <until>
but not in <since>.

In your case HEAD has commits not in FETCH_HEAD~4 (your first command)
while FETCH_HEAD~4 does not have commits not in HEAD. So HEAD is a
descendent of FETCH_HEAD~4.

Hope I didn't misunderstood your question.

HTH,
Santi
