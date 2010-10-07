From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: provide better prefix to go back to original cwd
Date: Thu, 7 Oct 2010 10:14:45 +0700
Message-ID: <AANLkTim7=8ALxBKWhYcZRSqAcxi0O-T-pxmYpG8_N8v7@mail.gmail.com>
References: <1286373578-2484-1-git-send-email-pclouds@gmail.com>
 <20101006180727.GA2118@burratino> <7v4ocz18az.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	judge.packham@gmail.com, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 05:15:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3gwy-0007ug-Bb
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 05:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557Ab0JGDPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 23:15:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61211 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab0JGDPH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 23:15:07 -0400
Received: by wyb28 with SMTP id 28so243760wyb.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jK3WqQRwa9Aon3aWR59OfzFZ0+iDuIluu0nUqlpKOSM=;
        b=H7eVe329gGo5LuUbgXLcbsRkmKmIjTGRXaPTCd+gOCMFoQhz7b0Jn+DMRfqI31QIp3
         f/qttfVo63gCaOQoTcriurV2/sBvVVkFuIXeXEV5JOV3D1CEmElMUG2qqwXLEWFFm0Rw
         Mb2aOnvLV1qFeNDtS+xm6eCx2PpdP7sp3iR9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pa8OmVLA/O8+Dwc7WIIzw5hk08moZS7KvQqUy/35JClo5wh457Ls3j54ju4PNnJzSF
         401X3zD1TpCD4lBea4pPpPMMvNdqY915o67nz5P57H9rKhNtVdSI0P3Ftgj2Z9rl69qi
         Sr1naIge3nPULFFfuianzZJ/x7UfRIrKHaOMc=
Received: by 10.216.11.131 with SMTP id 3mr1669061wex.92.1286421306150; Wed,
 06 Oct 2010 20:15:06 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Wed, 6 Oct 2010 20:14:45 -0700 (PDT)
In-Reply-To: <7v4ocz18az.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158363>

On Thu, Oct 7, 2010 at 1:32 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Are there any examples to illustrate whether teaching --show-prefix =
to
>> do what your --worktree-to-cwd does would be a good or bad idea?
>> (Just curious.)
>
> Do these additions interact well with the notion of "we are in the wo=
rking
> tree" vs "we are outside the working tree"? =C2=A0Even when we happen=
 to know
> via GIT_WORK_TREE that the root of the working tree is /var/tmp/junk,=
 we
> should correctly diagnse that we are outside the working tree when we=
 are
> in /var/tmp/, and require_work_tree should say "no you are not allowe=
d to
> do this", no?

It should work as it does now. I don't change prefix calculation and
chdir() behavior. So when you're at /var/tmp, require_work_tree should
say no.
--=20
Duy
