From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/2] fast-import: filemodify after M 040000 <tree> "" crashes
Date: Sun, 17 Oct 2010 20:13:09 -0500
Message-ID: <AANLkTik3iSSzKCxi9aeNw+ATPXvTN6yw-=NDGtqCidce@mail.gmail.com>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20101011063429.GA32034@burratino> <20101018010005.GA25524@burratino> <20101018010338.GB25524@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 03:13:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7eIC-0005np-Cl
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 03:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868Ab0JRBNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 21:13:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58092 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab0JRBNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 21:13:30 -0400
Received: by yxm8 with SMTP id 8so119237yxm.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5k5XxpsNbmCAr0Y5phaMjxZiVDnFgXb/JI26RwmSV+o=;
        b=rZafVLHDIRNHKi1O8v4DcAgwuu6qvZxYtzf6T1Yb4uVfxv8dBq0NBy6PydQC2E67Aj
         6BxO0ImWKAH7p/Wsz9dVZcf9xWkD6spzNgtdBj2Ef71tOMBzPqwEJDkF6U5/G5bnYFg0
         zjEVQ1cbE9tI1FA9YJma92pfnw3yLq0jYW2rY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ACYlXTQegT6iPBgg4Xwkni0cdL/EJE/J0PSDACy8DuWecJqux6ZSsa9Br90ZjLLr4R
         mHRzdZVrGKc4tS+ZXDdSyY/2hCe1UhvRKT15yIfKIQNjCrDld13Fv1GZ4WrdkY0doMUF
         KANz0PXAZXBbwyrXNCuhNa52AvcPN+6qDDKEg=
Received: by 10.150.218.21 with SMTP id q21mr5822682ybg.205.1287364410148;
 Sun, 17 Oct 2010 18:13:30 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Sun, 17 Oct 2010 18:13:09 -0700 (PDT)
In-Reply-To: <20101018010338.GB25524@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159223>

Heya,

On Sun, Oct 17, 2010 at 20:03, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Until M 040000 <tree> "" syntax was introduced in commit 2794ad5
> (fast-import: Allow filemodify to set the root, 2010-10-10), it
> was impossible for the root entry to refer to an unloaded tree.
> Update various functions to take that possibility into account.
> Otherwise
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M 040000 <tree> ""
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M 100644 :1 "foo"
>
> and similar commands (using D, C, or R after resetting the root
> tree) segfault.

I'm curious, how come this not found earlier? Would seem like a fairly
regular operation?

--=20
Cheers,

Sverre Rabbelier
