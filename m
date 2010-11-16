From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Bogus error: Untracked working tree file '....' would be
 overwritten by merge. Aborting
Date: Tue, 16 Nov 2010 18:34:40 +0700
Message-ID: <AANLkTikeaj6kfq+pv+F0mOUSC7yJKnwyUgy9k8GPTpxg@mail.gmail.com>
References: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com> <20101116112406.GA18259@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 12:35:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIJod-0002iS-Cd
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 12:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933446Ab0KPLfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Nov 2010 06:35:04 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64239 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933106Ab0KPLfC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Nov 2010 06:35:02 -0500
Received: by wyb28 with SMTP id 28so589640wyb.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 03:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aKsyYZYok0WJXOhbOMOv0ixmtvJ8Fq42r/cRuQMiTSc=;
        b=j7sy7cQxoyVHTMVF/IT25dP36600r8GjPLUlhap+ql2cpiXLafIHmHsKbDZ+0qAC18
         G8CQzyzI0cTGREYSpKsGPMCt9fA1M7J607BLo2iSCYjn7TNGNGbwipIy3mM8ecR+wGxI
         wVrMiauLcSLbRSRDfRupAo2qiiuPUlCO+ctnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RccKcImvZT3Pfb6YIdeZkGS3eeUx5xYuvTz6oTROUfg0F9qhiZzXfWfp4VNBO9UE+S
         SF8hjE1B9gwSPOxg4tCFhjpDsevuzYpOaqpC2gtoscniv0qEEVdJuBPvu3ZYKZaQJs1k
         99WnVymfIkm9RtPEDCgaIyUl+Xi0FHFRYdgP0=
Received: by 10.216.172.9 with SMTP id s9mr6450532wel.56.1289907300602; Tue,
 16 Nov 2010 03:35:00 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Tue, 16 Nov 2010 03:34:40 -0800 (PST)
In-Reply-To: <20101116112406.GA18259@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161559>

On Tue, Nov 16, 2010 at 6:24 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> +static int identical_content(struct cache_entry *ce, struct stat *st=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned char sha1[20];
> + =C2=A0 =C2=A0 =C2=A0 return !index_path(sha1, ce->name, st, 0) && !=
hashcmp(sha1, ce->sha1);

Even better, do a file size check here. If it's not equal, there's no
point in calling the expensive index_path().
--=20
Duy
