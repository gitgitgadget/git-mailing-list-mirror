From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 2/4] rev-parse: add tests for git rev-parse --flags.
Date: Sat, 25 Sep 2010 14:27:02 +0000
Message-ID: <AANLkTimj--jZdX++=ZjF3A0HE11FbkgVb2gs3ADVEGvx@mail.gmail.com>
References: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
	<1285421633-22684-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 16:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzVjW-00023U-Th
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 16:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab0IYO1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 10:27:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33792 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab0IYO1D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 10:27:03 -0400
Received: by iwn5 with SMTP id 5so3241899iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QUy1Dc2sfH05BsPscVm6Ut7DPP1aRzpwZ9QDvE2tV2w=;
        b=Yq8WypghuU93Na6VT+U/QUMaZSt0PlXz6KVhMoSx0jDkJdWEE60JjpwqTRUKKDnc/r
         7ZV5FcfeVYmswV71CTMdRQ2ykgegb3sIK5CcycxD8VAnYTV6I8NT88llFfvod5HLwWG2
         uFaRAp4ObwUTeyPMNSRmLiuDF2F3Urjj4drE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mtfuT6WeJgP6Xsm0ViYJDDPN7zZorDO0qYANFCIEeiGOLved3iBHr2P5+r65VUsHZ8
         /g09tNO2SsQ1rLNESpSkm+TujUS0MHVce7WBI+EKGBYAw/SYDlus/NivnmbLp7Whzs/i
         jDVqUYRJZQocbecbLyPaYQf19FQx0isyfj2SE=
Received: by 10.231.190.75 with SMTP id dh11mr5637282ibb.189.1285424822333;
 Sat, 25 Sep 2010 07:27:02 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 07:27:02 -0700 (PDT)
In-Reply-To: <1285421633-22684-3-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157157>

On Sat, Sep 25, 2010 at 13:33, Jon Seymour <jon.seymour@gmail.com> wrot=
e:

> + =C2=A0 =C2=A0 =C2=A0 : >expected &&

We've been dropping the ":>foo" style in favor of ">foo" in other
tests. There's no need for the ":".

> + =C2=A0 =C2=A0 =C2=A0 echo -X > expected &&
> + =C2=A0 =C2=A0 =C2=A0 echo -q > expected &&
> + =C2=A0 =C2=A0 =C2=A0 echo -X > expected &&
> + =C2=A0 =C2=A0 =C2=A0 echo --no-flags > expected &&

Maybe some echo implementations don't like flag-like params, and we nee=
d:

    printf "%s\n" "-X"

here. I don't know whether that's the case.
