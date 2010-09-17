From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the object store
Date: Sat, 18 Sep 2010 01:24:58 +0200
Message-ID: <AANLkTikoQb9R06ppYnPAHujnuXtGD7s14Z7AqhgcPUeN@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino> <1284596048.3298.3.camel@wilber>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Sep 18 01:25:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwkJ3-0004ON-V3
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 01:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab0IQXZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 19:25:20 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58952 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0IQXZT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 19:25:19 -0400
Received: by gxk23 with SMTP id 23so888960gxk.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8ux79x0/9IBXu8+xIfM+r19SMfLPZ50C+bKqanhAGYc=;
        b=hNwXG60JHeTotb5rb++1r5rQ8rc4MsQkLWs6fouXaTra9LajwuuuVxIBWk8SzKoV6O
         stC5y7QllF2y6vbKE1TmKaC1J+g/MkHm5DfA9qnHL88ucjCXVcEfM/SL3T1BW37HhDa0
         7jIsYTx5kV2UaLSrIC4vOVeRDBU20IggQEt4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sKHeF947bih6c4utHm5fPefIP89Mp3uGXhRTUqnjwxRGO/x57jPXvvw/ESS3DBHeVu
         Wq87OAKivVY6LdAXCpaWj8NnJtVQ9b1tzwHNLl1YwurecDbsgaIn/w1AdCF1LL50eHbl
         1bK5w6eTGQTvDaTGCuC2v/Jk3UZ4LGEi+QokU=
Received: by 10.150.134.18 with SMTP id h18mr6391875ybd.436.1284765918291;
 Fri, 17 Sep 2010 16:25:18 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Fri, 17 Sep 2010 16:24:58 -0700 (PDT)
In-Reply-To: <1284596048.3298.3.camel@wilber>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156418>

Heya,

On Thu, Sep 16, 2010 at 02:14, Sam Vilain <sam@vilain.net> wrote:
> This is probably quite a late comment, but I don't think that
> 'report-fd=3D3' is a good idea in a protocol like this. =C2=A0It shou=
ld not
> take an argument and just respond down the appropriate selected file
> descriptor. =C2=A0ie, default to standard output. =C2=A0If standard i=
nput is a
> socket, then use that bidirectionally. =C2=A0If --report-fd is used o=
n the
> command line, use that.

I understand your point, the generated stream is not very reusable if
the fd is 'hardcoded'. On the other hand, the primary use for this
feature is the case where an exporter feeds directly into an importer.
What use case do you see for re-use of a stream where the report-fd is
used? Or are your objections based on some other ground?

--=20
Cheers,

Sverre Rabbelier
